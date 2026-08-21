local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GroupUtil")
local SU = require("Common/SortUtil")
local SDU = require("Common/SoundUtil")
local TU = require("Common/TaskUtil")
local EU = require("Common/EquipUtil")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local WidgetGroupMembers = REF.WidgetGroupMembers
local Data = {
  currentActorUid = nil,
  currentActorID = nil,
  actorType = nil,
  groups = nil,
  selectedGroupId = nil,
  slotIndex = nil,
  resetActorSelect = nil,
  linksActorId = nil,
  displayAttrs = nil,
  displayNumbers = nil,
  advancedFilters = nil,
  displayOption = nil,
  linkActorPool = nil,
  GroupMemberslegalCheck = nil,
  UpdateGroupActorUids = nil,
  OnActorGroupChanged = nil,
  GetMembers = nil,
  SetMembers = nil,
  GroupChangeCompare = nil,
  GroupSlotChangeSuccCallb = nil,
  OnGroupSlotChangeCancel = nil,
  OnActorRemoveFromGroup = nil,
  ActorClassifyFunc = nil,
  OnGroupMemberClick = nil,
  actorBottom = nil,
  armBottom = nil,
  armList = nil,
  displayOptionOrigin = nil,
  currentGrid = nil,
  refreshGroup = nil,
  sortMateControl = nil,
  sortMateOrigin = nil,
  sortMateCurrent = nil
}

function SetupWindow()
  if REF.ToggleAttrs then
    CS.EventDelegate.Add(REF.ToggleAttrs.UIToggle.onChange, function()
      SetToggleMutex("displayAttrs", CS.UIToggle.current.value)
      if CS.UIToggle.current.value then
        TU.TaskFirstCheck(PB.enum.UseFuncMTimes.ViewTeamDetail)
      end
    end)
  end
  this:DelayInvokeEndOfFrame(function()
    if REF.ToggleAttrs then
      CS.EventDelegate.Add(REF.ToggleAttrs.UIToggle.onChange, function()
        WU.RecordButtonClick(fif(Data.displayAttrs, 5324, 5325))
      end)
    end
  end)
  if Data.OnActorRemoveFromGroup == nil then
    Data.OnActorRemoveFromGroup = DefaultOnActorRemoveFromGroup
  end
  WU.BindButtonEvent(REF.Remove, function()
    WU.RecordButtonClick(5328)
    Data.OnActorRemoveFromGroup()
  end)
  WidgetGroupMembers["$SetClickCallback"](OnSlotSelected)
  WidgetGroupMembers["$AllowDragDrop"](function(patchData, index)
    Data.slotIndex = index
    OnGroupSlotChangeSuccess(patchData)
  end, function()
    if Data.OnGroupSlotChangeCancel == nil then
      Data.OnGroupSlotChangeCancel = DefaultOnGroupSlotChangeCancel
    end
    Data.OnGroupSlotChangeCancel()
  end)
  if REF.TabGrid and REF.ArmSelectWidgetGrid then
    WU.TraverseChildren(REF.TabGrid, function(go)
      local gasket = _ENV["$"](go).root
      if REF.ShowNode then
        REF.ShowNode.gameObject:SetActive(false)
      end
      CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
        OnTabBottomChange()
      end)
    end)
    LU.Bind(REF.ArmSelectWidgetGrid, {
      updateRow = UpdateArmRow,
      delta = 0.01
    })
  end
end

function InitWindow()
  if REF.TabActors then
    REF.TabActors.UIToggle.value = true
  end
  Data.sortMateControl = true
  Data.sortMateOrigin = REF.root.SortMate
  Data.sortMateCurrent = REF.root.SortMate
  REF["$UILuaWindow"].SortMate = Data.sortMateCurrent
  this:SetData("ActorSelectBase/CurSortMate", Data.sortMateCurrent)
  this:SetData("ActorSelectBase/OriginSortMate", Data.sortMateOrigin)
  if Data.currentGrid == nil then
    Data.currentGrid = REF.ActorSelectWidgetGrid
  end
  OnTabBottomChange()
  SortFocusBase.InitWindowActor()
  this:Bind("SortFinished", OnSortFinished)
  if Data.GetMembers == nil then
    Data.GetMembers = DefaultGetMembers
  end
  if Data.SetMembers == nil then
    Data.SetMembers = DefaultSetMembers
  end
  local tutorialId = this:GetData("CurrentTutorial")
  if tutorialId == 40 then
    this:DelayInvokeEndOfFrame(function()
      this:BroadcastGameEvent("ApplySortAlternative", 1, true)
    end)
  end
  InitGroupChild()
  this:Bind("DisplayOptionChange", function()
    RefreshGroupMembers(false)
  end)
