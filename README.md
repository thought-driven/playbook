# Lunchtime Labs Playbook

1. Export HTML from
   https://www.notion.so/lunchtimelabs/How-We-Work-eb84744893f541e5b232e73e5e707307

2. Copy the HTML to this directory.

3. Run `ruby process.rb`, which:

- Adds `script.js` and `styles.css` to every file (for header and footer customization)
- Changes spaces to underscores

4. Test locally using `php -s localhost:3000`

5. Commit to master and it will be deployed via GH Pages
