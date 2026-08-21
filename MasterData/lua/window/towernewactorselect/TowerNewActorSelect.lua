local Base = inherit("Window/ActorSelect/ActorSelectBase", _ENV)
local groupBase = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local SE = require("Common/SkillEffect")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local GU = require("Common/GroupUtil")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local m_displayActorTable, m_initWindow
local m_repeatedContext = {}
local m_selectedActors = {}
local m_pills = {}
local m_members, m_mode
local m_select = 1
local m_group = 2
local m_tweenFromGroup = {
  80,
  788,
  1496
}

function SetupWindow()
  Base.SetupWindow()
  groupBase.SetupWindow()
  CustomizeWidgetGroup()
  this:SetData("TowerNew/PillSelected", nil)
  WU.BindButtonEvent(REF.ActorLink, OnActorLinkClick)
  WU.BindButtonEvent(REF.ButtonFight, Fight)
  REF.ActorMain.gameObject:SetActive(false)
  WU.BindButtonEvent(REF.Confirm, function()
    OnConfirm()
  end)
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateRow,
    delta = 0.01
  })
  Base.SetData("UpdateGroupActorUids", UpdateGroupActorUidsTower)
  Base.SetData("ActorClassifyFunc", OnTowerActorClassify)
  Base.SetData("OnActorGroupChanged", OnActorGroupChanged)
  Base.SetData("OnGroupMemberClick", function()
    SetMode(m_select)
  end)
  Base.SetData("GetMembers", function(groups)
    return groups
  end)
  Base.SetData("SetMembers", function(groups, patchData)
    m_members = patchData.members
    Base.SetData("groups", m_members)
    return true
  end)
end

function InitWindow()
  Base.SetData("refreshGroup", false)
  Base.InitWindow()
  groupBase.InitAutoFight(PB.enum.DungeonType.TowerNew)
  OnActorSelectMode()
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
  _ENV["$"](nav)["$$SetHomeCallback"](OnHomeCallback)
end

function UninitWindow()
  Base.UninitWindow()
end

function OnActorSelectMode()
  local groupUids = this:GetData("GroupActorUids")
  local copyUids = {}
  table.copy(groupUids, copyUids)
  this:SetData("GroupActorUidsCopy", copyUids)
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_initWindow = true
  WU.ToggleRendering(REF.Remove, false)
  WU.ToggleRendering(REF.Panel, false)
  WU.ToggleRendering(REF.ActorSelectWidgetGrid, false)
  local dataSource = this:GetData("fci/extreme-challenge/select-actors/")
  m_selectedActors = NormalizeActors(dataSource)
  this:SetData("fci/extreme-challenge/select-actors/", m_selectedActors)
  this:RegisterGameEvent("Sort/CurrentReverse", function(reverse)
    local factor = fif(reverse, 1, -1)
    for k, v in pairs(dataSource) do
      if v.hp then
        v.alive = fif(v.hp >= 0, factor, -factor)
      end
    end
  end)
  Base.OnSortFinished(m_selectedActors)
  this:Unbind("fci/extreme-challenge/actorgroup/", OnActorGroupChanged)
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/actorgroup/"), OnActorGroupChanged)
end

function NormalizeActors(data)
  if data == nil then
    return
  end
  for k, v in pairs(data.actors) do
    v.actor.actorName = WU.GetString("ActorName_" .. tostring(v.actor.id))
    v.actor.alive = fif(v.hp >= 0, 1, -1)
    v.actor.speed = U.GetAttrValue(v.actor.attrs, PB.enum.AttrType.Speed)
    v.actor.cultivationTotal = AU.GetActorCultivationDegree(v.actor)
    data[k] = v.actor
  end
  return data
end

function SetMode(mode)
  m_mode = mode
  REF.NodeGroup.gameObject:SetActive(m_mode == m_group)
  REF.PillGroup.gameObject:SetActive(m_mode == m_group)
  REF.NodeSelect.gameObject:SetActive(m_mode == m_select)
end

