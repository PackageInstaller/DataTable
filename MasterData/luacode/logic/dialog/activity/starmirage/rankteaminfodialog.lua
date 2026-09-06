local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local CStarryMirrorRanking = BeanManager.GetTableByName("dungeonselect.cstarrymirrorranking")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RankType = LuaNetManager.GetBeanDef("protocol.ranking.ranktype")
local TableFrame = require("framework.ui.frame.table.tableframe")
local RankTeamInfoDialog = class("RankTeamInfoDialog", Dialog)
RankTeamInfoDialog.AssetBundleName = "ui/layouts.activitystar"
RankTeamInfoDialog.AssetName = "ActivityStarRankBossTeam"

function RankTeamInfoDialog:Ctor(...)
  RankTeamInfoDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._levelId = 0
  self._protoData = nil
  self._roleList = {}
end

function RankTeamInfoDialog:OnCreate()
  self._name = self:GetChild("TeamBack/PlayerInfo/NameBack/Name")
  self._photo = self:GetChild("TeamBack/PlayerInfo/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("TeamBack/PlayerInfo/HeadPhoto/Frame")
  self._level = self:GetChild("TeamBack/PlayerInfo/LvBack/Level")
  self._bossIcon = self:GetChild("TeamBack/Team/Team/Boss")
  self._bossName = self:GetChild("TeamBack/Team/Team/Text")
  self._time = self:GetChild("TeamBack/Team/Time")
  self._difficultyTxt2 = self:GetChild("TeamBack/Team/Time/DifficultyTxt")
  self._difficultyTxt = self:GetChild("TeamBack/Team/Level")
  self._rank = self:GetChild("TeamBack/Team/Rank")
  self._panel = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._alternatePanel = self:GetChild("TeamBack/CharacterPanel/Frame2")
  self._frame = TableFrame.Create(self._panel, self, false, false, false)
  self._alternateFrame = TableFrame.Create(self._alternatePanel, self, false, false, false)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshData, Common.n_ReceiveOtherUserLineupData, nil)
end

function RankTeamInfoDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
  self._alternateFrame:Destroy()
end

function RankTeamInfoDialog:InitDataInfo(difficultyColorStrType, data, levelId)
  self._levelId = levelId
  self._name:SetText(data.baseUserData.userName)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(data.baseUserData.avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photo:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("RankTeamInfoDialog", "headPhotoRecord not found. avatarId = %s", data.baseUserData.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.baseUserData.frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photoFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("RankTeamInfoDialog", "headPhotoFrameRecord not found. frameId = %s", data.baseUserData.frameId)
  end
  self._level:SetText(data.baseUserData.userLv)
  local rankRecord = CStarryMirrorRanking:GetRecorder(levelId)
  local npcShapeRecorder = CNPCShape:GetRecorder(rankRecord.bossshapeid)
  if npcShapeRecorder then
    if self._handler ~= 0 then
      self._bossIcon:ReleaseModel(self._handler)
      self._handler = 0
    end
    self._handler = self._bossIcon:AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
    local list = string.split(rankRecord.bosspos, ",")
    local position = {
      x = tonumber(list[1]),
      y = tonumber(list[2])
    }
    local scale = tonumber(rankRecord.bossscale)
    self._bossIcon:SetAnchoredPosition(position.x, position.y)
    self._bossIcon:SetLocalScale(scale, scale, scale)
  end
  self._bossName:SetText(TextManager.GetText(rankRecord.nametextid))
  self._rank:SetText(data.rank)
  self._name:SetText(data.baseUserData.userName)
  local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1107).msgTextID
  str = TextManager.GetText(str)
  local num = data.bossPanelData.passTime / 1000
  local ret = NekoData.BehaviorManager.BM_Game:GetPreciseDecimal(num, 1)
  str = string.gsub(str, "%$parameter1%$", ret)
  self._time:SetText(str)
  self._difficultyTxt2:SetText(TextManager.GetText(rankRecord.rankingmarktxt))
  self._difficultyTxt:SetText(NekoData.BehaviorManager.BM_Game:GetBossRushDifficultyColorStr(data.bossPanelData.times, difficultyColorStrType))
  self._roleList = {}
  for index = #data.bossPanelData.roleIdList, 1, -1 do
    local info = {}
    info.roleId = data.bossPanelData.roleIdList[index]
    info.level = data.bossPanelData.roleLvList[index]
    info.breakLv = data.bossPanelData.roleBreakList[index]
    info.userId = data.baseUserData.userId
    info.skin = data.bossPanelData.roleSkinList[index]
    info.runeLevel = data.bossPanelData.runeLevelList[index]
    table.insert(self._roleList, info)
  end
  local userId = self._roleList[1].userId
  local csend = LuaNetManager.CreateProtocol("protocol.ranking.cuserlineupdata")
  csend.uniqueId = userId
  csend.rankType = RankType.BOSS_CHALLENGE
  csend.rankId = tostring(levelId)
  csend:Send()
  self._frame:ReloadAllCell()
  self._alternateFrame:ReloadAllCell()
end

function RankTeamInfoDialog:RefreshData(notification)
  if RankType.BOSS_CHALLENGE == notification.userInfo.rankType and tonumber(notification.userInfo.rankId) == self._levelId then
    self._protoData = notification
    local roles = notification.userInfo.lineup.roles
    for k, v in pairs(roles) do
      self._roleList[6 - k + 1].skin = v.skin
    end
  end
  self._frame:ReloadAllCell()
  self._alternateFrame:ReloadAllCell()
end

function RankTeamInfoDialog:GetRoleList()
  local temp = {}
  for i, v in ipairs(self._roleList) do
    table.insert(temp, v)
  end
  return temp
end

function RankTeamInfoDialog:NumberOfCell(frame)
  return 3
end

function RankTeamInfoDialog:CellAtIndex(helper, index)
  if helper == self._frame then
    return "mainline.bossrush.bossrushrankteamcell"
  else
    return "mainline.bossrush.bossrushrankteamalternatecell"
  end
end

function RankTeamInfoDialog:DataAtIndex(helper, index)
  if helper == self._frame then
    return self._roleList[index + 3]
  else
    return self._roleList[index]
  end
end

function RankTeamInfoDialog:OnBackBtnClicked()
  self:Destroy()
end

function RankTeamInfoDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return RankTeamInfoDialog
