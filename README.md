# Création d'une infrastructure via terrafom + aws

* Paramétrez votre environnement AWS dans votre environnement Terraform (aws cli plus crédential)
* Tester votre environnement aws avec le cli : aws ec2 describe-instances
* Créez un fichier main.tf qui vous permettra de créer une instance EC2 nommé "mavm"
* Exécutez la séquence init, plan apply pour créez l'instance
* Vérifiez que l'instance est bien créé.
* Ajoutez une nouvelle ressource dans votre fichier main.tf pour créer un bucket S3
* Créez le bucket S3 avec terraform.

**Bonus**:  
Pour ceux qui souhaitent aller plus loin vous pouvez jouer avec les différents paramètres de création associé à la ressource terraform ec2_instance (security group etc).

## docs:

[lien 1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) [lien 2](https://developer.hashicorp.com/terraform/language/backend/s3)


* Modifiez votre définition terraform pour ne pas spécifier directement l'identifiant de l'AMI, mais que ça récupère automatiquement la dernière Ubuntu
* lisez la documentation de la data source aws_ami  [ici](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)
* écrivez le bloc data adapté pour filtrer correctement (pensez à utiliser l'argument most_recent)
* utilisez cette data source pour inclure l'id de l'AMI voulu lors de votre création d'instance EC2
* Rajoutez une variable d'input nommée ec2_distribution et ec2_archiavec respectivement comme valeur par défaut ubuntu et amd64
* essayez d'adapter votre code pour pouvoir tenir compte de ces deux variable et créer automatiquement des instance EC2 appropriées.
* création d'un "aws_s3_bucket" et déployement automatique pour le partage du fichier .tfstate et versionning.


**Bon à savoir**:  
La récupération et la mise à jour automatique d'une image d'instance est à éviter en prod! 