end

function UninitWindow()
  this:SetData("ActorSelectBase/OriginSortMate", nil)
  this:SetData("ActorSelectBase/CurSortMate", nil)
  this:SetData("ActorSelectBase/ArmBottom", nil)
  WU.SetDislayOption(this:GetData("DisplayOptionOrigin"))
  this:SetData("SortFinished", this:GetData("SortFinished"))
  local nav = WU.FindWindow("Navigation")
  if nav ~= nil then
    _ENV["$"](nav)["$$Load"]()
  end
end

function InitGroupChild()
  if REF.LabelHintPar ~= nil then
    DB:DelayInvokeInSeconds(3.5, function()
      REF.LabelHintPar.gameObject:SetActive(false)
    end)
  end
  this:Bind("Arm/ArmUnlock", function(show)
    local showArm = show
    if REF.TabGrid then
      REF.ActorSelectWidgetScrollViewListChild.UIWidget:SetAnchor(REF.NotchedSize.gameObject, fif(showArm, 145, 0), 0, 0, 0)
      REF.GridPar.gameObject:SetActive(showArm)
      REF.TabGrid.UIGrid:Reposition()
    end
    if REF.TabArms and REF.ArmChangeTip_ActorGroup and showArm then
      WU.ActiveByNeverClick(REF.ArmChangeTip_ActorGroup)
      this:DelayInvokeInSeconds(5, function()
        WU.SetClickB4(REF.ArmChangeTip_ActorGroup)
      end)
    end
  end)
end

function OnSlotSelected(go, i)
  if i then
    WU.RecordButtonClick(5313 + i)
  end
  local ref = _ENV["$"](go)
  local index = ref["@index"]
  Data.slotIndex = index
  ClearAllSelect()
  ref.WidgetActorCard["$SetHighlighted"](true)
  Data.linksActorId = WidgetGroupMembers["$GetLinksActorIdByIndex"](index, Data.linkActorPool)
  Data.currentActorUid = ref["@uid"]
  WU.ToggleRendering(REF.Remove, ref["@actor"])
  local actorType = fif(GU.IsMainIndex(index), PB.enum.ActorType.Main, PB.enum.ActorType.Sub)
  Data.resetActorSelect = actorType ~= Data.actorType
  Data.actorType = actorType
  local sortMate = REF["$SortMate"] or REF["$UILuaWindow"].SortMate
  this:SetData(sortMate.contextName .. "/MainActors/", this:GetData(sortMate.contextName .. "/MainActors/"))
  this:SetData(sortMate.contextName .. "/SubActors/", this:GetData(sortMate.contextName .. "/SubActors/"))
  if rawget(__impl, "SwitchButtonGrid") then
    __impl.SwitchButtonGrid(go)
  end
  SetBottomList()
  if Data.OnGroupMemberClick then
    Data.OnGroupMemberClick()
  end
end

function SwitchGroup(groupId)
  Data.displayAttrs = false
  RefreshAttrDisplay()
  Data.selectedGroupId = groupId
  RefreshGroupMembers(true)
  Data.resetActorSelect = true
  ResetState()
  if __impl.ResetState then
    __impl.ResetState()
  end
end

function AutoSlotSelection()
  local index = Data.slotIndex
  local members = Data.GetMembers(Data.groups)
  if index == nil and members then
    for i = 1, 3 do
      if members[i].actorUid == 0 then
        index = members[i].index
        break
      end
      if members[i + 3].actorUid == 0 then
        index = members[i + 3].index
        break
      end
    end
  end
  local go = WidgetGroupMembers["$GetSlotByIndex"](index or 0)
  OnSlotSelected(go)
end

