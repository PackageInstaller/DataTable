local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CCellBattleInfo = BeanManager.GetTableByName("dungeonselect.ccellbattleinfo")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local TableFrame = require("framework.ui.frame.table.tableframe")
local RefreshIndex = {
  [1] = "1",
  [2] = "2",
  [3] = "3",
  [4] = "All"
}
local OfflinePvpMainDialog = class("OfflinePvpMainDialog", Dialog)
OfflinePvpMainDialog.AssetBundleName = "ui/layouts.offlinepvp"
OfflinePvpMainDialog.AssetName = "OffLinePVPMain"

function OfflinePvpMainDialog:Ctor(...)
  OfflinePvpMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function OfflinePvpMainDialog:OnCreate()
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
    self._cells[i] = self:GetChild("Cell" .. i)
    self._photos[i] = self:GetChild("Cell" .. i .. "/PlayerInfo/HeadPhoto/Photo")
    self._headFrames[i] = self:GetChild("Cell" .. i .. "/PlayerInfo/HeadPhoto/Frame")
    self._names[i] = self:GetChild("Cell" .. i .. "/PlayerInfo/NameBack/Name")
    self._levels[i] = self:GetChild("Cell" .. i .. "/PlayerInfo/Level/Num")
    self._startBtn[i] = self:GetChild("Cell" .. i .. "/StartBtn")
    self._startBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnStartBtnClicked(i)
    end, self)
    self._rewardItem[i] = self:GetChild("Cell" .. i .. "/Reward/Item")
    self._rewardItemCount[i] = self:GetChild("Cell" .. i .. "/Reward/Num")
    self._buffPanel[i] = self:GetChild("Cell" .. i .. "/BuffFrame")
    self._buffFrame[i] = TableFrame.Create(self._buffPanel[i], self, true, false)
    self._teams[i] = {}
    self._teams[i].panel = self:GetChild("Cell" .. i .. "/Team/Back")
    self._teams[i].charPanel = {}
    self._teams[i]._frame = {}
    self._teams[i]._photo = {}
    self._teams[i]._downRankBack = {}
    self._teams[i]._level = {}
    self._teams[i]._rankBack = {}
    self._teams[i]._rank = {}
    self._teams[i]._job = {}
    self._teams[i]._breakLevelBackBlack = {}
    self._teams[i]._breakLevelBack = {}
    self._teams[i]._breakLevelNum = {}
    self._teams[i]._breakLevel = {}
    self._teams[i]._element = {}
    self._teams[i]._grey = {}
    self._teams[i]._select = {}
    self._teams[i].charUpgrade = {}
    for j = 1, 3 do
      self._teams[i].charPanel[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j)
      self._teams[i]._frame[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Frame")
      self._teams[i]._photo[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Photo")
      self._teams[i]._downRankBack[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/DownRankBack")
      self._teams[i]._level[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Level/Num")
      self._teams[i]._rankBack[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/RankBack")
      self._teams[i]._rank[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Rank")
      self._teams[i]._job[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Job")
      self._teams[i]._breakLevelBackBlack[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelBackBlack")
      self._teams[i]._breakLevelBack[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelBack")
      self._teams[i]._breakLevelNum[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelNum")
      self._teams[i]._breakLevel[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevel")
      self._teams[i]._element[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Element")
      self._teams[i]._grey[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Grey")
      self._teams[i]._select[j] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Select")
      self._teams[i]._frame[j]:Subscribe_PointerClickEvent(function()
        self:OnCellClicked(i, j)
      end, self)
      self._teams[i].charUpgrade[j] = {
        panel = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/CharUpgrade"),
        levelImage = {}
      }
      for k = 1, 5 do
        self._teams[i].charUpgrade[j].levelImage[k] = self:GetChild("Cell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/CharUpgrade/Img" .. k)
      end
    end
  end
  self._refrashBtn = self:GetChild("ChangeBtn")
  self._rewardBtn = self:GetChild("SoldBtn")
  self._refrashBtn:Subscribe_PointerClickEvent(self.OnRefrashBtnBtnClicked, self)
  self._rewardBtn:Subscribe_PointerClickEvent(self.OpenRewardDialog, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._endTimeText = self:GetChild("Time/Txt2")
  self._topGroup = self:GetChild("TopGroup")
  self._topGroupFrame = TableFrame.Create(self._topGroup, self, false, false, true)
  LuaNotificationCenter.AddObserver(self, self.ReloadRTopFrame, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_EnterMianCity, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBagDialogDestroy, Common.n_DialogWillDestroy, nil)
end

function OfflinePvpMainDialog:OnDestroy()
  self._topGroupFrame:Destroy()
  for i, v in ipairs(self._buffFrame) do
    v:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function OfflinePvpMainDialog:Init(data)
  self._data = data
  local awardData = {
    items = NekoData.BehaviorManager.BM_Activity:GetArenaReceiveAward()
  }
  if awardData.items and #awardData.items > 0 then
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.ItemAccount,
      data = awardData
    })
    NekoData.DataManager.DM_Activity:ClearArenaReceiveAward()
    LuaNotificationCenter.AddObserver(self, self.OnBagDialogDestroy, Common.n_DialogWillDestroy, nil)
    return
  end
  if self.refreshIndex then
    self:GetRootWindow():PlayAnimation("Refresh" .. RefreshIndex[self.refreshIndex])
  end
  for i, lineupInfo in ipairs(self._data.lineupsInfo) do
    local headPhotoRecord = HeadPhotoTable:GetRecorder(lineupInfo.enemyUserData.avatarId)
    local imageRecord
    if headPhotoRecord then
      imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
      self._photos[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("OfflinePvpMainDialog", "userInfo.avatarId %s is wrong", lineupInfo.enemyUserData.avatarId)
    end
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(lineupInfo.enemyUserData.frameId)
    if headPhotoFrameRecord then
      imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
      self._headFrames[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("OfflinePvpMainDialog", "userInfo.frameId %s is wrong", lineupInfo.enemyUserData.frameId)
    end
    self._names[i]:SetText(lineupInfo.enemyUserData.userName)
    self._levels[i]:SetText(lineupInfo.enemyUserData.userLv)
    local recorder = CCellBattleInfo:GetRecorder(i)
    local item = Item.Create(recorder.rewardItem)
    imageRecord = item:GetIcon()
    self._rewardItem[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._rewardItemCount[i]:SetText(recorder.rewardNum)
    for j = 1, 3 do
      local roleInfo = lineupInfo.enemyRoleList[j]
      if roleInfo then
        self._teams[i].charPanel[j]:SetActive(true)
        local tempRole = Role.Create(roleInfo.id)
        tempRole:SetLevel(roleInfo.lv)
        tempRole:SetBreakLv(roleInfo.breakLv)
        tempRole:SetRuneLevel(roleInfo.runeLevel)
        local image = tempRole:GetShapeLittleHeadImageRecord()
        self._teams[i]._photo[j]:SetSprite(image.assetBundle, image.assetName)
        image = tempRole:GetSmallRarityFrameRecord()
        self._teams[i]._frame[j]:SetSprite(image.assetBundle, image.assetName)
        image = tempRole:GetRarityBottomBackRecord()
        self._teams[i]._downRankBack[j]:SetSprite(image.assetBundle, image.assetName)
        self._teams[i]._level[j]:SetText(tempRole:GetShowLv())
        image = tempRole:GetRarityImageRecord()
        self._teams[i]._rank[j]:SetSprite(image.assetBundle, image.assetName)
        image = tempRole:GetVocationImageRecord()
        self._teams[i]._job[j]:SetSprite(image.assetBundle, image.assetName)
        local breakLv = tempRole:GetBreakLv()
        self._teams[i]._breakLevelBackBlack[j]:SetActive(breakLv == 0)
        self._teams[i]._breakLevelBack[j]:SetActive(0 < breakLv)
        self._teams[i]._breakLevelNum[j]:SetActive(0 < breakLv)
        if 0 < breakLv then
          image = tempRole:GetCurBreakFrame1ImageRecord()
          self._teams[i]._breakLevelBack[j]:SetSprite(image.assetBundle, image.assetName)
          self._teams[i]._breakLevelNum[j]:SetText(breakLv)
        end
        image = tempRole:GetElementImageRecord()
        self._teams[i]._element[j]:SetSprite(image.assetBundle, image.assetName)
        local level = tempRole:GetRuneLevel()
        self._teams[i].charUpgrade[j].panel:SetActive(level ~= 0)
        for k = 1, 5 do
          self._teams[i].charUpgrade[j].levelImage[k]:SetActive(level == k)
        end
      else
        self._teams[i].charPanel[j]:SetActive(false)
      end
    end
  end
  local day = NekoData.BehaviorManager.BM_Activity:GetArenaEndDay()
  local str = TextManager.GetText(CStringRes:GetRecorder(1379).msgTextID)
  str = string.gsub(str, "%$parameter1%$", day)
  self._endTimeText:SetText(str)
  self._moneyTypeInfo = {
    {
      moneyType = DataCommon.PVPKeys
    },
    {
      moneyType = DataCommon.PVPCoin
    }
  }
  self._topGroupFrame:ReloadAllCell()
  self._bufferData = {}
  local allIds = CCellBattleInfo:GetAllIds()
  for i, v in ipairs(allIds) do
    self._bufferData[i] = CCellBattleInfo:GetRecorder(i).describe
    self._buffFrame[i]:ReloadAllCell()
  end
end

function OfflinePvpMainDialog:OnStartBtnClicked(index)
  local totalMoney = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.PVPKeys)
  if 0 < totalMoney then
    local dialog = DialogManager.CreateSingletonDialog("teamedit.offlineteameditdialog")
    if dialog then
      dialog:SetData(self._data.lineupsInfo[index].battleId)
      self.refreshIndex = index
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100243)
  end
end

function OfflinePvpMainDialog:OnBagDialogDestroy(notification)
  if notification.userInfo._dialogName == "bag.itemaccountdialog" then
    self:Init(self._data)
    LuaNotificationCenter.RemoveObserver(self, Common.n_DialogWillDestroy)
  end
end

function OfflinePvpMainDialog:OnCellClicked(teamIndex, roleIndex)
  local roleList = {}
  for i, v in pairs(self._data.lineupsInfo[teamIndex].enemyRoleList) do
    table.insert(roleList, v)
  end
  local newList = {}
  local idx = 0
  local curIdx = 0
  for index, v in ipairs(roleList) do
    idx = idx + 1
    table.insert(newList, v)
    if v.id == self._data.lineupsInfo[teamIndex].enemyRoleList[roleIndex].id then
      curIdx = idx
    end
  end
  local dlg = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
  if dlg then
    dlg:Init({index = curIdx, roleList = roleList}, dlg.ShowType.PVP)
  end
end

function OfflinePvpMainDialog:OnRefrashBtnBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("mainline.offlinepvp.refreshenemylineupssecondconfirm")
  if dialog then
    dialog:Init(self._data.refreshTimes)
    self.refreshIndex = 4
  end
end

function OfflinePvpMainDialog:OpenRewardDialog()
  local csend = LuaNetManager.CreateProtocol("protocol.battle.cshowrewardprogress")
  csend:Send()
end

function OfflinePvpMainDialog:NumberOfCell(frame)
  if frame == self._topGroupFrame then
    return #self._moneyTypeInfo
  else
    for i, v in ipairs(self._buffFrame) do
      if frame == v then
        return #self._bufferData[i]
      end
    end
  end
end

function OfflinePvpMainDialog:CellAtIndex(frame, index)
  if frame == self._topGroupFrame then
    return "shop.shoptopgroupcell"
  else
    return "mainline.offlinepvp.offlinepvpmainbuffcell"
  end
end

function OfflinePvpMainDialog:DataAtIndex(frame, index)
  if frame == self._topGroupFrame then
    return self._moneyTypeInfo[index]
  else
    for i, v in ipairs(self._buffFrame) do
      if frame == v then
        return self._bufferData[i][index]
      end
    end
  end
end

function OfflinePvpMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function OfflinePvpMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function OfflinePvpMainDialog:ReloadRTopFrame()
  self._topGroupFrame:ReloadAllCell()
end

function OfflinePvpMainDialog:Refresh()
  local csend = LuaNetManager.CreateProtocol("protocol.battle.cgetenemylineups")
  csend:Send()
end

return OfflinePvpMainDialog
