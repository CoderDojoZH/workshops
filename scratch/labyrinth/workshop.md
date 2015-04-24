# Labyrinth solving with Scratch

## Algorithms

### What is an Algorithm

The goal of this workshop is to help understanding what algorithms are, how they are implemented as programs on digital devices, and that programs execute by following precise and unambiguous instructions. So what exactly is an algorithm?

An algorithm is a precise method for solving a given problem. For example

- _Problem_: repair a puncture on your bike
  - _Algorithm_: take off the wheel, remove the tyre, remove the inner tube, find the hole, patch it, replace the inner tube, replace the tyre, put the wheel back on.
- _Problem_: find your way to the exit of a maze
  - _Algorithm 1_: walk around at random until you find the exit. (This is an algorithm!)
  - _Algorithm 2_: walk forward, keeping your right hand touching the wall at all time.
  - _Algorithm 3_: Walk forward until you reach an intersection. Turn right unless there is a doughnut in the way. If you can turn right, do so, and leave a doughnut on the ground to make sure you don’t do the same thing again.
- _Problem_: find which of your classmates picked up your calculator by mistake.
  - _Algorithm 1_: whenever you bump into a classmate, ask them, until you find the right person
  - _Algorithm 2_: like Algorithm 1, except never ask the same classmate twice
  - _Algorithm 3_: find your classmates in alphabetical order, and ask each in turn.  
    Stop when you find the calculator, or when you have asked the last pupil.
  - _Algorithm 4_: whenever you meet a classmate, ask them. If they don’t have the calculator, get them to join you in the search by running Algorithm 4 themselves. When someone finds the calculator, they should find you.

So an algorithm simply says how to do something, or accomplish some task. Notice that:

- Before we can speak of an algorithm we must be clear about the problem it is trying to solve.
- The audience for an algorithm is a human being, not a computer. The goal is to convey to the mind of your audience the essential insight of how the problem can be solved.
- Because the goal is to convey the “essential insight”, the description of an algorithm will usually suppress lots of incidental detail. For example, Algorithm 1 above did not specify the words to use to your classmates, still less which muscles to move when speaking those words.
- Nevertheless, an algorithm should be precise, in the sense that the listener can say "oh yes, I see; I could do that" (or perhaps "I could build a machine to do that").
- There may be lots of different algorithms that solve the same problem; I gave several algorithms for the final two example above.
- Some algorithms are simpler than others. For example, walking randomly through a maze is simpler than leaving doughnuts on the ground.
- Some algorithms are faster than others. For example, walking randomly around a maze might take a very long time indeed.
- You sometimes have to think very carefully

### Algorithms versus programs

    | Algorithm | Program
--- | --------- | -------
Audience | A person | A computer
Language | Usually expressed in informal language | Expressed in a programming language
Level of detail | Incidental detail suppressed | Every detail is specified
Level of precision | Precise enough for a human, with a reasonable level of common sense and background knowledge, to say “I can see how to do that”. | Precise enough that a mindless machine can execute the program without human intervention

## Biblitgraphy

- Simon Peyton Jones, _Understanding the new programmes of study for computing_, 2014  
  <http://primary.quickstartcomputing.org/resources/pdf/understanding_pos.pdf>