function OnActorGroupChanged(result)
  if result ~= nil then
    local groups = _ENV["!"]({})
    if result.actorGroup == nil then
      result = {actorGroup = result}
    end
    table.copy(result.actorGroup, groups, true)
    Base.SetData("groups", groups)
    m_members = groups
    WU.ToggleRendering(REF.Panel, true)
    RefreshGroupMembers()
    if m_initWindow then
      m_initWindow = false
      Base.ResetState(0, true, 0)
      Base.ClearAllSelect()
      REF["$Animator"]:Play("DelayOpen", -1, 0)
    end
    this:Bind("TowerNewActorSelect/MainActors/", function(list)
      local actorType = Base.GetData("actorType")
      if list and actorType == PB.enum.ActorType.Main then
        RefreshWrapContent(list)
      end
    end)
    this:Bind("TowerNewActorSelect/SubActors/", function(list)
      local actorType = Base.GetData("actorType")
      if list and actorType == PB.enum.ActorType.Sub then
        RefreshWrapContent(list)
      end
    end)
    SetMode(m_group)
    this:Bind("TowerNew/PillSelected", ManagePillSelected)
  end
end

function UpdateRow(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and m_displayActorTable ~= nil and rowIndex < #m_displayActorTable then
    local actor = m_displayActorTable[rowIndex + 1]
    rowRef["$$ResetState"]()
    rowRef["$$SetActor"](actor)
    rowRef["$$SetClickCallback"](ActorHeadClickCallBack)
    rowRef["$$SetHoldCallback"](Base.DefaultActorHeadHold)
    local currentActor
    local currentActorUid = Base.GetData("currentActorUid")
    if currentActorUid ~= nil then
      currentActor = GetTowerActor(currentActorUid)
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
      showSpeed = displayNumbers == SU.DisplayNumbers.Speed,
      showStar = displayNumbers == SU.DisplayNumbers.Star
    })
    local hp = actor.hp
    local maxHp = U.GetAttrValue(actor.attrs, PB.enum.AttrType.Hp)
    hp = fif(hp == 0, maxHp, actor.hp)
    local dead = hp < 0
    local pillDesc = fif(dead, nil, WU.GetString("Tower_PillFast") .. actor.dragfast)
    local hpDesc = fif(dead, nil, WU.GetString("ActorSelect_ActorAttrName_1") .. hp)
    local data = {
      Hp = hpDesc,
      Pill = pillDesc,
      Dead = dead
    }
    rowRef["$$ShowMoreInfo"](data)
  end
end

function ActorHeadClickCallBack(go)
  if m_members == nil then
    return
  end
  WU.RecordButtonClick(10012170 .. Base.GetData("actorType"))
  local ref = _ENV["$"](go)
  local WidgetGroupMembers = REF.WidgetGroupMembers
  local actorUid = ref["@uid"]
  if actorUid == nil then
    warning("actorUid nil?")
    return
  end
  local actorDown = GetTowerActor(actorUid)
  if actorDown.hp < 0 then
    WU.ShowHintText(WU.GetString("Tower_DeadChoose"))
    return
  end
  local top = WU.TopWindow()
  if top and top.name == "ActorPeek" then
    WU.ShowActorPeek(acTower)
  else
    local targetRef = WidgetGroupMembers["$GetSlotByIndex"](Base.GetData("slotIndex"))
    local cardUid = _ENV["$"](targetRef)["@uid"]
    if cardUid == actorUid then
      return
    end
    local actorUp = GetTowerActor(cardUid)
    Base.ClearAllSelect()
    local eventData = {
      index = Base.GetData("slotIndex"),
      cardS = actorDown,
      card = actorUp
    }
    WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, Base.OnGroupSlotChangeSuccess, function()
      Base.DefaultOnGroupSlotChangeCancel()
    end)
    Base.SetData("currentActorUid", actorUid)
  end
  RefreshGroupMembers()
  Base.OnSlotSelected(REF.WidgetGroupMembers["$GetSlotByIndex"](Base.GetData("slotIndex")))
end

function RefreshGroupMembers()
  local displayIdx = SU.DisplayOption[WU.GetGameDataCache("LocalDisplayOption") or "name"]
  REF.WidgetGroupMembers["$SetTowerNewGroupMembers"](m_members)
  REF.WidgetGroupMembers["$ShowCustom"]({
    showNew = false,
    showName = displayIdx == SU.DisplayOption.name,
    showEquips = displayIdx == SU.DisplayOption.equip,
    showArm = displayIdx == SU.DisplayOption.arm
  })
end

