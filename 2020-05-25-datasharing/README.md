# Data and code sharing via the Donders Repository and/or via GitHub

## What are the differences between a Donders Repository (DR) (https://data.donders.ru.nl/) and a GitHub repository? 

- Persistence
  - Repository: Once you can put it in the DR, you cannot delete it
  - Not guaranteed by single individual researcher, but by institution (data stewards, technical group; university responsible/ ensuring that this does not disappear)
  - Can get persistent identifier: handle or DOI
    - Not available for individuals, but institutions who guarantee sustainability
    - Easily available via Zenodo
      - Possible to export github repository to Zenodo
      - Cannot be deleted any more
- Long term accessible
  - DR: not possible to delete entire directory
  - Github: possible to delete entire account (or other ways to interfere with it)
- The size of the files you can store
  - Github: technology not suited for large files
  - Github: free service, but someone paying for this in the background (now: Microsoft as owner) can decide what to do with it
  - Repository: Donders paying for it, ensures long-term data storage
- Detailed control over who can access the files 
- Future goal: What do you want to happen with the code in the future?
  - Just get a static copy out there: the DR or Zenodo is just fine.
  - Continue development and aim for reuse and collaboration: Github is very efficient ways for interaction
  - The visibility of the code will be better on GitHub, so probably best to disseminate your code on both the DR (static) and GitHub (dynamic)

A good way to go would be to have data+code stored at a DR and the code also available at a Github repository 

- Link both Github and DR to each other:
  - DR:
    - Metadata: link to publication: also possible to enter URL (e.g. to Github)
    - Automatically transfer into other systems, e.g. Narcis
      - Harvested by other search engines
    - Metadata: “Type” gives type of repository (DAC/ RDC/ DSC)
      - Alternative: Put URL link in abstract of metadata:
  - Github: put a link to the DR repository

## Stages Radboud repository:

![alt text](https://raw.githubusercontent.com/Donders-Institute/meg-hackathon/master/2020-05-25-datasharing/shared%20collection%20states.png)

- Editable (read and write)
- Internal review (read only)
  - No changes any more
  - Make sure that all collaborators see the same thing
  - Can switch back to editable
- External review (read only)
  - Share URL that allows anonymous access
  - Can switch back to editable
- Published
  - Not anonymously accessible any more
  - Access under data use agreement
  - Possible to switch back to editable; but published version will not disappear; any back-and-forth results in new version

### DAC, RDC and DSC
- DSC (Data Sharing Collection)
- DAC (Data Acquisition Collection)/ RDC (Research Document Collection)
  - No external review
  - Published called “archived”, for only internal re-use (e.g., future colleagues in the same working group)
- DAC:
  - Different from project drive
  - Automatically created
  - Large files (DICOMs, MEG files) automatically stored there
  
### How to create new DR? Whom to ask?
- DCCN: ask Sandra Hermskerk
- DCC: ask Miriam Kos
- DCN: ask Bernhard Engliz
- DCMN: ask Arthur (?), probably via Hong

### Notes
- useful link with the user manual for DR: https://data.donders.ru.nl/doc/help/user-manual.html?1
- in the future (Q3/2020) also at the RU level, see https://data-acc.ru.nl/?0 for the acceptance (=testing) environment.

