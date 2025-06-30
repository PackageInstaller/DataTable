-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/challenge/rank/rankcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local RankCell = class("RankCell", Dialog)
RankCell.AssetBundleName = "ui/layouts.activitysummer2"
RankCell.AssetName = "ActivitySummer2XiGuaRankCell"
RankCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RankCell
  ((RankCell.super).Ctor)(self, ...)
end

RankCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : LineUpStation, _ENV
  self._backs = {}
  self._ranks = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

    (self._backs)[i] = self:GetChild("Back" .. i)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._ranks)[i] = self:GetChild("Panel/Rank" .. i)
  end
  self._selfBack = self:GetChild("BackPlayer")
  self._normalBack = self:GetChild("Back")
  self._normalRank = self:GetChild("Panel/Rank")
  self._name = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._selfName = self:GetChild("Panel/PlayerInfo/NameBack/NamePlayer")
  self._photo = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._level = self:GetChild("Panel/PlayerInfo/LvBack/Level")
  self._charIcons = {}
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._charIcons)[LineUpStation.BACK_ROW] = self:GetChild("Panel/CharBack" .. 1 .. "/Char")
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._charIcons)[LineUpStation.MIDDLE_ROW] = self:GetChild("Panel/CharBack" .. 2 .. "/Char")
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._charIcons)[LineUpStation.FRONT_ROW] = self:GetChild("Panel/CharBack" .. 3 .. "/Char")
  self._time = self:GetChild("Panel/Time")
  self._difficultyTxt = self:GetChild("Panel/Level")
  ;
  (self:GetChild("Panel/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2156))
  ;
  (self:GetChild("Panel/Click")):Subscribe_PointerClickEvent(self.OnTeamClicked, self)
end

RankCell.OnDestroy = function(self)
  -- function num : 0_2
end

RankCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable, CSkin, CNpcShapeTable, RoleConfigTable
  (self._normalRank):SetText(data.rank)
  ;
  (self._normalRank):SetActive(data.rank > 3)
  for i = 1, 3 do
    ((self._ranks)[i]):SetActive(i == data.rank)
    ;
    ((self._backs)[i]):SetActive(i == data.rank)
  end
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  ;
  (self._selfBack):SetActive(data.rank > 3 and (data.baseUserData).userId == userInfo.userid)
  ;
  (self._normalBack):SetActive(data.rank > 3 and (data.baseUserData).userId ~= userInfo.userid)
  ;
  (self._selfName):SetActive((data.baseUserData).userId == userInfo.userid)
  ;
  (self._name):SetActive((data.baseUserData).userId ~= userInfo.userid)
  ;
  (self._selfName):SetText((data.baseUserData).userName)
  ;
  (self._name):SetText((data.baseUserData).userName)
  ;
  (self._level):SetText((data.baseUserData).userLv)
  ;
  (self._difficultyTxt):SetText((data.undrPanelData).score)
  local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1107)).msgTextID
  str = (TextManager.GetText)(str)
  local num = (data.undrPanelData).passTime / 1000
  local ret = ((NekoData.BehaviorManager).BM_Game):GetPreciseDecimal(num, 1)
  str = (string.gsub)(str, "%$parameter1%$", ret)
  ;
  (self._time):SetText(str)
  local headPhotoRecord = HeadPhotoTable:GetRecorder((data.baseUserData).avatarId)
  if headPhotoRecord then
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    (self._photo):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
    LogErrorFormat("RankCell", "headPhotoRecord not found. avatarId = %s", (data.baseUserData).avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((data.baseUserData).frameId)
  if headPhotoFrameRecord then
    if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    (self._photoFrame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
    LogErrorFormat("RankCell", "headPhotoFrameRecord not found. frameId = %s", (data.baseUserData).frameId)
  end
  for index,roleid in ipairs((data.undrPanelData).roleIdList) do
    if (self._charIcons)[index] then
      if roleid > 0 then
        ((self._charIcons)[index]):SetActive(true)
        local shapeCfg = nil
        local skinId = ((data.undrPanelData).roleSkinList)[index]
        if skinId > 0 then
          local skin = CSkin:GetRecorder(skinId)
          shapeCfg = CNpcShapeTable:GetRecorder(skin.shapeID)
        else
          local roleCfg = RoleConfigTable:GetRecorder(roleid)
          shapeCfg = CNpcShapeTable:GetRecorder(roleCfg.shapeID)
        end
        if not CImagePathTable:GetRecorder(shapeCfg.skillHeadID) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        ((self._charIcons)[index]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        index = index + 1
      else
        ((self._charIcons)[index]):SetActive(false)
      end
    end
  end
  -- DECOMPILER ERROR: 20 unprocessed JMP targets
end

RankCell.OnTeamClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.challenge.rank.rankteaminfodialog")):InitDataInfo(self._cellData, ((self._delegate)._delegate)._tabType)
end

return RankCell

