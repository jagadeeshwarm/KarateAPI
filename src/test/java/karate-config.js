function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue'
  }
  var config ={
    apiUrl:'https://conduit-api.bondaracademy.com/api/'
  }
  if (env == 'dev') {
   config.userEmail = 'karatej@gmail.com'
   config.userPassword = 'karate1234'
  }
   else if (env == 'qa') {
   config.userEmail = 'karate2@test.com'
   config.userPassword = 'karate456'
   
  
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.log('Access Token:', accessToken); // Debugging line to check token
 karate.configure('headers', {Authorization: 'Token '+ accessToken})
  return config;
}
