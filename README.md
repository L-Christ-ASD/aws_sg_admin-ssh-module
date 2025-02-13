# configuration AWS security group -> terraform

**En utilisant uniquement terraform appliquez les actions suivantes :**

## Créez un security group nommé admin-ssh

* Créez l'ingress qui accepte le trafic SSH en entrée pour toute les ip's
* Associez l'ingress au security group
* Associez le security group à l'instance EC2
* Tester la connexion entrante

## Associer une ip

* Créez un fichier monip.auto.tfvars pour y mettre dedans votre IP
* Modifier votre security group pour n'autoriser que votre ip dedans

## Associer une liste d'ip
* Créez un fichier admin-ip.auto.tfvars qui contient une liste d'ip à paramétrer
* associez cette liste d'ip à votre security group pour autoriser ssh sur chacune d'entre elle


**Champs libre**:  
Trouver une solution pour renseigner automatiquement votre ip publique dans le security group.

## docs:

* lisez la documentation de la data source aws_ami  [ici](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)  
[lien 1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) [lien 2](https://developer.hashicorp.com/terraform/language/backend/s3)  
[Adaptez votre code avec ce lien3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)


*Troisième challenge saison10*.