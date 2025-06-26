-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/yardmusic/rewardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAudioPlayerAlbum = (BeanManager.GetTableByName)("courtyard.caudioplayeralbum")
local RewardStatus = (LuaNetManager.GetBeanDef)("protocol.yard.musiccollectionrewardsstatus")
local Item = require("logic.manager.experimental.types.item")
local RewardCell = class("RewardCell", Dialog)
RewardCell.AssetBundleName = "ui/layouts.yard"
RewardCell.AssetName = "MusicPlayerAchievementCell"
RewardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RewardCell, CAudioPlayerAlbum
  ((RewardCell.super).Ctor)(self, ...)
  self._albumRecords = {}
  local allIds = CAudioPlayerAlbum:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local id = allIds[i]
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._albumRecords)[id] = CAudioPlayerAlbum:GetRecorder(id)
  end
end

RewardCell.OnCreate = function(self)
  -- function num : 0_1
  self._notGet = self:GetChild("GetBack")
  self._notGet_notFinishedBtn = self:GetChild("GetBack/DownBtn")
  self._notGet_availableBtn = self:GetChild("GetBack/GetBtn")
  self._got = self:GetChild("DownBack")
  self._title = self:GetChild("ItemTxt")
  self._progress = self:GetChild("Loading/Loading/BackGround/Progress")
  self._progress_txt = self:GetChild("Loading/Num/Num")
  self._items = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'

      (self._items)[i] = {panel = self:GetChild("TaskCellItem" .. i), icon = self:GetChild("TaskCellItem" .. i .. "/Panel/ItemCell/_BackGround/Icon"), frame = self:GetChild("TaskCellItem" .. i .. "/Panel/ItemCell/_BackGround/Frame"), count = self:GetChild("TaskCellItem" .. i .. "/Panel/ItemCell/_Count")}
      ;
      (((self._items)[i]).panel):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnItemClick(i)
  end
, self)
    end
  end
  ;
  (self._notGet_availableBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
end

RewardCell.OnDestroy = function(self)
  -- function num : 0_2
end

RewardCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, RewardStatus, Item
  (self._title):SetText((TextManager.GetText)((data.record).audioRewardTypeTxt))
  if data.rewardStatus == RewardStatus.RECEIVED then
    (self._got):SetActive(true)
    ;
    (self._notGet):SetActive(false)
  else
    ;
    (self._got):SetActive(false)
    ;
    (self._notGet):SetActive(true)
    if data.rewardStatus == RewardStatus.UNFINISHED then
      (self._notGet_notFinishedBtn):SetActive(true)
      ;
      (self._notGet_availableBtn):SetActive(false)
    else
      ;
      (self._notGet_notFinishedBtn):SetActive(false)
      ;
      (self._notGet_availableBtn):SetActive(true)
    end
  end
  local totalNum = 0
  if (data.record).audioRewardType == 1 then
    totalNum = (data.record).audioRewardNum
  else
    if (data.record).audioRewardType == 2 then
      totalNum = totalNum + ((NekoData.BehaviorManager).BM_YardMusic):GetAlbumMusicTotalNum((data.record).audioRewardNum)
    end
  end
  if data.rewardStatus == RewardStatus.UNFINISHED then
    local curNum = 0
    if (data.record).audioRewardType == 1 then
      for k,v in pairs(self._albumRecords) do
        curNum = curNum + ((NekoData.BehaviorManager).BM_YardMusic):GetUnlockMusicNum(k)
      end
    else
      do
        do
          if (data.record).audioRewardType == 2 then
            curNum = curNum + ((NekoData.BehaviorManager).BM_YardMusic):GetUnlockMusicNum((data.record).audioRewardNum)
          end
          ;
          (self._progress):SetFillAmount((curNum) / (totalNum))
          ;
          (self._progress_txt):SetText(curNum .. "/" .. totalNum)
          ;
          (self._progress):SetFillAmount(1)
          ;
          (self._progress_txt):SetText(totalNum .. "/" .. totalNum)
          local len = #(data.record).RewardId
          for i = len + 1, 2 do
            (((self._items)[i]).panel):SetActive(false)
          end
          for i = 1, len do
            (((self._items)[i]).panel):SetActive(true)
            local item = (Item.Create)(((data.record).RewardId)[i])
            local imageRecord = item:GetIcon()
            ;
            (((self._items)[i]).icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            imageRecord = item:GetPinJiImage()
            ;
            (((self._items)[i]).frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            ;
            (((self._items)[i]).count):SetNumber(((data.record).RewardNum)[i])
          end
        end
      end
    end
  end
end

RewardCell.OnGetBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.yard.cmusiccollectionrewardsget")
  local list = {[1] = (self._cellData).rewardId}
  protocol.musicCollectionRewardsList = list
  protocol:Send()
end

RewardCell.OnItemClick = function(self, index)
  -- function num : 0_5 , upvalues : _ENV, Item
  local map = (self._items)[index]
  local width, height = (map.panel):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)((((self._cellData).record).RewardId)[index])})
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return RewardCell

