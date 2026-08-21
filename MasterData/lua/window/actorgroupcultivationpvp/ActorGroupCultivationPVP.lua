local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local EU = require("Common/EquipUtil")
local LU = require("Common/ListUtil")
local m_repeatedContext = {}
local m_dungeonId, m_replayTween, m_chapterId, m_groups, m_selectedGroupId

function SetupWindow()
  Base.SetupWindow()
  REF.WidgetGroupMembers["$SetShowHint"](true)
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    m_groups[tostring(m_selectedGroupId)] = patchData
    OnActorGroupChanged(m_groups)
  end)
  Base.SetData("Fight", Fight)
  WU.BindButtonEvent(REF.ButtonEdit, function()
    WU.AcquireWindowAsync("CultivationPVPEdit", function(w)
      _ENV["$"](w)["$$SetMembers"](m_groups[tostring(m_selectedGroupId)].members, m_dungeonId)
    end)
  end)
end

function InitWindow()
  Base.InitAutoFight(PB.enum.DungeonType.Normal)
  this:Bind("ActorGroupCultivationPVP/DungeonId", OnActorGroupDungeonId)
  this:Bind("ActorGroupCultivationPVP/ChapterId", OnActorGroupChapterId)
end

function UninitWindow()
  this:SetData("equipMinRequireLevelPosMap", nil)
end

function SaveContext()
  table.insert(m_repeatedContext, {dungeonId = m_dungeonId, chapterId = m_chapterId})
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    this:SetData("ActorGroupCultivationPVP/DungeonId", context.dungeonId)
    this:SetData("ActorGroupCultivationPVP/ChapterId", context.chapterId)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnActorGroupDungeonId(dungeonId)
  if dungeonId == nil then
    return
  end
  m_dungeonId = dungeonId
  if this:GetData("ActorGroup/CurrentCultivationRatios/" .. dungeonId) == nil then
    this:SetData("ActorGroup/CurrentCultivationRatios/" .. dungeonId, GetRatiosFromCache() or {
      [0] = 1,
      [1] = 1,
      [2] = 1,
      [3] = 1,
      [4] = 1,
      [5] = 1
    })
  end
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_replayTween = true
  Base.SetData("powerMultiple", 1)
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  Base.OnDungeonInfo(dungeonId)
  this:Unbind("fci/SelectedGroupId/StoryMode/", OnSelectedActorGroupId)
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/StoryMode/"), OnSelectedActorGroupId)
  if this:GetData("equipMinRequireLevelPosMap") == nil then
    EU.InitEquipMinRequireLevelByPos()
  end
end

function OnActorGroupChapterId(chapterId)
  if chapterId == nil then
    return
  end
  m_chapterId = chapterId
end

function OnSelectedActorGroupId(result)
  if result then
    m_selectedGroupId = fif(tonumber(result.selectActorGroupId) == 0, 1, tonumber(result.selectActorGroupId))
    this:Unbind("fci/ActorGroup/", OnActorGroupChanged)
    this:BindRemote(DB:GameRequest("fci/ActorGroup/"), OnActorGroupChanged)
  end
end

function OnActorGroupButtonClick(go)
  this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
  WU.AcquireWindowAsync("ActorSelect", function(w)
    this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.Dungeon)
    _ENV["$"](w)["$$SetCultivationPVPMode"](true)
  end)
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    m_groups = actorGroup
    local members = actorGroup[tostring(m_selectedGroupId)].members
    if this:GetData("CurrentTutorial") == 7 then
      this:BroadcastGameEvent("Tutorial/StepReady")
    end
    Base.Member2FightActorInfo(members)
    Base.RefreshGroupMembersAndTween(members, m_replayTween)
    m_replayTween = false
    this:Unbind("ActorGroup/CurrentCultivationRatios/" .. m_dungeonId, OnCurrentCultivationRatios)
    this:Bind("ActorGroup/CurrentCultivationRatios/" .. m_dungeonId, OnCurrentCultivationRatios)
  end
end

function Fight()
  local members = m_groups[tostring(m_selectedGroupId)].members
  if GU.GroupIsOK(members, true) then
    RequestPostDungeon()
  end
end

function RequestPostDungeon()
  this:GameRequest("fci/ActorGroup/"):Put({actorGroups = m_groups}, function(resp)
    local members = m_groups[tostring(m_selectedGroupId)].members
    local reduceInfo = {}
    for i = 1, 6 do
      if members[i].actorUid ~= 0 then
        local ratio = 1000
        local ratios = this:GetData("ActorGroup/CurrentCultivationRatios/" .. m_dungeonId)
        if ratios then
          ratio = ratios[members[i].index] * 1000
        end
        reduceInfo[tostring(members[i].actorUid)] = ratio
      end
    end
    local param = {
      dungeonId = m_dungeonId,
      selectActorGroupId = m_selectedGroupId,
      multiPower = 1,
      price = DU.GetDungeonPrice(m_dungeonId),
      isChallengeMode = true,
      reduceInfo = reduceInfo
    }
    this:SetData("PowerMultiple", 1)
    this:SetData("WindowDungeon/EnterParam", param)
    this:SetData("BalanceInfo/Groups", {groups = m_groups, selectedGroupId = m_selectedGroupId})
    this:GameRequest("fci/dungeon/"):Post(param, function(result)
      this:SetData("EnteredChapterId", m_chapterId)
      this:SetData("WindowDungeon/ChapterId", m_chapterId)
      this:SetData("IsCultivationPVPMode", true)
      DBH.ResChange(result.resChange)
      WU.EnterGameLevel(result.dungeonUid, result.baseInfo, m_dungeonId, PB.enum.DungeonType.Normal, 1)
    end)
  end)
end

function Focus(on)
  if on and m_groups then
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.RefreshGroupMembersAndTween(members, true)
    local ratios = this:GetData("ActorGroup/CurrentCultivationRatios/" .. m_dungeonId)
    REF.WidgetGroupMembers["$SetGroupMembers"](members, ratios)
    SetScorePreview()
  end
end

function OnCurrentCultivationRatios(ratios)
  if ratios then
    local members = m_groups[tostring(m_selectedGroupId)].members
    REF.WidgetGroupMembers["$SetGroupMembers"](members, ratios)
    SetScorePreview()
  end
end

function SetScorePreview()
  local members = m_groups[tostring(m_selectedGroupId)].members
  local degrees = {
    [0] = 0,
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0
  }
  for _, member in pairs(members) do
    if 0 < member.actorUid and this:GetData("fci/actor/" .. member.actorUid) then
      degrees[member.index] = AU.GetActorCultivationDegree(this:GetData("fci/actor/" .. member.actorUid), this:GetData("ActorGroup/CurrentCultivationRatios/" .. m_dungeonId)[member.index])
    end
  end
  REF.LabelCultivationDegree.UILabel.text = WU.GetString("Window_CultivationPVPScorePreview") .. " " .. math.max(degrees[0] + degrees[3], degrees[1] + degrees[4], degrees[2] + degrees[5])
end

function GetRatiosFromCache()
  local data = WU.GetGameDataCache("ActorGroup/CurrentCultivationRatios/" .. this:GetData("ActorGroupCultivationPVP/DungeonId"))
  local res = {}
  for i = 1, 6 do
    res[i - 1] = 1
    if data and data[i] then
      res[i - 1] = data[i]
    end
  end
  return res
end
