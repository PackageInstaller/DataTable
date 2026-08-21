-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/party/scheckmemberapply.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local list = protocol.applyMembers
  if list then
    (table.sort)(list, function(a, b)
    -- function num : 0_0_0
    if a.applyTime < b.applyTime then
      return true
    end
    return false
  end
)
  end
  if #list == 0 then
    ((NekoData.DataManager).DM_Guild):ClientCancelApplyRedpoint()
  end
  local dialog = (DialogManager.CreateSingletonDialog)("guild.guildcheckdialog")
  if dialog then
    dialog:Init(list)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

