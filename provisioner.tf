/*
1. Local exec
2. Remote exec
3. File
*/

//Note: terraform apply -refresh-only to run the state
//Note: terraform apply -replace="aws_intance.my_server"  to replace the instance this a state replacement 

resource "local_file" "web" {
  # ... //this is resource declaration
  content  = "This can be the content "
  filename = "${path.module}/s3outputvalues.config" //string interpolation is used here
  provisioner "local-exec" {
    command = "echo ${aws_s3_bucket.my_bucket.id} >> ${path.module}/s3outputvalues.config" //here provisioner is local executing on machine not on remote
  }
}

//we have a provisioner block we can have interpreter specified as well by default it is using bash

//in the similar fashion we can declare a remote exec scrpit 
resource "local_file" "web" {
  # ... //this is resource declaration
  content  = "This can be the content "
  filename = "${path.module}/s3outputvalues.config" //string interpolation is used here
  provisioner "remote-exec" {
    command = "echo ${aws_s3_bucket.my_bucket.id} >> ${path.module}/s3outputvalues.config" //here provisioner is local executing on machine not on remote
  }
}


resource "aws_instance" "web" {
  # ...

  provisioner "file" {                      //copy file from local to the remote location resource
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {                                //connection block required by the prov for placing the file
    type     = "ssh"
    user     = "root"
    password = "${var.root_password}"
    host     = "${var.host}"
  }
  }

  provisioner "remote-exec" {               //it has 3 types refer to the documentation
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
    connection {                                //connection block required by the prov for placing the file
    type     = "ssh"
    user     = "root"
    password = "${var.root_password}"
    host     = "${var.host}"
  }
  }                                        ///for remote exec we can use a template file datasource which can be rendered afterwards
}


//look into null resources as well