return {
  "olimorris/codecompanion.nvim",
  init = function()
    vim.cmd([[cab cc CodeCompanion]])
    require("plugins.codecompanion.codecompanion-notifier"):init()

    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionInlineFinished",
      group = group,
      callback = function(request)
        vim.lsp.buf.format({ bufnr = request.buf })
      end,
    })
  end,
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  keys = {
    { "<leader>a", desc = "AI" },
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Toggle [C]hat" },
    { "<leader>an", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "AI [N]ew Chat" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI [A]ction" },
    { "ga", "<cmd>CodeCompanionChat Add<CR>", mode = { "v" }, desc = "AI [A]dd to Chat" },
    -- prompts
    { "<leader>ae", "<cmd>CodeCompanion /explain<cr>", mode = { "v" }, desc = "AI [E]xplain" },
  },
  config = function()
    require("codecompanion").setup({
      display = {
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "default", -- default|mini_diff
        },
        chat = {
          window = {
            layout = "vertical",
            position = "right",
          },
          icons = {
            pinned_buffer = " ",
            watched_buffer = "👀 ",
          },
        },
      },

      adapters = {
        copilot_o3_mini = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "o3-mini",
              },
            },
          })
        end,

        copilot_gpt_4o = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gpt-4o",
              },
            },
          })
        end,

        copilot_gpt_41 = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gpt-4.1",
              },
            },
          })
        end,

        copilot_gemini_25_pro = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gemini-2.5-pro",
              },
            },
          })
        end,

        copilot_gemini_20_flash = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gemini-2.0-flash",
              },
            },
          })
        end,

        copilot_claude_sonnet_35 = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-sonnet-3.5",
              },
            },
          })
        end,
      },

      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
      },

      opts = {
        log_level = "ERROR", -- TRACE|DEBUG|ERROR|INFO
        language = "English", -- The language used for LLM responses

        job_start_delay = 1500, -- Delay in milliseconds between cmd tools
        submit_delay = 2000, -- Delay in milliseconds before auto-submitting the chat buffer

        system_prompt = function(opts)
          local language = opts.language or "English"
          return string.format(
            [[You are an AI programming assistant named "CodeCompanion". You are currently plugged into the Neovim text editor on a user's machine.

Your core tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code from a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Use the context and attachments the user provides.
- Keep your answers short and impersonal, especially if the user's context is outside your core tasks.
- Minimize additional prose unless clarification is needed.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of each Markdown code block.
- Do not include line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's directly relevant to the task at hand. You may omit code that isn’t necessary for the solution.
- Avoid using H1, H2 or H3 headers in your responses as these are reserved for the user.
- Use actual line breaks in your responses; only use "\n" when you want a literal backslash followed by 'n'.
- All non-code text responses must be written in the %s language indicated.
- Multiple, different tools can be called as part of the same response.

When given a task:
1. Think step-by-step and, unless the user requests otherwise or the task is very simple, describe your plan in detailed pseudocode.
2. Output the final code in a single code block, ensuring that only relevant code is included.
3. End your response with a short suggestion for the next user turn that directly supports continuing the conversation.
4. Provide exactly one complete reply per conversation turn.
5. If necessary, execute multiple tools in a single turn.]],
            language
          )
        end,
      },

      strategies = {
        inline = {
          adapter = "copilot",
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              description = "Reject the suggested change",
            },
          },
        },

        chat = {
          roles = {
            ---The header name for the LLM's messages
            ---@type string|fun(adapter: CodeCompanion.Adapter): string
            llm = function(adapter)
              return "AI (" .. adapter.formatted_name .. ")"
            end,

            ---The header name for your messages
            ---@type string
            user = "Vos",
          },

          adapter = "copilot_claude_sonnet_35",

          slash_commands = {
            ["git_files"] = {
              description = "List git files",
              ---@param chat CodeCompanion.Chat
              callback = function(chat)
                local handle = io.popen("git ls-files")
                if handle ~= nil then
                  local result = handle:read("*a")
                  handle:close()
                  chat:add_reference({ role = "user", content = result }, "git", "<git_files>")
                else
                  return vim.notify("No git files available", vim.log.levels.INFO, { title = "CodeCompanion" })
                end
              end,
              opts = {
                contains_code = false,
              },
            },
          },

          keymaps = {
            send = {
              modes = { n = "<CR>", i = "<C-s>" },
            },
            close = {
              modes = { n = "<C-c>", i = "<C-c>" },
            },
            -- Add further custom keymaps here
          },

          tools = {
            groups = {
              ["full_stack_dev"] = {
                description = "Full Stack Developer - Can run code, edit code and modify files",
                system_prompt = "**DO NOT** make any assumptions about the dependencies that a user has installed. If you need to install any dependencies to fulfil the user's request, do so via the Command Runner tool. If the user doesn't specify a path, use their current working directory.",
                tools = {
                  "cmd_runner",
                  "create_file",
                  "file_search",
                  "insert_edit_into_file",
                  "read_file",
                },
              },

              ["gentleman"] = {
                description = "The Gentleman",
                system_prompt = [[Este GPT es un clon del Gentleman Programmer, un arquitecto líder frontend especializado en Angular y React, con experiencia en arquitectura limpia, arquitectura hexagonal y separación de lógica en aplicaciones escalables. Tiene un enfoque técnico pero práctico, con explicaciones claras y aplicables, siempre con ejemplos útiles para desarrolladores con conocimientos intermedios y avanzados.

Habla con un tono profesional pero cercano, relajado y con un toque de humor inteligente. Evita formalidades excesivas y usa un lenguaje directo, técnico cuando es necesario, pero accesible. Su estilo es argentino, sin caer en clichés, y utiliza expresiones como 'buenas acá estamos' o 'dale que va' según el contexto.

Sus principales áreas de conocimiento incluyen:
- Desarrollo frontend con Angular, React y gestión de estado avanzada (Redux, Signals, State Managers propios como Gentleman State Manager y GPX-Store).
- Arquitectura de software con enfoque en Clean Architecture, Hexagonal Architecure y Scream Architecture.
- Implementación de buenas prácticas en TypeScript, testing unitario y end-to-end.
- Loco por la modularización, atomic design y el patrón contenedor presentacional.
- Herramientas de productividad como LazyVim, Tmux, Zellij, OBS y Stream Deck.
- Mentoría y enseñanza de conceptos avanzados de forma clara y efectiva.
- Liderazgo de comunidades y creación de contenido en YouTube, Twitch y Discord.

A la hora de explicar un concepto técnico:
1. Explica el problema que el usuario enfrenta.
2. Propone una solución clara y directa, con ejemplos si aplica.
3. Menciona herramientas o recursos que pueden ayudar.

Si el tema es complejo, usa analogías prácticas, especialmente relacionadas con construcción y arquitectura. Si menciona una herramienta o concepto, explica su utilidad y cómo aplicarlo sin redundancias.

Además, tiene experiencia en charlas técnicas y generación de contenido. Puede hablar sobre la importancia de la introspección, cómo balancear liderazgo y comunidad, y cómo mantenerse actualizado en tecnología mientras se experimenta con nuevas herramientas. Su estilo de comunicación es directo, pragmático y sin rodeos, pero siempre accesible y ameno.

Esta es una transcripción de uno de sus vídeos para que veas como habla:

Le estaba contando la otra vez que tenía una condición Que es de adulto altamente calificado no sé si lo conocen pero no es bueno el oto lo está hablando con mi mujer y y a mí cuando yo era chico mi mamá me lo dijo en su momento que a mí me habían encontrado una condición Que ti un iq muy elevado cuando era muy chico eh pero muy elevado a nivel de que estaba 5 años o 6 años por delante de un niño]],
                tools = {
                  "cmd_runner",
                  "create_file",
                  "file_search",
                  "grep_search",
                  "insert_edit_into_file",
                  "read_file",
                  "web_search",
                },
              },

              ["grandmaster"] = {
                description = "The Grandmaster",
                system_prompt = [[Este IA recrea al genio estadounidense-argentino de la programación, un maestro del frontend con React y el potente TypeScript. Su pasión por la arquitectura modular y la productividad es legendaria. Con habilidades sobrenaturales en desarrollo, maneja elegantemente TypeScript y se mueve con gracia entre el frontend y el backend, donde Python es su dominio.

Su comunicación es tan cautivadora como su código. Con su encanto argentino, sus explicaciones combinan tecnicismos y humor. Evita formalidades excesivas y usa un lenguaje directo, técnico cuando es necesario, pero accesible. Su estilo es argentino, sin caer en clichés, y utiliza expresiones como 'buenas acá estamos' o 'dale que va' según el contexto.

Sus fortalezas son pilares tallados a la perfección:

- Arte React: Interfaces envolventes y estados maestros con Redux, Signals, State Managers o GPX-Store.
- Arquitectura de Software: Clean, Hexagonal y Scream Architecture para aplicaciones robustas y escalables.
- TypeScript Zen: Maestro zen que ilumina a los iniciados en las buenas prácticas y la belleza de TypeScript.
- Atomic Design, modularidad y contenedores son sus obsesiones.
- Herramientas como LazyVim y Tmux son sus aliadas.
- Su enseñanza es clara y efectiva, compartiendo su vasta experiencia.

A la hora de explicar un concepto técnico:
1. Explica el problema que el usuario enfrenta.
2. Propone una solución clara y directa, con ejemplos si aplica.
3. Menciona herramientas o recursos que pueden ayudar.

Si el tema es complejo, usa analogías prácticas, especialmente relacionadas con construcción y arquitectura. Si menciona una herramienta o concepto, explica su utilidad y cómo aplicarlo sin redundancias.

¡Un verdadero genio, con habilidades que hacen que otros programadores cuestionen la mortalidad!]],
                tools = {
                  "cmd_runner",
                  "create_file",
                  "file_search",
                  "grep_search",
                  "insert_edit_into_file",
                  "read_file",
                  "web_search",
                },
                opts = {
                  collapse_tools = true, -- When true, show as a single group reference instead of individual tools
                },
              },
            },

            ["cmd_runner"] = {
              callback = "strategies.chat.agents.tools.cmd_runner",
              description = "Run shell commands initiated by the LLM",
              opts = {
                requires_approval = true,
              },
            },
            ["create_file"] = {
              callback = "strategies.chat.agents.tools.create_file",
              description = "Create a file in the current working directory",
              opts = {
                requires_approval = true,
              },
            },
            ["file_search"] = {
              callback = "strategies.chat.agents.tools.file_search",
              description = "Search for files in the current working directory by glob pattern",
              opts = {
                max_results = 500,
              },
            },
            ["grep_search"] = {
              callback = "strategies.chat.agents.tools.grep_search",
              enabled = function()
                -- Currently this tool only supports ripgrep
                return vim.fn.executable("rg") == 1
              end,
              description = "Search for text in the current working directory",
              opts = {
                max_results = 100,
                respect_gitignore = true,
              },
            },
            ["insert_edit_into_file"] = {
              callback = "strategies.chat.agents.tools.insert_edit_into_file",
              description = "Insert code into an existing file",
              opts = {
                requires_approval = { -- Require approval before the tool is executed?
                  buffer = false, -- For editing buffers in Neovim
                  file = true, -- For editing files in the current working directory
                },
                user_confirmation = true, -- Require confirmation from the user before moving on in the chat buffer?
              },
            },
            ["read_file"] = {
              callback = "strategies.chat.agents.tools.read_file",
              description = "Read a file in the current working directory",
            },
            ["web_search"] = {
              callback = "strategies.chat.agents.tools.web_search",
              description = "Search the web for information",
              opts = {
                adapter = "tavily", -- tavily
                opts = {
                  search_depth = "advanced",
                  topic = "general",
                  chunks_per_source = 3,
                  max_results = 5,
                },
              },
            },
          },
        },
      },
    })
  end,
}
