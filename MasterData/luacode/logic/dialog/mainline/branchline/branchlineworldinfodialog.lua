local CSideStoryChapter = BeanManager.GetTableByName("dungeonselect.csidestorychapter")
local CSideStoryStage = BeanManager.GetTableByName("dungeonselect.csidestorystage")
local CSideStoryRole = BeanManager.GetTableByName("dungeonselect.csidestoryrole")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local BranchLineWorldInfoDialog = class("BranchLineWorldInfoDialog", Dialog)
BranchLineWorldInfoDialog.AssetBundleName = "ui/layouts.sidestory"
BranchLineWorldInfoDialog.AssetName = "SideStoryMain"
local limit
local CellType = {Dot = 1, Line = 2}
local MillisecondToDay = 86400000
local StageState = {
  Lock = 0,
  UnLockNotStart = 1,
  StartNotEnd = 2,
  Pass = 3
}

function BranchLineWorldInfoDialog:Ctor(...)
  BranchLineWorldInfoDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function BranchLineWorldInfoDialog:OnCreate()
  self._backImg = self:GetChild("BackImg")
  self._backEffect = self:GetChild("BackImg/Effect")
  self._rolePanel = self:GetChild("Role")
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  self._charName = self:GetChild("Panel/NameBack/Name")
  self._charTitle = self:GetChild("Panel/CharTitle")
  self._regionBackImg = self:GetChild("Panel/Region/TxtBack")
  self._regionImg = self:GetChild("Panel/Region/Image")
  self._regionTxt = self:GetChild("Panel/Region/Text")
  self._teamBackImg = self:GetChild("Panel/Team/TxtBack")
  self._teamImg = self:GetChild("Panel/Team/Image")
  self._teamTxt = self:GetChild("Panel/Team/Text")
  self._storyTxt = self:GetChild("Panel/RightPanel/StoryTxt")
  self._storyName = self:GetChild("Panel/RightPanel/StoryName")
  self._sceneTitle = self:GetChild("Panel/RightPanel/Title")
  self._sceneDescribe = self:GetChild("Panel/RightPanel/Describe")
  self._levelPanel = self:GetChild("Panel/RightPanel/Level")
  self._level = self:GetChild("Panel/RightPanel/Level/Txt2")
  self._levelPanel_Break = self:GetChild("Panel/RightPanel/LevelBreak")
  self._level_Break = self:GetChild("Panel/RightPanel/LevelBreak/Txt2")
  self._breaklevel = self:GetChild("Panel/RightPanel/LevelBreak/BreakNumTxt")
  self._itemBackPanel = self:GetChild("Panel/RightPanel/Item")
  self._item_BackGround = self:GetChild("Panel/RightPanel/Item/ItemCell/_BackGround")
  self._itemBack = self:GetChild("Panel/RightPanel/Item/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/RightPanel/Item/ItemCell/_BackGround/Icon")
  self._costBack = self:GetChild("Panel/RightPanel/CostBack")
  self._costTxt = self:GetChild("Panel/RightPanel/CostBack/Txt2")
  self._costTxtRed = self:GetChild("Panel/RightPanel/CostBack/Txt2Red")
  self._vitPanel = self:GetChild("Panel/TopGroup/VIT")
  self._vitNum = self:GetChild("Panel/TopGroup/VIT/Text")
  self._vitIcon = self:GetChild("Panel/TopGroup/VIT/Icon")
  self._addVIT = self:GetChild("Panel/TopGroup/VIT/Add")
  self._vitRedDot = self:GetChild("Panel/TopGroup/VIT/RedDot")
  self._backBtn = self:GetChild("Panel/BackBtn")
  self._menuBtn = self:GetChild("Panel/MenuBtn")
  self._dotPanel = self:GetChild("Panel/RightPanel/DotArea")
  self._dotFrame = TableFrame.Create(self._dotPanel, self, false, true)
  self._goBtn = self:GetChild("Panel/RightPanel/GoBtn")
  self._goOnBtn = self:GetChild("Panel/RightPanel/GoOnBtn")
  self._resetBtn = self:GetChild("Panel/RightPanel/ResetBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._goOnBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._resetBtn:Subscribe_PointerClickEvent(self.OnResetBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._vitPanel:Subscribe_PointerClickEvent(self.OnAddVITBtnClicked, self)
  self._item_BackGround:Subscribe_PointerClickEvent(self.OnItemClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.SetSpiritRedDot, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.SetSpiritRedDot, Common.n_ItemNumModify, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_ReceiveBranchLineData)
  LuaNotificationCenter.AddObserver(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
end

function BranchLineWorldInfoDialog:OnDestroy()
  self._dotFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BranchLineWorldInfoDialog:Init(data)
  local finishi = NekoData.BehaviorManager.BM_Game:GetBranchLineIsFinishiByWordId(data.chapterId)
  local hasPassed = NekoData.BehaviorManager.BM_Game:GetBranchHasPassedByWordId(data.chapterId)
  local currentStageId = NekoData.BehaviorManager.BM_Game:GetBranchLineCurrentZoneByWordId(data.chapterId) or NekoData.BehaviorManager.BM_Game:GetBranchLineLastZoneByWordId(data.chapterId)
  local stageData = NekoData.BehaviorManager.BM_Game:GetBranchLineList()[data.chapterId]
  if stageData then
    stageData = stageData.questInfo
  else
    LogErrorFormat("BranchLineWorldInfoDialog", "Cannot find chapter data, id = %s", tostring(self._data.chapterId))
    return
  end
  local currentStageState = stageData[currentStageId]
  if hasPassed then
    self._itemBackPanel:SetActive(false)
    self._costBack:SetActive(false)
  end
  if finishi then
    self._goBtn:SetActive(false)
    self._goOnBtn:SetActive(false)
    self._resetBtn:SetActive(true)
  elseif currentStageState == StageState.UnLockNotStart then
    self._goBtn:SetActive(true)
    self._goOnBtn:SetActive(false)
    self._resetBtn:SetActive(false)
  elseif currentStageState == StageState.StartNotEnd then
    self._goBtn:SetActive(false)
    self._goOnBtn:SetActive(true)
    self._resetBtn:SetActive(false)
  end
  self._data = data
  local recorder = CSideStoryChapter:GetRecorder(data.chapterId)
  local str
  str = TextManager.GetText(recorder.chapternumnametxt)
  self._storyTxt:SetText(str)
  str = TextManager.GetText(recorder.sidestorytitletxt)
  self._storyName:SetText(str)
  self._worldTitleTxt = str
  local charRecorder = CSideStoryRole:GetRecorder(recorder.sidestoryroleid)
  str = TextManager.GetText(charRecorder.rolenametxt)
  self._charName:SetText(str)
  str = TextManager.GetText(charRecorder.rolenicknametxt)
  self._charTitle:SetText(str)
  local imageRecord = ImageTable:GetRecorder(charRecorder.roleworldpic)
  self._regionImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = ImageTable:GetRecorder(charRecorder.rolegrouppic)
  self._teamImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  str = TextManager.GetText(charRecorder.roleworldtxt)
  self._regionTxt:SetText(str)
  str = TextManager.GetText(charRecorder.rolegrouptxt)
  self._teamTxt:SetText(str)
  local stageRecorder = CSideStoryStage:GetRecorder(currentStageId)
  str = TextManager.GetText(stageRecorder.stagenametxtid)
  self._sceneTitle:SetText(str)
  str = TextManager.GetText(stageRecorder.stageintrotxt)
  self._sceneDescribe:SetText(str)
  local clientBreakLevel = CRoleLevelCfgTable:GetRecorder(stageRecorder.suggestlvl).clientBreakLevel
  self._levelPanel_Break:SetActive(0 < clientBreakLevel)
  self._levelPanel:SetActive(clientBreakLevel == 0)
  if 0 < clientBreakLevel then
    self._breaklevel:SetText(clientBreakLevel)
    self._level_Break:SetText(CRoleLevelCfgTable:GetRecorder(stageRecorder.suggestlvl).clientLevel)
  else
    self._level:SetText(CRoleLevelCfgTable:GetRecorder(stageRecorder.suggestlvl).clientLevel)
  end
  self._firstItem = Item.Create(stageRecorder.firstItems[1])
  imageRecord = self._firstItem:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._firstItem:GetPinJiImage()
  self._itemBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._spiritCost = stageRecorder.spirit
  local isSpiritEnough = self._spiritCost <= NekoData.BehaviorManager.BM_Currency:GetSpirit()
  self._costTxt:SetActive(isSpiritEnough)
  self._costTxtRed:SetActive(not isSpiritEnough)
  if isSpiritEnough then
    self._costTxt:SetText(self._spiritCost)
  else
    self._costTxtRed:SetText(self._spiritCost)
  end
  limit = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetSpirit()
  self._vitNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(limit))
  imageRecord = ImageTable:GetRecorder(recorder.stagebackground) or DataCommon.DefaultImageAsset
  self._backImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if self._handler then
    self._backEffect:ReleaseEffect(self._handler)
    self._handler = nil
  end
  self._handler = self._backEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(recorder.stagebackgroundeffect))
  self:SetLive2D(recorder.stageinillu)
  self:SetDotData(stageData)
  self:SetSpiritRedDot()
  self:HandleSpriteEvidence()
