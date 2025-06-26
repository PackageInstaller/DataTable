-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/branchline/branchlinecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSideStoryChapter = (BeanManager.GetTableByName)("dungeonselect.csidestorychapter")
local CSideStoryStage = (BeanManager.GetTableByName)("dungeonselect.csidestorystage")
local CSideStoryRole = (BeanManager.GetTableByName)("dungeonselect.csidestoryrole")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CItemAccessType = (BeanManager.GetTableByName)("item.citemaccesstype")
local Item = require("logic.manager.experimental.types.item")
local BranchLineCell = class("BranchLineCell", Dialog)
BranchLineCell.AssetBundleName = "ui/layouts.sidestory"
BranchLineCell.AssetName = "SideStoryEntryCell"
BranchLineCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BranchLineCell
  ((BranchLineCell.super).Ctor)(self, ...)
  self._data = {}
end

BranchLineCell.OnCreate = function(self)
  -- function num : 0_1
  self._backImage = self:GetChild("Panel/Cell/CharImg")
  self._storyTxt = self:GetChild("Panel/Cell/StoryTxt")
  self._storyName = self:GetChild("Panel/Cell/StoryName")
  self._charName = self:GetChild("Panel/Cell/CharName/CharName")
  self._charTitle = self:GetChild("Panel/Cell/CharName/CharTitle")
  self._new = self:GetChild("Panel/New")
  self._redDot = self:GetChild("Panel/Cell/RedDot")
  self._lock = self:GetChild("Panel/Lock")
  self._lockTxt = self:GetChild("Panel/Lock/Lock/LockTxt")
  self._lockImg = self:GetChild("Panel/Lock/Lock/Image")
  self._unLockBtn = self:GetChild("Panel/Lock/UnLockBtn")
  self._unLockBtnTxt = self:GetChild("Panel/Lock/UnlockTxt")
  self._unLockItemName = self:GetChild("Panel/Lock/Need/ItemName")
  self._unLockItemNum = self:GetChild("Panel/Lock/Need/ItemName/Txt/ItemNum")
  self._unLockItemImage = self:GetChild("Panel/Lock/Need/Image")
  self._current = self:GetChild("Panel/Current")
  self._currentNeme = self:GetChild("Panel/Current/Txt2")
  self._done = self:GetChild("Panel/Done")
  ;
  (self._lockImg):Subscribe_PointerClickEvent(self.UnLockBranchLineWorld, self)
  ;
  (self._unLockBtn):Subscribe_PointerClickEvent(self.UnLockBranchLineWorld, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self._redDot):SetActive(false)
end

BranchLineCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

BranchLineCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CSideStoryChapter, _ENV, CSideStoryRole, ImageTable, Item, CSideStoryStage
  self._data = data
  local recorder = CSideStoryChapter:GetRecorder((self._data).id)
  local str = (TextManager.GetText)(recorder.chapternumnametxt)
  ;
  (self._storyTxt):SetText(str)
  str = (TextManager.GetText)(recorder.sidestorytitletxt)
  ;
  (self._storyName):SetText(str)
  local charRecorder = CSideStoryRole:GetRecorder(recorder.sidestoryroleid)
  str = (TextManager.GetText)(charRecorder.rolenametxt)
  ;
  (self._charName):SetText(str)
  str = (TextManager.GetText)(charRecorder.rolenicknametxt)
  ;
  (self._charTitle):SetText(str)
  local imageRecord = ImageTable:GetRecorder(recorder.selectroleback)
  ;
  (self._backImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.passed then
    (self._done):SetActive(not data.reset)
    ;
    (self._lock):SetActive(not data.unlock)
    ;
    (self._current):SetActive(data.unlock and ((not data.passed or data.passed) and data.reset))
    if recorder.unlockitem == 0 then
      self._unlockByPerDungeon = true
    else
      self._unlockByPerDungeon = false
    end
    if not data.unlock then
      if self._unlockByPerDungeon then
        (self._lockTxt):SetActive(false)
        ;
        (self._unLockItemImage):SetActive(false)
        ;
        (self._unLockItemName):SetActive(false)
      else
        (self._lockTxt):SetActive(true)
        ;
        (self._unLockItemImage):SetActive(true)
        ;
        (self._unLockItemName):SetActive(true)
        str = (TextManager.GetText)(recorder.unlockdialogtxt)
        ;
        (self._lockTxt):SetText(str)
        local item = (Item.Create)(recorder.unlockitem)
        imageRecord = item:GetIcon()
        ;
        (self._unLockItemImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._unLockItemName):SetText(item:GetName())
      end
    elseif not data.passed or data.passed and data.reset then
      local stageRecorder = CSideStoryStage:GetRecorder(data.current)
      ;
      (self._currentNeme):SetText((TextManager.GetText)(stageRecorder.stagenametxtid))
      if data.currentFirst then
        (self._currentNeme):SetText((TextManager.GetText)(charRecorder.rolenametxt))
      end
    end
    ;
    (self._new):SetActive(not data.passed)
    -- DECOMPILER ERROR: 8 unprocessed JMP targets
  end
end

BranchLineCell.OnCellClicked = function(self, index)
  -- function num : 0_4 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(46) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(46)
  end
  if (self._data).unlock then
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.branchline.branchlineworldinfodialog")
    if dialog then
      dialog:Init({chapterId = (self._data).id})
    end
  end
end

BranchLineCell.UnLockBranchLineWorld = function(self)
  -- function num : 0_5 , upvalues : _ENV, CSideStoryChapter, Item
  if not (self._data).unlock then
    if self._unlockByPerDungeon then
      local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cunlocknewsidequest")
      csend.unlockDungeonID = (self._data).id
      csend:Send()
    else
      do
        local recorder = CSideStoryChapter:GetRecorder((self._data).id)
        self._itemId = recorder.unlockitem
        local item = (Item.Create)(self._itemId)
        local itemName = item:GetName()
        local parameter = {itemName, (TextManager.GetText)(recorder.chapternumnametxt), (TextManager.GetText)(recorder.sidestorytitletxt)}
        ;
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(77, parameter, function()
    -- function num : 0_5_0 , upvalues : self
    self:UnLockYesFunction()
  end
, {}, nil, {})
      end
    end
  end
end

BranchLineCell.UnLockYesFunction = function(self)
  -- function num : 0_6 , upvalues : _ENV, Item, CItemAccessType
  local count = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(self._itemId)
  if count > 0 then
    if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(43) then
      ((NekoData.BehaviorManager).BM_Guide):FinishGuide(43)
    end
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cunlocknewsidequest")
    do
      csend.unlockDungeonID = (self._data).id
      csend:Send()
    end
  else
    do
      local item = (Item.Create)(self._itemId)
      local itemName = item:GetName()
      local gainWays = (item:GetGainWays())
      local _gainType = nil
      if #gainWays > 0 then
        _gainType = ((item:GetGainWays())[1]).type
      else
        LogErrorFormat("BranchLineCell", "item %s no GainWays!", item:GetName())
        return 
      end
      local str = (TextManager.GetText)((CItemAccessType:GetRecorder((DataCommon.GainTypeEnum).Tower)).type)
      local parameter = {itemName, str}
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(78, parameter, function()
    -- function num : 0_6_0 , upvalues : _ENV, _gainType
    ((DialogManager.GetGroup)("Modal")):CloseAllDialog()
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
    if dialog then
      local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
      dialog:Init(sceneController)
      dialog:ItemTipsJump({gainType = _gainType})
    end
  end
, {}, nil, {})
    end
  end
end

return BranchLineCell

