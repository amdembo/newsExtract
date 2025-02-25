# Load necessary libraries
library(dplyr)
library(stringr)

# Example: Load your dataset (replace with your actual data)
# data <- read.csv("C:\\Users\\Admin\\Documents\\whatsapp_chat.csv")

# Sample data for demonstration
data <- data.frame(
  ID = c(1, 2, 3, 4, 5, 6),
  Name = c("John Doe", "Jane Smith", "John Doe", "Alice Johnson", "Bob Brown", "Alice Johnson"),
  Email = c("john@example.com", "jane@example.com", "john@example.com", "alice@example.com", "bob@example.com", "alice@example.com"), 
  Age = c(25, 30, 25, 28, 35, 28),
  Comments = c("Great service!", "Good experience.", "Great service!", "Needs improvement.", "  Too expensive!  ", "Needs improvement.")
)

# Step 1: Remove duplicate rows
data <- data %>%
  distinct()

# Step 2: Remove inconsistent characters (e.g., special characters, extra spaces)
clean_text <- function(text) {
  # Remove special characters (keep only alphanumeric and spaces)
  text <- str_replace_all(text, "[^a-zA-Z0-9\\s]", "")
  # Convert to lowercase
  text <- tolower(text)
  # Trim leading and trailing whitespace
  text <- str_trim(text)
  return(text)
}

# Apply clean_text function to text columns
data <- data %>%
  mutate(across(where(is.character), clean_text))

# Step 3: Handle missing values
# Option 1: Remove rows with missing values
data <- data %>%
  filter(complete.cases(.))

# Option 2: Fill missing values with a placeholder (e.g., "Unknown")
# data <- data %>%
#   replace_na(list(Name = "Unknown", Email = "Unknown", Comments = "No comments"))

# Step 4: Standardize text (if not already done in clean_text)
# Example: Convert all text to lowercase
data <- data %>%
  mutate(across(where(is.character), tolower))

# Step 5: Remove extra spaces within text
data <- data %>%
  mutate(across(where(is.character), str_squish))

# Print cleaned data
print(data)

# Save cleaned data to a CSV file
write.csv(data, "cleaned_data.csv", row.names = FALSE)

# Print confirmation
cat("Data cleaning complete. Cleaned data saved to 'cleaned_data.csv'.\n")
