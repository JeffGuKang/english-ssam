# Korean Speaker Pattern Test Cases

These test cases focus on errors commonly made by Korean speakers due to language transfer.

## Honorific/Formality Transfer

### K-01: Overly Formal

**Input:** "Would you please kindly help me to fix this bug?"

**Suggested:** "Can you help me fix this bug?"

**Note:** Korean speakers often over-formalize due to honorific system

---

### K-02: Double Politeness

**Input:** "Could you please possibly review my code please?"

**Suggested:** "Could you please review my code?"

**Note:** One polite marker is enough in English

---

## Direct Translation Patterns

### K-03: "Do" Overuse

**Input:** "I will do commit the code"

**Suggested:** "I will commit the code"

**Note:** Direct translation from Korean verb structure

---

### K-04: Topic Marker Transfer

**Input:** "This code, it is working"

**Suggested:** "This code is working"

**Note:** Korean topic markers don't transfer to English

---

### K-05: Omitted Subject

**Input:** "Is very difficult problem"

**Suggested:** "**It** is a very difficult problem"

**Note:** Korean allows subject omission; English doesn't

---

## Tense Issues

### K-06: Present for Completed Actions

**Input:** "Yesterday I write the test"

**Suggested:** "Yesterday I **wrote** the test"

**Note:** Korean doesn't conjugate verbs for tense the same way

---

### K-07: Present Perfect Confusion

**Input:** "I already finish the task"

**Suggested:** "I **have** already **finished** the task"

**Note:** Present perfect usage differs from Korean

---

## Spacing and Particles

### K-08: Compound Nouns

**Input:** "data base" / "web site"

**Suggested:** "database" / "website"

**Note:** Korean word spacing patterns differ

---

## Common Vocabulary Confusions

### K-09: "See" vs "Look" vs "Watch"

**Input:** "Please see the error log"

**Suggested:** "Please **check** the error log"

**Note:** Korean 보다 maps to multiple English verbs

---

### K-10: "Listen" vs "Hear"

**Input:** "Did you listen what I said?"

**Suggested:** "Did you **hear** what I said?"

**Note:** 듣다 vs deliberate listening distinction

---

## Sentence Ending Patterns

### K-11: Question Formation

**Input:** "You can fix this?"

**Suggested:** "**Can you** fix this?"

**Note:** Korean uses rising intonation; English inverts

---

### K-12: Tag Questions

**Input:** "This is correct, no?"

**Suggested:** "This is correct, **isn't it**?"

**Note:** Korean tag patterns don't directly transfer

---

## Articles Deep Dive

### K-13: Generic vs Specific

**Input:** "I like the coffee" (meaning coffee in general)

**Suggested:** "I like coffee"

**Note:** Korean doesn't distinguish generic vs specific with articles

---

### K-14: First Mention Rule

**Input:** "I found the bug. The bug was in the login function."

**Expected:** Correct! (second mention uses "the")

**Note:** Reinforce correct usage patterns

---

## Number/Plurality

### K-15: Information

**Input:** "I need more informations"

**Suggested:** "I need more information"

**Note:** Korean doesn't have uncountable concept; "information" is uncountable

---

### K-16: Advice

**Input:** "He gave me good advices"

**Suggested:** "He gave me good advice"

**Note:** "advice" is uncountable
