# LangChain & Agentic AI Cheatsheet

---

## 1. What is an Agent?

- An **Agent** is a system that uses an LLM **plus logic** to:
  - Interpret the LLM’s output
  - Decide what *actions* to take (e.g., call tools)
  - Loop and reason until a final answer

- LLM = The *brain* (generates text/predictions)  
- Agent logic = The *controller* (decides next step, calls tools)

---

## 2. What are Tools?

- Tools = External functions the agent can call, e.g.:
  - Calculators
  - Search engines
  - APIs
  - Document retrievers

- Decorated with `@tool` in LangChain to define usage and description

---

## 3. Why use Agent instead of just LLM?

| LLM only                    | Agent (LLM + tools + logic)                |
|-----------------------------|--------------------------------------------|
| Generates answers directly   | Dynamically chooses and calls tools        |
| No multi-step decision logic | Supports multi-step reasoning & workflows  |
| No external action           | Can call calculators, APIs, retrieval etc. |

---

## 4. AgentType in LangChain

- `ZERO_SHOT_REACT_DESCRIPTION`:  
  Zero-shot ReAct (Reason + Act) using tool descriptions; default and versatile.

- Other notable types:  
  - `OPENAI_FUNCTIONS`: Uses OpenAI function calling API  
  - `STRUCTURED_CHAT_ZERO_SHOT_REACT`: Structured multi-turn chat  
  - `CHAT_CONVERSATIONAL_REACT_DESCRIPTION`: Chat-oriented ReAct  
  - `SELF_ASK_WITH_SEARCH`: Self-asking with search tool  
  - `PLAN_AND_EXECUTE`: Plan all steps, then execute sequentially

---

## 5. What is Agentic AI?

- AI systems that act **autonomously** to achieve goals by:
  - Planning
  - Taking actions (calling tools/APIs)
  - Adapting dynamically

- LangChain agents are a simple, practical example of agentic AI.

---

## 6. RAG vs Agent

| Aspect                | RAG (Retrieval-Augmented Generation)          | Agent                                        |
|-----------------------|-----------------------------------------------|----------------------------------------------|
| Uses external data?   | Yes, via retrieval from vector DB              | Yes, plus other tools/APIs                    |
| Multi-step reasoning? | No (single pass)                               | Yes (loops, multiple steps)                   |
| Dynamic tool calls?   | No                                            | Yes                                           |
| Best for             | Static document Q&A                            | Complex workflows & dynamic tool usage        |

---

## 7. Example Hybrid Setup: Agent + Retriever Tool

```python
from langchain.tools import tool

@tool
def document_search_tool(query: str) -> str:
    results = retriever.get_relevant_documents(query)
    return "\n\n".join([doc.page_content for doc in results])

@tool
def calculator_tool(expression: str) -> str:
    try:
        return str(eval(expression))
    except Exception as e:
        return f"Error: {e}"

tools = [document_search_tool, calculator_tool]

agent = initialize_agent(
    tools=tools,
    llm=llm,
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True
)

response = agent.run("What is the refund policy? Also, calculate 12 * 15.")
print(response)
