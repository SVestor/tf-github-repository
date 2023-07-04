provider "github" {
  owner = var.github_owner
  token = var.github_token
}

resource "github_repository" "this" {
  name       = var.repository_name
  visibility = var.repository_visibility
  auto_init  = true
}

resource "github_repository_deploy_key" "this" {
  title      = var.public_key_openssh_title
  repository = github_repository.this.name
  key        = var.public_key_openssh
  read_only  = false
}

resource "github_repository_file" "kbot-ns" {
  repository          = var.repository_name
  branch              = var.branch
  file                = "clusters/kbot-demo/kbot-ns.yaml" 
  content             = "---\napiVersion: v1\nkind: Namespace\nmetadata:\n  name: kbot-demo"
  commit_message      = var.commit_message
  commit_author       = var.commit_author
  commit_email        = var.commit_email
  overwrite_on_create = true
}

resource "github_repository_file" "kbot-src" {
  repository          = var.repository_name
  branch              = var.branch
  file                = "clusters/kbot-demo/kbot-src.yaml" 
  content             = "---\napiVersion: source.toolkit.fluxcd.io/v1\nkind: GitRepository\nmetadata:\n  name: kbot\n  namespace: kbot-demo\nspec:\n  interval: 1m0s\n  ref:\n    branch: main\n  url: https://github.com/SVestor/kbot"
  commit_message      = var.commit_message
  commit_author       = var.commit_author
  commit_email        = var.commit_email
  overwrite_on_create = true
}

resource "github_repository_file" "kbot-hr" {
  repository          = var.repository_name
  branch              = var.branch
  file                = "clusters/kbot-demo/kbot-hr.yaml" 
  content             = "---\napiVersion: helm.toolkit.fluxcd.io/v2beta1\nkind: HelmRelease\nmetadata:\n  name: kbot\n  namespace: kbot-demo\nspec:\n  chart:\n    spec:\n      chart: ./helm\n      reconcileStrategy: ChartVersion\n      sourceRef:\n        kind: GitRepository\n        name: kbot\n  interval: 1m0s"
  commit_message      = var.commit_message
  commit_author       = var.commit_author
  commit_email        = var.commit_email
  overwrite_on_create = true
}