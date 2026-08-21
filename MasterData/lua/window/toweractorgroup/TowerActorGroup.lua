local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local EU = require("Common/EquipUtil")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local m_summary
local m_members = {}
local m_membersDetail, m_groups
local m_changedConfirmGroups = {}
local m_locked, m_allDead, m_selectedGroupId, m_selectedGroupData, m_actorsReady, m_unlockGroups, m_level, m_memeberOrderChanged, m_displayAttrs

function SetupWindow()
  CS.EventDelegate.Add(REF.ToggleAttrs.UIToggle.onChange, function()
    m_displayAttrs = CS.UIToggle.current.value
    RefreshAttrDisplay()
  end)
  m_memeberOrderChanged = false
  WU.TraverseChildren(REF.Tabs, function(go, i)
    REF.Tabs[i].GroupGroupLabel.UIHtmlLabel.text = ""
    CS.EventDelegate.Add(REF.Tabs[i].root.UIToggle.onChange, function()
      if CS.UIToggle.current.value and not REF.Tabs[m_selectedGroupId - 1].root.UIToggle.value then
        if table.has(m_unlockGroups, i + 1) then
          m_selectedGroupId = i + 1
          m_actorsReady = false
          UpdateGroupView()
        else
          WU.ShowHintText(WU.GetString("Window_TowerGroupUnlockLv", PB.all("TowerGroupUnlockLv")[i + 1].level))
          this:DelayInvokeInFrames(1, function()
            REF.Tabs[m_selectedGroupId - 1].root.UIToggle.value = true
          end)
        end
      end
    end)
  end)
  WU.BindButtonEvent(REF.ButtonFight, function()
    if not DU.IsWaitingForJob(OnFightClick) then
      OnFightClick()
    end
  end)
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorSlotClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData, replacedIndex, selectedIndex)
    m_memeberOrderChanged = true
    if m_locked then
      local i = replacedIndex + 1
      local j = selectedIndex + 1
      local members = m_groups[tostring(m_selectedGroupId)].members
      members[i], members[j] = members[j], members[i]
      members[i].index, members[j].index = members[j].index, members[i].index
      m_changedConfirmGroups[tostring(m_selectedGroupId)] = patchData
    else
      m_groups[tostring(m_selectedGroupId)] = patchData
    end
    UpdateGroupView()
  end)
end

function InitWindow()
  RefreshAttrDisplay()
  m_unlockGroups = {}
  local unlockRes = PB.all("TowerGroupUnlockLv")
  local level = DB:GetData("fci/baseinfo/").level
  if m_level ~= nil and m_level ~= level then
    this:SetData("fci/tower/actorgroup/", nil)
  end
  m_level = level
  for i = 1, #unlockRes do
    if level >= unlockRes[i].level then
      table.insert(m_unlockGroups, unlockRes[i].groupId)
    end
  end
  m_actorsReady = false
  WU.ToggleRendering(REF.LeftContent, false)
  WU.ToggleRendering(REF.RightContent, false)
  this:Bind("fci/tower/summary/", OnSummaryChange)
end

function OnSummaryChange(result)
  if result == nil then
    return
  end
  m_summary = result
  if m_summary.selectActorGroupId == 0 then
    m_summary.selectActorGroupId = 1
  end
  m_selectedGroupId = m_summary.selectActorGroupId
  m_locked = m_summary.locked
  if m_locked then
    this:BindRemote(DB:GameRequest("fci/tower/actorgroup-confirm/"), OnConfirmedActorGroup)
  else
    this:BindRemote(DB:GameRequest("fci/tower/actorgroup/"), OnActorGroupChange)
  end
  m_selectedGroupData = {selectActorGroupId = m_selectedGroupId}
  this:SetData("fci/SelectedGroupId/tower", m_selectedGroupData)
  this:Bind("fci/SelectedGroupId/tower", function(result)
    if result ~= nil then
      m_summary.selectActorGroupId = result.selectActorGroupId
      REF.Tabs[result.selectActorGroupId - 1].root.UIToggle.value = true
    end
  end)
