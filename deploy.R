
# deploy.R - deployment script for golem-training-apps
library(rsconnect)

# Deploy with correct app name (matches your current live app)
deployApp(
  appDir = ".",
  appName = "golem-training-apps",  # This matches your live URL
  forceUpdate = TRUE,
  launch.browser = FALSE
)

cat("✅ App deployed successfully!\n")
cat("🌐 Live at: https://daniva.shinyapps.io/golem-training-apps\n")
