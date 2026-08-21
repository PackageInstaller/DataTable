-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/user/sitemconverttoframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, ItemTypeEnum, HeadPhotoFrameTable
  ((NekoData.DataManager).DM_Game):OnSItemConvertToFrame(protocol)
  local frameInfo = {}
  frameInfo.gain = 0
  frameInfo.itemtype = ItemTypeEnum.BASEITEM
  frameInfo.id = (HeadPhotoFrameTable:GetRecorder(protocol.frameId)).unlockcondition
  frameInfo.number = 1
  local data = {
items = {}
}
  ;
  (table.insert)(data.items, frameInfo)
  ;
  ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).ItemAccount, data = data})
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

