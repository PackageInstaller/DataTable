local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")

local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSItemConvertToFrame(protocol)
  local frameInfo = {}
  frameInfo.gain = 0
  frameInfo.itemtype = ItemTypeEnum.BASEITEM
  frameInfo.id = HeadPhotoFrameTable:GetRecorder(protocol.frameId).unlockcondition
  frameInfo.number = 1
  local data = {
    items = {}
  }
  table.insert(data.items, frameInfo)
  NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
    tag = DataCommon.ShowDialogType.ItemAccount,
    data = data
  })
end

local function p2(protocol, client)
end

return {p1, p2}