function ResetState(sortIndex, sortReverse, slotIndex)
  Data.slotIndex = slotIndex
  Data.currentActorUid = nil
  local sortLocalContext = WU.GetGameDataCache("SortLocalContext")
  if sortLocalContext ~= nil then
    local sortMate = REF["$SortMate"] or REF["$UILuaWindow"].SortMate
    local contextName = sortMate.contextName
    local context = sortLocalContext[contextName] or {}
    context.contextName = contextName
    context.kind = 0
    context.tags1 = 0
    context.tags2 = 0
    sortLocalContext[contextName] = context
    this:BroadcastGameEvent("ApplySortAlternative", sortIndex or sortMate.tabIndex, sortReverse or sortMate.reverse, context)
  end
  WidgetGroupMembers.UIPlayTween.enabled = false
  WidgetGroupMembers.UIPlayTween.enabled = true
  WU.ToggleRendering(REF.Remove, false)
  AutoSlotSelection()
end

function DefaultGroupChangeCompare(membersBefore, members)
  local flag = 0
  local changedIndex = {}
  for i = 1, #membersBefore do
    if membersBefore[i].actorUid ~= members[i].actorUid then
      flag = flag + 1
      if members[i].actorUid ~= 0 then
        table.insert(changedIndex, members[i].index)
      end
    end
  end
  return flag, changedIndex
end

function OnGroupSlotChangeSuccess(patchData)
  if Data.GroupMemberslegalCheck == nil then
    Data.GroupMemberslegalCheck = DefaultGroupMemberslegalCheck
  end
  local legal = Data.GroupMemberslegalCheck(patchData.members)
  if not legal then
    WU.ShowHintText(WU.GetString("ActorSelect_ActorNotLegalWithKind"))
  end
  local members = Data.GetMembers(Data.groups)
  if members == nil then
    return
  end
  if Data.GroupChangeCompare == nil then
    Data.GroupChangeCompare = DefaultGroupChangeCompare
  end
  local flag, changedIndex = Data.GroupChangeCompare(members, patchData.members)
  if flag == 0 then
    return
  end
  if Data.UpdateGroupActorUids then
    local copy = {}
    _ENV["!"](Data.groups):copy(copy)
    if not Data.SetMembers(copy, patchData) then
      return
    end
    Data.UpdateGroupActorUids(Data.groups, copy)
  end
  WidgetGroupMembers["$PlayActorCardEffect"](changedIndex)
  if not Data.SetMembers(Data.groups, patchData) then
    return
  end
  Data.OnActorGroupChanged(Data.groups)
  if Data.GroupSlotChangeSuccCallb == nil then
    Data.GroupSlotChangeSuccCallb = DefaultGroupSlotChangeSuccCallb
  end
  Data.GroupSlotChangeSuccCallb()
end

function DefaultOnGroupSlotChangeCancel()
  if Data.slotIndex then
    local go = WidgetGroupMembers["$GetSlotByIndex"](Data.slotIndex)
    OnSlotSelected(go)
  end
end

function ClearAllSelect()
  WU.TraverseChildren(REF.ActorSelectWidgetGrid, function(go)
    _ENV["$"](go)["$$SetHighlighted"](false)
  end)
  WidgetGroupMembers["$ClearSelection"]()
end

function DefaultOnActorRemoveFromGroup()
  if Data.currentActorUid ~= nil then
    local eventData = {
      index = Data.slotIndex,
      cardUid = Data.currentActorUid,
      cardSUid = 0
    }
    WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, OnGroupSlotChangeSuccess, function()
      if Data.OnGroupSlotChangeCancel == nil then
        Data.OnGroupSlotChangeCancel = DefaultOnGroupSlotChangeCancel
      end
      Data.OnGroupSlotChangeCancel()
    end)
  end
end

function RefreshAttrDisplay()
  WidgetGroupMembers["$DisplayAttrs"](Data.displayAttrs)
  if REF.ToggleAttrs.UIToggle.value ~= Data.displayAttrs then
    REF.ToggleAttrs.UIToggle.value = Data.displayAttrs
  end
end

function Focus(on)
  SortFocusBase.FocusActor(on, function()
    Data.resetActorSelect = true
    return Data.advancedFilters
  end)
  if on and Data.groups and Data.slotIndex then
    RefreshGroupMembers(true)
    local go = WidgetGroupMembers["$GetSlotByIndex"](Data.slotIndex)
    OnSlotSelected(go)
  end
end

