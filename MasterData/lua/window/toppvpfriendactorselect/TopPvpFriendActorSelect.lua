local Base = inherit("Window/ActorSelect/ActorSelectBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local GU = require("Common/GroupUtil")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local m_displayActorTable, m_initWindow
local urlKey = "fci/friendpvp/match/"
local m_invoke, m_count, m_window

function SetupWindow()
  Base.SetupWindow()
  Base.BindTabs()
  WU.BindButtonEvent(REF.ActorLink, OnActorLinkClick)
  WU.BindButtonEvent(REF.ActorMain, OnActorMainClick)
  WU.BindButtonEvent(REF.Confirm, function()
    OnConfirm()
  end)
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateRow,
    delta = 0.01
  })
  Base.SetData("UpdateGroupActorUids", function(groups, copy)
    GU.UpdateGroupActorUids(groups, copy, PB.enum.ActorGroupType.FriendPvp)
  end)
  Base.SetData("OnActorGroupChanged", OnActorGroupChanged)
end

function InitWindow()
  m_initWindow = true
  WU.ToggleRendering(REF.Remove, false)
  WU.ToggleRendering(REF.Panel, false)
  WU.ToggleRendering(REF.ActorSelectWidgetGrid, false)
  local groupUids = this:GetData("GroupActorUids")
  local copyUids = {}
  table.copy(groupUids, copyUids)
  this:SetData("GroupActorUidsCopyTopPvpFriend", copyUids)
  Base.InitWindow()
  this:Bind(urlKey, OnActorGroupChanged)
  this:Bind("TopPvpFriendActorSelect/MainActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Main then
      RefreshWrapContent(list)
    end
  end)
  this:Bind("TopPvpFriendActorSelect/SubActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Sub then
      RefreshWrapContent(list)
    end
  end)
  this:RegisterGameEvent("DealFriendFightRes", function(res)
    if res.resultCode ~= 0 then
      WU.RecycleWindow(this)
    end
  end)
  m_window = WU.FindWindow("TopPvpFriendActorGroup")
  if m_window then
    m_window = _ENV["$"](m_window)
    m_invoke = this:RepeatInvokeInSeconds(1, function()
      m_count = m_window["$$GetCount"]()
      REF.LabelCount.UILabel.text = tostring(m_count)
      if m_count <= 0 and m_invoke then
        this:StopCoroutine(m_invoke)
        m_invoke = nil
      end
    end)
  end
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
  _ENV["$"](nav)["$$SetHomeCallback"](OnHomeCallback)
end

function UninitWindow()
  Base.UninitWindow()
end

function SaveContext()
  this:SetData("GroupActorUids", this:GetData("GroupActorUidsCopyTopPvpFriend"))
end

function OnSelectedActorGroupId(result)
  if result then
    local selectedGroupId = fif(tonumber(result.selectActorGroupId) == 0, 1, tonumber(result.selectActorGroupId))
    Base.SetData("selectedGroupId", selectedGroupId)
    Base.SetData("displayAttrs", false)
    Base.RefreshAttrDisplay()
    this:Unbind(urlKey, OnActorGroupChanged)
    this:BindRemote(DB:GameRequest(urlKey), OnActorGroupChanged)
  end
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    local groups = {}
    table.copy(actorGroup, groups, true)
    Base.SetData("groups", groups)
    Base.SetData("selectedGroupId", 1)
    local selectedGroupId = Base.GetData("selectedGroupId")
    REF.GroupTabNode[selectedGroupId - 1]["$UIToggle"].value = true
    Base.RefreshGroupMembers(true)
    WU.ToggleRendering(REF.Panel, true)
    if m_initWindow then
      m_initWindow = false
      local index = this:GetData("AutoSlotSelection")
      this:SetData("AutoSlotSelection", nil)
      Base.ResetState(0, true, index)
      REF["$Animator"]:Play("DelayOpen", -1, 0)
    end
  end
end