function OnConfirm(isHome, onBack)
  local groups = Base.GetData("groups")
  if WU.IsStandaloneGame() then
    this:SetData("fci/extreme-challenge/actorgroup/", groups)
    return
  end
  local wireFormatTable = GroupParamPrepare()
  this:GameRequest("fci/extreme-challenge/actorgroup/"):Post(wireFormatTable, function(response)
    this:SetData("fci/extreme-challenge/actorgroup/", groups)
    SetMode(m_group)
    if onBack then
      if isHome then
        Home()
      else
        WU.RecycleWindow(this)
      end
    end
  end)
end

function OnBackCallback()
  local top = WU.TopWindow()
  if top and top.name == "TowerNewActorSelect" then
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

function OnBackValidate(isHome)
  local function DontSave()
    this:SetData("GroupActorUids", this:GetData("GroupActorUidsCopy"))
    
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  local originalGroups = this:GetData("fci/extreme-challenge/actorgroup/")
  local groups = Base.GetData("groups")
  local orgMembers = originalGroups.actorGroup or originalGroups
  for i = 1, #orgMembers do
    local originUid, myUid
    if groups[i].actor then
      myUid = groups[i].actor.uid or 0
    else
      myUid = groups[i].actorUid or 0
    end
    if orgMembers[i].actor then
      originUid = orgMembers[i].actor.uid or 0
    else
      originUid = orgMembers[i].actorUid or 0
    end
    if myUid ~= originUid then
      WU.ShowMessageYesNo(WU.GetString("Window_ActorSelectBackValidate"), function(result)
        if result == "YES" then
          OnConfirm(isHome, true)
        else
          DontSave()
        end
      end)
      return
    end
  end
  DontSave()
end

function Focus(on)
  SetMode(m_group)
  Base.ClearAllSelect()
end

function Fight()
  WU.RecordButtonClick(100121706)
  local members = SplitUid(Base.GetData("groups"))
  if GU.GroupIsOK(members, true) and HasActorDead(members) then
    groupBase.Member2FightActorInfoTowerNew(members)
    RequestPostDungeon()
  end
end

function SplitUid(groups)
  local dataSource = groups.actorGroup or groups
  for k, v in pairs(dataSource) do
    if v.actor then
      v.actorUid = v.actor.uid
    end
  end
  return dataSource
end

function HasActorDead(members)
  local dataSource = members.actorGroup or members
  for _, member in pairs(dataSource) do
    if member.hp or member.actor then
      local hp = member.hp or member.actor.hp
      if hp < 0 then
        WU.ShowHintText(WU.GetString("Tower_FightWithDead"))
        return false
      end
    end
  end
  return true
end

function RequestPostDungeon()
  local summary = this:GetData("fci/extreme-challenge/summary/")
  local pillUse = {}
  for i = 1, 3 do
    if m_pills[i] then
      pillUse[i] = m_pills[i].id
    else
      pillUse[i] = 0
    end
  end
  local wireFormatTable = GroupParamPrepare()
  this:GameRequest("fci/extreme-challenge/actorgroup/"):Post(wireFormatTable, function(groupResponse)
    local requestGroup = groupResponse.actorGroup
    local reduceInfo = {}
    local dungeonId = this:GetData("ActorGroupTower/DungeonId")
    local param = {
      dungeonId = dungeonId,
      multiPower = 1,
      price = DU.GetDungeonPrice(dungeonId),
      isChallengeMode = true,
      reduceInfo = reduceInfo
    }
    this:SetData("PowerMultiple", 1)
    this:SetData("WindowDungeon/EnterParam", param)
    this:SetData("BalanceInfo/Groups", {groups = requestGroup})
    this:GameRequest("fci/extreme-challenge/"):Post({buffItemUse = pillUse}, function(result)
      DBH.ResChange(result.resChange)
      local fightActorInfo = {
        {
          playerId = this:GetData("playerId"),
          actors = requestGroup
        }
      }
      this:SetData("FightActorInfo", fightActorInfo)
      if requestGroup ~= nil then
        local fightInitInfo = {
          {
            hp = result.challengeInfo.myHpList,
            monsterList = {
              0,
              0,
              0,
              0,
              0,
              0
            },
            mp = -1,
            sp = -1
          },
          {
            hp = {
              0,
              0,
              0,
              0,
              0,
              0
            },
            monsterList = result.challengeInfo.enemyList
          }
        }
        this:SetData("FightInitInfo", fightInitInfo)
        WU.EnterGameLevel(result.dungeonUid, result.baseInfo, param.dungeonId, PB.enum.DungeonType.TowerNew, 1)
      end
    end)
  end)
