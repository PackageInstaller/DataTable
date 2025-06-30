-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sgetreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local ids = protocol.process
  local dialog = (DialogManager.GetDialog)("mainline.offlinepvp.offlinepvprewarddialog")
  if dialog then
    dialog:Refresh(ids)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

