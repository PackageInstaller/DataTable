local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local RankType = LuaNetManager.GetBeanDef("protocol.ranking.ranktype")
local CBossRush = BeanManager.GetTableByName("dungeonselect.cbossrush")
local CWeeklyBossRush = BeanManager.GetTableByName("dungeonselect.cweeklybossrush")
local BossRushTeamInfoDialog = class("BossRushTeamInfoDialog", Dialog)
BossRushTeamInfoDialog.AssetBundleName = "ui/layouts.mainline"
BossRushTeamInfoDialog.AssetName = "BossRushTeam"
local TableFrame = require("framework.ui.frame.table.tableframe")

function BossRushTeamInfoDialog:Ctor(...)
  BossRushTeamInfoDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._rankId = nil
  self._protoData = nil
  self._roleList = {}
end

function BossRushTeamInfoDialog:OnCreate()
  self._name = self:GetChild("TeamBack/TeamName/Name")
  self._fight = self:GetChild("TeamBack/Fight/Num")
  self._bossIcon = self:GetChild("TeamBack/Team/Team/Boss")
  self._bossName = self:GetChild("TeamBack/Team/Team/Text")
  self._time = self:GetChild("TeamBack/Team/Time")
  self._difficultyTxt = self:GetChild("TeamBack/Team/Time/DifficultyTxt")
  self._rank = self:GetChild("TeamBack/Team/Rank")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._frame = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._alternatePanel = self:GetChild("TeamBack/CharacterPanel/Frame2")
  self._helper = TableFrame.Create(self._frame, self, false, false, false)
  self._alternateFrame = TableFrame.Create(self._alternatePanel, self, false, false, false)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshData, Common.n_ReceiveOtherUserLineupData, nil)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  DialogManager.CreateSingletonDialog("guide.blockclickdialog")
end

function BossRushTeamInfoDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._helper:Destroy()
  self._alternateFrame:Destroy()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
end

function BossRushTeamInfoDialog:InitDataInfo(data, bossRushId, isWeekBoss, rankId)
  local tableName = CBossRush
  self._isWeekBoss = isWeekBoss
  if self._isWeekBoss then
    tableName = CWeeklyBossRush
  end
  local bossrushcfg = tableName:GetRecorder(bossRushId)
  if not bossrushcfg then
    LogErrorFormat("BossRushTeamInfoDialog", "isWeekBoss %s bossRushId %s is not exist in cbossrush/cweeklybossrush", isWeekBoss, bossRushId)
  else
    local npcShapeRecorder = CNPCShape:GetRecorder(bossrushcfg.bossshapeid)
    if npcShapeRecorder then
      if self._handler ~= 0 then
        self._bossIcon:ReleaseModel(self._handler)
        self._handler = 0
      end
      self._handler = self._bossIcon:AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
      local list = string.split(bossrushcfg.bosspos, ",")
      local position = {
        x = tonumber(list[1]),
        y = tonumber(list[2])
      }
      local scale = tonumber(bossrushcfg.bossscale)
      self._bossIcon:SetAnchoredPosition(position.x, position.y)
      self._bossIcon:SetLocalScale(scale, scale, scale)
    end
    self._bossName:SetText(TextManager.GetText(bossrushcfg.nameTextID))
  end
  self._rank:SetText(data.rank)
  self._name:SetText(data.baseUserData.userName)
  self._fight:SetText(data.bossPanelData.power)
  local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1107).msgTextID
  str = TextManager.GetText(str)
  local num = data.bossPanelData.passTime / 1000
  local ret = NekoData.BehaviorManager.BM_Game:GetPreciseDecimal(num, 1)
  str = string.gsub(str, "%$parameter1%$", ret)
  self._time:SetText(str)
  self._difficultyTxt:SetText(NekoData.BehaviorManager.BM_Game:GetBossRushDifficultyStr(data.bossPanelData.times, self._isWeekBoss))
  self._roleList = {}
  for index = #data.bossPanelData.roleIdList, 1, -1 do
    local info = {}
    info.index = index
    info.roleId = data.bossPanelData.roleIdList[index]
    info.level = data.bossPanelData.roleLvList[index]
    info.breakLv = data.bossPanelData.roleBreakList[index]
    info.userId = data.baseUserData.userId
    info.userName = data.baseUserData.userName
    info.bossRushId = bossRushId
    info.skin = data.bossPanelData.roleSkinList[index]
    info.runeLevel = data.bossPanelData.runeLevelList[index]
    table.insert(self._roleList, info)
  end
  local userId = self._roleList[1].userId
  local csend = LuaNetManager.CreateProtocol("protocol.ranking.cuserlineupdata")
  csend.uniqueId = userId
  if self._isWeekBoss then
    csend.rankType = RankType.WEEK_BOSS_CHALLENGE
  else
    csend.rankType = RankType.BOSS_CHALLENGE
  end
  if rankId then
    csend.rankId = tostring(rankId)
    self._rankId = rankId
  else
    csend.rankId = tostring(bossRushId)
    self._rankId = bossRushId
  end
  csend:Send()
  self._helper:ReloadAllCell()
  self._alternateFrame:ReloadAllCell()
end

function BossRushTeamInfoDialog:RefreshData(protocol)
  if (RankType.BOSS_CHALLENGE == protocol.userInfo.rankType or RankType.WEEK_BOSS_CHALLENGE == protocol.userInfo.rankType) and tonumber(protocol.userInfo.rankId) == self._rankId then
    self._protoData = protocol
    local roles = protocol.userInfo.lineup.roles
    for k, v in pairs(roles) do
      self._roleList[6 - k + 1].skin = v.skin
    end
  end
  self._helper:ReloadAllCell()
  self._alternateFrame:ReloadAllCell()
end

function BossRushTeamInfoDialog:GetRoleList()
  local temp = {}
  for i, v in ipairs(self._roleList) do
    table.insert(temp, v)
  end
  return temp
end

function BossRushTeamInfoDialog:NumberOfCell(helper)
  return 3
end

function BossRushTeamInfoDialog:CellAtIndex(helper, index)
  if helper == self._helper then
    return "mainline.bossrush.bossrushrankteamcell"
  else
    return "mainline.bossrush.bossrushrankteamalternatecell"
  end
end

function BossRushTeamInfoDialog:DataAtIndex(helper, index)
  if helper == self._helper then
    return self._roleList[index + 3]
  else
    return self._roleList[index]
  end
end

function BossRushTeamInfoDialog:OnAnimationStateExit(handle, stateName, normalizedTime)
  if stateName == "TeamEditShow" then
    DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  end
end

function BossRushTeamInfoDialog:OnBackBtnClicked()
  self:Destroy()
end

function BossRushTeamInfoDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return BossRushTeamInfoDialog
