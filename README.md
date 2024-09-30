Demo Commercetools + Terraform store
======================================

This repository aims to demonstrate how to use [Terraform](https://registry.terraform.io/) to orchestrate [Commercetools](https://commercetools.com/) using it's powerful declarative schemas by utilising the [labd/commercetools](https://registry.terraform.io/providers/labd/commercetools/latest) provider.

## Prerequisites

### Accounts

This project assumes accounts for the following services:

* Commercetools [60-day free trial](https://commercetools.com/free-trial) of `commercetools` and generate an API client to access specific keys in order to drive this.
* Sanity for the Studio, CMS and storefront UI.
* Commercelayer as the e-commerce layer and checkout functionality.
* Netlify for deployments.

Requires the `terraform` CLI tool. [See guide here on how to install](https://developer.hashicorp.com/terraform/install).

Additionally, you are going to need to

### Environment Variables

Create an environment file `.env` with the following credentials:

| **Variable**                       | **Description**                                                                                                                                                                                                                                               |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `BUILD_LANGUAGES`                  | The supported locales (the default is `en-US, it-IT, fr-FR`).                                                                                                                                                                                                 |
| `NEXT_PUBLIC_SITE_NAME`            | Optional name for the `<title>` head tag (you can also edit this directly in the code).                                                                                                                                                                       |
| `NEXT_PUBLIC_SITE_URL`             | Optional URL of your deployed project for the `og:url` meta property (you can also edit this directly in the code).                                                                                                                                           |
| `NEXT_PUBLIC_CL_CLIENT_ID`         | Your Commerce Layer sales channels application client ID (you can create this automatically by following this [onboarding guide](https://docs.commercelayer.io/developers) or manually on the [Commerce Layer dashboard](https://dashboard.commercelayer.io). |
| `NEXT_PUBLIC_CL_ENDPOINT`          | Your Commerce Layer organization's base endpoint (you can copy this on the [Commerce Layer dashboard](https://dashboard.commercelayer.io).                                                                                                                    |
| `NEXT_PUBLIC_SANITY_PROJECT_TITLE` | Optional name for the `<title>` head tag in Sanity studio (you can also edit this directly in the code).                                                                                                                                                      |
| `NEXT_PUBLIC_SANITY_PROJECT_ID`    | Sanity project ID (you can get this from [sanity.io/manage](https://sanity.io/manage) after creating a new project with the `npm -y create sanity@latest` CLI command or this [quick start wizard](https://sanity.io/get-started).                            |
| `NEXT_PUBLIC_SANITY_DATASET`       | Sanity dataset (you can get this from [sanity.io/manage](https://sanity.io/manage)).                                                                                                                                                                          |
| `NEXT_PUBLIC_SANITY_API_VERSION`   | Sanity API version in the ISO date format, e.g `2022-02-15` (you can learn more about this in [Sanity docs](https://www.sanity.io/help/js-client-api-version)).                                                                                               |
| `NEXT_PUBLIC_SANITY_TOKEN`         | Sanity API token (you can get this from [sanity.io/manage](https://sanity.io/manage)).                                                                                                                                                                        |


## Installation Guide (backend/commercetools)

Firstly, you need to ensure the following `.env` variables are present in your project:
```env
ctp_project_key=
ctp_client_id=
ctp_client_secret=
ctp_scopes=
ctp_api_url=
ctp_auth_url=
ctp_debug=1
```

Secondly, initialise `terraform`:
```bash
terraform init
```

Thirdly, stage and list changes that can be applied:
```bash
terraform plan
```

Finally, apply those changes and push to your `commercetools` project:
```bash
terraform apply
```

### Installation Guide (frontend/sanity)

1. Run the command below to install the required dependencies:

```bash
pnpm preinstall
pnpm install
```

2. Run the command below to start the development server:

```bash
pnpm run dev
```

### Seeding Data

Data is......


Log into your application via the CLI using the previously created CLI credentials like so:

```bash
pnpm run cl:login
```

Install the [seeder plugin](https://github.com/commercelayer/commercelayer-cli-plugin-seeder/blob/main/README.md) using the command below:

```bash
pnpm run cl plugins:install seeder
```

Install the [checkout plugin](https://github.com/commercelayer/commercelayer-cli-plugin-checkout/blob/main/README.md) using the command below:

```bash
pnpm run cl plugins:install checkout
```

Run the command below to import three demo [markets](https://data.commercelayer.app/seed/markets.json) (UK, USA, and Europe), a set of [SKUs](https://data.commercelayer.app/seed/skus.json), related [price lists](https://data.commercelayer.app/seed/price_lists.json), related [prices](https://data.commercelayer.app/seed/prices.json), [stock locations](https://data.commercelayer.app/seed/stock_locations.json), and [inventory](https://data.commercelayer.app/seed/stock_items.json) into your organization using the `multi_market` [business model](https://commercelayer.io/docs/data-model/markets-and-business-models).

```bash
pnpm run cl seed -b multi_market
```

To see the commands for other seeder options, type the command below:

```bash
pnpm run cl:help
```

### Import Seed Sanity Studio Content

Kindly follow the steps below to add the dataset the template was developed with (structured text and image files for all Sanity schema documents). This data will match the commerce data in Commerce Layer (SKUs, prices, etc.).

1. Extract the `production.tar.gz` file in the `/data` directory using the command below:

```bash
tar -xcvf ./data/production.tar.gz
```

The extracted folder name should look like `production-export-2021-02-26t14-15-56-557z`.

2. Move this to the `.sanity-template/data` directory:
```bash
mkdir -p ./.sanity-template/data
mv production-export-2021-02-26t14-15-56-557z ./.sanity-template/data
```

Ensure you set this path as your `$NEXT_PUBLIC_SANITY_DATASET_RELPATH` and the dataset name to `$NEXT_PUBLIC_SANITY_DATASET` environment variables.

3. Run the command below to import the `data.ndjson` file in the extracted folder.

```bash
pnpm run sanity:import
```

4 Check the Sanity studio now on `localhost:3000/studio` to preview the imported content.

<br />


## Extending

The [labd/commercetools](https://registry.terraform.io/providers/labd/commercetools/latest) Terraform provider allows you [extend commercetools in these ways](https://registry.terraform.io/providers/labd/commercetools/latest/docs). In this example we merely [add a category](https://registry.terraform.io/providers/labd/commercetools/latest/docs/resources/category) but, there are so many other resources here to sink your teeth into.