# "Statistics with R" coding attempts

Some code for the Coursera "Statistics with R" specialization course as organized by Duke University:

[Statistics with R Specialization](https://www.coursera.org/specializations/statistics)

This repository will change often!

- Course 1: ["Introduction to Probability and Data"](https://www.coursera.org/learn/probability-intro/)
   - Week 1: "Introduction"
   - Week 2: "Exploratory Data Analysis and Introduction to Inference"
   - Week 3: "Defining Probability & Conditional Probability"
   - Week 4: "Probability Distributions"
   - Week 5: "Peer-Reviewed Assignment"
- Course 2: ["Inferential Statistics"](https://www.coursera.org/learn/inferential-statistics-intro/)
   - Week 1: "Central Limit Theorem and Confidence Interval"
   - Week 2: "Hypothesis Testing" (now in progress)

## Supplementary Materials

- One really needs to get a grip on R outside of the above course, even when coming from the IT side. Thus: [this page](More_on_R.md)
- Some philosophy on probability, statistics, and inference is helpful and rewarding (see below). 
- From the AI side, new approaches to inference are brewing. Let's have a look (see below).

### Probability and Statistics

#### Stanford Encyclopedia of Philosophy

- [Interpretations of Probability](https://plato.stanford.edu/entries/probability-interpret/)
- [Information](https://plato.stanford.edu/entries/information/)
- [Causal Models](https://plato.stanford.edu/entries/causal-models/)

#### "The Foundations of Statistics Reconsidered"

by Leonard J. Savage, University of Michigan. Appears in: _Vol.1 of the Proceedings of the Fourth Berkeley Symposium on Mathematics and Probability, Berkeley, University of California Press, 1961._

> Introduction: This is an expository paper on the evolution of opinion about the foundations of statistics.
> It particularly emphasizes the paths that some of us have followed to a position that may be called
> Bayesian or neo-Bayesian.
> The intense modern growth of statistical theory of which this Symposium is a manifestation has been
> strongly oriented by a certain view as to the meaning of probability. I shall try to explain why another
> view seems now to be entering upon the scene almost of its own accord and to suggest what practical 
> implications it brings with it.

PDF download links at the [CiteSeerX page](https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.170.8812).

#### "The origins and legacy of Kolmogorov's Grundbegriffe"

by Glenn Shafer and Vladimir Vovk. _"A shorter version was published under the title "The sources of Kolmogorov's Grundbegriffe" in Statistical Science 21, 70 - 98 (2006)"_

> Abstract: April 25, 2003, marked the 100th anniversary of the birth of Andrei Nikolaevich Kolmogorov, the
> twentieth century's foremost contributor to the mathematical and philosophical foundations of probability. The year
> 2003 was also the 70th anniversary of the publication of Kolmogorov's _Grundbegriffe der Wahrscheinlichkeitsrechnung_.
> Kolmogorov's _Grundbegriffe_ put probability's modern mathematical formalism in place. It also provided a philosophy of
> probability - an explanation of how the formalism can be connected to the world of experience. In this article, we
> examine the sources of these two aspects of the _Grundbegriffe_ - the work of the earlier scholars whose ideas
> Kolmogorov synthesized. 

PDF download links at the [ArXiv](https://arxiv.org/abs/1802.06071)

#### "Severe Testing as a Basic Concept in a Neyman-Pearson Philosophy of Induction"

by Deborah G. Mayo , Aris Spanos. BRITISH JOURNAL FOR THE PHILOSOPHY OF SCIENCE, 2006.

- [CiteSeerX](https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.130.8131)
- [PDF](https://www.phil.vt.edu/dmayo/personal_website/2006Mayo_Spanos_severe_testing.pdf)

There is a whole book by Deborah Mayo on this ([Reviews](https://statmodeling.stat.columbia.edu/2019/04/12/several-reviews-of-deborah-mayos-new-book-statistical-inference-as-severe-testing-how-to-get-beyond-the-statistics-wars/)). This is promising!

### Causal Inference: The Next Generation

By Judea Pearl ([yep, *that* guy](https://www.quantamagazine.org/to-build-truly-intelligent-machines-teach-them-cause-and-effect-20180515/))

#### Theoretical Impediments to Machine Learning With Seven Sparks from the Causal Revolution

> Current machine learning systems operate, almost exclusively, in a statistical, or model-free mode, which entails
> severe theoretical limits on their power and performance. Such systems cannot reason about interventions and 
> retrospection and, therefore, cannot serve as the basis for strong AI. To achieve human level intelligence, learning
> machines need the guidance of a model of reality, similar to the ones used in causal inference tasks. To demonstrate
> the essential role of such models, I will present a summary of seven tasks which are beyond reach of current machine
> learning systems and which have been accomplished using the tools of causal modeling. 

- [PDF](https://arxiv.org/abs/1801.04016)

#### Causal inference in statistics: An overview

> This review presents empirical researchers with recent advances in causal inference, and stresses the paradigmatic
> shifts that must be undertaken in moving from traditional statistical analysis to causal analysis of multivariate
> data. Special emphasis is placed on the assumptions that underly all causal inferences, the languages used in 
> formulating those assumptions, the conditional nature of all causal and counterfactual claims, and the methods that
> have been developed for the assessment of such claims. These advances are illustrated using a general theory of
> causation based on the Structural Causal Model (SCM) described in Pearl (2000a), which subsumes and unifies other
> approaches to causation, and provides a coherent mathematical foundation for the analysis of causes and counterfactuals.
> In particular, the paper surveys the development of mathematical tools for inferring (from a combination of data and
> assumptions) answers to three types of causal queries: (1) queries about the effects of potential interventions, (also
> called “causal effects” or “policy evaluation”) (2) queries about probabilities of counterfactuals, (including
> assessment of “regret,” “attribution” or “causes of effects”) and (3) queries about direct and indirect effects (also
> known as “mediation”). Finally, the paper defines the formal and conceptual relationships between the structural and
> potential-outcome frameworks and presents tools for a symbiotic analysis that uses the strong features of both.

- [PDF](https://ftp.cs.ucla.edu/pub/stat_ser/r350.pdf)
