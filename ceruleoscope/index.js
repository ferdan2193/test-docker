/*module.exports = async function (context, myTimer) {
    var timeStamp = new Date().toISOString();
    
    if (myTimer.IsPastDue)
    {
        context.log('JavaScript is running late! Fernando Alvarez');
    }
    context.log('JavaScript timer trigger function ran Fernando Daniel Alvarez Jasso!', timeStamp);   
};*/

module.exports = async function (context, myTimer) {
    try{
      const { PlaywrightTestLauncher } = require("ceruleoscope");

      let responseMessage = await PlaywrightTestLauncher.Run();

      context.log("Playwright tests console output: " + responseMessage); // optional
    } catch(ex){
      context.log("Failed to run Playwright tests: " + ex);
    }
}; 