local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local SU = require("Common/SortUtil")
local EU = require("Common/EquipUtil")
local GU = require("Common/GroupUtil")
local DU = require("Common/DungeonUtil")
local m_actorList, m_advancedFilters, m_sortHasChanged, m_displayNumbers, m_activeData, m_resetPosition, m_displayOption, m_tabIndex, m_reverse, m_clearNewFlag, m_playTween
local m_tutorialGate = true
local m_tutorialTempActorData, m_tutorialMikotoUid

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonDecompose, function()
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local isFinished
    local allowDungeon = PB.all("Misc")[1].allowActorDecomposeDungeon
    DU.IsDungeonFinished(chapterInfo, allowDungeon, function(finished)
      isFinished = finished
    end)
    if isFinished then
      WU.OpenActorDecompose()
    else
      WU.ShowHintText(WU.GetString("Window_AllowActorDecomposeDungeon"))
    end
  end)
  WU.BindButtonEvent(REF.ButtonGroup, function()
    WU.AcquireWindowAsync("ActorSelect", function()
      this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.Dungeon)
    end)
  end)
  WU.TraverseChildren(REF.WrapContentActors, function(row)
    WU.TraverseChildren(_ENV["$"](row)["$"], function(go)
      _ENV["$"](go)["$$SetClickCallback"](OnActorCardClick)
    end)
  end)
  LU.Bind(REF.WrapContentActors, {
    dataSource = function(dataIndex)
      return m_activeData and m_activeData[dataIndex]
    end,
    updateSlot = UpdateSlot,
    delta = 0.03
  })
end

function InitWindow()
  m_tutorialTempActorUid = nil
  m_tutorialGate = true
  m_tabIndex = nil
  m_reverse = nil
  m_actorList = nil
  m_resetPosition = true
  m_displayNumbers = SU.DisplayNumbers.Star
  if REF.CardShowOption then
    REF.CardShowOption["$HideAttr"](true)
  end
  WU.ToggleRendering(REF.AnchorScrollViewActors, false)
  SortFocusBase.InitWindowActor()
  this:Bind("SortFinished", OnSortFinished)
  local tutorial = this:GetData("CurrentTutorial")
  if tutorial == 20 then
    local arms = this:GetData("fci/arms/")
    local actors = this:GetData("fci/actor/")
    local _, arm = table.find(arms, function(k, v)
      local _, actor = table.find(actors, function(key, value)
        return v.position == value.kind and value.level >= PB.all("Misc"):first().weaponMisc.weaponShowLevel
      end)
      return actor
    end)
    local kind = arm.position
    this:DelayInvokeInFrames(1, function()
      this:BroadcastGameEvent("ApplySortAlternative", 0, true, {
        contextName = "ActorList",
        kind = kind,
        tags1 = 0,
        tags2 = 0,
        displayOption = m_advancedFilters.displayOption
      })
    end)
  end
  this:Bind("GroupActorUids", function()
    m_resetPosition = false
    RefreshWrapContent(m_actorList)
  end, false)
  this:Bind("fci/ActorGroup/", function()
    m_resetPosition = false
    RefreshWrapContent(m_actorList)
  end, false)
  this:RegisterGameEvent("ClearNewFlags", OnClearNewFlags)
  EU.InitEquipMinRequireLevelByPos()
  DU.IsDungeonFinished(this:GetData("fci/dungeon/chapter-summary/"), 1000203, function(finished)
    local triggerSuccess = false
    if finished then
      triggerSuccess = WU.TriggerUnforcedTutorial(1101)
    end
    if not triggerSuccess and this:GetData("fci/baseinfo").level >= 20 then
      triggerSuccess = WU.TriggerUnforcedTutorial(1103)
    end
    if not triggerSuccess and this:GetData("fci/baseinfo").level >= 17 then
      WU.TriggerUnforcedTutorial(1103)
    end
  end)
end

function UninitWindow()
  this:SetData("SortFinished", nil)
  this:SetData("Actor/RollerTraverse", nil)
  this:SetData("equipMinRequireLevelPosMap", nil)
end

