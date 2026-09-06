local CAudioPlayerAlbum = BeanManager.GetTableByName("courtyard.caudioplayeralbum")
local RewardStatus = LuaNetManager.GetBeanDef("protocol.yard.musiccollectionrewardsstatus")
local Item = require("logic.manager.experimental.types.item")
local RewardCell = class("RewardCell", Dialog)
RewardCell.AssetBundleName = "ui/layouts.yard"
RewardCell.AssetName = "MusicPlayerAchievementCell"

function RewardCell:Ctor(...)
  RewardCell.super.Ctor(self, ...)
  self._albumRecords = {}
  local allIds = CAudioPlayerAlbum:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local id = allIds[i]
    self._albumRecords[id] = CAudioPlayerAlbum:GetRecorder(id)
  end
end

function RewardCell:OnCreate()
  self._notGet = self:GetChild("GetBack")
  self._notGet_notFinishedBtn = self:GetChild("GetBack/DownBtn")
  self._notGet_availableBtn = self:GetChild("GetBack/GetBtn")
  self._got = self:GetChild("DownBack")
  self._title = self:GetChild("ItemTxt")
  self._progress = self:GetChild("Loading/Loading/BackGround/Progress")
  self._progress_txt = self:GetChild("Loading/Num/Num")
  self._items = {}
  for i = 1, 2 do
    self._items[i] = {
      panel = self:GetChild("TaskCellItem" .. i),
      icon = self:GetChild("TaskCellItem" .. i .. "/Panel/ItemCell/_BackGround/Icon"),
      frame = self:GetChild("TaskCellItem" .. i .. "/Panel/ItemCell/_BackGround/Frame"),
      count = self:GetChild("TaskCellItem" .. i .. "/Panel/ItemCell/_Count")
    }
    self._items[i].panel:Subscribe_PointerClickEvent(function()
      self:OnItemClick(i)
    end, self)
  end
  self._notGet_availableBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
end

function RewardCell:OnDestroy()
end

function RewardCell:RefreshCell(data)
  self._title:SetText(TextManager.GetText(data.record.audioRewardTypeTxt))
  if data.rewardStatus == RewardStatus.RECEIVED then
    self._got:SetActive(true)
    self._notGet:SetActive(false)
  else
    self._got:SetActive(false)
    self._notGet:SetActive(true)
    if data.rewardStatus == RewardStatus.UNFINISHED then
      self._notGet_notFinishedBtn:SetActive(true)
      self._notGet_availableBtn:SetActive(false)
    else
      self._notGet_notFinishedBtn:SetActive(false)
      self._notGet_availableBtn:SetActive(true)
    end
  end
  local totalNum = 0
  if data.record.audioRewardType == 1 then
    totalNum = data.record.audioRewardNum
  elseif data.record.audioRewardType == 2 then
    totalNum = totalNum + NekoData.BehaviorManager.BM_YardMusic:GetAlbumMusicTotalNum(data.record.audioRewardNum)
  end
  if data.rewardStatus == RewardStatus.UNFINISHED then
    local curNum = 0
    if data.record.audioRewardType == 1 then
      for k, v in pairs(self._albumRecords) do
        curNum = curNum + NekoData.BehaviorManager.BM_YardMusic:GetUnlockMusicNum(k)
      end
    elseif data.record.audioRewardType == 2 then
      curNum = curNum + NekoData.BehaviorManager.BM_YardMusic:GetUnlockMusicNum(data.record.audioRewardNum)
    end
    self._progress:SetFillAmount(curNum / totalNum)
    self._progress_txt:SetText(curNum .. "/" .. totalNum)
  else
    self._progress:SetFillAmount(1)
    self._progress_txt:SetText(totalNum .. "/" .. totalNum)
  end
  local len = #data.record.RewardId
  for i = len + 1, 2 do
    self._items[i].panel:SetActive(false)
  end
  for i = 1, len do
    self._items[i].panel:SetActive(true)
    local item = Item.Create(data.record.RewardId[i])
    local imageRecord = item:GetIcon()
    self._items[i].icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = item:GetPinJiImage()
    self._items[i].frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._items[i].count:SetNumber(data.record.RewardNum[i])
  end
end

function RewardCell:OnGetBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.yard.cmusiccollectionrewardsget")
  local list = {
    [1] = self._cellData.rewardId
  }
  protocol.musicCollectionRewardsList = list
  protocol:Send()
end

function RewardCell:OnItemClick(index)
  local map = self._items[index]
  local width, height = map.panel:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(self._cellData.record.RewardId[index])
    })
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return RewardCell
