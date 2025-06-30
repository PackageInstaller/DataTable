-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/srolequicklevelup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("character.quicklevelup.quicklevelupconfirmdialog")
  ;
  (DialogManager.DestroySingletonDialog)("character.quicklevelup.quicklevelupmaindialog")
  ;
  ((DialogManager.CreateSingletonDialog)("character.quicklevelup.quicklevelupsuccessdialog")):SetData(protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

