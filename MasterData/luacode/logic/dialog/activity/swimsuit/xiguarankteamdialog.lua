local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local RankType = LuaNetManager.GetBeanDef("protocol.ranking.ranktype")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BossChallenge = LuaNetManager.GetBeanDef("protocol.ranking.bosschallenge")
local XiGuaRankTeamDialog = class("XiGuaRankTeamDialog", Dialog)
XiGuaRankTeamDialog.AssetBundleName = "ui/layouts.activitysummer"
XiGuaRankTeamDialog.AssetName = "ActivitySummerXiGuaTeam"

function XiGuaRankTeamDialog:Ctor(...)
  XiGuaRankTeamDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._protoData = nil
  self._roleList = {}
end

function XiGuaRankTeamDialog:OnCreate()
  self._bossIcon = self:GetChild("TeamBack/Team/Team/Boss")
  self._bossName = self:GetChild("TeamBack/Team/Team/Text")
  self._maxDamageNum = self:GetChild("TeamBack/Team/Num")
  self._teamRank = self:GetChild("TeamBack/Team/Rank")
  self._teamName = self:GetChild("TeamBack/TeamName/Name")
  self._mainRolePanel = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._minorRolePanel = self:GetChild("TeamBack/CharacterPanel/Frame2")
  self._mainRoleFrame = TableFrame.Create(self._mainRolePanel, self, false, false)
  self._minorRoleFrame = TableFrame.Create(self._minorRolePanel, self, false, false)
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshData, Common.n_ReceiveOtherUserLineupData, nil)
end

function XiGuaRankTeamDialog:OnDestroy()
  self._mainRoleFrame:Destroy()
  self._minorRoleFrame:Destroy()
end

function XiGuaRankTeamDialog:SetData(bossData, rankData)
  self._bossData = bossData
  self._rankData = rankData
  local npcShapeRecorder = CNPCShape:GetRecorder(self._bossData.cfg.shapeId)
  if npcShapeRecorder then
    if self._handler ~= 0 then
      self._bossIcon:ReleaseModel(self._handler)
      self._handler = 0
    end
    self._handler = self._bossIcon:AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
    local list = string.split(self._bossData.cfg.position, ",")
    local position = {
      x = tonumber(list[1]),
      y = tonumber(list[2])
    }
    local scale = tonumber(self._bossData.cfg.scale)
    self._bossIcon:SetAnchoredPosition(position.x, position.y)
    self._bossIcon:SetLocalScale(scale, scale, scale)
  end
  self._bossName:SetText(TextManager.GetText(self._bossData.cfg.name))
  self._maxDamageNum:SetText(self._rankData.watermelonPanelData.damage)
  if self._rankData.rank == BossChallenge.NOT_Challenge then
    self._teamRank:SetText(TextManager.GetText(CStringRes:GetRecorder(1420).msgTextID))
  elseif self._rankData.rank == BossChallenge.NOT_ON_LIST then
    self._teamRank:SetText(TextManager.GetText(CStringRes:GetRecorder(1421).msgTextID))
  else
    self._teamRank:SetText(self._rankData.rank)
  end
  self._teamName:SetText(self._rankData.baseUserData.userName)
  self._roleList = {}
  for index = #self._rankData.watermelonPanelData.roleIdList, 1, -1 do
    local info = {}
    info.index = index
    info.roleId = self._rankData.watermelonPanelData.roleIdList[index]
    info.level = self._rankData.watermelonPanelData.roleLvList[index]
    info.breakLv = self._rankData.watermelonPanelData.roleBreakList[index]
    info.userId = self._rankData.baseUserData.userId
    info.userName = self._rankData.baseUserData.userName
    info.skin = self._rankData.watermelonPanelData.roleSkinList[index]
    info.runeLevel = self._rankData.watermelonPanelData.runeLevelList[index]
    table.insert(self._roleList, info)
  end
  local csend = LuaNetManager.CreateProtocol("protocol.ranking.cuserlineupdata")
  csend.uniqueId = self._rankData.baseUserData.userId
  csend.rankType = RankType.WATERMELON
  csend.rankId = tostring(self._bossData.cfg.id)
  csend:Send()
  self._mainRoleFrame:ReloadAllCell()
  self._minorRoleFrame:ReloadAllCell()
end

function XiGuaRankTeamDialog:RefreshData(protocol)
  if RankType.WATERMELON == protocol.userInfo.rankType and tonumber(protocol.userInfo.rankId) == self._bossData.cfg.id then
    self._protoData = protocol
    local roles = protocol.userInfo.lineup.roles
    for k, v in pairs(roles) do
      self._roleList[6 - k + 1].skin = v.skin
    end
  end
  self._mainRoleFrame:ReloadAllCell()
  self._minorRoleFrame:ReloadAllCell()
end

function XiGuaRankTeamDialog:GetRoleList()
  local temp = {}
  for i, v in ipairs(self._roleList) do
    table.insert(temp, v)
  end
  return temp
end

function XiGuaRankTeamDialog:NumberOfCell(frame, index)
  return 3
end

function XiGuaRankTeamDialog:CellAtIndex(frame, index)
  if frame == self._mainRoleFrame then
    return "mainline.bossrush.bossrushrankteamcell"
  elseif frame == self._minorRoleFrame then
    return "mainline.bossrush.bossrushrankteamalternatecell"
  end
end

function XiGuaRankTeamDialog:DataAtIndex(frame, index)
  if frame == self._mainRoleFrame then
    return self._roleList[index + 3]
  elseif frame == self._minorRoleFrame then
    return self._roleList[index]
  end
end

function XiGuaRankTeamDialog:OnBackBtnClicked()
  self:Destroy()
end

function XiGuaRankTeamDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return XiGuaRankTeamDialog