function OnSortFinished(data)
  local sortMate = REF["$SortMate"] or REF["$UILuaWindow"].SortMate
  if data == nil then
    return
  end
  if data ~= nil and data.sortMate == sortMate and not Data.armBottom then
    local tutorialId = DB:GetData("CurrentTutorial")
    local sortMate = data.sortMate
    Data.resetActorSelect = true
    Data.advancedFilters = fif(data.advancedFilters == nil, Data.advancedFilters, data.advancedFilters)
    local filteredList = SU.ApplyFilters(data.list, Data.advancedFilters)
    if tutorialId == 40 then
      filteredList = data.list
    end
    Data.displayOption = SU.DisplayOption.name
    if data.advancedFilters ~= nil then
      Data.displayOption = SU.DisplayOption[data.advancedFilters.displayOption]
    end
    Data.displayNumbers = SU.DisplayNumbers.Star
    if sortMate.ids[sortMate.tabIndex] == nil then
      return
    end
    local id = sortMate.ids[sortMate.tabIndex]
    for _, ids in pairs(SU.DisplayNumbers) do
      if table.find(ids, function(_, v)
        return v == id
      end) then
        Data.displayNumbers = ids
      end
    end
    if Data.ActorClassifyFunc ~= nil then
      Data.ActorClassifyFunc(filteredList)
      return
    end
    local mainActors, subActors = SU.OnActorClassify(filteredList)
    if tutorialId == 40 then
      local firstActor
      firstActor = mainActors[1]
      if firstActor.id ~= 1009 then
        local index, kirino = table.find(mainActors, function(k, v)
          return v.id == 1009 and v.quality == firstActor.quality
        end)
        if kirino then
          mainActors[1] = kirino
          mainActors[index] = firstActor
        end
      end
      local actorsIngroup = _ENV["!"]({})
      local selectedGroupId = this:GetData("fci/SelectedGroupId/StoryMode/").selectActorGroupId
      if selectedGroupId == 0 then
        selectedGroupId = 1
      end
      local group = this:GetData("fci/ActorGroup")
      local members = group[tostring(selectedGroupId)].members
      if members then
        for _, v in pairs(members) do
          if v.index < 3 and v.actorUid ~= 0 then
            local actor = this:GetData("fci/actor/" .. v.actorUid)
            table.insert(actorsIngroup, actor.id)
          end
        end
        firstActor = mainActors[1]
        if actorsIngroup:has(firstActor.id) then
          do
            local index, actor = table.find(mainActors, function(k, v)
              return not actorsIngroup:has(v.id)
            end)
            if index then
              mainActors[1] = mainActors[index]
              mainActors[index] = firstActor
            end
          end
        end
      end
    end
    this:SetData(sortMate.contextName .. "/MainActors/", mainActors)
    this:SetData(sortMate.contextName .. "/SubActors/", subActors)
    RefreshGroupMembers()
  else
    RefreshGroupMembers()
    SetBottomList()
  end
end

function RemoveActorsInGroup(actors)
  local members = Data.GetMembers(Data.groups)
  local uids = {}
  for i = 1, #members do
    local member = members[i]
    uids[member.actorUid] = true
  end
  for i = #actors, 1, -1 do
    local actor = actors[i]
    if uids[actor.uid] == true then
      table.remove(actors, i)
    end
  end
end

function RefreshGroupMembers(setMembers, ratios)
  if Data.refreshGroup == false then
    return
  end
  if setMembers then
    local members = Data.GetMembers(Data.groups)
    if not members then
      return
    end
    WidgetGroupMembers["$SetGroupMembers"](members, ratios)
    REF.WidgetGroupCultivation["$SetGroupMembers"](members, ratios)
  end
  RefreshShow()
  RefreshAttrDisplay()
end

function RefreshShow()
  Data.displayOption = SU.DisplayOption[WU.GetGameDataCache("LocalDisplayOption") or "name"]
  WidgetGroupMembers["$ShowCustom"]({
    showNew = false,
    showEquips = Data.displayOption == SU.DisplayOption.equip,
    showName = Data.displayOption == SU.DisplayOption.name,
    showArm = Data.displayOption == SU.DisplayOption.arm,
    showCultivationTotal = Data.displayNumbers == SU.DisplayNumbers.Cultivation,
    showSpeed = Data.displayNumbers == SU.DisplayNumbers.Speed,
    showStar = Data.displayNumbers == SU.DisplayNumbers.Star
  })
end

function GetData(name)
  return Data[name]
end

function SetData(name, value)
  Data[name] = value