end

function BranchLineWorldInfoDialog:Refresh()
  self:Init(self._data)
end

function BranchLineWorldInfoDialog:SetLive2D(shapeid)
  local shapeRecord = CNpcShapeTable:GetRecorder(shapeid)
  if self._L2DHandler then
    self._live2D:Release(self._L2DHandler)
    self._L2DHandler = nil
  end
  if Live2DManager.CanUse() and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" then
    self._photo:SetActive(false)
    self._L2DHandler = self._live2D:AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
  else
    local lihuiImage = ImageTable:GetRecorder(shapeRecord.lihuiID) or DataCommon.DefaultImageAsset
    self._photo:SetActive(true)
    self._photo:SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    local scale = shapeRecord.photoScale
    self._photo:SetLocalScale(scale, scale, scale)
    self._photo:SetAnchoredPosition(shapeRecord.photoLocation[1], shapeRecord.photoLocation[2])
  end
end

function BranchLineWorldInfoDialog:SetDotData(stageData)
  self._cellData = {}
  local keys = table.keys(stageData)
  table.sort(keys, function(a, b)
    local shotA = CSideStoryStage:GetRecorder(a).stagesort
    local shotB = CSideStoryStage:GetRecorder(b).stagesort
    return shotA < shotB
  end)
  for _, id in ipairs(keys) do
    local state = stageData[id]
    local tempDot = {}
    local tempLine = {}
    tempDot.type = CellType.Dot
    tempLine.type = CellType.Line
    if state == StageState.Lock then
      tempDot.lock = true
      tempDot.select = false
      tempLine.lock = true
    elseif state == StageState.UnLockNotStart then
      tempDot.lock = false
      tempDot.select = true
      tempLine.lock = true
    elseif state == StageState.StartNotEnd then
      tempDot.lock = false
      tempDot.select = true
      tempLine.lock = false
    else
      tempDot.lock = false
      tempDot.select = false
      tempLine.lock = false
    end
    table.insert(self._cellData, tempDot)
    table.insert(self._cellData, tempLine)
  end
  table.remove(self._cellData)
  self._dotFrame:ReloadAllCell()