function UpdateRow(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and m_displayActorTable ~= nil and rowIndex < #m_displayActorTable then
    local actor = m_displayActorTable[rowIndex + 1]
    rowRef["$$BindActor"](actor)
    local key = TowerTipsCheck(actor.uid)
    local selectedGroupId = Base.GetData("selectedGroupId")
    if key ~= nil and key ~= tostring(selectedGroupId) then
      rowRef["$$SetClickCallback"]()
      rowRef["$$SetHoldCallback"]()
    else
      rowRef["$$SetClickCallback"](Base.DefaultActorHeadClick)
      rowRef["$$SetHoldCallback"](Base.DefaultActorHeadHold)
    end
    local currentActor
    local currentActorUid = Base.GetData("currentActorUid")
    if currentActorUid ~= nil then
      currentActor = this:GetData("fci/actor/" .. currentActorUid)
    end
    local linksActorId = Base.GetData("linksActorId")
    if currentActor ~= nil and currentActor.id == actor.id then
      rowRef["$$SetMemberLink"](false)
    elseif linksActorId ~= nil then
      rowRef["$$SetMemberLink"](linksActorId[actor.id])
    end
    rowRef["@uid"] = actor.uid
    local displayNumbers = Base.GetData("displayNumbers")
    rowRef["$$ShowCustom"]({
      showCultivationTotal = displayNumbers == SU.DisplayNumbers.Cultivation,
      showSpeed = displayNumbers == SU.DisplayNumbers.Speed,
      showStar = displayNumbers == SU.DisplayNumbers.Star
    })
  end
end

function TowerTipsCheck(uid)
  local groups = Base.GetData("groups")
  for k, v in pairs(groups) do
    for i = 1, #v.members do
      if v.members[i].actorUid == uid then
        return k
      end
    end
  end
end

function OnConfirm(isHome)
  local groups = Base.GetData("groups")
  
  local function Recycle()
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  local selectedGroupId = Base.GetData("selectedGroupId")
  local members = groups[tostring(selectedGroupId)].members
  if not GU.GroupIsOK(members, true) then
    return
  end
  this:GameRequest(urlKey):Put({
    groupInfo = groups[tostring(selectedGroupId)]
  }, function(response)
    local groups = {}
    groups["1"] = response
    this:SetData(urlKey, groups)
    Recycle()
  end)
end

function OnBackCallback()
  local top = WU.TopWindow()
  if top and top.name == "TopPvpFriendActorSelect" then
    OnBackValidate()
  else
    this:BroadcastGameEvent("OnNavigation", "Back")
  end
end

function OnHomeCallback()
  OnBackValidate(true)
end

function Home()
  local winName = "City"
  S:Get("TutorialManager").SetNavigation(winName)
  this:BroadcastGameEvent("OnNavigation", winName)
end

function OnBackValidate(isHome, force)
  local function DontSave()
    this:SetData("GroupActorUids", this:GetData("GroupActorUidsCopyTopPvpFriend"))
    
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  if force then
    DontSave()
  else
    local originalGroups = this:GetData(urlKey)
    local groups = Base.GetData("groups")
    for k, v in pairs(originalGroups) do
      for i = 1, #v.members do
        local member = v.members[i]
        if member.actorUid ~= groups[k].members[i].actorUid then
          WU.ShowMessageYesNo(WU.GetString("Window_ActorSelectBackValidate"), function(result)
            if result == "YES" then
              OnConfirm(isHome)
            else
              DontSave()
            end
          end)
          return
        end
      end
    end
    DontSave()
  end
end

function Focus(on)
  Base.Focus(on)
  if on then
    WU.SetWindowTitle("TopPvpFriendActorSelect", "ActorSelect")
    local nav = WU.FindWindow("TopPvpFriendActorGroup")
    if nav ~= nil then
      _ENV["$"](nav)["$$CheckNeedClose"]()
    end
  end
end

function RefreshWrapContent(list)
  WU.ToggleRendering(Base.GetData("currentGrid"), true)
  m_displayActorTable = _ENV["!"]({})
  _ENV["!"](list):copy(m_displayActorTable)
  Base.RemoveActorsInGroup(m_displayActorTable)
  local resetPosition = true
  local resetActorSelect = Base.GetData("resetActorSelect")
  if resetActorSelect == false then
    resetPosition = false
  end
  if Base.GetData("currentGrid") == REF.ActorSelectWidgetGrid then
    LU.Set(REF.ActorSelectWidgetGrid, #m_displayActorTable, resetPosition, not resetPosition)
  end
end

function OnActorLinkClick()
  local currentActorUid = Base.GetData("currentActorUid")
  if currentActorUid ~= nil and 0 < currentActorUid then
    WU.AcquireWindowAsync("ActorInfo", function()
      this:SetData("Actor/RollerTraverse", CreateRollerTraverse())
      this:SetData("Actor/SelectedUid", currentActorUid)
      this:BroadcastGameEvent("EventSwitchTab", "TabRelation")
    end)
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function OnActorMainClick()
  local currentActorUid = Base.GetData("currentActorUid")
  if currentActorUid ~= nil and 0 < currentActorUid then
    this:SetData("Actor/SelectedUid", nil)
    WU.AcquireWindowAsync("ActorMain", function()
      this:SetData("Actor/RollerTraverse", CreateRollerTraverse())
      this:SetData("Actor/SelectedUid", currentActorUid)
    end)
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function CreateRollerTraverse()
  local traverseData = _ENV["!"]({})
  local groups = Base.GetData("groups")
  local groupId = Base.GetData("selectedGroupId")
  local members = groups[tostring(groupId)].members
  for i = 1, #members do
    if members[i].actorUid ~= 0 then
      table.insert(traverseData, this:GetData("fci/actor/" .. members[i].actorUid))
    end
  end
  return traverseData
end

function ShowConfirmTips()
  local tips = ""
  local cancelText
  local groups = Base.GetData("groups")
  local invalidGroups = GU.GetTowerNotOKGroup(groups)
  if invalidGroups ~= "" then
    tips = WU.GetString("WindowTower_TipGroupInsufficientMembers", invalidGroups) .. "</br>"
  end
  tips = tips .. WU.GetString("WindowTower_TipCantChangeGroup")
  cancelText = WU.GetString("WindowTower_AdjustGroup")
  WU.ShowMessageYesNo(tips, function(result)
    if result == "YES" then
      OnConfirm()
    end
  end, nil, cancelText)
end
