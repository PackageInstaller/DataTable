-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/explore/detailunlockcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CExploreAreaCfg = (BeanManager.GetTableByName)("courtyard.cexplorearea")
local CExploreRarity = (BeanManager.GetTableByName)("courtyard.cexplorerarity")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Num = 3
local DetailNoBeginCell = class("DetailNoBeginCell", Dialog)
DetailNoBeginCell.AssetBundleName = "ui/layouts.yard"
DetailNoBeginCell.AssetName = "YardExploreTaskCell1"
DetailNoBeginCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DetailNoBeginCell
  ((DetailNoBeginCell.super).Ctor)(self, ...)
  self._itemList = {}
end

DetailNoBeginCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._backIcon = self:GetChild("Back")
  self._index = self:GetChild("TopBack/LevelBack/Text")
  self._name = self:GetChild("TopBack/Text")
  self._lvTxt = self:GetChild("TopBack/Level")
  self._refreshBtn = self:GetChild("RefreshBtn")
  self._time = self:GetChild("TaskTime/Time")
  self._itemPanel = self:GetChild("TaskReward/ItemFrame")
  self._startBtn = self:GetChild("StartBtn")
  self._iBtn = self:GetChild("Ibtn")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false, false)
  self._itemFrame_width = (self._itemPanel):GetRectSize()
  self._itemFrame_anchoredx = (self._itemPanel):GetAnchoredPosition()
  ;
  (self._startBtn):Subscribe_PointerClickEvent(self.OnStartBtnClicked, self)
  ;
  (self._refreshBtn):Subscribe_PointerClickEvent(self.OnRefreshBtnClicked, self)
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationExit, self)
end

DetailNoBeginCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._itemFrame):Destroy()
end

DetailNoBeginCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CExploreAreaCfg, CImagePathTable, _ENV, CExploreRarity, CStringres, Item, Num
  self._data = self._cellData
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
  local time = record.time * 60
  local str = ""
  str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", time))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", time))
  str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", time))
  ;
  (self._time):SetText(str)
  while (self._itemList)[#self._itemList] do
    (table.remove)(self._itemList, #self._itemList)
  end
  local item = (Item.Create)(record.mainItem)
  item:SetCount(0)
  ;
  (table.insert)(self._itemList, {item = item, isMainItem = true})
  for i,v in ipairs(record.secondaryItem) do
    item = (Item.Create)(v)
    item:SetCount(0)
    ;
    (table.insert)(self._itemList, {item = item})
  end
  ;
  (self._itemFrame):ReloadAllCell()
  local cellPanelWidth = self._itemFrame_width / Num * #self._itemList
  local cellPanelHeight = (self._itemFrame):GetTotalLength()
  ;
  (self._itemPanel):SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  ;
  (self._itemPanel):SetAnchoredPosition(self._itemFrame_anchoredx, self._itemFrame_anchoredy)
  ;
  (self._itemFrame):ReloadAllCell()
end

DetailNoBeginCell.OnStartBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Explore):GetWorkingTaskNum() < ((NekoData.BehaviorManager).BM_Explore):GetMaxTaskNum() then
    local dialog = (DialogManager.CreateSingletonDialog)("magictree.chooseroledialog")
    if dialog then
      dialog:Init("StartTask", DataCommon.Explore, (self._data).slotId)
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100089)
    end
  end
end

DetailNoBeginCell.OnRefreshBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not (self._delegate)._enableRefresh then
    return 
  end
  local restTimes = ((NekoData.BehaviorManager).BM_Explore):GetRefreshTimes()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  if restTimes > 0 then
    (self._delegate)._enableRefresh = false
    local crefreshCavernTask = (LuaNetManager.CreateProtocol)("protocol.yard.crefreshcaverntask")
    crefreshCavernTask.id = (self._data).slotId
    crefreshCavernTask:Send()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100171)
    end
  end
end

DetailNoBeginCell.OnAnimationExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_6 , upvalues : _ENV
  if stateName == "Refresh" then
    self:RefreshCell(((NekoData.BehaviorManager).BM_Explore):GetSlotInfoBySlotId((self._data).slotId))
  end
end

DetailNoBeginCell.NumberOfCell = function(self)
  -- function num : 0_7
  return #self._itemList
end

DetailNoBeginCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "explore.detailslotitemcell"
end

DetailNoBeginCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._itemList)[index]
end

DetailNoBeginCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_10
  if eventName == "PlayRefreshAnimation" and (self._data).slotId == arg then
    (self._rootWindow):PlayAnimation("Refresh")
  end
end

DetailNoBeginCell.OnIBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (DialogManager.CreateSingletonChildDialog)("explore.descriptiondialog", (self._delegate)._dialogName, (self._delegate):GetRootWindow())
end

return DetailNoBeginCell

