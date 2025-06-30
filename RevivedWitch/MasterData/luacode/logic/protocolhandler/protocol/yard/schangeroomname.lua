-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/schangeroomname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Cabin):OnSChangeRoomName(protocol)
  ;
  (DialogManager.DestroySingletonDialog)("courtcabin.changecabinnamedialog")
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100160)
  local dialog = (DialogManager.GetDialog)("courtcabin.cabinmaindialog")
  if dialog then
    dialog:OnRefreshName()
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

