-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/activitysummerbuybuildingtip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CHexagonLand = (BeanManager.GetTableByName)("activity.chexagonland")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ActivitySummerBuyBuildingTip = class("ActivitySummerBuyBuildingTip", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local CMessageTip = (BeanManager.GetTableByName)("message.cmessagetip")
ActivitySummerBuyBuildingTip.AssetBundleName = "ui/layouts.activitysummer"
ActivitySummerBuyBuildingTip.AssetName = "ActivitySummerBuy"
ActivitySummerBuyBuildingTip.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActivitySummerBuyBuildingTip
  ((ActivitySummerBuyBuildingTip.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._canClick = false
end

ActivitySummerBuyBuildingTip.OnCreate = function(self)
  -- function num : 0_1
  self._buyBtn = self:GetChild("BuyBtn")
  self._name = self:GetChild("Name")
  self._detail = self:GetChild("Detail")
  self._item = self:GetChild("Item")
  self._materialPanel = self:GetChild("MaterialFrame")
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
end

ActivitySummerBuyBuildingTip.OnDestroy = function(self)
  -- function num : 0_2
  (self._materialFrame):Destroy()
end

ActivitySummerBuyBuildingTip.SetData = function(self, ID)
  -- function num : 0_3 , upvalues : CHexagonLand, CImagePathTable, _ENV, TableFrame
  self._ID = ID
  local recorder = CHexagonLand:GetRecorder(ID)
  if not CImagePathTable:GetRecorder(recorder.image) then
    local image = DataCommon.DefaultImageAsset
  end
  ;
  (self._item):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(recorder.name))
  ;
  (self._detail):SetText((TextManager.GetText)(recorder.destribe))
  if self._materialFrame then
    (self._materialFrame):Destroy()
  end
  self._materialFrame = (TableFrame.Create)(self._materialPanel, self, true, false)
  self._materialsData = {}
  for i,v in ipairs(recorder.itemID) do
    (table.insert)(self._materialsData, {id = v, count = (recorder.itemAmount)[i]})
  end
  ;
  (self._materialFrame):ReloadAllCell()
end

ActivitySummerBuyBuildingTip.OnBuyBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, CMessageTip
  for i,v in ipairs(self._materialsData) do
    local count = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(v.id)
    if count < v.count then
      ((NekoData.BehaviorManager).BM_Message):AddMessageTip((TextManager.GetText)((CMessageTip:GetRecorder(100392)).msgTextID))
      return 
    end
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cupdatesummerconstruction")
  csend.ID = self._ID
  csend.vertical = 0
  csend.abscissa = 0
  csend:Send()
  self:Destroy()
end

ActivitySummerBuyBuildingTip.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._materialsData
end

ActivitySummerBuyBuildingTip.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.swimsuit.swimsuitmaterialcell"
end

ActivitySummerBuyBuildingTip.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._materialsData)[index]
end

return ActivitySummerBuyBuildingTip