end

function OnActorSlotClick(go)
  if not m_locked then
    this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
    WU.AcquireWindowAsync("TowerActorSelect")
  end
end

function OnFightClick()
  if m_actorsReady then
    if m_allDead then
      WU.ShowHintText(WU.GetString("WindowTower_TipGroupAllDead"))
    elseif not GU.GroupIsOK(m_members) then
      WU.ShowHintText(WU.GetString("WindowTower_TipGroupInsufficient"))
    elseif m_memeberOrderChanged then
      if m_locked then
        local luaTable = {actorGroups = m_changedConfirmGroups}
        local wireFormatTable = ProtobufT("ApiTowerActorGroupConfirm", luaTable)
        this:GameRequest("fci/tower/actorgroup-confirm/"):Put(wireFormatTable, function(result)
          EnterDungeon()
        end)
      else
        local luaTable = {actorGroups = m_groups}
        local wireFormatTable = ProtobufT("ApiTowerActorGroup", luaTable)
        this:GameRequest("fci/tower/actorgroup/"):Put(wireFormatTable, function(result)
          EnterDungeon()
        end)
      end
    else
      EnterDungeon()
    end
  else
    WU.ShowHintText(WU.GetString("Window_DungeonDataIsNotReady"))
  end
end

function OnConfirmedActorGroup(result)
  if result ~= nil then
    m_groups = result
    WU.ToggleRendering(REF.LeftContent, true)
    WU.ToggleRendering(REF.RightContent, true)
    SetGroupTabView(true)
    UpdateGroupView()
  end
end

function OnActorGroupChange(result)
  if result ~= nil then
    m_groups = result
    WU.ToggleRendering(REF.LeftContent, true)
    WU.ToggleRendering(REF.RightContent, true)
    this:Bind("TowerActorGroupReset", function(flag)
      if flag == true then
        GU.UpdateGroupActorUids({}, m_groups, PB.enum.ActorGroupType.Tower)
        this:SetData("TowerActorGroupReset", false)
      end
    end)
    SetGroupTabView(false)
    UpdateGroupView()
  end
end

function EnterDungeon()
  local floor = m_summary.towerFloor
  local towerReset = this:GetData("TowerActorGroupReset")
  if towerReset == true then
    return
  end
  if floor == 0 and m_groups ~= nil then
    local reset2ZeroUids = {}
    for _, v in pairs(m_groups) do
      for i = 1, #v.members do
        if v.members[i].actorUid ~= 0 then
          table.insert(reset2ZeroUids, v.members[i].actorUid)
        end
      end
    end
    GU.GroupUidsReset(reset2ZeroUids, PB.enum.ActorGroupType.Tower)
    floor = 1
  end
  local postData = {
    dungeonId = PB.get("TowerFloor", floor).dungeonId,
    selectActorGroupId = m_summary.selectActorGroupId,
    towerFloor = floor
  }
  this:GameRequest("fci/tower-dungeon/"):Post(postData, function(result)
    DBH.ResChange(result.resChange)
    local fightActorInfo = {
      {
        playerId = this:GetData("playerId"),
        actors = m_membersDetail
      }
    }
    this:SetData("FightActorInfo", fightActorInfo)
    local hps = {}
    for _, member in ipairs(m_members) do
      if member.hp == nil then
        table.insert(hps, 0)
      elseif member.dead then
        table.insert(hps, -1)
      else
        table.insert(hps, member.hp)
      end
    end
    local enemyHps = result.enemyRecord.hp
    for i = 1, 6 do
      if enemyHps[i] == nil then
        enemyHps[i] = 0
      elseif enemyHps[i] == 0 then
        enemyHps[i] = -1
      end
    end
    if m_groups ~= nil then
      local group = _ENV["!"](m_groups[tostring(m_selectedGroupId)])
      local groupInfo = {
        hp = hps,
        sp = group.energySp,
        mp = group.energyMp
      }
      local fightInitInfo = {
        groupInfo,
        result.enemyRecord
      }
      this:SetData("FightInitInfo", fightInitInfo)
      WU.EnterGameLevel(result.dungeonUid, result.baseInfo, result.baseInfo.dungeonId, PB.enum.DungeonType.Tower, 1, false)
    end
  end)
