-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/rankcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local RankCell = class("RankCell", Dialog)
RankCell.AssetBundleName = "ui/layouts.activitynewyear"
RankCell.AssetName = "ActivityNewYearRankCell"
RankCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RankCell
  ((RankCell.super).Ctor)(self, ...)
end

RankCell.OnCreate = function(self)
  -- function num : 0_1
  self._rankNum = self:GetChild("Panel/Rank")
  self._back = self:GetChild("Back")
  self._headFrame = self:GetChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._headPhoto = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._userName = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._callScoreNum = self:GetChild("Panel/Num")
  self._level = self:GetChild("Panel/PlayerInfo/LvBack/Level")
  ;
  (self._headPhoto):Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  self._top3Element = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

    (self._top3Element)[i] = {}
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._top3Element)[i]).rankIcon = self:GetChild("Panel/Rank" .. i)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._top3Element)[i]).back = self:GetChild("Back" .. i)
  end
  self._backPlayer = self:GetChild("BackPlayer")
  ;
  (self._backPlayer):SetActive(false)
end

RankCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

RankCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, HeadPhotoFrameTable, CImagePathTable, HeadPhotoTable
  self._data = data
  local userName, score, rank, frameId, avatarId = nil, nil, nil, nil, nil
  userName = ((self._data).baseUserData).userName
  score = (self._data).score
  rank = (self._data).rank
  frameId = ((self._data).baseUserData).frameId
  avatarId = ((self._data).baseUserData).avatarId
  for i,v in ipairs(self._top3Element) do
    (v.rankIcon):SetActive(rank == i)
    ;
    (v.back):SetActive(rank == i)
  end
  ;
  (self._rankNum):SetActive(rank > 3)
  ;
  (self._back):SetActive(rank > 3)
  ;
  (self._rankNum):SetText(rank)
  ;
  (self._callScoreNum):SetText(score)
  ;
  (self._userName):SetText(userName)
  ;
  (self._level):SetText(((self._data).baseUserData).userLv)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(frameId)
  if headPhotoFrameRecord then
    if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    (self._headFrame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
    LogErrorFormat("CallRankCell", "headPhotoFrameRecord not found. frameId = %s", frameId)
  end
  local headPhotoRecord = HeadPhotoTable:GetRecorder(avatarId)
  if headPhotoRecord then
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    (self._headPhoto):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
    LogErrorFormat("CallRankCell", "headPhotoRecord not found. avatarId = %s", avatarId)
  end
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

RankCell.OnHeadPhotoClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.clookotherinfo")
  if protocol then
    protocol.userId = ((self._data).baseUserData).userId
    protocol:Send()
  end
end

return RankCell

