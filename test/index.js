module.exports = async function (context, myTimer) {
    var timeStamp = new Date().toISOString();
    
    if (myTimer.IsPastDue)
    {
        context.log('JavaScript is running late! Fernando');
    }
    context.log('JavaScript timer trigger function ran!', timeStamp);   
};