end

function BranchLineWorldInfoDialog:NumberOfCell(frame)
  return #self._cellData
end

function BranchLineWorldInfoDialog:CellAtIndex(frame, index)
  if self._cellData[index].type == CellType.Dot then
    return "mainline.branchline.branchlinestagedotcell"
  elseif self._cellData[index].type == CellType.Line then
    return "mainline.branchline.branchlinestagelinecell"
  end
end

function BranchLineWorldInfoDialog:DataAtIndex(frame, index)
  return self._cellData[index]
end

function BranchLineWorldInfoDialog:RefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
  self._vitNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(limit))
  local isSpiritEnough = self._spiritCost <= NekoData.BehaviorManager.BM_Currency:GetSpirit()
  self._costTxt:SetActive(isSpiritEnough)
  self._costTxtRed:SetActive(not isSpiritEnough)
  if isSpiritEnough then
    self._costTxt:SetText(self._spiritCost)
  else
    self._costTxtRed:SetText(self._spiritCost)
  end
end

function BranchLineWorldInfoDialog:OnGoBtnClicked()
  if self._spiritCost > self._spirit then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    local stageId = NekoData.BehaviorManager.BM_Game:GetBranchLineCurrentZoneByWordId(self._data.chapterId)
    if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AssistBattle) then
      NekoData.BehaviorManager.BM_Team:SaveTeamEditCopyInfo("BranchLine", stageId)
      local crefreshSupportRoleList = LuaNetManager.CreateProtocol("protocol.chat.crefreshsupportrolelist")
      crefreshSupportRoleList:Send()
    else
      local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
      if dialog then
        dialog:SetCopyInfo("BranchLine", stageId)
      end
    end
  end
end

function BranchLineWorldInfoDialog:OnResetBtnClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(76, {
    self._worldTitleTxt
  }, function()
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cresetpassedquest")
    csend.resetID = self._data.chapterId
    csend:Send()
  end)
end

function BranchLineWorldInfoDialog:OnAddVITBtnClicked()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

function BranchLineWorldInfoDialog:OnBackBtnClicked()
  self:Destroy()
end

function BranchLineWorldInfoDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function BranchLineWorldInfoDialog:HaveSpiritItemSoonExpire()
  local spiritItems = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(DataCommon.SpiritItemType)
  for i, v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - ServerGameTimer.GetServerTime() < MillisecondToDay then
      return true
    end
  end
  return false
end

function BranchLineWorldInfoDialog:SetSpiritRedDot()
  self._vitRedDot:SetActive(self:HaveSpiritItemSoonExpire())
end

function BranchLineWorldInfoDialog:OnItemClicked()
  if self._firstItem then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._firstItem
      })
    end
  end
end

function BranchLineWorldInfoDialog:HandleSpriteEvidence()
  local haveSpriteEvidence = NekoData.BehaviorManager.BM_Currency:GetSpiritRecoverTimes()[DataCommon.SpriteEvidence]
  if haveSpriteEvidence then
    local imageRecord = ImageTable:GetRecorder(tonumber(CVarconfig:GetRecorder(125).Value)) or DataCommon.DefaultImageAsset
    self._vitIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    local imageRecord = Item.Create(DataCommon.SpiritID):GetIcon()
    self._vitIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

return BranchLineWorldInfoDialog