function UpdateSlot(widget, data)
  local tutorial = this:GetData("CurrentTutorial")
  if (tutorial == 51 or tutorial == 52) and data ~= nil then
    if m_tutorialGate then
      m_tutorialGate = false
      local actors = this:GetData("fci/actor/")
      local _, mikoto = table.find(actors, function(_, v)
        return v.id == 1001 and v.level >= 4 and v.star == 1
      end)
      if mikoto ~= nil then
        m_tutorialTempActorData = data
        data = mikoto
        m_tutorialMikotoUid = mikoto.uid
      end
    elseif data.uid == m_tutorialMikotoUid and m_tutorialTempActorData ~= nil then
      data = m_tutorialTempActorData
    end
  end
  WU.ToggleRendering(widget["$"], data ~= nil)
  widget["$$SetSCardEffect"](true)
  widget["$$SetListTweenSwitch"](m_playTween)
  if data ~= nil then
    widget["@uid"] = data.uid
    widget["$$BindActor"](data)
    local inWhichGroup
    if m_displayOption == SU.DisplayOption.group then
      inWhichGroup = GU.GetActorInWhichGroups(data.uid)
    end
    widget["$$ShowCustom"]({
      redPoint = true,
      lock = true,
      showEquips = m_displayOption == SU.DisplayOption.equip,
      showName = m_displayOption == SU.DisplayOption.name,
      showArm = m_displayOption == SU.DisplayOption.arm,
      showCultivationTotal = m_displayNumbers == SU.DisplayNumbers.Cultivation,
      showSpeed = m_displayNumbers == SU.DisplayNumbers.Speed,
      showStar = m_displayNumbers == SU.DisplayNumbers.Star,
      showGroup = inWhichGroup
    })
  end
end

function OnActorCardClick(go)
  WU.RecordButtonClick(10301)
  this:SetData("Actor/RollerTraverse", m_actorList)
  this:SetData("Actor/SelectedUid", nil)
  local tutorial = this:GetData("CurrentTutorial")
  local actorUid = _ENV["$"](go)["@uid"]
  if tutorial == 51 or tutorial == 52 then
    local actors = this:GetData("fci/actor/")
    local _, mikoto = table.find(actors, function(_, v)
      return v.id == 1001 and v.level >= 4 and v.star == 1
    end)
    if mikoto ~= nil then
      actorUid = mikoto.uid
    end
  end
  WU.AcquireWindowAsync("ActorMain", function()
    this:SetData("Actor/SelectedUid", actorUid)
  end)
end

function RefreshWrapContent(data)
  if data == nil then
    return
  end
  WU.ToggleRendering(REF.AnchorScrollViewActors, true)
  local wrapContent = REF.WrapContentActors
  local row = math.ceil(#data / #REF.WidgetActorListSlot)
  m_activeData = data
  local instant = fif(m_resetPosition ~= nil, not m_resetPosition, nil)
  m_playTween = m_resetPosition
  LU.Set(wrapContent, row, m_resetPosition, instant)
  m_playTween = true
  m_resetPosition = false
  REF.NodeEmpty.gameObject:SetActive(#data == 0)
end

function OnSortFinished(data)
  if data ~= nil and data.sortMate == REF["$SortMate"] then
    local sortMate = data.sortMate
    local isChanged = m_tabIndex ~= sortMate.tabIndex or m_reverse ~= sortMate.reverse or m_advancedFilters == nil
    if m_advancedFilters then
      isChanged = isChanged or data.advancedFilters.kind ~= m_advancedFilters.kind or data.advancedFilters.tags1 ~= m_advancedFilters.tags1 or data.advancedFilters.tags2 ~= m_advancedFilters.tags2 or data.advancedFilters.displayOption ~= m_advancedFilters.displayOption
    end
    m_resetPosition = fif(not m_resetPosition, isChanged, m_resetPosition)
    m_tabIndex = sortMate.tabIndex
    m_reverse = sortMate.reverse
    m_advancedFilters = data.advancedFilters
    REF.SortFullScreenFilters.gameObject:SetActive(false)
    m_actorList = SU.ApplyFilters(data.list, m_advancedFilters)
    m_displayOption = SU.DisplayOption[WU.GetGameDataCache("LocalDisplayOption") or "name"]
    local id = sortMate.ids[sortMate.tabIndex]
    for _, ids in pairs(SU.DisplayNumbers) do
      if table.find(ids, function(_, v)
        return v == id
      end) then
        m_displayNumbers = ids
      end
    end
    local top = WU.TopWindow()
    if top and top.name ~= "ActorList" and isChanged then
      m_sortHasChanged = true
      return
    end
    RefreshWrapContent(m_actorList)
    NewFlagCount(m_actorList)
  end
end

function Focus(on)
  SortFocusBase.FocusActor(on, function()
    m_resetPosition = true
    return m_advancedFilters
  end)
  if on and m_sortHasChanged then
    m_sortHasChanged = false
    m_resetPosition = true
    RefreshWrapContent(m_actorList)
  end
  if not on then
    OnClearNewFlags()
  end
  WU.RecordWindowFocus(100103, on)
end

function NewFlagCount(list)
  if table.empty(list) then
    return
  end
  m_clearNewFlag = {}
  for i = 1, #list do
    if list[i].isNewCard then
      table.insert(m_clearNewFlag, list[i])
    end
  end
end

function OnClearNewFlags()
  SU.ClearNewFlag(PB.enum.ResourceType.ResActor, m_clearNewFlag)
  m_clearNewFlag = {}
end
