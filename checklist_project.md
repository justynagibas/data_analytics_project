
## Checklist for project Grading

Remebre, this is the report structure, it does not have to correspond to your actual workflow (for example, second model can be specified after finding what is missing in the first one). Remember in grading we are not looking at benchmarks, but are evaluating the tought process. Model can be performing *badly* as long as there were good reasons to try it in the first place. 

When grading each of criterions you have to **write** justification why the points were given. 

1. Problem formulation [0-5 pts]:
  - is the problem clearly stated [1 pt]
    - Yes the problem is clearly stated. 1
  - what is the point of creating model, are potential use cases defined [1 pt]
  - where do data comes from, what does it containt [1 pt]
    - Yes, data are available on Kaggle and come from orders in India. 1
  - DAG has been drawn [1 pt]
    - Yes, it is drawn.
  - confoundings (pipe, fork, collider) were described [1 pt]
    - Yes. 1
2. Data preprocessing [0-2 pts]:
  - is preprocessing step clearly described [1 pt]
    - Yes. 1
  - reasoning and types of actions taken on the dataset have been described [1 pt]
    - Yes. 1
3. Model [0-4 pts]
  - are two different models specified [1 pt] 
    -Yes.  1
  - are difference between two models explained [1 pt]
    - Yes. Both are linear models, but second contains more parameters. 1
  - is the difference in the models justified (e.g. does adding aditional parameter makes sense? ) [1 pt]
    - Yes. 1
  - are models sufficiently described (what are formulas, what are parameters, what data are required ) [1 pt]
    - Yes. 1
4. Priors [0-4 pts] 
  - Is it explained why particular priors for parameters were selected [1 pt]
    -Yes. 1
  - Have prior predictive checks been done for parameters (are parameters simulated from priors make sense) [1 pt]
    -Yes. 1
  - Have prior predictive checks been done for measurements (are measurements simulated from priors make sense) [1 pt]
    -Yes. 1
  - How prior parameters were selected [1 pt] 
    - Yes. 1
5. Posterior analysis (model 1) [0-4 pts] 
  - were there any issues with the sampling? if there were what kind of ideas for mitigation were used [1 pt]
    -Yes. 1
  - are the samples from posterior predictive distribution analyzed [1 pt]
    -Yes. 1
  - are the data consistent with posterior predictive samples and is it sufficiently commented (if they are not then is the justification provided)
    - Yes. 1 
  - have parameter marginal disrtibutions been analyzed (histograms of individual parametes plus summaries, are they diffuse or concentrated, what can we say about values) [1 pt]  
    - Yes. 1 
6. Posterior analysis (model 2) [0-4 pts] 
  - were there any issues with the sampling? if there were what kind of ideas for mitigation were used [1 pt]
    - Yes. 1
  - are the samples from posterior predictive distribution analyzed [1 pt]
    - Yes. 1
  - are the data consistent with posterior predictive samples and is it sufficiently commented (if they are not then is the justification provided)
    - Yes. 1
  - have parameter marginal disrtibutions been analyzed (histograms of individual parametes plus summaries, are they diffuse or concentrated, what can we say about values) [1 pt]  
    - Yes. 1
7. Model comaprison [0-4 pts]
  - Have models been compared using information criteria [1 pt]
    - Yes. 1
  - Have result for WAIC been discussed (is there a clear winner, or is there an overlap, were there any warnings) [1 pt]
    - Yes. 1
  - Have result for PSIS-LOO been discussed (is there a clear winner, or is there an overlap, were there any warnings) [1 pt]
    - Yes. 1
  - Was the model comparison discussed? Do authors agree with information criteria? Why in your opinion one model better than another [1 pt]
    - Yes. 1 

Total grade will be converted to percentage.
 Total grade: 27/27 Percentage: 100%

Graded by: Rafał Skrzypek & Jakub Majcher :>


