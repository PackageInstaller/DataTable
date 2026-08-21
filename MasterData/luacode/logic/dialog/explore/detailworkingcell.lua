-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/explore/detailworkingcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CExploreAreaCfg = (BeanManager.GetTableByName)("courtyard.cexplorearea")
local CExploreRarity = (BeanManager.GetTableByName)("courtyard.cexplorerarity")
local CExploreLvUp = (BeanManager.GetTableByName)("courtyard.cexplorelvup")
local SlotStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.caverntask")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Num = 3
local DetailWorkingCell = class("DetailWorkingCell", Dialog)
DetailWorkingCell.AssetBundleName = "ui/layouts.yard"
DetailWorkingCell.AssetName = "YardExploreTaskCell2"
DetailWorkingCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DetailWorkingCell
  ((DetailWorkingCell.super).Ctor)(self, ...)
  self._getItems = {}
end

DetailWorkingCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._backIcon = self:GetChild("Back")
  self._lvTxt = self:GetChild("Level")
  self._index = self:GetChild("TopBack/LevelBack/Text")
  self._name = self:GetChild("TopBack/Text")
  self._time = self:GetChild("TaskTime/Time")
  self._getTime = self:GetChild("TaskReward/Time")
  self._getRewardTimes = self:GetChild("TitleBack3/Num")
  self._getTimeProgressPanel = self:GetChild("Loading")
  self._getTimeProgress = self:GetChild("Loading/BackGround/Progress")
  self._getBtn = self:GetChild("GetBtn")
  self._finishBtn = self:GetChild("FinishBtn")
  self._finishBtn_redDot = self:GetChild("FinishBtn/RedDot")
  self._rolePanel = self:GetChild("CharFrame")
  self._itemPanel = self:GetChild("TaskReward/ItemFrame")
  self._iBtn = self:GetChild("Ibtn")
  ;
  (self._getRewardTimes):SetActive(false)
  ;
  (self._getTimeProgressPanel):SetActive(false)
  ;
  (self._getBtn):SetActive(false)
  ;
  (self._finishBtn):SetActive(true)
  self._width = (self._rolePanel):GetRectSize()
  self._anchoredx = (self._rolePanel):GetAnchoredPosition()
  self._itemFrame_width = (self._itemPanel):GetRectSize()
  self._itemFrame_anchoredx = (self._itemPanel):GetAnchoredPosition()
  self._roleFrame = (TableFrame.Create)(self._rolePanel, self, false, false)
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false, false)
  ;
  (self._rolePanel):Subscribe_PointerClickEvent(self.OnRolePanelClicked, self)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  ;
  (self._finishBtn):Subscribe_PointerClickEvent(self.OnFinishBtnClicked, self)
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
end

DetailWorkingCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._roleFrame):Destroy()
  ;
  (self._itemFrame):Destroy()
end

DetailWorkingCell.ChangeCellPosition = function(self)
  -- function num : 0_3 , upvalues : Num
  local cellPanelWidth = self._width / Num * #(self._data).roles
  local cellPanelHeight = (self._roleFrame):GetTotalLength()
  ;
  (self._rolePanel):SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  ;
  (self._rolePanel):SetAnchoredPosition(self._anchoredx, self._anchoredy)
  ;
  (self._roleFrame):ReloadAllCell()
  cellPanelWidth = self._itemFrame_width / Num * #self._getItems
  cellPanelHeight = (self._itemFrame):GetTotalLength()
  ;
  (self._itemPanel):SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  ;
  (self._itemPanel):SetAnchoredPosition(self._itemFrame_anchoredx, self._itemFrame_anchoredy)
  ;
  (self._itemFrame):ReloadAllCell()
end

DetailWorkingCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, CExploreAreaCfg, CImagePathTable, CExploreRarity, SlotStateEnum, CStringres
  self._data = data
  while (self._getItems)[#self._getItems] do
    (table.remove)(self._getItems, #self._getItems)
  end
  for i,v in ipairs((self._data).getItems) do
    (table.insert)(self._getItems, {item = v})
  end
  local index = (self._delegate):GetSlotIndexBySlotId(data.slotId)
  ;
  (self._index):SetText(index)
  local record = CExploreAreaCfg:GetRecorder(data.cavernId)
  if not CImagePathTable:GetRecorder(record.imageID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._backIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(record.nameTextID))
  local rarityRecord = CExploreRarity:GetRecorder(record.rarity)
  if rarityRecord then
    if not CImagePathTable:GetRecorder(rarityRecord.explorerarity) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._lvTxt):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogInfoFormat("DescriptionCell", "Can not find record in CExploreRarity by rarity(%s)", record.rarity)
  end
  self._totalTime = record.time * 60 * 1000
  ;
  (self._roleFrame):ReloadAllCell()
  local str = ""
  if data.taskState == SlotStateEnum.DEADLINE then
    str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", "00")
    str = (string.gsub)(str, "%$parameter2%$", "00")
    str = (string.gsub)(str, "%$parameter3%$", "00")
    ;
    (self._time):SetText(str)
    ;
    (self._getTime):SetText(str)
    ;
    (self._finishBtn):SetInteractable(true)
    ;
    (self._finishBtn_redDot):SetActive(true)
  else
    self:RefreshTimeState()
    ;
    (self._roleFrame):FireEvent("RefreshEnergy")
    ;
    (self._finishBtn):SetInteractable(false)
    ;
    (self._finishBtn_redDot):SetActive(false)
    ;
    (self._getBtn):SetInteractable(data.curCapacity > 0)
  end
  ;
  (self._getRewardTimes):SetText(data.getRewardsTimes .. "/" .. (math.ceil)(record.time / record.getRate))
  ;
  (self._getTimeProgress):SetFillAmount(data.getRewardsTimes / (math.ceil)(record.time / record.getRate))
  ;
  (self._itemFrame):ReloadAllCell()
  self:ChangeCellPosition()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DetailWorkingCell.RefreshTimeState = function(self)
  -- function num : 0_5 , upvalues : SlotStateEnum, _ENV, CStringres
  if (self._data).taskState ~= SlotStateEnum.DEADLINE then
    local slotInfo = ((NekoData.BehaviorManager).BM_Explore):GetSlotInfoBySlotId((self._data).slotId)
    local str = ""
    local time = slotInfo.nextGetLeftTime
    if time // 1000 > 0 then
      str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", time // 1000))
      str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", time // 1000))
      str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", time // 1000))
    else
      str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", "00")
      str = (string.gsub)(str, "%$parameter2%$", "00")
      str = (string.gsub)(str, "%$parameter3%$", "00")
    end
    ;
    (self._getTime):SetText(str)
    str = ""
    time = slotInfo.finishLeftTime
    if time // 1000 > 0 then
      str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", time // 1000))
      str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", time // 1000))
      str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", time // 1000))
    else
      str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", "00")
      str = (string.gsub)(str, "%$parameter2%$", "00")
      str = (string.gsub)(str, "%$parameter3%$", "00")
    end
    ;
    (self._time):SetText(str)
  end
end

DetailWorkingCell.OnGetBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local ccollectProduct = (LuaNetManager.CreateProtocol)("protocol.yard.ccollectproduct")
  ccollectProduct.id = (self._data).slotId
  ccollectProduct:Send()
end

DetailWorkingCell.OnFinishBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local carriveDeadLine = (LuaNetManager.CreateProtocol)("protocol.yard.carrivedeadline")
  carriveDeadLine.positionId = (self._data).slotId
  carriveDeadLine:Send()
end

DetailWorkingCell.OnRolePanelClicked = function(self)
  -- function num : 0_8
end

DetailWorkingCell.NumberOfCell = function(self, frame)
  -- function num : 0_9 , upvalues : CExploreLvUp, _ENV
  if frame == self._roleFrame then
    return (CExploreLvUp:GetRecorder(((NekoData.BehaviorManager).BM_Explore):GetLevel())).roleNum
  else
    return #self._getItems
  end
end

DetailWorkingCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._roleFrame then
    return "explore.detailslotrolecell"
  else
    return "explore.detailslotitemcell"
  end
end

DetailWorkingCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._roleFrame then
    return ((self._data).roles)[index]
  else
    return (self._getItems)[index]
  end
end

DetailWorkingCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_12 , upvalues : SlotStateEnum
  if eventName == "RefreshTimeState" and (self._data).taskState ~= SlotStateEnum.DEADLINE then
    self:RefreshTimeState()
  end
end

DetailWorkingCell.OnIBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  (DialogManager.CreateSingletonChildDialog)("explore.descriptiondialog", (self._delegate)._dialogName, (self._delegate):GetRootWindow())
end

return DetailWorkingCell

