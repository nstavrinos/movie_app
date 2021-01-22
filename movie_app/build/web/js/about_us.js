
// Listen for a submit
document.querySelector(".contact100-form").addEventListener("submit", submitForm);

function submitForm(e) {
  e.preventDefault();

  //   Get input Values
  let name = document.querySelector(".input100[name='name']").value;
  let email = document.querySelector(".input100[name='email']").value;
  let message = document.querySelector(".input100[name='message']").value;
  console.log(name, email, message);


  document.querySelector(".contact100-form").reset();
  
  sendEmail(name, email, message);
}

function sendEmail(name,email,message){
    Email.send({
        Host:"smtp.gmail.com",
        Username:"website.messages21@gmail.com",
        Password:"website21@",
        To:"website.messages21@gmail.com",
        From:"website.messages21@gmail.com",
        Subject:`${name} sent you an message`,
        Body:`Name : ${name}<br/>Email :  ${email}<br/>Message : ${message}`
        
    }).then((message)=> alert("mail sent succesfully"));
    
}