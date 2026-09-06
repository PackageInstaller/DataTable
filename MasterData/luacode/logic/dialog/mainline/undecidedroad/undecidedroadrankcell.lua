local TableFrame = require("framework.ui.frame.table.tableframe")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local UndecidedRoadRankCell = class("UndecidedRoadRankCell", Dialog)
UndecidedRoadRankCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadRankCell.AssetName = "ActivityRoadRankCell"

function UndecidedRoadRankCell:Ctor(...)
  UndecidedRoadRankCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function UndecidedRoadRankCell:OnCreate()
  self._rankIcon = {}
  self._cellBack = {}
  for i = 1, 3 do
    self._rankIcon[i] = self:GetChild("Panel/Rank" .. i)
    self._cellBack[i] = self:GetChild("Back" .. i)
  end
  self._selfBack = self:GetChild("BackPlayer")
  self._commonBack = self:GetChild("Back")
  self._rank = self:GetChild("Panel/Rank")
  self._photo = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._photo:Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  self._photoFrame = self:GetChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._name = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._selfName = self:GetChild("Panel/PlayerInfo/NameBack/NamePlayer")
  self._level = self:GetChild("Panel/PlayerInfo/LvBack/Level")
  self._charIcon = {}
  self._charIcon[LineUpStation.FRONT_ROW] = self:GetChild("Panel/CharBack" .. 3 .. "/Char")
  self._charIcon[LineUpStation.MIDDLE_ROW] = self:GetChild("Panel/CharBack" .. 2 .. "/Char")
  self._charIcon[LineUpStation.BACK_ROW] = self:GetChild("Panel/CharBack" .. 1 .. "/Char")
  self._time = self:GetChild("Panel/Time")
  self._scoreTxt = self:GetChild("Panel/Time/DifficultyTxt")
  self:GetChild("Panel/Click"):Subscribe_PointerClickEvent(self.OnTeamClicked, self)
end

function UndecidedRoadRankCell:OnDestroy()
end

function UndecidedRoadRankCell:RefreshCell()
  if self._cellData.rank > 3 then
    self._rank:SetText(self._cellData.rank)
  end
  self._rank:SetActive(self._cellData.rank > 3)
  for i = 1, 3 do
    self._rankIcon[i]:SetActive(i == self._cellData.rank)
    self._cellBack[i]:SetActive(i == self._cellData.rank)
  end
  self._selfBack:SetActive(self._cellData.rank > 3 and self._cellData.baseUserData.userId == NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._commonBack:SetActive(self._cellData.rank > 3 and self._cellData.baseUserData.userId ~= NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._selfName:SetActive(self._cellData.baseUserData.userId == NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._name:SetActive(self._cellData.baseUserData.userId ~= NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._selfName:SetText(self._cellData.baseUserData.userName)
  self._name:SetText(self._cellData.baseUserData.userName)
  self._level:SetText(self._cellData.baseUserData.userLv)
  local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1107).msgTextID
  str = TextManager.GetText(str)
  local num = self._cellData.undrPanelData.passTime / 1000
  local ret = NekoData.BehaviorManager.BM_Game:GetPreciseDecimal(num, 1)
  str = string.gsub(str, "%$parameter1%$", ret)
  self._time:SetText(str)
  self._scoreTxt:SetText(self._cellData.undrPanelData.score)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(self._cellData.baseUserData.avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photo:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("UndecidedRoadRankCell", "headPhotoRecord not found. avatarId = %s", self._cellData.baseUserData.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(self._cellData.baseUserData.frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photoFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("UndecidedRoadRankCell", "headPhotoFrameRecord not found. frameId = %s", self._cellData.baseUserData.frameId)
  end
  for index, roleid in ipairs(self._cellData.undrPanelData.roleIdList) do
    if self._charIcon[index] then
      if 0 < roleid then
        self._charIcon[index]:SetActive(true)
        local shapeCfg
        local skinId = self._cellData.undrPanelData.roleSkinList[index]
        if 0 < skinId then
          local skin = CSkin:GetRecorder(skinId)
          shapeCfg = CNpcShapeTable:GetRecorder(skin.shapeID)
        else
          local roleCfg = RoleConfigTable:GetRecorder(roleid)
          shapeCfg = CNpcShapeTable:GetRecorder(roleCfg.shapeID)
        end
        local imageRecord = CImagePathTable:GetRecorder(shapeCfg.skillHeadID) or DataCommon.DefaultImageAsset
        self._charIcon[index]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        index = index + 1
      else
        self._charIcon[index]:SetActive(false)
      end
    end
  end
end

function UndecidedRoadRankCell:OnTeamClicked()
  DialogManager.CreateSingletonDialog("mainline.undecidedroad.undecidedroadteaminfodialog"):InitDataInfo(self._cellData, self._delegate._selectDayId)
end

function UndecidedRoadRankCell:OnHeadPhotoClicked()
  if self._cellData.baseUserData.userId ~= NekoData.BehaviorManager.BM_Game:GetUserId() then
    self:SendCLookOtherInfo(self._cellData.baseUserData.userId)
  end
end

function UndecidedRoadRankCell:SendCLookOtherInfo(userId)
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.clookotherinfo")
  if protocol then
    protocol.userId = userId
    protocol:Send()
  end
end

return UndecidedRoadRankCell
