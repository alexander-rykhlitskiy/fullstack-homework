import { test, expect, chromium } from '@playwright/test';

test('main page', async () => {
  const browser = await chromium.launch();
  const context = await browser.newContext();

  // Start tracing before creating / navigating a page.
  await context.tracing.start({ screenshots: true, snapshots: true });
  const page = await context.newPage();

  await page.goto("http://localhost:3001");

  const firstDataRowLocator = page.locator('.table__row:nth-of-type(2)');
  await expect(firstDataRowLocator).toHaveText(/.*-18.1.*/);

  await page.click("text=Spring Wheat");
  await page.click("text=Winter Wheat");

  await expect(firstDataRowLocator).toHaveText(/.*-13.4.*/);

  await context.tracing.stop({ path: "trace.zip" });
});