end

function RefreshWrapContent(list)
  WU.ToggleRendering(Base.GetData("currentGrid"), true)
  m_displayActorTable = _ENV["!"]({})
  _ENV["!"](list):copy(m_displayActorTable)
  RemoveActorsInGroupTower(m_displayActorTable)
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
  WU.RecordButtonClick(100121704)
  OpenDisplayInfo("ActorInfoDisplay", function(ui)
    _ENV["$"](ui)["$$SetSelectedTab"]("TabRelation")
    _ENV["$"](ui)["$$HideTab"]("TabEquipDisplay")
  end)
end

function OnActorMainClick()
  OpenDisplayInfo("ActorMainDisplay")
end

function CreateRollerTraverse()
  local traverseData = _ENV["!"]({})
  local groups = Base.GetData("groups")
  local members = groups
  for i = 1, #members do
    if members[i].actorUid ~= 0 then
      table.insert(traverseData, GetTowerActor(members[i].actorUid))
    end
  end
  return traverseData
end

function OnTowerActorClassify(data)
  local actors = data
  local main = {}
  local sub = {}
  if actors ~= nil then
    for i = 1, #actors do
      local actorConfig = PB.get("ActorConfig", actors[i].id)
      if actorConfig then
        if actorConfig.kind == PB.enum.ActorType.Main then
          table.insert(main, actors[i])
        elseif actorConfig.kind == PB.enum.ActorType.Sub then
          table.insert(sub, actors[i])
        end
      end
    end
  end
  DB:SetData("TowerNewActorSelect/MainActors/", main)
  DB:SetData("TowerNewActorSelect/SubActors/", sub)
  return main, sub
end

function UpdateGroupActorUidsTower(groupsBefore, groupsNow, mode)
  mode = PB.enum.ActorGroupType.TowerNew
  local number = 1 << mode - 1
  local groupActorUids = DB:GetData("GroupActorUids")
  local tmpUids = _ENV["!"]({})
  _ENV["!"](groupActorUids):copy(tmpUids)
  local uids = _ENV["!"]({})
  for _, v in pairs(groupsBefore) do
    table.insert(uids, v.actorUid)
  end
  uids = uids:distinct()
  for i = 1, #uids do
    groupActorUids[uids[i]] = (groupActorUids[uids[i]] or 0) & ~number
  end
  uids = _ENV["!"]({})
  for _, v in pairs(groupsNow) do
    table.insert(uids, v.actorUid)
  end
  uids = uids:distinct()
  for i = 1, #uids do
    groupActorUids[uids[i]] = (groupActorUids[uids[i]] or 0) | number
  end
  DB:SetData("GroupActorUids", groupActorUids)
end

function RemoveActorsInGroupTower(actors)
  local uids = {}
  for i = 1, #m_members do
    local member = m_members[i].actor
    if member ~= nil then
      uids[member.uid] = true
    end
  end
  for i = #actors, 1, -1 do
    local actor = actors[i]
    if uids[actor.uid] == true then
      table.remove(actors, i)
    end
  end
end

