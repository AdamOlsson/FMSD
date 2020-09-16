### Propositional Atoms
$\Epsilon$ ={R1, G1, R2, G2}

### LTL Formula
1. not G1 and not G2
2. []<>(G1 or G2)
3. R1UR2

Does the following run satisfy this last property: {R1,G2}→{R1,G2}→… (i.e., all states of the run interpret R1 as true and G2 as true and all others as false)? 
No because U only holds if traffic light 2 becomes red at some point in the future.