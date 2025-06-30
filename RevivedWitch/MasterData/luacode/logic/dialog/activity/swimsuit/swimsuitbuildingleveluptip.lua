-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitbuildingleveluptip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CHexagonLand = (BeanManager.GetTableByName)("activity.chexagonland")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SwimSuitBuildingLevelupTip = class("SwimSuitBuildingLevelupTip", Dialog)
local CMessageTip = (BeanManager.GetTableByName)("message.cmessagetip")
SwimSuitBuildingLevelupTip.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitBuildingLevelupTip.AssetName = "ActivitySummerBuildingUp"
SwimSuitBuildingLevelupTip.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitBuildingLevelupTip
  ((SwimSuitBuildingLevelupTip.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

SwimSuitBuildingLevelupTip.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._cancelButton = self:GetChild("CancelButton")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._text = self:GetChild("Text1")
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, false)
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnConfirmClick, self)
end

SwimSuitBuildingLevelupTip.OnDestroy = function(self)
  -- function num : 0_2
end

SwimSuitBuildingLevelupTip.Init = function(self, Id)
  -- function num : 0_3 , upvalues : CHexagonLand, _ENV
  self._id = Id
  self._itemData = {}
  local recorder = CHexagonLand:GetRecorder(Id)
  for i,v in ipairs(recorder.itemID) do
    (table.insert)(self._itemData, {itemID = v, count = (recorder.itemAmount)[i]})
  end
  ;
  (self._frame):ReloadAllCell()
end

SwimSuitBuildingLevelupTip.OnConfirmClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, CMessageTip
  for i,v in ipairs(self._itemData) do
    if ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v.itemID) < v.count then
      ((NekoData.BehaviorManager).BM_Message):AddMessageTip((TextManager.GetText)((CMessageTip:GetRecorder(100392)).msgTextID))
      return 
    end
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cupdatesummerconstruction")
  csend.ID = self._id
  csend:Send()
end

SwimSuitBuildingLevelupTip.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._itemData
end

SwimSuitBuildingLevelupTip.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.swimsuit.swimsuitbattleitemcell"
end

SwimSuitBuildingLevelupTip.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._itemData)[index]
end

SwimSuitBuildingLevelupTip.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

return SwimSuitBuildingLevelupTip

