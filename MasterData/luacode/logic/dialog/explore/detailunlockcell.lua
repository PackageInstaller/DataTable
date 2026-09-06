local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CExploreAreaCfg = BeanManager.GetTableByName("courtyard.cexplorearea")
local CExploreRarity = BeanManager.GetTableByName("courtyard.cexplorerarity")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Num = 3
local DetailNoBeginCell = class("DetailNoBeginCell", Dialog)
DetailNoBeginCell.AssetBundleName = "ui/layouts.yard"
DetailNoBeginCell.AssetName = "YardExploreTaskCell1"

function DetailNoBeginCell:Ctor(...)
  DetailNoBeginCell.super.Ctor(self, ...)
  self._itemList = {}
end

function DetailNoBeginCell:OnCreate()
  self._backIcon = self:GetChild("Back")
  self._index = self:GetChild("TopBack/LevelBack/Text")
  self._name = self:GetChild("TopBack/Text")
  self._lvTxt = self:GetChild("TopBack/Level")
  self._refreshBtn = self:GetChild("RefreshBtn")
  self._time = self:GetChild("TaskTime/Time")
  self._itemPanel = self:GetChild("TaskReward/ItemFrame")
  self._startBtn = self:GetChild("StartBtn")
  self._iBtn = self:GetChild("Ibtn")
  self._itemFrame = TableFrame.Create(self._itemPanel, self, false, false)
  self._itemFrame_width, self._itemFrame_height = self._itemPanel:GetRectSize()
  self._itemFrame_anchoredx, self._itemFrame_anchoredy = self._itemPanel:GetAnchoredPosition()
  self._startBtn:Subscribe_PointerClickEvent(self.OnStartBtnClicked, self)
  self._refreshBtn:Subscribe_PointerClickEvent(self.OnRefreshBtnClicked, self)
  self._iBtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationExit, self)
end

function DetailNoBeginCell:OnDestroy()
  self._itemFrame:Destroy()
end

function DetailNoBeginCell:RefreshCell(data)
  self._data = self._cellData
  local index = self._delegate:GetSlotIndexBySlotId(data.slotId)
  self._index:SetText(index)
  local record = CExploreAreaCfg:GetRecorder(data.cavernId)
  local imageRecord = CImagePathTable:GetRecorder(record.imageID) or DataCommon.DefaultImageAsset
  self._backIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(record.nameTextID))
  local rarityRecord = CExploreRarity:GetRecorder(record.rarity)
  if rarityRecord then
    imageRecord = CImagePathTable:GetRecorder(rarityRecord.explorerarity) or DataCommon.DefaultImageAsset
    self._lvTxt:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogInfoFormat("DescriptionCell", "Can not find record in CExploreRarity by rarity(%s)", record.rarity)
  end
  local time = record.time * 60
  local str = ""
  str = TextManager.GetText(CStringres:GetRecorder(1109).msgTextID)
  str = string.gsub(str, "%$parameter1%$", os.date("!%H", time))
  str = string.gsub(str, "%$parameter2%$", os.date("!%M", time))
  str = string.gsub(str, "%$parameter3%$", os.date("!%S", time))
  self._time:SetText(str)
  while self._itemList[#self._itemList] do
    table.remove(self._itemList, #self._itemList)
  end
  local item = Item.Create(record.mainItem)
  item:SetCount(0)
  table.insert(self._itemList, {item = item, isMainItem = true})
  for i, v in ipairs(record.secondaryItem) do
    item = Item.Create(v)
    item:SetCount(0)
    table.insert(self._itemList, {item = item})
  end
  self._itemFrame:ReloadAllCell()
  local cellPanelWidth = self._itemFrame_width / Num * #self._itemList
  local cellPanelHeight = self._itemFrame:GetTotalLength()
  self._itemPanel:SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  self._itemPanel:SetAnchoredPosition(self._itemFrame_anchoredx, self._itemFrame_anchoredy)
  self._itemFrame:ReloadAllCell()
end

function DetailNoBeginCell:OnStartBtnClicked()
  if NekoData.BehaviorManager.BM_Explore:GetWorkingTaskNum() < NekoData.BehaviorManager.BM_Explore:GetMaxTaskNum() then
    local dialog = DialogManager.CreateSingletonDialog("magictree.chooseroledialog")
    if dialog then
      dialog:Init("StartTask", DataCommon.Explore, self._data.slotId)
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100089)
  end
end

function DetailNoBeginCell:OnRefreshBtnClicked()
  if not self._delegate._enableRefresh then
    return
  end
  local restTimes = NekoData.BehaviorManager.BM_Explore:GetRefreshTimes()
  if 0 < restTimes then
    self._delegate._enableRefresh = false
    local crefreshCavernTask = LuaNetManager.CreateProtocol("protocol.yard.crefreshcaverntask")
    crefreshCavernTask.id = self._data.slotId
    crefreshCavernTask:Send()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100171)
  end
end

function DetailNoBeginCell:OnAnimationExit(handler, stateName, normalizedTime)
  if stateName == "Refresh" then
    self:RefreshCell(NekoData.BehaviorManager.BM_Explore:GetSlotInfoBySlotId(self._data.slotId))
  end
end

function DetailNoBeginCell:NumberOfCell()
  return #self._itemList
end

function DetailNoBeginCell:CellAtIndex(frame, index)
  return "explore.detailslotitemcell"
end

function DetailNoBeginCell:DataAtIndex(frame, index)
  return self._itemList[index]
end

function DetailNoBeginCell:OnEvent(eventName, arg)
  if eventName == "PlayRefreshAnimation" and self._data.slotId == arg then
    self._rootWindow:PlayAnimation("Refresh")
  end
end

function DetailNoBeginCell:OnIBtnClicked()
  DialogManager.CreateSingletonChildDialog("explore.descriptiondialog", self._delegate._dialogName, self._delegate:GetRootWindow())
end

return DetailNoBeginCell
