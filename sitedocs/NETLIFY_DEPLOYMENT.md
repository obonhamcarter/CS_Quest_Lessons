# Netlify Deployment Guide

## 🎯 Overview
This guide walks you through deploying your CS Quest Lessons website to Netlify with a custom domain.

## 📋 Prerequisites
- ✅ Netlify account (free at https://netlify.com)
- ✅ Custom domain purchased
- ✅ GitHub repository with your code
- ✅ `netlify.toml` configuration file (already created)
- ✅ `requirements.txt` for Python dependencies (already created)

## 🚀 Deployment Steps

### Step 1: Prepare Your Repository
Ensure all files are committed and pushed to GitHub:

```bash
git add netlify.toml requirements.txt
git commit -m "Add Netlify configuration"
git push origin main
```

### Step 2: Connect to Netlify

1. **Log in to Netlify** (https://app.netlify.com)
2. Click **"Add new site"** → **"Import an existing project"**
3. Choose **GitHub** as your Git provider
4. Authorize Netlify to access your GitHub account
5. Select your **CS_Quest_Lessons** repository

### Step 3: Configure Build Settings

Netlify should automatically detect your settings from `netlify.toml`, but verify:

- **Build command:** `./build.sh`
- **Publish directory:** `_site`
- **Branch to deploy:** `main`

Click **"Deploy site"**

### Step 4: Wait for Initial Build

- Netlify will assign a random subdomain (e.g., `random-name-123.netlify.app`)
- Monitor the build logs for any errors
- First build may take 3-5 minutes

### Step 5: Connect Your Custom Domain

1. In your Netlify site dashboard, go to **"Domain settings"**
2. Click **"Add custom domain"**
3. Enter your domain (e.g., `yourdomain.com`)
4. Click **"Verify"**

### Step 6: Configure DNS

You have two options:

#### Option A: Use Netlify DNS (Recommended - Easiest)
1. Netlify will prompt you to use Netlify DNS
2. Click **"Set up Netlify DNS"**
3. Netlify will provide you with 4 nameservers (e.g., `dns1.p01.nsone.net`)
4. Go to your domain registrar (where you purchased the domain)
5. Update the nameservers to those provided by Netlify
6. Save changes (DNS propagation takes 24-48 hours, but often faster)

#### Option B: Use Your Domain Registrar's DNS
1. In Netlify, click **"Set up a custom domain"** → **"Use external DNS"**
2. Netlify will show you the DNS records to add
3. Go to your domain registrar's DNS settings
4. Add the following records:

**For apex domain (yourdomain.com):**
```
Type: A
Name: @
Value: 75.2.60.5
```

**For www subdomain:**
```
Type: CNAME
Name: www
Value: your-site-name.netlify.app
```

### Step 7: Enable HTTPS

1. In **Domain settings**, scroll to **HTTPS**
2. Netlify automatically provisions a free SSL certificate via Let's Encrypt
3. Wait for the certificate to be issued (usually 1-5 minutes)
4. Enable **"Force HTTPS"** to redirect HTTP to HTTPS

### Step 8: Test Your Site

Once DNS propagates and SSL is enabled:
- Visit `https://yourdomain.com`
- Test the JupyterLite integration at `https://yourdomain.com/jupyterlite/lab/index.html`
- Verify all lessons load correctly

## 🔄 Continuous Deployment

Once connected, Netlify automatically:
- Builds and deploys when you push to `main` branch
- Provides deploy previews for pull requests
- Maintains deploy history with rollback capability

## ⚙️ Optional: Build Environment Variables

If your build needs environment variables:
1. Go to **Site settings** → **Environment variables**
2. Add any required variables
3. Trigger a new deploy

## 🐛 Troubleshooting

### Build Fails
- Check the build logs in Netlify dashboard
- Ensure `build.sh` has execute permissions: `chmod +x build.sh`
- Verify Quarto is installed (Netlify has Quarto available)

### JupyterLite Not Working
- Verify the build script successfully copies JupyterLite to `_site/jupyterlite`
- Check that `jupyterlite_build` directory is created during build

### DNS Not Resolving
- Use `nslookup yourdomain.com` to check DNS propagation
- DNS changes can take up to 48 hours
- Clear your browser cache

### SSL Certificate Issues
- Ensure DNS is properly configured first
- Try clicking "Renew certificate" in Netlify dashboard
- Check that your domain registrar isn't blocking HTTPS

## 📚 Additional Resources

- [Netlify Docs](https://docs.netlify.com)
- [Custom Domain Setup](https://docs.netlify.com/domains-https/custom-domains/)
- [Quarto on Netlify](https://quarto.org/docs/publishing/netlify.html)

## 💡 Pro Tips

1. **Deploy Previews:** Enable deploy previews for branches to test changes before merging
2. **Build Plugins:** Explore Netlify plugins for optimization and features
3. **Analytics:** Enable Netlify Analytics to monitor site traffic
4. **Forms:** Use Netlify Forms if you add contact forms
5. **Split Testing:** Test different versions of pages with Netlify's A/B testing

## 🎉 Next Steps

After deployment:
- Share your live URL with students
- Set up a custom 404 page
- Configure redirects if needed
- Monitor build times and optimize if necessary