function ManagePillSelected(pills)
  pills = pills or {}
  WU.TraverseChildren(REF.PillGroup, function(go, index)
    local ref = _ENV["$"](go)
    local root = ref.root
    local realIndex = 3 - index
    m_pills = pills
    local pillAdds = CacuDrugEffect(pills)
    for i = 1, 3 do
      local idx = 4 - i
      local drug1, drug2
      if m_members[idx].actor then
        drug1 = m_members[idx].actor.dragfast
      else
        drug1 = m_members[idx].dragfast
      end
      if m_members[idx + 3].actor then
        drug2 = m_members[idx + 3].actor.dragfast
      else
        drug2 = m_members[idx + 3].dragfast
      end
      local dragfast = {
        fif(m_members[idx].actor == nil, nil, drug1),
        fif(m_members[idx + 3].actor == nil, nil, drug2)
      }
      local ref = _ENV["$"](REF.Grid[idx - 1].WidgetGroupMemberLink)
      if pillAdds[i] then
        ref["$$SetPill"](dragfast, pillAdds[i])
      else
        ref["$$SetPill"](dragfast)
      end
    end
    local desc = ""
    if pills[realIndex] then
      desc = SE.GetTowerPillDesc(pills[realIndex].id, true, 2)
      ref.WidgetIconSlot["$SetData"](pills[realIndex].type, pills[realIndex].id, pills[realIndex].count)
    else
      ref.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResExtremeChallengeItem, nil, nil)
    end
    ref.LabelPillDesc.UIHtmlLabel.text = desc
    ref.SpriteAdd.gameObject:SetActive(not pills[realIndex])
    local redVal = PB.index("Misc", 1).extremeChallengeDrugLimit
    local main = m_members[realIndex].actor
    local sub = m_members[realIndex + 3].actor
    ref.SpriteUseless.gameObject:SetActive(false)
    if pills[realIndex] then
      local pillInfo = PB.get("ExtremeChallengeBuffItem", pills[realIndex].id)
      local useful = main and sub and main.hp >= 0 and sub.hp >= 0 and redVal > main.dragfast + sub.dragfast
      ref.SpriteUseless.gameObject:SetActive(not useful and pillInfo.dragfastAdd and 0 < pillInfo.dragfastAdd)
    end
    if not root.bindB4 then
      WU.BindButtonEvent(ref.ButtonPill, function()
        WU.RecordButtonClick(100121703)
        WU.AcquireWindowAsync("TowerNewPillsSelect", function(ui)
          _ENV["$"](ui)["$$SetGroup"](m_members)
          _ENV["$"](ui)["$$SetSelectedIndex"](realIndex)
        end)
      end)
      root.bindB4 = true
    end
  end)
end

function CacuDrugEffect(pills)
  local addGroups = {}
  for i = 1, 3 do
    if pills[i] then
      local pillInfo = PB.get("ExtremeChallengeBuffItem", pills[i].id)
      if pillInfo.dragfastAdd then
        if pillInfo.isDragfastGlobal == true then
          for j = 1, 3 do
            addGroups[j] = addGroups[j] or 0
            addGroups[j] = addGroups[j] + pillInfo.dragfastAdd
          end
        else
          addGroups[i] = addGroups[i] or 0
          addGroups[i] = addGroups[i] + pillInfo.dragfastAdd
        end
      end
    end
  end
  return addGroups
end

function CustomizeWidgetGroup()
  REF.WidgetGroupMembers.transform.localScale = CS.UnityEngine.Vector3(0.8, 0.8, 1)
  REF.GroupTabNode.gameObject:SetActive(false)
  REF.Grid.UIGrid.cellWidth = 708
  for i = 1, 3 do
    local root = _ENV["$"](REF["TweenNode" .. i])
    local pos = REF["TweenNode" .. i].transform.localPosition
    REF["TweenNode" .. i].TweenPosition.from = CS.UnityEngine.Vector3(m_tweenFromGroup[i], pos.y, 0)
    REF["TweenNode" .. i].TweenPosition.to = CS.UnityEngine.Vector3(m_tweenFromGroup[i] - 80, pos.y, 0)
    root.WidgetActorCardEffectMain.transform.localScale = CS.UnityEngine.Vector3(0.8, 0.8, 1)
    root.WidgetActorCardEffectSub.transform.localScale = CS.UnityEngine.Vector3(0.8, 0.8, 1)
    root.Attrs.UISprite.height = 350
  end
end

function GetTowerActor(uid)
  local ac
  for i = 1, #m_selectedActors do
    if m_selectedActors[i].uid == uid then
      ac = m_selectedActors[i]
      break
    end
  end
  return ac
end

function GroupParamPrepare()
  local param = {}
  for k, v in pairs(m_members) do
    if v.actor then
      param[k] = v.actor.index
    else
      param[k] = 0
    end
  end
  return ProtobufT("ApiExtremeChallengeActorGroup", {actorIndexs = param})
end

function OpenDisplayInfo(win, callback)
  local currentActorUid = Base.GetData("currentActorUid")
  if currentActorUid ~= nil and 0 < currentActorUid then
    local ac = GetTowerActor(currentActorUid)
    local actorInfo = ac
    local displayInfo = {actorInfo = actorInfo}
    if actorInfo ~= nil and 0 < actorInfo.id then
      WU.AcquireWindowAsync(win, function(ui)
        if callback then
          callback(ui)
        end
        this:SetData("Space/DisplayInfo", displayInfo)
      end)
    end
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001217, on)
end