end

function BindTabs()
  WU.TraverseChildren(REF.GroupTabNode, function(go, i)
    local ref = _ENV["$"](go)
    ref.GroupGroupLabel.UILabel.text = i + 1
    WU.BindButtonEvent(go, function()
      WU.RecordButtonClick(5319 + i)
      if Data.selectedGroupId ~= i + 1 then
        if i < table.count(Data.groups) then
          SwitchGroup(i + 1)
        else
          REF.GroupTabNode[Data.selectedGroupId - 1]["$UIToggle"].value = true
          WU.ShowHintText(WU.GetString("ActorSelect_GroupIsLocked"))
        end
      end
    end)
  end)
end

function DefaultGroupMemberslegalCheck(members)
  local legal = true
  for _, v in pairs(members) do
    if v.actorUid ~= 0 then
      local actor = this:GetData("fci/actor/" .. v.actorUid)
      if actor ~= nil and 0 < actor.id then
        local actorConfig = PB.get("ActorConfig", actor.id)
        local mainIndex = GU.IsMainIndex(v.index)
        if mainIndex and actorConfig.kind == PB.enum.ActorType.Sub or not mainIndex and actorConfig.kind == PB.enum.ActorType.Main then
          legal = false
          v.actorUid = 0
        end
      end
    end
  end
  return legal
end

function DefaultActorHeadHold(go)
  local ref = _ENV["$"](go)
  local actorUid = ref["@uid"]
  if actorUid then
    WU.ShowActorPeek(this:GetData("fci/actor/" .. actorUid))
  end
end

function DefaultActorHeadClick(go)
  local ref = _ENV["$"](go)
  local actorUid = ref["@uid"]
  if actorUid == nil then
    warning("DefaultActorHeadClick", "actorUid nil?")
    return
  end
  local top = WU.TopWindow()
  if top and top.name == "ActorPeek" then
    WU.ShowActorPeek(this:GetData("fci/actor/" .. actorUid))
  else
    local targetRef = WidgetGroupMembers["$GetSlotByIndex"](Data.slotIndex)
    local cardUid = _ENV["$"](targetRef)["@uid"]
    if cardUid == actorUid then
      return
    end
    ClearAllSelect()
    local eventData = {
      index = Data.slotIndex,
      cardUid = cardUid or 0,
      cardSUid = actorUid
    }
    eventData.actorS = this:GetData("fci/actor/" .. actorUid)
    WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, OnGroupSlotChangeSuccess, function()
      if Data.OnGroupSlotChangeCancel == nil then
        Data.OnGroupSlotChangeCancel = DefaultOnGroupSlotChangeCancel
      end
      Data.OnGroupSlotChangeCancel()
    end)
    Data.currentActorUid = actorUid
  end
end

function DefaultGetMembers(groups)
  if Data.selectedGroupId then
    return groups[tostring(Data.selectedGroupId)].members
  end
end

function DefaultSetMembers(groups, members)
  if Data.selectedGroupId then
    groups[tostring(Data.selectedGroupId)] = members
    return true
  else
    warning("DefaultSetMembers", "failed!")
  end
end

function DefaultGroupSlotChangeSuccCallb()
  local go = WidgetGroupMembers["$GetSlotByIndex"](Data.slotIndex)
  if go then
    local ref = _ENV["$"](go)
    if ref["@actor"] ~= nil then
      if Data.currentActorID then
        SDU.StopActorAdded(Data.currentActorID)
        Data.currentActorID = ref["@actor"].id
      end
      SDU.PlayActorAdded(ref["@actor"].id)
    end
  end
  OnSlotSelected(go)
end

function SetToggleMutex(prioritiy, flag)
  Data.displayAttrs = false
  Data.displayArms = false
  local toggleVals = {
    Data.displayAttrs,
    Data.displayArms
  }
  local toggleRef = {
    "ToggleAttrs",
    "ToggleArms"
  }
  Data[prioritiy] = flag
  for k, v in pairs(toggleRef) do
    if REF[v] and REF[v].UIToggle.value ~= toggleVals[k] then
      REF[v].UIToggle.value = toggleVals[k]
    end
  end
  RefreshAttrDisplay()
end

