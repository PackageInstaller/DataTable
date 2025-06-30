-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/xiguarankteamdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local RankType = (LuaNetManager.GetBeanDef)("protocol.ranking.ranktype")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BossChallenge = (LuaNetManager.GetBeanDef)("protocol.ranking.bosschallenge")
local XiGuaRankTeamDialog = class("XiGuaRankTeamDialog", Dialog)
XiGuaRankTeamDialog.AssetBundleName = "ui/layouts.activitysummer"
XiGuaRankTeamDialog.AssetName = "ActivitySummerXiGuaTeam"
XiGuaRankTeamDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : XiGuaRankTeamDialog
  ((XiGuaRankTeamDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._protoData = nil
  self._roleList = {}
end

XiGuaRankTeamDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._bossIcon = self:GetChild("TeamBack/Team/Team/Boss")
  self._bossName = self:GetChild("TeamBack/Team/Team/Text")
  self._maxDamageNum = self:GetChild("TeamBack/Team/Num")
  self._teamRank = self:GetChild("TeamBack/Team/Rank")
  self._teamName = self:GetChild("TeamBack/TeamName/Name")
  self._mainRolePanel = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._minorRolePanel = self:GetChild("TeamBack/CharacterPanel/Frame2")
  self._mainRoleFrame = (TableFrame.Create)(self._mainRolePanel, self, false, false)
  self._minorRoleFrame = (TableFrame.Create)(self._minorRolePanel, self, false, false)
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshData, Common.n_ReceiveOtherUserLineupData, nil)
end

XiGuaRankTeamDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._mainRoleFrame):Destroy()
  ;
  (self._minorRoleFrame):Destroy()
end

XiGuaRankTeamDialog.SetData = function(self, bossData, rankData)
  -- function num : 0_3 , upvalues : CNPCShape, _ENV, BossChallenge, CStringRes, RankType
  self._bossData = bossData
  self._rankData = rankData
  local npcShapeRecorder = CNPCShape:GetRecorder(((self._bossData).cfg).shapeId)
  if npcShapeRecorder then
    if self._handler ~= 0 then
      (self._bossIcon):ReleaseModel(self._handler)
      self._handler = 0
    end
    self._handler = (self._bossIcon):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
    local list = (string.split)(((self._bossData).cfg).position, ",")
    local position = {x = tonumber(list[1]), y = tonumber(list[2])}
    local scale = tonumber(((self._bossData).cfg).scale)
    ;
    (self._bossIcon):SetAnchoredPosition(position.x, position.y)
    ;
    (self._bossIcon):SetLocalScale(scale, scale, scale)
  end
  do
    ;
    (self._bossName):SetText((TextManager.GetText)(((self._bossData).cfg).name))
    ;
    (self._maxDamageNum):SetText(((self._rankData).watermelonPanelData).damage)
    if (self._rankData).rank == BossChallenge.NOT_Challenge then
      (self._teamRank):SetText((TextManager.GetText)((CStringRes:GetRecorder(1420)).msgTextID))
    else
      if (self._rankData).rank == BossChallenge.NOT_ON_LIST then
        (self._teamRank):SetText((TextManager.GetText)((CStringRes:GetRecorder(1421)).msgTextID))
      else
        ;
        (self._teamRank):SetText((self._rankData).rank)
      end
    end
    ;
    (self._teamName):SetText(((self._rankData).baseUserData).userName)
    self._roleList = {}
    for index = #((self._rankData).watermelonPanelData).roleIdList, 1, -1 do
      local info = {}
      info.index = index
      info.roleId = (((self._rankData).watermelonPanelData).roleIdList)[index]
      info.level = (((self._rankData).watermelonPanelData).roleLvList)[index]
      info.breakLv = (((self._rankData).watermelonPanelData).roleBreakList)[index]
      info.userId = ((self._rankData).baseUserData).userId
      info.userName = ((self._rankData).baseUserData).userName
      info.skin = (((self._rankData).watermelonPanelData).roleSkinList)[index]
      info.runeLevel = (((self._rankData).watermelonPanelData).runeLevelList)[index]
      ;
      (table.insert)(self._roleList, info)
    end
    local csend = (LuaNetManager.CreateProtocol)("protocol.ranking.cuserlineupdata")
    csend.uniqueId = ((self._rankData).baseUserData).userId
    csend.rankType = RankType.WATERMELON
    csend.rankId = tostring(((self._bossData).cfg).id)
    csend:Send()
    ;
    (self._mainRoleFrame):ReloadAllCell()
    ;
    (self._minorRoleFrame):ReloadAllCell()
  end
end

XiGuaRankTeamDialog.RefreshData = function(self, protocol)
  -- function num : 0_4 , upvalues : RankType, _ENV
  if RankType.WATERMELON == (protocol.userInfo).rankType and tonumber((protocol.userInfo).rankId) == ((self._bossData).cfg).id then
    self._protoData = protocol
    local roles = ((protocol.userInfo).lineup).roles
    for k,v in pairs(roles) do
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

      ((self._roleList)[6 - k + 1]).skin = v.skin
    end
  end
  do
    ;
    (self._mainRoleFrame):ReloadAllCell()
    ;
    (self._minorRoleFrame):ReloadAllCell()
  end
end

XiGuaRankTeamDialog.GetRoleList = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local temp = {}
  for i,v in ipairs(self._roleList) do
    (table.insert)(temp, v)
  end
  return temp
end

XiGuaRankTeamDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_6
  return 3
end

XiGuaRankTeamDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._mainRoleFrame then
    return "mainline.bossrush.bossrushrankteamcell"
  else
    if frame == self._minorRoleFrame then
      return "mainline.bossrush.bossrushrankteamalternatecell"
    end
  end
end

XiGuaRankTeamDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._mainRoleFrame then
    return (self._roleList)[index + 3]
  else
    if frame == self._minorRoleFrame then
      return (self._roleList)[index]
    end
  end
end

XiGuaRankTeamDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

XiGuaRankTeamDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return XiGuaRankTeamDialog

