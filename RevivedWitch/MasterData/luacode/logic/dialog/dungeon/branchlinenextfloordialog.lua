-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/branchlinenextfloordialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSideStoryChapter = (BeanManager.GetTableByName)("dungeonselect.csidestorychapter")
local CSideStoryStage = (BeanManager.GetTableByName)("dungeonselect.csidestorystage")
local CSideStoryRole = (BeanManager.GetTableByName)("dungeonselect.csidestoryrole")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local BranchLineNextFloorDialog = class("BranchLineNextFloorDialog", Dialog)
BranchLineNextFloorDialog.AssetBundleName = "ui/layouts.sidestory"
BranchLineNextFloorDialog.AssetName = "SideStoryMainDungeon"
local limit = nil
local CellType = {Dot = 1, Line = 2}
local MillisecondToDay = 86400000
local StageState = {Lock = 0, UnLockNotStart = 1, StartNotEnd = 2, Pass = 3}
BranchLineNextFloorDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BranchLineNextFloorDialog
  ((BranchLineNextFloorDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

BranchLineNextFloorDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._backImg = self:GetChild("BackImg")
  self._backEffect = self:GetChild("BackImg/Effect")
  self._rolePanel = self:GetChild("Role")
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  self._charName = self:GetChild("Panel/NameBack/Name")
  self._charTitle = self:GetChild("Panel/CharTitle")
  self._regionImg = self:GetChild("Panel/Region/Image")
  self._regionTxt = self:GetChild("Panel/Region/Text")
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
  self._addVIT = self:GetChild("Panel/TopGroup/VIT/Add")
  self._vitRedDot = self:GetChild("Panel/TopGroup/VIT/RedDot")
  self._backBtn = self:GetChild("Panel/LeaveBtn")
  self._menuBtn = self:GetChild("Panel/MenuBtn")
  ;
  (self._menuBtn):SetActive(false)
  self._dotPanel = self:GetChild("Panel/RightPanel/DotArea")
  self._dotFrame = (TableFrame.Create)(self._dotPanel, self, false, true)
  self._goBtn = self:GetChild("Panel/RightPanel/GoBtn")
  self._goOnBtn = self:GetChild("Panel/RightPanel/GoOnBtn")
  self._resetBtn = self:GetChild("Panel/RightPanel/ResetBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._resetBtn):Subscribe_PointerClickEvent(self.OnResetBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._vitPanel):Subscribe_PointerClickEvent(self.OnAddVITBtnClicked, self)
  ;
  (self._item_BackGround):Subscribe_PointerClickEvent(self.OnItemClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetSpiritRedDot, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetSpiritRedDot, Common.n_ItemNumModify, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_ReceiveBranchLineData)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(4)
end

BranchLineNextFloorDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._dotFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (UIBackManager.SetUIBackShow)(false)
end

BranchLineNextFloorDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, StageState, CSideStoryChapter, CSideStoryRole, ImageTable, CSideStoryStage, CRoleLevelCfgTable, Item, limit
  local finishi = ((NekoData.BehaviorManager).BM_Game):GetBranchLineIsFinishiByWordId(data.chapterId)
  local hasPassed = ((NekoData.BehaviorManager).BM_Game):GetBranchHasPassedByWordId(data.chapterId)
  if not ((NekoData.BehaviorManager).BM_Game):GetBranchLineCurrentZoneByWordId(data.chapterId) then
    local currentStageId = ((NekoData.BehaviorManager).BM_Game):GetBranchLineLastZoneByWordId(data.chapterId)
  end
  local stageData = (((NekoData.BehaviorManager).BM_Game):GetBranchLineList())[data.chapterId]
  if stageData then
    stageData = stageData.questInfo
  else
    LogErrorFormat("BranchLineNextFloorDialog", "Cannot find chapter data, id = %s", tostring((self._data).chapterId))
    return 
  end
  local currentStageState = stageData[currentStageId]
  if hasPassed then
    (self._itemBackPanel):SetActive(false)
    ;
    (self._costBack):SetActive(false)
  end
  if finishi then
    (self._goBtn):SetActive(false)
    ;
    (self._goOnBtn):SetActive(false)
    ;
    (self._resetBtn):SetActive(true)
  else
    if currentStageState == StageState.UnLockNotStart then
      (self._goBtn):SetActive(true)
      ;
      (self._goOnBtn):SetActive(false)
      ;
      (self._resetBtn):SetActive(false)
    else
      if currentStageState == StageState.StartNotEnd then
        (self._goBtn):SetActive(false)
        ;
        (self._goOnBtn):SetActive(true)
        ;
        (self._resetBtn):SetActive(false)
      end
    end
  end
  self._data = data
  local recorder = (CSideStoryChapter:GetRecorder(data.chapterId))
  local str = nil
  str = (TextManager.GetText)(recorder.chapternumnametxt)
  ;
  (self._storyTxt):SetText(str)
  str = (TextManager.GetText)(recorder.sidestorytitletxt)
  ;
  (self._storyName):SetText(str)
  self._worldTitleTxt = str
  local charRecorder = CSideStoryRole:GetRecorder(recorder.sidestoryroleid)
  str = (TextManager.GetText)(charRecorder.rolenametxt)
  ;
  (self._charName):SetText(str)
  str = (TextManager.GetText)(charRecorder.rolenicknametxt)
  ;
  (self._charTitle):SetText(str)
  local imageRecord = ImageTable:GetRecorder(charRecorder.roleworldpic)
  ;
  (self._regionImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = ImageTable:GetRecorder(charRecorder.rolegrouppic)
  ;
  (self._teamImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  str = (TextManager.GetText)(charRecorder.roleworldtxt)
  ;
  (self._regionTxt):SetText(str)
  str = (TextManager.GetText)(charRecorder.rolegrouptxt)
  ;
  (self._teamTxt):SetText(str)
  local stageRecorder = CSideStoryStage:GetRecorder(currentStageId)
  str = (TextManager.GetText)(stageRecorder.stagenametxtid)
  ;
  (self._sceneTitle):SetText(str)
  str = (TextManager.GetText)(stageRecorder.stageintrotxt)
  ;
  (self._sceneDescribe):SetText(str)
  local clientBreakLevel = (CRoleLevelCfgTable:GetRecorder(stageRecorder.suggestlvl)).clientBreakLevel
  ;
  (self._levelPanel_Break):SetActive(clientBreakLevel > 0)
  ;
  (self._levelPanel):SetActive(clientBreakLevel == 0)
  if clientBreakLevel > 0 then
    (self._breaklevel):SetText(clientBreakLevel)
    ;
    (self._level_Break):SetText((CRoleLevelCfgTable:GetRecorder(stageRecorder.suggestlvl)).clientLevel)
  else
    (self._level):SetText((CRoleLevelCfgTable:GetRecorder(stageRecorder.suggestlvl)).clientLevel)
  end
  self._firstItem = (Item.Create)((stageRecorder.firstItems)[1])
  imageRecord = (self._firstItem):GetIcon()
  ;
  (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._firstItem):GetPinJiImage()
  ;
  (self._itemBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._spiritCost = stageRecorder.spirit
  local isSpiritEnough = self._spiritCost <= ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  (self._costTxt):SetActive(isSpiritEnough)
  ;
  (self._costTxtRed):SetActive(not isSpiritEnough)
  if isSpiritEnough then
    (self._costTxt):SetText(self._spiritCost)
  else
    (self._costTxtRed):SetText(self._spiritCost)
  end
  limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  (self._vitNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
  if not ImageTable:GetRecorder(recorder.stagebackground) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._backImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if self._handler then
    (self._backEffect):ReleaseEffect(self._handler)
    self._handler = nil
  end
  self._handler = (self._backEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(recorder.stagebackgroundeffect))
  self:SetLive2D(recorder.stageinillu)
  self:SetDotData(stageData)
  self:SetSpiritRedDot()
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

BranchLineNextFloorDialog.Refresh = function(self)
  -- function num : 0_4
  self:Init(self._data)
end

BranchLineNextFloorDialog.SetLive2D = function(self, shapeid)
  -- function num : 0_5 , upvalues : CNpcShapeTable, _ENV, ImageTable
  local shapeRecord = CNpcShapeTable:GetRecorder(shapeid)
  if self._L2DHandler then
    (self._live2D):Release(self._L2DHandler)
    self._L2DHandler = nil
  end
  if (Live2DManager.CanUse)() and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" then
    (self._photo):SetActive(false)
    self._L2DHandler = (self._live2D):AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
  else
    if not ImageTable:GetRecorder(shapeRecord.lihuiID) then
      local lihuiImage = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetActive(true)
    ;
    (self._photo):SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    local scale = shapeRecord.photoScale
    ;
    (self._photo):SetLocalScale(scale, scale, scale)
    ;
    (self._photo):SetAnchoredPosition((shapeRecord.photoLocation)[1], (shapeRecord.photoLocation)[2])
  end
end

BranchLineNextFloorDialog.SetDotData = function(self, stageData)
  -- function num : 0_6 , upvalues : _ENV, CSideStoryStage, CellType, StageState
  self._cellData = {}
  local keys = (table.keys)(stageData)
  ;
  (table.sort)(keys, function(a, b)
    -- function num : 0_6_0 , upvalues : CSideStoryStage
    local shotA = (CSideStoryStage:GetRecorder(a)).stagesort
    local shotB = (CSideStoryStage:GetRecorder(b)).stagesort
    do return shotA < shotB end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for _,id in ipairs(keys) do
    local state = stageData[id]
    local tempDot = {}
    local tempLine = {}
    tempDot.type = CellType.Dot
    tempLine.type = CellType.Line
    if state == StageState.Lock then
      tempDot.lock = true
      tempDot.select = false
      tempLine.lock = true
    else
      if state == StageState.UnLockNotStart then
        tempDot.lock = false
        tempDot.select = true
        tempLine.lock = true
      else
        if state == StageState.StartNotEnd then
          tempDot.lock = false
          tempDot.select = true
          tempLine.lock = false
        else
          tempDot.lock = false
          tempDot.select = false
          tempLine.lock = false
        end
      end
    end
    ;
    (table.insert)(self._cellData, tempDot)
    ;
    (table.insert)(self._cellData, tempLine)
  end
  ;
  (table.remove)(self._cellData)
  ;
  (self._dotFrame):ReloadAllCell()
end

BranchLineNextFloorDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._cellData
end

BranchLineNextFloorDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8 , upvalues : CellType
  if ((self._cellData)[index]).type == CellType.Dot then
    return "mainline.branchline.branchlinestagedotcell"
  else
    if ((self._cellData)[index]).type == CellType.Line then
      return "mainline.branchline.branchlinestagelinecell"
    end
  end
end

BranchLineNextFloorDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._cellData)[index]
end

BranchLineNextFloorDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_10 , upvalues : _ENV, limit
  self._spirit = (notification.userInfo).spirit
  ;
  (self._vitNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
  local isSpiritEnough = self._spiritCost <= ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  (self._costTxt):SetActive(isSpiritEnough)
  ;
  (self._costTxtRed):SetActive(not isSpiritEnough)
  if isSpiritEnough then
    (self._costTxt):SetText(self._spiritCost)
  else
    (self._costTxtRed):SetText(self._spiritCost)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BranchLineNextFloorDialog.OnGoBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self._spirit < self._spiritCost then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    local stageId = ((NekoData.BehaviorManager).BM_Game):GetBranchLineCurrentZoneByWordId((self._data).chapterId)
    if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AssistBattle) then
      ((NekoData.BehaviorManager).BM_Team):SaveTeamEditCopyInfo("BranchLine", stageId)
      local crefreshSupportRoleList = (LuaNetManager.CreateProtocol)("protocol.chat.crefreshsupportrolelist")
      crefreshSupportRoleList:Send()
    else
      do
        local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
        if dialog then
          dialog:SetCopyInfo("BranchLine", stageId)
        end
      end
    end
  end
end

BranchLineNextFloorDialog.OnResetBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(76, {self._worldTitleTxt}, function()
    -- function num : 0_12_0 , upvalues : _ENV, self
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cresetpassedquest")
    csend.resetID = (self._data).chapterId
    csend:Send()
  end
)
end

BranchLineNextFloorDialog.OnAddVITBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

BranchLineNextFloorDialog.OnBackBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(41, nil, function()
    -- function num : 0_14_0 , upvalues : _ENV, self
    local effect = (EffectFactory.CreateJumpBackEffect)()
    effect:Run()
    ;
    ((EffectFactory.CreateThawEffect)()):Run()
    self:Destroy()
  end
, {}, nil, {})
end

BranchLineNextFloorDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

BranchLineNextFloorDialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_16 , upvalues : _ENV, MillisecondToDay
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < MillisecondToDay then
      return true
    end
  end
  return false
end

BranchLineNextFloorDialog.SetSpiritRedDot = function(self)
  -- function num : 0_17
  (self._vitRedDot):SetActive(self:HaveSpiritItemSoonExpire())
end

BranchLineNextFloorDialog.OnItemClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self._firstItem then
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = self._firstItem})
    end
  end
end

return BranchLineNextFloorDialog

