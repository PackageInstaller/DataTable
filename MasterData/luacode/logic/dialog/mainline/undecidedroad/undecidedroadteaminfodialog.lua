local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local RankType = LuaNetManager.GetBeanDef("protocol.ranking.ranktype")
local UndecidedRoadTeamInfoDialog = class("UndecidedRoadTeamInfoDialog", Dialog)
UndecidedRoadTeamInfoDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadTeamInfoDialog.AssetName = "ActivityRoadTeam"
local TableFrame = require("framework.ui.frame.table.tableframe")

function UndecidedRoadTeamInfoDialog:Ctor(...)
  UndecidedRoadTeamInfoDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._rankId = ""
  self._protoData = nil
  self._roleList = {}
end

function UndecidedRoadTeamInfoDialog:OnCreate()
  self._name = self:GetChild("TeamBack/TeamName/Name")
  self._fight = self:GetChild("TeamBack/Fight/Num")
  self._bossIcon = self:GetChild("TeamBack/Team/Team/Boss")
  self._bossName = self:GetChild("TeamBack/Team/Team/Text")
  self._time = self:GetChild("TeamBack/Team/Time")
  self._num1 = self:GetChild("TeamBack/Team/Num1")
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

function UndecidedRoadTeamInfoDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._helper:Destroy()
  self._alternateFrame:Destroy()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
end

function UndecidedRoadTeamInfoDialog:InitDataInfo(data, rankid)
  local cweidingsortcfg = BeanManager.GetTableByName("dungeonselect.cweidingsort")
  local battleId = NekoData.BehaviorManager.BM_UndecidedRoad:GetBattleId(rankid)
  local record = cweidingsortcfg:GetRecorder(battleId)
  if record then
    self._rankId = NekoData.BehaviorManager.BM_UndecidedRoad:GetRankId(rankid)
    local npcShapeRecorder = CNPCShape:GetRecorder(record.bossshapeid)
    if npcShapeRecorder then
      if self._handler ~= 0 then
        self._bossIcon:ReleaseModel(self._handler)
        self._handler = 0
      end
      self._handler = self._bossIcon:AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
      local list = string.split(record.bosspos, ",")
      local position = {
        x = tonumber(list[1]),
        y = tonumber(list[2])
      }
      local scale = tonumber(record.bossscale)
      self._bossIcon:SetAnchoredPosition(position.x, position.y)
      self._bossIcon:SetLocalScale(scale, scale, scale)
    end
    self._bossName:SetText(TextManager.GetText(record.nameTextID))
  else
    LogErrorFormat("UndecidedRoadTeamInfoDialog", "record:%s does not exist", battleId)
  end
  self._rank:SetText(data.rank)
  self._name:SetText(data.baseUserData.userName)
  self._fight:SetText(data.undrPanelData.power)
  local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1107).msgTextID
  str = TextManager.GetText(str)
  local num = data.undrPanelData.passTime / 1000
  local ret = NekoData.BehaviorManager.BM_Game:GetPreciseDecimal(num, 1)
  str = string.gsub(str, "%$parameter1%$", ret)
  self._time:SetText(str)
  self._num1:SetText(data.undrPanelData.score)
  self._roleList = {}
  for index = #data.undrPanelData.roleIdList, 1, -1 do
    local info = {}
    info.index = index
    info.roleId = data.undrPanelData.roleIdList[index]
    info.level = data.undrPanelData.roleLvList[index]
    info.breakLv = data.undrPanelData.roleBreakList[index]
    info.userId = data.baseUserData.userId
    info.userName = data.baseUserData.userName
    info.rankId = rankid
    info.skin = data.undrPanelData.roleSkinList[index]
    info.runeLevel = data.undrPanelData.runeLevelList[index]
    table.insert(self._roleList, info)
  end
  local userId = self._roleList[1].userId
  local csend = LuaNetManager.CreateProtocol("protocol.ranking.cuserlineupdata")
  csend.uniqueId = userId
  csend.rankType = RankType.UNDECIDED_CHALLENGE
  csend.rankId = self._rankId
  csend:Send()
  self._helper:ReloadAllCell()
  self._alternateFrame:ReloadAllCell()
end

function UndecidedRoadTeamInfoDialog:RefreshData(protocol)
  if RankType.UNDECIDED_CHALLENGE == protocol.userInfo.rankType and protocol.userInfo.rankId == self._rankId then
    self._protoData = protocol
    local roles = protocol.userInfo.lineup.roles
    for k, v in pairs(roles) do
      self._roleList[6 - k + 1].skin = v.skin
    end
  end
  self._helper:ReloadAllCell()
  self._alternateFrame:ReloadAllCell()
end

function UndecidedRoadTeamInfoDialog:GetRoleList()
  local temp = {}
  for i, v in ipairs(self._roleList) do
    table.insert(temp, v)
  end
  return temp
end

function UndecidedRoadTeamInfoDialog:NumberOfCell(helper)
  return 3
end

function UndecidedRoadTeamInfoDialog:CellAtIndex(helper, index)
  if helper == self._helper then
    return "mainline.undecidedroad.undecidedroadrankteamcell"
  else
    return "mainline.undecidedroad.undecidedroadrankteamalternatecell"
  end
end

function UndecidedRoadTeamInfoDialog:DataAtIndex(helper, index)
  if helper == self._helper then
    return self._roleList[index + 3]
  else
    return self._roleList[index]
  end
end

function UndecidedRoadTeamInfoDialog:OnAnimationStateExit(handle, stateName, normalizedTime)
  if stateName == "TeamEditShow" then
    DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  end
end

function UndecidedRoadTeamInfoDialog:OnBackBtnClicked()
  self:Destroy()
end

function UndecidedRoadTeamInfoDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return UndecidedRoadTeamInfoDialog
