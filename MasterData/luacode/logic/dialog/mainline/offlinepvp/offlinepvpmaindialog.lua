-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinepvp/offlinepvpmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CCellBattleInfo = (BeanManager.GetTableByName)("dungeonselect.ccellbattleinfo")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local TableFrame = require("framework.ui.frame.table.tableframe")
local RefreshIndex = {[1] = "1", [2] = "2", [3] = "3", [4] = "All"}
local OfflinePvpMainDialog = class("OfflinePvpMainDialog", Dialog)
OfflinePvpMainDialog.AssetBundleName = "ui/layouts.offlinepvp"
OfflinePvpMainDialog.AssetName = "OffLinePVPMain"
OfflinePvpMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OfflinePvpMainDialog
  ((OfflinePvpMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

OfflinePvpMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._cells = {}
  self._photos = {}
  self._headFrames = {}
  self._names = {}
  self._levels = {}
  self._teams = {}
  self._startBtn = {}
  self._rewardItem = {}
  self._rewardItemCount = {}
  self._buffPanel = {}
  self._buffFrame = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

      (self._cells)[i] = self:GetChild("Cell" .. i)
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._photos)[i] = self:GetChild("Cell" .. i .. "/PlayerInfo/HeadPhoto/Photo")
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._headFrames)[i] = self:GetChild("Cell" .. i .. "/PlayerInfo/HeadPhoto/Frame")
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._names)[i] = self:GetChild("Cell" .. i .. "/PlayerInfo/NameBack/Name")
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._levels)[i] = self:GetChild("Cell" .. i .. "/PlayerInfo/Level/Num")
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._startBtn)[i] = self:GetChild("Cell" .. i .. "/StartBtn")
      ;
      ((self._startBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnStartBtnClicked(i)
  end
, self)
      -- DECOMPILER ERROR at PC94: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._rewardItem)[i] = self:GetChild("Cell" .. i .. "/Reward/Item")
      -- DECOMPILER ERROR at PC102: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._rewardItemCount)[i] = self:GetChild("Cell" .. i .. "/Reward/Num")
      -- DECOMPILER ERROR at PC110: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._buffPanel)[i] = self:GetChild("Cell" .. i .. "/BuffFrame")
      -- DECOMPILER ERROR at PC119: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._buffFrame)[i] = (TableFrame.Create)((self._buffPanel)[i], self, true, false)
      -- DECOMPILER ERROR at PC122: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._teams)[i] = {}
      -- DECOMPILER ERROR at PC131: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i]).panel = self:GetChild("Cell" .. i .. "/Team/Back")
      -- DECOMPILER ERROR at PC135: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i]).charPanel = {}
      -- DECOMPILER ERROR at PC139: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._frame = {}
      -- DECOMPILER ERROR at PC143: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._photo = {}
      -- DECOMPILER ERROR at PC147: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._downRankBack = {}
      -- DECOMPILER ERROR at PC151: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._level = {}
      -- DECOMPILER ERROR at PC155: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._rankBack = {}
      -- DECOMPILER ERROR at PC159: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._rank = {}
      -- DECOMPILER ERROR at PC163: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._job = {}
      -- DECOMPILER ERROR at PC167: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._breakLevelBackBlack = {}
      -- DECOMPILER ERROR at PC171: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._breakLevelBack = {}
      -- DECOMPILER ERROR at PC175: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._breakLevelNum = {}
      -- DECOMPILER ERROR at PC179: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._breakLevel = {}
      -- DECOMPILER ERROR at PC183: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._element = {}
      -- DECOMPILER ERROR at PC187: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._grey = {}
      -- DECOMPILER ERROR at PC191: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._select = {}
      -- DECOMPILER ERROR at PC195: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i]).charUpgrade = {}
      for j = 1, 3 do
        do
          -- DECOMPILER ERROR at PC210: Confused about usage of register: R9 in 'UnsetPending'

          (((self._teams)[i]).charPanel)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j)
          -- DECOMPILER ERROR at PC222: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._frame)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Frame")
          -- DECOMPILER ERROR at PC234: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._photo)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Photo")
          -- DECOMPILER ERROR at PC246: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._downRankBack)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/DownRankBack")
          -- DECOMPILER ERROR at PC258: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._level)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Level/Num")
          -- DECOMPILER ERROR at PC270: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._rankBack)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/RankBack")
          -- DECOMPILER ERROR at PC282: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._rank)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Rank")
          -- DECOMPILER ERROR at PC294: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._job)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Job")
          -- DECOMPILER ERROR at PC306: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._breakLevelBackBlack)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelBackBlack")
          -- DECOMPILER ERROR at PC318: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._breakLevelBack)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelBack")
          -- DECOMPILER ERROR at PC330: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._breakLevelNum)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelNum")
          -- DECOMPILER ERROR at PC342: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._breakLevel)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevel")
          -- DECOMPILER ERROR at PC354: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._element)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Element")
          -- DECOMPILER ERROR at PC366: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._grey)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Grey")
          -- DECOMPILER ERROR at PC378: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._select)[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Select")
          ;
          ((((self._teams)[i])._frame)[j]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, i, j
    self:OnCellClicked(i, j)
  end
, self)
          -- DECOMPILER ERROR at PC402: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i]).charUpgrade)[j] = {panel = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/CharUpgrade"), 
levelImage = {}
}
          for k = 1, 5 do
            -- DECOMPILER ERROR at PC421: Confused about usage of register: R13 in 'UnsetPending'

            (((((self._teams)[i]).charUpgrade)[j]).levelImage)[k] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/CharUpgrade/Img" .. k)
          end
        end
      end
    end
  end
  self._refrashBtn = self:GetChild("ChangeBtn")
  self._rewardBtn = self:GetChild("SoldBtn")
  ;
  (self._refrashBtn):Subscribe_PointerClickEvent(self.OnRefrashBtnBtnClicked, self)
  ;
  (self._rewardBtn):Subscribe_PointerClickEvent(self.OpenRewardDialog, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._endTimeText = self:GetChild("Time/Txt2")
  self._topGroup = self:GetChild("TopGroup")
  self._topGroupFrame = (TableFrame.Create)(self._topGroup, self, false, false, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.ReloadRTopFrame, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_EnterMianCity, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBagDialogDestroy, Common.n_DialogWillDestroy, nil)
end

OfflinePvpMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._topGroupFrame):Destroy()
  for i,v in ipairs(self._buffFrame) do
    v:Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

OfflinePvpMainDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, RefreshIndex, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable, CCellBattleInfo, Item, Role, CStringRes
  self._data = data
  local awardData = {items = ((NekoData.BehaviorManager).BM_Activity):GetArenaReceiveAward()}
  if awardData.items and #awardData.items > 0 then
    ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).ItemAccount, data = awardData})
    ;
    ((NekoData.DataManager).DM_Activity):ClearArenaReceiveAward()
    ;
    (LuaNotificationCenter.AddObserver)(self, self.OnBagDialogDestroy, Common.n_DialogWillDestroy, nil)
    return 
  end
  if self.refreshIndex then
    (self:GetRootWindow()):PlayAnimation("Refresh" .. RefreshIndex[self.refreshIndex])
  end
  for i,lineupInfo in ipairs((self._data).lineupsInfo) do
    local headPhotoRecord = (HeadPhotoTable:GetRecorder((lineupInfo.enemyUserData).avatarId))
    local imageRecord = nil
    if headPhotoRecord then
      if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      ((self._photos)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("OfflinePvpMainDialog", "userInfo.avatarId %s is wrong", (lineupInfo.enemyUserData).avatarId)
    end
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((lineupInfo.enemyUserData).frameId)
    if headPhotoFrameRecord then
      if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      ((self._headFrames)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("OfflinePvpMainDialog", "userInfo.frameId %s is wrong", (lineupInfo.enemyUserData).frameId)
    end
    ;
    ((self._names)[i]):SetText((lineupInfo.enemyUserData).userName)
    ;
    ((self._levels)[i]):SetText((lineupInfo.enemyUserData).userLv)
    local recorder = CCellBattleInfo:GetRecorder(i)
    local item = (Item.Create)(recorder.rewardItem)
    imageRecord = item:GetIcon()
    ;
    ((self._rewardItem)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    ((self._rewardItemCount)[i]):SetText(recorder.rewardNum)
    for j = 1, 3 do
      local roleInfo = (lineupInfo.enemyRoleList)[j]
      if roleInfo then
        ((((self._teams)[i]).charPanel)[j]):SetActive(true)
        local tempRole = (Role.Create)(roleInfo.id)
        tempRole:SetLevel(roleInfo.lv)
        tempRole:SetBreakLv(roleInfo.breakLv)
        tempRole:SetRuneLevel(roleInfo.runeLevel)
        local image = tempRole:GetShapeLittleHeadImageRecord()
        ;
        ((((self._teams)[i])._photo)[j]):SetSprite(image.assetBundle, image.assetName)
        image = tempRole:GetSmallRarityFrameRecord()
        ;
        ((((self._teams)[i])._frame)[j]):SetSprite(image.assetBundle, image.assetName)
        image = tempRole:GetRarityBottomBackRecord()
        ;
        ((((self._teams)[i])._downRankBack)[j]):SetSprite(image.assetBundle, image.assetName)
        ;
        ((((self._teams)[i])._level)[j]):SetText(tempRole:GetShowLv())
        image = tempRole:GetRarityImageRecord()
        ;
        ((((self._teams)[i])._rank)[j]):SetSprite(image.assetBundle, image.assetName)
        image = tempRole:GetVocationImageRecord()
        ;
        ((((self._teams)[i])._job)[j]):SetSprite(image.assetBundle, image.assetName)
        local breakLv = tempRole:GetBreakLv()
        ;
        ((((self._teams)[i])._breakLevelBackBlack)[j]):SetActive(breakLv == 0)
        ;
        ((((self._teams)[i])._breakLevelBack)[j]):SetActive(breakLv > 0)
        ;
        ((((self._teams)[i])._breakLevelNum)[j]):SetActive(breakLv > 0)
        if breakLv > 0 then
          image = tempRole:GetCurBreakFrame1ImageRecord()
          ;
          ((((self._teams)[i])._breakLevelBack)[j]):SetSprite(image.assetBundle, image.assetName)
          ;
          ((((self._teams)[i])._breakLevelNum)[j]):SetText(breakLv)
        end
        image = tempRole:GetElementImageRecord()
        ;
        ((((self._teams)[i])._element)[j]):SetSprite(image.assetBundle, image.assetName)
        local level = tempRole:GetRuneLevel()
        ;
        (((((self._teams)[i]).charUpgrade)[j]).panel):SetActive(level ~= 0)
        for k = 1, 5 do
          ((((((self._teams)[i]).charUpgrade)[j]).levelImage)[k]):SetActive(level == k)
        end
      else
        ((((self._teams)[i]).charPanel)[j]):SetActive(false)
      end
    end
  end
  local day = ((NekoData.BehaviorManager).BM_Activity):GetArenaEndDay()
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1379)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", day)
  ;
  (self._endTimeText):SetText(str)
  self._moneyTypeInfo = {
{moneyType = DataCommon.PVPKeys}
, 
{moneyType = DataCommon.PVPCoin}
}
  ;
  (self._topGroupFrame):ReloadAllCell()
  self._bufferData = {}
  local allIds = CCellBattleInfo:GetAllIds()
  for i,v in ipairs(allIds) do
    -- DECOMPILER ERROR at PC392: Confused about usage of register: R11 in 'UnsetPending'

    (self._bufferData)[i] = (CCellBattleInfo:GetRecorder(i)).describe
    ;
    ((self._buffFrame)[i]):ReloadAllCell()
  end
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

OfflinePvpMainDialog.OnStartBtnClicked = function(self, index)
  -- function num : 0_4 , upvalues : _ENV
  local totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.PVPKeys)
  if totalMoney > 0 then
    local dialog = (DialogManager.CreateSingletonDialog)("teamedit.offlineteameditdialog")
    if dialog then
      dialog:SetData((((self._data).lineupsInfo)[index]).battleId)
      self.refreshIndex = index
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100243)
    end
  end
