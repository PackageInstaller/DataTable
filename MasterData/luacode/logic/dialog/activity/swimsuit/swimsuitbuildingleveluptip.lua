local CHexagonLand = BeanManager.GetTableByName("activity.chexagonland")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SwimSuitBuildingLevelupTip = class("SwimSuitBuildingLevelupTip", Dialog)
local CMessageTip = BeanManager.GetTableByName("message.cmessagetip")
SwimSuitBuildingLevelupTip.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitBuildingLevelupTip.AssetName = "ActivitySummerBuildingUp"

function SwimSuitBuildingLevelupTip:Ctor(...)
  SwimSuitBuildingLevelupTip.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function SwimSuitBuildingLevelupTip:OnCreate()
  self._cancelButton = self:GetChild("CancelButton")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._text = self:GetChild("Text1")
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, false)
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmClick, self)
end

function SwimSuitBuildingLevelupTip:OnDestroy()
end

function SwimSuitBuildingLevelupTip:Init(Id)
  self._id = Id
  self._itemData = {}
  local recorder = CHexagonLand:GetRecorder(Id)
  for i, v in ipairs(recorder.itemID) do
    table.insert(self._itemData, {
      itemID = v,
      count = recorder.itemAmount[i]
    })
  end
  self._frame:ReloadAllCell()
end

function SwimSuitBuildingLevelupTip:OnConfirmClick()
  for i, v in ipairs(self._itemData) do
    if v.count > NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v.itemID) then
      NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(CMessageTip:GetRecorder(100392).msgTextID))
      return
    end
  end
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cupdatesummerconstruction")
  csend.ID = self._id
  csend:Send()
end

function SwimSuitBuildingLevelupTip:NumberOfCell(frame)
  return #self._itemData
end

function SwimSuitBuildingLevelupTip:CellAtIndex(frame, index)
  return "activity.swimsuit.swimsuitbattleitemcell"
end

function SwimSuitBuildingLevelupTip:DataAtIndex(frame, index)
  return self._itemData[index]
end

function SwimSuitBuildingLevelupTip:OnBackBtnClicked()
  self:Destroy()
end

return SwimSuitBuildingLevelupTip
