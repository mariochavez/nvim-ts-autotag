local _, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
local log = require('nvim-ts-autotag._log')
local M={}


M.t = function(cmd)
  return vim.api.nvim_replace_termcodes(cmd, true, false, true)
end

M.repeat_key = function(key, num)
    local text=''
    for _ = 1, num, 1 do
       text=text..key
    end
    return text
end


M.key = {
    del = "<del>",
    bs = "<bs>",
    left = "<left>",
    right = "<right>",
    join_left = "<c-g>U<left>",
    join_right = "<c-g>U<right>"
}
M.dump_node = function(node)
    local text=ts_utils.get_node_text(node)
    for _, txt in pairs(text) do
        print(txt)
    end
end

M.is_close_empty_node = function(node)
    local tag_name = ''
    if node ~= nil then
        local text = ts_utils.get_node_text(node)
        tag_name = text[#text-1]
    end
    return tag_name:match("%<%/%>$")
end


M.dump_node_text = function(target)
    log.debug('=============================')
    for node in target:iter_children() do
        local node_type = node:type()
        local text = ts_utils.get_node_text(node)
        log.debug("type:" .. node_type .. " ")
        log.debug(text)
    end
    log.debug('=============================')
end
return M
