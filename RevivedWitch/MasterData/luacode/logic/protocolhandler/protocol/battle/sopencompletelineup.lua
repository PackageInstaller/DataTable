-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sopencompletelineup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("mainline.resource.completelineupdialog")
  if dialog then
    dialog:Init(protocol)
  else
    dialog = (DialogManager.GetDialog)("mainline.resource.resourcefloordialog")
    if dialog then
      dialog = (DialogManager.CreateSingletonChildDialog)("mainline.resource.completelineupdialog", dialog._dialogName, dialog:GetRootWindow())
    end
    dialog:Init(protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