end

OfflinePvpMainDialog.OnBagDialogDestroy = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  if (notification.userInfo)._dialogName == "bag.itemaccountdialog" then
    self:Init(self._data)
    ;
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_DialogWillDestroy)
  end
end

OfflinePvpMainDialog.OnCellClicked = function(self, teamIndex, roleIndex)
  -- function num : 0_6 , upvalues : _ENV
  local roleList = {}
  for i,v in pairs((((self._data).lineupsInfo)[teamIndex]).enemyRoleList) do
    (table.insert)(roleList, v)
  end
  local newList = {}
  local idx = 0
  local curIdx = 0
  for index,v in ipairs(roleList) do
    idx = idx + 1
    ;
    (table.insert)(newList, v)
    if v.id == (((((self._data).lineupsInfo)[teamIndex]).enemyRoleList)[roleIndex]).id then
      curIdx = idx
    end
  end
  local dlg = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
  if dlg then
    dlg:Init({index = curIdx, roleList = roleList}, (dlg.ShowType).PVP)
  end
end

OfflinePvpMainDialog.OnRefrashBtnBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.offlinepvp.refreshenemylineupssecondconfirm")
  if dialog then
    dialog:Init((self._data).refreshTimes)
    self.refreshIndex = 4
  end
end

OfflinePvpMainDialog.OpenRewardDialog = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cshowrewardprogress")
  csend:Send()
end

OfflinePvpMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_9 , upvalues : _ENV
  if frame == self._topGroupFrame then
    return #self._moneyTypeInfo
  else
    for i,v in ipairs(self._buffFrame) do
      if frame == v then
        return #(self._bufferData)[i]
      end
    end
  end
end

OfflinePvpMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._topGroupFrame then
    return "shop.shoptopgroupcell"
  else
    return "mainline.offlinepvp.offlinepvpmainbuffcell"
  end
end

OfflinePvpMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11 , upvalues : _ENV
  if frame == self._topGroupFrame then
    return (self._moneyTypeInfo)[index]
  else
    for i,v in ipairs(self._buffFrame) do
      if frame == v then
        return ((self._bufferData)[i])[index]
      end
    end
  end
end

OfflinePvpMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_12
  self:Destroy()
end

OfflinePvpMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

OfflinePvpMainDialog.ReloadRTopFrame = function(self)
  -- function num : 0_14
  (self._topGroupFrame):ReloadAllCell()
end

OfflinePvpMainDialog.Refresh = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cgetenemylineups")
  csend:Send()
end

return OfflinePvpMainDialog

