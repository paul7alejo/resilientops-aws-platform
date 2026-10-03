# Network Design

## Initial architecture

Internet users will access the application through a public Application Load Balancer.

Application resources will remain private and will not accept direct public traffic.

Database resources will remain private and accessible only from the application layer.

## Traffic flow

Internet → Public Load Balancer → Private Application → Private Database

## Security principles

- No public database
- Least-privilege security-group rules
- No administrative access open to the internet
- Separate public and private network areas
- Synthetic data only
- Avoid chargeable AWS resources until the design is understood

## Cost decision

Do not create a NAT Gateway during the initial learning phase because it creates ongoing cost. Document the production alternative later.