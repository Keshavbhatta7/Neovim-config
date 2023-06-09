dofile(vim.g.base46_cache .. "lsp")
require "nvchad_ui.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

require("lspconfig").lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

require("lspconfig").clangd.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  filetypes = {"c", "cpp", "cc", "h", "objc", "objcpp", "cuda", "proto"},

  settings = {
    clangd = {
      diagnostic = {
        enable = true,
        semanticHighlighting = true
      },
      -- specify any additional options for clangd here
      workspace = {
        -- set the path to an array of folders containing the header files
        -- in this example, we're setting it to two folders:
        -- /path/to/my/headers1 and /path/to/my/headers2
        -- replace these with the actual paths to your header files
        includePaths = {"C:/MinGW/include/"}
      }
    },
  },
}


require("lspconfig").html.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  filetypes = {"html", "htm"},

  settings = {
    clangd = {
      diagnostic = {
        enable = true,
        semanticHighlighting = true
      },
      workspace = {
      }
    },
  },
}



require("lspconfig").cssls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  filetypes = {"css"},

  settings = {
    clangd = {
      diagnostic = {
        enable = true,
        semanticHighlighting = true
      },
      workspace = {
      }
    },
  },
}


require("lspconfig").pylsp.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  filetypes = {"py", "python"},

  settings = {
    clangd = {
      diagnostic = {
        enable = true,
        semanticHighlighting = true
      },
      workspace = {
      }
    },
  },
}

return M