end

function SetGroupTabView(confirmed)
  if m_groups ~= nil then
    if confirmed then
      for i = 0, #REF.Tabs - 1 do
        REF.Tabs[i].root.gameObject:SetActive(false)
      end
      local groupCount = _ENV["!"](m_groups):count()
      for i = 0, groupCount - 1 do
        local index = tostring(i + 1)
        local members = m_groups[index].members
        local ok = GU.GroupIsOK(members)
        REF.Tabs[i].root.gameObject:SetActive(ok)
        if ok then
          REF.Tabs[i].GroupGroupLabel.UIHtmlLabel.text = i + 1
          REF.Tabs[i].SpriteDead.gameObject:SetActive(GU.TowerGroupIsDead(members))
        end
      end
    else
      for i = 0, #REF.Tabs - 1 do
        REF.Tabs[i].root.gameObject:SetActive(true)
        REF.Tabs[i].GroupGroupLabel.UIHtmlLabel.text = i + 1
      end
      for i = 0, #m_unlockGroups - 1 do
        local index = tostring(i + 1)
        local ok = false
        if m_groups[index] then
          local members = m_groups[index].members
          ok = GU.GroupIsOK(members)
        end
        REF.Tabs[i].SpriteInsufficient.gameObject:SetActive(not ok)
      end
    end
    REF.Tabs[m_selectedGroupId - 1].root.UIToggle.value = true
  end
end

function UpdateGroupView()
  if m_selectedGroupId ~= m_summary.selectActorGroupId then
    this:GameRequest("fci/SelectedGroupId/tower"):Patch({selectActorGroupId = m_selectedGroupId}, function(response)
      this:SetData("fci/SelectedGroupId/tower", response)
      m_summary.selectActorGroupId = response.selectActorGroupId
      m_selectedGroupData.selectActorGroupId = response.selectActorGroupId
    end)
  end
  m_membersDetail = {}
  if m_groups ~= nil then
    m_members = m_groups[tostring(m_selectedGroupId)].members
    if not m_locked then
      PollingActors(m_members)
    else
      for i = 1, #m_members do
        local member = m_members[i]
        m_membersDetail[member.index + 1] = member.actor or {}
      end
      m_actorsReady = true
    end
    m_allDead = true
    if m_locked then
      for i = 1, #m_members do
        if not m_members[i].dead then
          m_allDead = false
          break
        end
      end
    else
      m_allDead = false
    end
    REF.WidgetGroupMembers["$SetTowerGroupMembers"](m_members, m_locked)
    REF.WidgetGroupMembers["$ShowCustom"]({showNew = false, showName = true})
  end
end

function PollingActors(members)
  this:RegisterGameEvent("fci/actor/", function()
    m_actorsReady = true
  end)
  local isRemoteData = false
  for i = 1, #members do
    local member = members[i]
    if member.actorUid and member.actorUid ~= 0 then
      if not this:GetData("fci/actor/" .. member.actorUid) then
        isRemoteData = true
      end
      this:Bind("fci/actor/" .. member.actorUid, function(actor)
        if actor ~= nil and actor.id ~= 0 then
          m_membersDetail[member.index + 1] = actor
        end
      end)
    else
      m_membersDetail[member.index + 1] = {}
    end
  end
  if not isRemoteData then
    m_actorsReady = true
  end
end

function RefreshAttrDisplay()
  REF.WidgetGroupMembers["$DisplayAttrs"](m_displayAttrs)
  if REF.ToggleAttrs.UIToggle.value ~= m_displayAttrs then
    REF.ToggleAttrs.UIToggle.value = m_displayAttrs
  end
end
