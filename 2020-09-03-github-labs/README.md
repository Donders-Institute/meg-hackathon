# Using GitHub as a lab

## Visibility

GitHub can be useful for various purposes, including version control of code and manuscripts, collaboration on code, or code maintenance. An important advantage is **visibility**: People can easily find code online, download it, and develop it further. Code on GitHub is often more visible and easier to find than other comparable services or than code hosted on individual lab webpages.

## Individual accounts

Usually, code is written by individual researchers who upload it on their **own account**. This has the advantage that their name becomes associated with the code, so the individual researcher **gets credit** for their work. This helps individual researcher in career development and conveying their skills to future employers.

However, at the same time, hosting code on one's own webpage comes with **responsibility**: One is expected to respond to issues and questions about the code, fix bugs, and ensure its **long-term maintenance**. At a certain point young researchers might not want to have this responsibility (any more), e.g. if they leave academia, or if the code is continuously developed (within one lab) and responsibility shifts from one researcher to the other.

## Organizations

In this cases, it might be more suited to found an **organization** for the lab: An organization works similar to a user account in that it can host repositories. However, an organization is not attached to a single individual. Instead, multiple individual accounts can be added to an organization, where they can have either _owner_ or _member_ status. Owners and members can directly push code to repositories on the organization (in addition to the repositories they have on their own account).

Repositories can be hosted on organizations, such that their **URL** is not github.com/researchername/mycoolproject, but instead github.com/organizationname/mycoolproject. In this way, the organization gets part of the credit and visibility instead of the researcher (whose name is still visible as the person who did all the commits).

The **members** and **owners** of an organization can changed over time. For example, the principal investigator can be one of the owners owner, bit simultaneously also another (more junior) researcher who handles the day-to-day administration of the organization and the repositories it hosts (e.g. answers issues and pull rejects). Once junior researcher "A" leaves, another junior researcher "B" can take over as owner without the need to transfer repositories to another account.

### Code development in an organization

From the perspective of _individual researchers_, it is adviseable that they host their own code on their **own account**. In this way, they get credit for their code, their own work is visible to outside people (including future employers), and they remain responsible for the code and can develop it further.

At the same time, the principal investigator of a _lab_ might want to have all the code developed by its researchers centrally stored (and findable) at one central spot on GitHub. This way, potential users can find the code by googling the lab (rather than the exact author). Also, labs might want to have a stable version of certain code independent of later changes by the individual researcher. Hence, they might create an **organization** for the entire lab and then **fork** the repositories of their individual lab members (once those reach a certain stable state that is appropriate to be released). In this way, labs keep a copy of all the code developed by its members at a central storage, where it can be found by future users, while the members can also continue to further develop their work and get the credit as original authors.

If junior researcher "A" moves to another university, it can also be that junior researcher "B" takes over responsibility for the lab-specific code of researcher "A", making adjustments and keeping its value for teh lab. At the same time researcher "A" might want to modify the code so that she can continue to use it in her new lab. In that case the repository under the account of researcher "A" and the fork of the repository under the GitHub organization of the lab really go different ways. That is perfectly fine, and one of the things for which git and GitHub have been designed.

### Teams

Within an organization, multiple individuals can be added to a **team**. Teams can be granted access rights as a whole, such that access rights for different projects do not have to be manually managed for each (incoming or leaving) individual, but instead, it can be handled by adding or removing people to teams in a central manner. Teams can also be used in communication where, e.g. you can mention a team as a whole in an issue or pull request. However, maintaining teams is also work, and for small labs where everyone knows each other it is probably not worth the hassle.

### Private repositories

In the past (under a different business model), free GitHub accounts only allowed for _public_ repositories, while paid accounts allowed for (a certain number of) _private_ repositories. Some companies created paid organization accounts to allow for private repositories. Nowadays this is different and any free GitHub account (personal or organization) can also host private repositories.

## Good examples

- [FieldTrip](https://github.com/fieldtrip): one organization with multiple members
  - Outside users can easily find what they are looking for by googling "FieldTrip".
  - All relevant M/EEG processing scripts are bundled under one central organization under the label "FieldTrip".
  - Maintenance can be shared by many users rather than a single maintainer, and continued once a certain maintainer leaves.
  - The FieldTrip community gets credit for the performed work.
  
- [Voytek lab at UC San Diego](https://github.com/voytekresearch): one organization with multiple members
  - On the [lab homepage](https://voyteklab.com/) there is a link to code and data on Github.
  - There are different repositories for different publciations.
  - For individual repositories (like [this one](https://github.com/voytekresearch/rvandermeij_voytek) from a former Donderian) it is still visible who actually contributed the work.
  - The PI also has his own repositories under [his own account](https://github.com/voytek), including his personal (not lab) website.
  - Other lab members also use their own account to host personal repositories (like [this](https://github.com/TomDonoghue)).

## Not so good examples

- Example 1: A single enthusiastic junior researcher (PhD) hosts all their lab's repositories under his personal account on GitHub. The downsides are:
  - The code is hard to find: need to google not the lab's name, but the individual reseacher's name.
  - Only that PhD gets credit for the work, but not the other lab members who actually wrote the code.
  - Once that PhD leaves the lab or even leaves science, repositories must be transferred to someone else, so old links break and outside users again don't know how to google for the code they are looking for.
  - After leaving academia following many frustrations the PhD might delete the research-related repositories, or even his whole acocunt (with everything in it)   
- Example 2: A PI hosts all their lab's repositories under their own personal account (under "PInameLab"). Downsides:
  - Only the PI gets credit for the code that the individual lab members write.
  - The account must be maintained by the PI itself (extra work for PI) or another junior researcher who needs to know the PIs password (beyond their own personal account), and the password has to be transferred once the junior researcher leaves.
- Example 3: Lab forms a team under another, bigger organization (e.g. [Donders Institute](https://github.com/Donders-Institute/)). Downsides:
  - The big organization gets the credit, not the lab, not the individual researchers.
  - The code is hard to find when googling the lab, need to know that code is hosted under the big organization.
  - The big organization probably has a lot of members and therefore a lot of repositories, any individual repository is hard to find.  
