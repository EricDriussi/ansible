# Host your stuff!
> '*Easy to use*' Ansible script to set up a VPS in one go.

Simple Ansible playbook that provides you with:

- A self-hosted website.
- An onion version of your website served to Tor.
- A [Nextcloud](https://nextcloud.com/) instance @ `cloud.domain`.
- A [Vaultwarden](https://github.com/dani-garcia/vaultwarden) instance @ `vault.domain`.
- A [SearxNG](https://github.com/searxng/searxng) instance @ `searx.domain`.
- HTTPS all the things.
- Possibly more stuff in the future.

## 🔧 Pre-requisites

Things you need to set up for the script to work as expected.

### A Debian based VPS

This should work with the cheapest most basic VPS you can find.

### Ports and DNS

Ports `80` and `443` need to be available.

You **need** a valid domain name and your DNS records should be properly set up.

This should include A and AAAA records for your root domain, as well as your subdomains (at least `cloud`, `vault` and `searx`).

### SSH root user

There needs to be a working ssh connection from your machine to your VPS's root user.

This connection is expected to use your `id_rsa` key pair. As in:

```sh
ssh-copy-id -i ~/.ssh/id_rsa.pub root@[your.domain.com]
```

The script will use the same ssh key for the `ansible` user it creates.

---

#### 📝 Note

Please keep in mind that by the end, you won't be able to ssh into your VPS as the `root` user.

This is intentional and considered best practice, but might be unexpected and will require you to connect as the `ansible` user created by the script (or with any other user you decide to configure).

---

### A website to serve

You need to set the `website` var to the local directory containing the website to serve.

You can update the website once the script is done with something like:

```sh
rsync -rtvzP --rsh=ssh [LOCAL-WEBSITE-DIR] ansible@[your.domain.com]:/var/www/website
```

Of course, any user you decide to set up is equally valid, as described above.

## ⚙️ Config

User config is done through the `.env.yml` file.
Create it by renaming `.env-sample.yml` and filling in the correct information.

### ⚠️ Note on Vars

The `signups` var is set as `false` by default, which means that random users (or yourself) can't just create an account on your Vaultwarden instance.

Instead, permission needs to be granted through the admin panel at `vault.domain.com/admin`.
Access the panel with the `admin_token`.

The `admin_token` should be set to the output of something like `openssl rand -base64 48` as recommended in the [documentation](https://github.com/dani-garcia/vaultwarden/wiki/Enabling-admin-page) for Vaultwarden.

## 🏃 Run

To run the whole playbook in one go, run:

```sh
ansible-playbook run.yml --extra-vars=@.env.yml
```

Optionally and in case you need to debug, use the `--tags` flag, to run only the selected tasks:

```sh
ansible-playbook run.yml --extra-vars=@.env.yml --tags="user,ssh,install"
```

## Why?

Having your own private spot on the internet shouldn't be a luxury.

Here's a step to make it more accessible.
