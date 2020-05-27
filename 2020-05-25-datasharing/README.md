# Data and code sharing via the Donders Repository and/or via GitHub

by Maria Carla Piastra and Johannes Algermissen (consulted by Robert Oostenveld)

## What are the differences between a collection on the Donders Repository (DR) (https://data.donders.ru.nl/) and a GitHub repository? 

### Persistence/ long-term accessibility

<p style="color:rgb(142,0,0)"><strong>Donders repository</strong></p> 

- Once you have created a collection on the DR, you cannot delete it any more
    - All changes to all files are tracked; no "secret" changes possible
- Persistence of the collection guaranteed _not_ by single individual researcher, but by an institution (data stewards & technical group of the university, who will  ensure that this does not disappear)
    - Donders/ Radboud University pays for the repository, ensures long-term data storage
    - Collections can get a persistent identifier: [handle](http://handle.net/) or [DOI](https://www.doi.org/)
        - Persistent idenfifiers not available for individuals, but only for institutions who can guarantee sustainability (e.g. journals, publishers, universities)

**GitHub**
- Repository can be deleted at any time (by deleting individual researcher's GitHub account)
- Persistence not guaranteed by current (commercial) owner (Microsoft), thus no persistent identifier awarded
    - BUT: Can export static version GitHub repository to [Zenodo](https://zenodo.org/) which can award DOI
        - Initiated/ hosted by the CERN (Switzerland), thus likely persistent in the future
        - Repositories on Zenodo cannot be deleted any more

### Possible file size

<p style="color:rgb(142,0,0)"><strong>Donders repository</strong></p> 

- Donders Repository designed to handle large files (e.g. DICOMS, MEG output files)
- Donders/ Radboud University paying for repository, ensures long-term data storage

**GitHub**
  - Technology not suited for large files (no large data files, no large image files, only code)

### Goal of distribution

<p style="color:rgb(142,0,0)"><strong>Donders repository</strong></p> 

- Detailed control over who can access the files: users need to sign data use agreement (DUA)
- Suited as a _static_ copy of data and code
- Allows for _metadata_: 
    - Link to publication: also possible to enter URL (e.g. to Github)
      - Alternative: Put URL link in "abstract" field of the metadata
    - Availability of metadata allows to automatically transfer the collection into other systems, e.g. Narcis (Dutch inventory of research output)
      - Harvested by other search engines
    - Metadata: “Type” gives type of repository (DAC/ RDC/ DSC)


**Github**
- Suited for continuous development, reuse by others, collaboration on a _dynamic_ repository
- Github provides specific tools for _interaction_ with other users/ collaborators such as issues and pull requests 
- Possible to export static copy to [Zenodo](https://zenodo.org/)
- Higher _visibility_, better suited to disseminate your code 
    - Possible to have version of code both on the Donders Repository (static, "version 1.0") and GitHub (dynamic)
        - Possible to add link to respective collection on Donders repository 

A good way to go would be to have data+code stored as a collection on the Donders Repository and the code also available as a Github repository.

## Stages of a collection in the Donders repository

![alt text](https://raw.githubusercontent.com/Donders-Institute/meg-hackathon/master/2020-05-25-datasharing/shared%20collection%20states.png)

- Editable (read and write)
    - Status while making changes/ working on a project
- Internal review (read only)
  - No changes possible any more (project declared "finished")
  - Makes sure that all collaborators see the same document/ file version while review/ approving a submission
  - Possible to switch back to editable
- External review (read only)
  - Possible to share URL that allows anonymous access (e.g. for reviewers/ editors)
  - Possible to switch back to editable
- Published
  - Not anonymously accessible any more
  - Access only under data use agreement
  - Possible to switch back to editable; but published version will not disappear; any back-and-forth results in a new version

### DAC, RDC and DSC

#### DAC (Data Acquisition Collection)


- Intended for [**raw data**](https://data.donders.ru.nl/doc/help/faq/organise-data-collections.html?1#faq-dac-files)
- Different from project drive
- Automatically created when filing PPM (DCCN) or PPF (DCC)
    - Large files (DICOMs, MEG files) automatically stored there
    - Smaller files (behavior, EEG, Castor, task code, experiment log files) need to be added manually
    - Best organized in [BIDS format](https://bids.neuroimaging.io/)
    - _Must not_ contain any personal information that directly identifies subjects (e.g., their name, address, telephone number, bank account, etc.). 
        - _Do not_ upload the signed informed consent forms 
        - Can contain _indirectly_ identifying information, e.g. detailed questionnaire results (with the personal information removed), photos, audio or video recordings, facial features in an anatomical MRI.
- Not visible to researchers outside the Donders, but only internals (with the respective access rights)
    - Only for internal re-use (e.g., future colleagues in the same working group)
- Collection does not get "published", but “archived”, so all the raw data is safely stored for the future
- All changes to data are tracked
  - Not possible for researchers to edit data without anyone noticing
      - Prevents fraud; ensure data fidelity
      - Helps researchers in case of fraud accusations

#### Research Documentation Collection (RDC)
- Store any [intermediate/ **processed** data/ code](https://data.donders.ru.nl/doc/help/faq/organise-data-collections.html?0#faq-rdc-files) (that might not go into the data sharing collection) 
    - Documenting the scientific process
    - Share preliminary results within the project team
        - Can contain figures, tables, PowerPoint presentations, etc.
        - Should contain documents of the editorial and peer-review process
        - Must be linked to a publication
    - Document the editorial and peer-review process
- Not visible to researchers outside the Donders, but only internals (with the respective access rights)

#### Data Sharing Collection (DSC)
- share  any (processed or raw) with **other users outside the Donders/ your team**
    - either during peer review (anonymously)
        - [create anonymous URL for external review](https://data.donders.ru.nl/doc/help/faq/share-data-external-reviewers.html?9)
    - for any other researcher who signs the data use agreement (DUA). 
    -  _Must not_ contain any data that make participants identifiable; see [this overview](https://data.donders.ru.nl/doc/help/faq/publish-data.html?4#faq-dsc-files) 
        - Anatomical MRI scans must be defaced before being shared.

### How to create new DR? Whom to ask?
- DCCN: ask Sandra Hermskerk
- DCC: ask Miriam Kos (usually requested during PPF)
- DCN: ask Bernhard Engliz
- DCMN: ask Arthur (?), probably via Hong

### References and resources
- Useful link with the [user manual](https://data.donders.ru.nl/doc/help/user-manual.html?) for the Donders Repository
- Particularly useful: [how to organize collections](https://data.donders.ru.nl/doc/help/faq/organise-data-collections.html?2#faq-dac-files)
- In the future (Q3/2020) also at the RU level, see https://data-acc.ru.nl/?0 for the acceptance (=testing) environment.