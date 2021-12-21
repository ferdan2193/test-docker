import { test } from 'ceruleoscope';

let appInsights = require('applicationinsights');

test('TestTuEmpresa', async ({ page }) => {
    await page.goto('https://tuempresa.com.mx/');
    // Click text=PORTAFOLIO
    await page.click('text=PORTAFOLIO');
    
    
    // Click text=SERVICIOS
    await page.click('text=SERVICIOS');
    // Click text=DISEÑO WEB
    await page.click('text=DISEÑO WEB');
    
    // Click #footerPage a:has-text("Redes sociales")
    await page.click('#footerPage a:has-text("Redes sociales")');
    
});