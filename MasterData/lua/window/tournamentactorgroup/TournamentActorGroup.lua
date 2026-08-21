local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local DU = require("Common/DungeonUtil")
local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local m_members = {}
local m_selectedGroupId, m_groups, m_targetActor, m_uid
local m_displayAttrs = false

function SetupWindow()
  Base.SetupWindow()
  WU.BindButtonEvent(REF.ButtonFight, function()
    if not DU.IsWaitingForJob(OnFightClick) then
      OnFightClick()
    end
  end)
  REF.WidgetGroupMembers["$SetShowHint"](true)
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    m_groups[tostring(m_selectedGroupId)] = patchData
    OnGetActorGroup(m_groups)
  end)
  CS.EventDelegate.Add(REF.ToggleAttrs.UIToggle.onChange, function()
    m_displayAttrs = CS.UIToggle.current.value
    RefreshAttrDisplay()
  end)
end

function InitWindow()
  Base.InitAutoFight(PB.enum.DungeonType.AsyncPvp)
  m_displayAttrs = false
  RefreshAttrDisplay()
  REF.WidgetGroupMembers.UIPlayTween.enabled = false
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  this:BindRemote(DB:GameRequest(this:GetData("ActorGroup/SelectedGroupIdUri")), OnRefreshSelectedActorGroupId)
end

function SetUid(uid)
  m_uid = uid
end

function OnRefreshSelectedActorGroupId(result)
  if result ~= nil then
    m_selectedGroupId = tonumber(result.selectActorGroupId)
    if m_selectedGroupId == 0 then
      m_selectedGroupId = 1
      result.selectActorGroupId = 1
    end
    this:BindRemote(DB:GameRequest(this:GetData("ActorGroup/GroupUri")), OnGetActorGroup)
  end
end

function OnGetActorGroup(actorGroup)
  if actorGroup ~= nil and m_selectedGroupId ~= nil then
    m_groups = actorGroup
    m_members = m_groups[tostring(m_selectedGroupId)].members
    REF.WidgetGroupMembers["$SetGroupMembers"](m_members)
    if REF.WidgetGroupCultivation then
      REF.WidgetGroupCultivation["$SetGroupMembers"](m_members)
    elseif REF.WidgetGroupCultivation4Group then
      REF.WidgetGroupCultivation4Group["$SetGroupMembers"](m_members)
    end
    REF.WidgetGroupMembers["$ShowCustom"]({showNew = false, showName = true})
    WU.ToggleRendering(REF.WidgetGroupMembers, true)
    REF.WidgetGroupMembers.UIPlayTween.enabled = true
  end
end

function OnActorGroupButtonClick(go)
  this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
  WU.AcquireWindowAsync("ActorSelect", function()
    this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.AsyncPvp)
  end)
end

function OnFightClick()
  if not m_members or m_members and not GU.GroupIsOK(m_members, true) then
    return
  end
  RequestTargetDetail(m_uid, function()
    SetFightMembers()
  end)
end

function RequestTargetDetail(uid, callback)
  m_targetActor = nil
  this:GameRequest("fci/asyncpvptargetdetail/" .. uid):Get(function(response)
    m_targetActor = response
    callback()
  end)
end

function SetFightMembers()
  local actorList = {}
  this:RegisterGameEvent("fci/actor/", function()
    SetFightActorInfo(actorList)
  end)
  local isRemoteData = false
  for i = 1, #m_members do
    local member = m_members[i]
    if member.actorUid and member.actorUid ~= 0 then
      if not this:GetData("fci/actor/" .. member.actorUid) then
        isRemoteData = true
      end
      this:Bind("fci/actor/" .. member.actorUid, function(actor)
        if actor then
          actorList[member.index + 1] = actor
        end
      end)
    else
      actorList[member.index + 1] = {}
    end
  end
  if not isRemoteData then
    SetFightActorInfo(actorList)
  end
end

function SetFightActorInfo(actorList)
  local fightActorInfo = {
    {
      playerId = this:GetData("playerId"),
      actors = actorList
    },
    {
      playerId = m_targetActor.uid,
      actors = m_targetActor.targetBattleActors
    }
  }
  this:SetData("FightActorInfo", fightActorInfo)
  this:GameRequest("fci/ActorGroup/"):Put({actorGroups = m_groups}, function(resp)
    EnterDungeon()
  end)
end

function EnterDungeon()
  local postData = {
    tournamentId = this:GetData("fci/tournament/curId"),
    activityType = this:GetData("fci/tournament/curActivityType"),
    target_uid = m_uid
  }
  this:GameRequest("fci/tournament/dungeonenter/"):Post(postData, function(response)
    this:BroadcastGameEvent("MedalAttrAppend")
    WU.EnterGameLevel(response.dungeonUid, nil, response.dungeonId, PB.enum.DungeonType.AsyncPvp, 1, false)
  end)
end

function RefreshAttrDisplay()
  REF.WidgetGroupMembers["$DisplayAttrs"](m_displayAttrs)
  if REF.ToggleAttrs.UIToggle.value ~= m_displayAttrs then
    REF.ToggleAttrs.UIToggle.value = m_displayAttrs
  end
end

function Focus(on)
  if on and m_groups then
    REF.WidgetGroupMembers["$SetGroupMembers"](m_groups[tostring(m_selectedGroupId)].members)
    if REF.WidgetGroupCultivation then
      REF.WidgetGroupCultivation["$SetGroupMembers"](m_groups[tostring(m_selectedGroupId)].members)
    elseif REF.WidgetGroupCultivation4Group then
      REF.WidgetGroupCultivation4Group["$SetGroupMembers"](m_groups[tostring(m_selectedGroupId)].members)
    end
    REF.WidgetGroupMembers["$ShowCustom"]({showNew = false, showName = true})
  end
end
