# Using Github as a lab

## Visibility

Github can be useful for various purposes, including version control, collaboration on code, or code maintenance. An important advantage is **visibility**: People can easily find code online, download it, and develop it further. Github is often more visible and easier to find than other comparable services or than individual lab webpages.

## Individual accounts ##
Usually, code is written by individual researchers who upload it on their **own account**. This has the advantage that their name becomes associated with the code, so the individual researcher **gets credit** for their work. This helps individual researcher in career development and conveying their skills to future employers.

However, at the same time, hosting code on one's own webpage comes with **responsibility**: One is expected to respond to issues and questions about the code, fix bugs, and ensure its **long-term maintenance**. People might not want to have this responsibility (any more), e.g. if they leave academia, or if the code is continuously developed (within one lab) and responsibility shifts from one researcher to the other. 

## Organizations
In this cases, it might be more suited to found an **organization** for the lab: An organization works similar to an account in that it can host repositories. However, it is not attached to a particular individual. Instead, multiple individual accounts can be added to an organization, where they can have either *owner* or *member* status. Owners and members can directly push code to repositories on the organization (in addition to the repositories they have on their own account).

Repositories can be hosted on such organizations, such that they **URL** is not github.com/researchername/mycoolproject, but instead github.com/organizationname/mycoolproject. In this way, the organization gets credit instead of the researcher.

The **owners** of organizations can be changed over time. The PI can be owner, bit simultaneously also another (more junior) researcher who handles the administration of the organization (e.g. answers issues and pull rejects). Once  junior researcher A leaves, another junior researcher B can take over as owner without the need to transfer repositories to another account.

### Code development in an organization
Ideally, *individual researchers* should host their own code on their **own account**. In this way, they get credit for their code (and their own work is visible to outside people including future employers), they remain responsible for the code and can develop it further.

At the same time, *labs* might want to have all the code developed by its members centrally stored (and findable) at one central spot on Github. This way, potential users can find the code by googling the lab (rather than the exact author). Also, labs might want to have a stable version of certain code independent of later changes by the individual researcher. Hence, they might create an **organization** for the entire lab and then **fork** the repositories of their individual lab members (once those reach a certain stable version ready for release). In this way, labs keep all the code developed by its members at a central storage, where it can be found by future users, while the members can continue to further develop the code and get the credit as original authors.

### Teams
Within organization, multiple individuals can be added to a 
**team**. Teams can be granted access rights as a whole, such that access rights for different projects do not have to be manually managed for each (incoming or leaving) individual, but instead, it can be handled by adding or removing people to teams in a central manner. Beyond that feature, there seem to be no more benefits to teams.

### Private repositories
In the past (under a different business model), free Github accounts only allowed for *public* repositories, while paid accounts allowed for (a certain number of) *private* repositories. Some companies created paid organization accounts to allow for private repositories. This has changed by now. Nowadays, any free Github account can also host private repositories.

## Good examples

- Fieldtrip: one organization with multiple members
    - Outside users can easily find what they are looking for by googling "Fieldtrip".
    - All relevant M/EEG processing scripts are bundled under one central organization under the label "Fieldtrip".
    - Maintenance can be shared by many users rather than a single maintainer, and continued once a certain maintainer leaves.
    - The Fieldtrip community gets credit for the performed work.

## Not so good examples

- Example 1: A single enthusiastic junior researcher (PhD) hosts all their lab's repositories on their personal account. Downsides:
    - Code hard to find: need to google not the lab's name, but the individual reseacher's name.
    - Only that PhD gets credit for the work, but not the other lab members who actually wrote the code.
    - Once that PhD leaves the lab or even leaves science, repositories must be transferred to someone else, so old links break and outside users again don't know how to google for the code they are looking for.
- Example 2: A PI hosts all their lab's repositories under their own personal account (under "PInameLab"). Downsides:
    - Only the PI gets credit for the code that the individual lab members write.
    - The account must be maintained by the PI itself (extra work for PI) or another junior researcher who needs to know the password etc. (beyond their own personal account), and the password has to be transferred once the junior researcher leaves.
- Example 3: Lab forms a team under another, bigger organization (e.g. Donders Institute). Downsides:
    - Big organization gets the credit, not the lab, not the individual researchers.
    - Code hard to find when googling the lab, need to know that code is hosted under the big organization.
