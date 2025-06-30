-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guildboss/guildbossrankplayercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CGuildBossInfo = (BeanManager.GetTableByName)("guild.cguildchallengebossinfo")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local GuildBossRankPlayerCell = class("GuildBossRankPlayerCell", Dialog)
GuildBossRankPlayerCell.AssetBundleName = "ui/layouts.guild"
GuildBossRankPlayerCell.AssetName = "GuildBossRankPlayerCell"
GuildBossRankPlayerCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildBossRankPlayerCell
  ((GuildBossRankPlayerCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

GuildBossRankPlayerCell.OnCreate = function(self)
  -- function num : 0_1
  self._rankIcon = {}
  self._cellBack = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

    (self._rankIcon)[i] = self:GetChild("Panel/Rank" .. i)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._cellBack)[i] = self:GetChild("Back" .. i)
  end
  self._selfBack = self:GetChild("BackPlayer")
  self._commonBack = self:GetChild("Back")
  self._rank = self:GetChild("Panel/Rank")
  self._battleTimes = self:GetChild("Panel/Number1")
  ;
  (self._battleTimes):SetText("")
  self._damageNum = self:GetChild("Panel/Number2")
  ;
  (self._damageNum):SetText("")
  self._photo = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._name = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._selfName = self:GetChild("Panel/PlayerInfo/NameBack/NamePlayer")
  self._level = self:GetChild("Panel/PlayerInfo/LvBack/Level")
end

GuildBossRankPlayerCell.OnDestroy = function(self)
  -- function num : 0_2
end

GuildBossRankPlayerCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, CGuildBossInfo, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable
  if (self._cellData).rank > 3 then
    (self._rank):SetText((self._cellData).rank)
  end
  ;
  (self._rank):SetActive((self._cellData).rank > 3)
  for i = 1, 3 do
    ((self._rankIcon)[i]):SetActive(i == (self._cellData).rank)
    ;
    ((self._cellBack)[i]):SetActive(i == (self._cellData).rank)
  end
  ;
  (self._selfBack):SetActive((self._cellData).rank > 3 and (self._cellData).id == (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid)
  ;
  (self._commonBack):SetActive((self._cellData).rank > 3 and (self._cellData).id ~= (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid)
  ;
  (self._selfName):SetActive((self._cellData).id == (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid)
  ;
  (self._name):SetActive((self._cellData).id ~= (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid)
  ;
  (self._selfName):SetText((self._cellData).name)
  ;
  (self._name):SetText((self._cellData).name)
  ;
  (self._level):SetText((self._cellData).lv)
  ;
  (self._battleTimes):SetText((self._cellData).extra)
  local recorder = CGuildBossInfo:GetRecorder((self._delegate)._selectBossId)
  do
    if recorder then
      local Num = (string.format)("%.2f", (self._cellData).score / recorder.point1 * 100)
      Num = Num .. "%"
      ;
      (self._damageNum):SetText(Num)
    end
    local headPhotoRecord = HeadPhotoTable:GetRecorder((self._cellData).avatarId)
    if headPhotoRecord then
      if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      (self._photo):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
    end
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((self._cellData).frameId)
    if headPhotoFrameRecord then
      if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      (self._photoFrame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
    end
    -- DECOMPILER ERROR: 16 unprocessed JMP targets
  end
end

return GuildBossRankPlayerCell

