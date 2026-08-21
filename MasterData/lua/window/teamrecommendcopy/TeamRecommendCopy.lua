local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local TR = require("Common/TeamRCMDUtil")
local m_groupData
local m_pickActors = {}
local m_isActorAbsent
local TypeColor = TR.TypeColor

function SetupWindow()
  WU.TraverseChildren(REF.TeamTab, function(GO, index)
    local ref = _ENV["$"](GO)
    ref.LabelTab.UIHtmlLabel.text = WU.GetString("WindowSpace_Team") .. index + 1
  end)
  WU.TraverseChildren(REF.TeamTab, function(GO, index)
    local ref = _ENV["$"](GO)
    WU.BindButtonEvent(ref.BtnConfirm, function()
      Confirm(index)
    end)
    WU.BindButtonEvent(ref.BtnEdit, function()
      WU.AcquireWindowAsync("ActorSelect", function(UI)
        this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.Dungeon)
        _ENV["$"](UI).GroupTabNode[index]["$UIToggle"].value = true
        _ENV["$"](UI)["$$SafeSwitch"](index + 1)
      end)
    end)
    WU.SetActive(ref.BtnEdit, false)
    WU.SetActive(ref.BtnConfirm, true)
  end)
end

function CopyToGroup(teamNum)
  if ValidCheck() then
    local actorGroups = this:GetData("fci/ActorGroup/")
    local actorGroup = actorGroups[tostring(teamNum)]
    for i = 1, 6 do
      actorGroup.members[i] = {
        index = i - 1,
        actorUid = m_pickActors[i]
      }
    end
    this:SetData("fci/ActorGroup/", actorGroups)
    WU.ShowHintText(WU.GetString("TeamRCMD_CopySuccess"))
    this:GameRequest("fci/ActorGroup/"):Put({
      actorGroups = {
        [tostring(teamNum)] = actorGroup
      }
    })
    m_groupData.useCount = m_groupData.useCount + 1
    this:GameRequest("fci/share-group/copy/" .. m_groupData.groupId):SyncInput(false):Post({}, function(resp)
      m_groupData.useCount = resp.useCount
    end)
    this:BroadcastGameEvent("UpdateTeamDetails", m_groupData)
    WU.SetActive(REF.TeamTab[teamNum - 1].BtnConfirm, false)
    WU.SetActive(REF.TeamTab[teamNum - 1].BtnEdit, true)
  else
    WU.ShowHintText(WU.GetString("TeamRCMD_TeamInvalid"))
  end
end

function ValidCheck()
  local cfgs = {}
  if m_groupData == nil then
    return false
  end
  local actors = m_groupData.actors
  for i = 1, 6 do
    cfgs[i] = PB.get("ActorConfig", actors[i] and actors[i].id)
  end
  for i = 1, 3 do
    if cfgs[i] and cfgs[i].kind ~= PB.enum.ActorType.Main then
      warning("TeamRCMD", "Actor Kind Invalid")
      return false
    end
  end
  for i = 4, 6 do
    if cfgs[i] and cfgs[i].kind ~= PB.enum.ActorType.Sub then
      warning("TeamRCMD", "Actor Kind Invalid")
      return false
    end
  end
  for i = 1, 3 do
    if cfgs[i] and cfgs[i + 3] and cfgs[i].role == cfgs[i + 3].role then
      warning("TeamRCMD", "Actor Role Invalid")
      return false
    end
  end
  for i = 1, 6 do
    for j = i + 1, 6 do
      if cfgs[i] and cfgs[j] and cfgs[i].role == cfgs[j].role and cfgs[i].isLimited == cfgs[j].isLimited then
        warning("TeamRCMD", "Actor Limited Invalid")
        return false
      end
    end
  end
  return true
end

function InitWindow()
  this:BindRemote(DB:GameRequest("fci/ActorGroup/"), OnActorGroupChanged)
end

function UninitWindow()
  this:Unbind("fci/ActorGroup/", OnActorGroupChanged)
end

function OnActorGroupChanged(groups)
  if groups then
    WU.TraverseChildren(REF.TeamTab, function(GO, index)
      local ref = _ENV["$"](GO)
      UpdateGroup(ref, index + 1, groups)
    end)
  end
end

function Confirm(index)
  if m_isActorAbsent then
    WU.ShowMessageYesNo(WU.GetString("TeamRCMD_Copy2"), function(message)
      if message == "YES" then
        CopyToGroup(index + 1)
      end
    end, WU.GetString("TeamRCMD_Confirm"), nil, false)
  else
    WU.ShowMessageYesNo(WU.GetString("TeamRCMD_Copy1"), function(message)
      if message == "YES" then
        CopyToGroup(index + 1)
      end
    end, WU.GetString("TeamRCMD_Confirm"), nil, false)
  end
end

function SetData(groupData)
  WU.TraverseChildren(REF.TeamTab, function(GO, index)
    local ref = _ENV["$"](GO)
    WU.SetActive(ref.BtnEdit, false)
    WU.SetActive(ref.BtnConfirm, true)
  end)
  m_isActorAbsent = false
  m_groupData = groupData
  if m_groupData.tag then
    local color = TR.TypeColor[m_groupData.tag]
    if color then
      REF.LabelTeamType.UILabel.text = WU.GetString("TeamRCMD_Type" .. m_groupData.tag)
      REF.SpriteTeamType.UISprite.color = color
    else
      REF.LabelTeamType.UILabel.text = WU.GetString("TeamRCMD_UnknownType")
      REF.SpriteTeamType.UISprite.color = TR.TypeColor[1]
    end
  end
  REF.LabelTeamName.UILabel.text = m_groupData.name
  local actors = m_groupData.actors
  for index = 1, 6 do
    local actor = actors[index]
    if actor == nil then
      actor = {id = -3}
    end
    local uid = AU.GetHighestLevelActor(actor.id, "noErrLog")
    if uid then
      local card = this:GetData("fci/actor/" .. uid)
      m_pickActors[index] = uid
    else
      m_pickActors[index] = 0
      m_isActorAbsent = true
    end
    local actorGasket = REF["WidgetIconActor" .. index]
    actorGasket["$SetActorCustom"](actor)
    actorGasket["$SetGraify"](m_pickActors[index] == 0)
  end
end

function UpdateGroup(ref, teamNum, groups)
  local members = groups[tostring(teamNum)].members
  local actors = {}
  for index = 1, 6 do
    local member = members[index]
    if member then
      local actor = member.actor
      if actor == nil then
        if member.actorUid == nil or member.actorUid == 0 then
          actor = {id = -3}
        else
          actor = DB:GetData("fci/actor/" .. member.actorUid)
          if actor == nil then
            actor = {id = -3}
          end
        end
      end
      local Gasketactor = ref["WidgetIconActor" .. index]
      Gasketactor["$SetActorCustom"](actor)
    end
  end
  return actors
end
