import requests
from requests.exceptions import JSONDecodeError, HTTPError
import logging

def setup_logging():
    logger = logging.getLogger(__name__)  # Get a logger for your module
    logger.setLevel(logging.DEBUG)  # Set the logging level

    # Create a file handler for writing logs to a file
    file_handler = logging.FileHandler('logs/route_problems.log')
    file_handler.setLevel(logging.ERROR)  # Set the logging level for the file

    # Create a console handler for printing logs to the console
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.DEBUG)  # Set the logging level for the console

    # Create a formatter and set it for both handlers
    formatter = logging.Formatter('%(asctime)s - %(message)s')
    file_handler.setFormatter(formatter)
    console_handler.setFormatter(formatter)

    # Add the handlers to the logger
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)

    return logger


if not logging.getLogger().hasHandlers():
    logger = setup_logging()


class OSMR_Client:

    def __init__(self) -> None:
        self.base_url = f'http://router.project-osrm.org/route/v1/driving/'
        self.suffix = '?overview=false&geometries=geojson&steps=true'


    def _parse_geodata_to_dict(geodata) -> dict:
        pass


    def _create_valid_url(self, start_point, end_point):
        '''
        Pass points as (latitude, longitude), not other way around!!!
        Requests allow for passing suffix as params=dict, but im too lazy to do that
        '''
        return self.base_url + f'{start_point[1]},{start_point[0]};{end_point[1]},{end_point[0]}' + self.suffix


    def get_route_json(self, record_id, start_point, end_point):
        osrm_url = self._create_valid_url(start_point, end_point)
        response = requests.get(osrm_url)
        try:
            response.raise_for_status()
        except HTTPError as error:
            logger.exception(f"ID: {record_id}. Returned error: {error}. Route for points: start {start_point}, end {end_point}")
            return

        try:
            data = response.json()  # this can raise exception
        except JSONDecodeError as error:
            logger.exception(f"ID: {record_id}. Cannot decode json: {error}. Route for points: start {start_point}, end {end_point}")
            return

        return


