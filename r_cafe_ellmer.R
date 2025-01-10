# install.packages("ellmer")
library(ellmer)

# download and run ollama
# https://github.com/ollama/ollama

chat <- chat_ollama(model = "llama3.2")
chat$chat("Tell me three jokes about statisticians")

question <- "
  How can I compute the mean and median of variables a, b, c, and so on,
  all the way up to z, grouped by age and sex.
"

chat <- chat_ollama(model = "llama3.2", system_prompt = "
  You are an expert R programmer who prefers the tidyverse.
  Just give me the code. I don't want any explanation or sample data.
")

chat$chat(question)

result <- chat$extract_data(
  "My name is Susan and I'm 65 years old. I have diabetes and hypertension and my brother takes care of me.",
  type = type_object(
    age = type_number(),
    name = type_string(),
    diagnosis = type_array(items = type_string())
  )
)

result