function RefreshArm(actorType, resetPosition)
  if this:GetData("SortFinished") == nil then
    return
  end
  Data.armList = EU.GetArmByType(actorType, this:GetData("SortFinished").list)
  LU.Set(REF.ArmSelectWidgetGrid, #Data.armList, resetPosition)
  REF.ScrollViewList.UIScrollView:ResetPosition()
end

function UpdateArmRow(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and Data.armList ~= nil and rowIndex < #Data.armList then
    local arm = this:GetData("fci/arms/" .. Data.armList[rowIndex + 1].id)
    if arm ~= nil then
      local equipping = arm.actorUid == Data.currentActorUid
      rowRef["$$BindArm"](arm, "N")
      rowRef["$$ShowCustom"]({showEquip = true, showUsing = equipping})
      rowRef["$$SetClickCallback"](function()
        OnArmClick(arm)
      end)
    else
      warning("arm nil wiredly!")
    end
  end
end

function OnArmClick(arm)
  if Data.currentActorUid == nil then
    warning("ArmClick Current Uid Nil!")
    return
  end
  local ac = this:GetData("fci/actor/" .. Data.currentActorUid)
  if ac == nil then
    warning("ArmClick No Actor Found in Bag!")
    return
  end
  if arm.position ~= ac.kind then
    WU.ShowHintText("position not match!")
    return
  end
  local showArm = PB.all("Misc"):first().weaponMisc.weaponShowLevel
  if showArm > ac.level then
    WU.ShowHintText(WU.GetString("WindowActorEquip_ArmLoadLevelLimit"))
    return
  end
  local param = {
    uniqueWeaponId = arm.id,
    actorUid = ac.uid
  }
  
  local function yesFunc()
    this:GameRequest("fci/unique-weapon/on/"):Post(param, function(resp)
      DBH.UpdateArms({
        resp.newWeapon,
        resp.oldWeapon
      })
      DBH.UpdateActors({
        resp.oldActor,
        resp.newActor
      })
      SetBottomList()
    end)
  end
  
  if arm.actorUid and arm.actorUid ~= 0 and arm.actorUid ~= ac.uid then
    local ac = AU.GetActorByArm(arm)
    local tipKey = WU.GetString("UniqueWeapon_EquippedByOther", WU.GetString("ActorName_" .. ac.id), ac.level)
    WU.ShowMessageYesNo(tipKey, function(result)
      if result == "YES" then
        yesFunc()
      else
        return
      end
    end)
  else
    yesFunc()
  end
end

function OnTabBottomChange()
  if REF.TabGrid == nil or REF.ArmSelectWidgetGrid == nil then
    return
  end
  Data.armBottom = REF.TabArms.UIToggle.value
  Data.actorBottom = REF.TabActors.UIToggle.value
  this:SetData("ActorSelectBase/ArmBottom", Data.armBottom)
  if Data.sortMateControl then
    if Data.armBottom then
      Data.sortMateCurrent = REF.SortMateArm.SortMate
      DB:SetData("DisplayOptionOrigin", WU.GetGameDataCache("LocalDisplayOption"))
      WU.SetDislayOption("arm")
    else
      local displayOption = DB:GetData("DisplayOptionOrigin")
      if displayOption == nil then
        displayOption = WU.GetGameDataCache("LocalDisplayOption")
      end
      WU.SetDislayOption(displayOption)
      Data.sortMateCurrent = Data.sortMateOrigin
    end
    REF["$UILuaWindow"].SortMate = Data.sortMateCurrent
    this:SetData("ActorSelectBase/CurSortMate", Data.sortMateCurrent)
  end
  SetBottomList(true)
  local go = WidgetGroupMembers["$GetSlotByIndex"](Data.slotIndex or 0)
  if Data.actorBottom then
    if Data.GetMembers ~= nil then
      OnSlotSelected(go)
    end
  elseif go ~= nil then
    _ENV["$"](go).WidgetActorCard["$SetHighlighted"](true)
  end
end

function SetBottomList(callBind)
  local sortData = this:GetData("SortFinished")
  if REF.ArmSelectWidgetGrid then
    REF.ArmSelectWidgetGrid.gameObject:SetActive(Data.armBottom)
  end
  if Data.armBottom and REF.ArmSelectWidgetGrid then
    Data.currentGrid = REF.ArmSelectWidgetGrid
    EU.SetArmUnNew()
    RefreshArm(Data.actorType)
  else
    Data.currentGrid = REF.ActorSelectWidgetGrid
  end
end
