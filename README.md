Урок 47.
Создание копии сайта ASKfm на платформе Ruby on Rails.

Суть ошибки:

```
http://localhost:3000/show

Webpacker::Manifest::MissingEntryError in Users#show

Showing /media/sf_rubytut2/ror/askme/app/views/layouts/application.html.erb where line #9 raised:

Webpacker can't find application in /media/sf_rubytut2/ror/askme/public/packs/manifest.json. Possible causes:
1. You want to set webpacker.yml value of compile to true for your environment
   unless you are using the `webpack -w` or the webpack-dev-server.
2. webpack has not yet re-run to reflect updates.
3. You have misconfigured Webpacker's config/webpacker.yml file.
4. Your webpack configuration is not creating a manifest.
Your manifest contains:
{
}

Extracted source (around line #9):

7
8   <%= stylesheet_link_tag 'application', media: 'all' %>
9   <%= javascript_pack_tag 'application' %>
10  </head>
11
12  <body>

Rails.root: /media/sf_rubytut2/ror/askme
```