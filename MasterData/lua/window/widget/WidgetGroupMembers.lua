local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local U = require("Common/Util")
local DU = require("Common/DungeonUtil")
local m_showHint = false
local m_allowDragDrop = false
local m_confirmCallback, m_cancelCallback, m_widgetRefCache, m_clickBack

function SetClickCallback(callback)
  m_clickBack = callback
  
  local function Fuc(ref, i)
    local go = ref["$gameObject"]
    ref.ButtonSlot.BoxCollider2D.enabled = false
    WU.BindButtonEvent(go, function()
      if m_clickBack ~= nil then
        m_clickBack(go, i)
      end
    end)
  end
  
  for i = 0, #REF.Grid - 1 do
    Fuc(_ENV["$"](REF.Grid[i].DragDropNodeMain), i * 2)
    Fuc(_ENV["$"](REF.Grid[i].DragDropNodeSub), i * 2 + 1)
  end
end

function ClearClickCallback()
  for i = 0, #REF.Grid - 1 do
    WU.ClearButtonEvent(_ENV["$"](REF.Grid[i].DragDropNodeMain)["$gameObject"])
    WU.ClearButtonEvent(_ENV["$"](REF.Grid[i].DragDropNodeSub)["$gameObject"])
  end
end

function Start()
  local function Fuc(ref)
    table.insert(m_widgetRefCache, ref)
    
    ref["$UIEventListener"].onDrop = OnDrop
    ref["$UIDragDropItem"].onClone = function(original, clone)
      _ENV["$"](clone)["@uid"] = _ENV["$"](original)["@uid"]
      _ENV["$"](clone)["@index"] = _ENV["$"](original)["@index"]
      _ENV["$"](clone)["@actor"] = _ENV["$"](original)["@actor"]
      _ENV["$"](clone)["@isNpc"] = _ENV["$"](original)["@isNpc"]
      _ENV["$"](clone)["@isGuildActor"] = _ENV["$"](original)["@isGuildActor"]
    end
    ref["$UIDragDropItem"].parentNode = REF.DragDropTop.gameObject
  end
  
  m_widgetRefCache = {}
  for i = 0, #REF.Grid - 1 do
    Fuc(_ENV["$"](REF.Grid[i].DragDropNodeMain))
    Fuc(_ENV["$"](REF.Grid[i].DragDropNodeSub))
  end
  local localScale = REF["$transform"].localScale
  if localScale.x ~= 1 or localScale.y ~= 1 then
    for i = 0, #REF.Grid - 1 do
      local ref = _ENV["$"](REF.Grid[i].WidgetGroupMemberLink)
      ref["$$SetSCardScale"](CS.UnityEngine.Vector3(localScale.x, localScale.y, localScale.z))
    end
  end
end

function OnDrop(gameObject, dropGo)
  local goRef = _ENV["$"](gameObject)
  local dropRef = _ENV["$"](dropGo)
  if dropRef["@isNpc"] and (not goRef["@isNpc"] or not dropRef["@isNpc"]) then
    local dun = this:GetData("ActorGroup/DungeonId")
    if not DU.IsSemifixedDungeon(dun) then
      WU.ShowHintText(WU.GetString("Window_SemiFixedActorSelect_FixedOnly"))
      return
    end
  end
  if dropRef["@isNpc"] and dropRef["@actor"] then
    dropRef["@uid"] = dropRef["@actor"].npcId
  end
  if goRef["@isNpc"] and goRef["@actor"] then
    goRef["@uid"] = goRef["@actor"].npcId
  end
  if dropRef["@uid"] and m_allowDragDrop then
    local eventData = {
      index = goRef["@index"],
      card = goRef["@actor"],
      cardS = dropRef["@actor"],
      isDrop = true,
      actorS = dropRef["@actor"]
    }
    OnActorGroupSlotChanged(eventData, function(patchData)
      if type(m_confirmCallback) == "function" then
        m_confirmCallback(patchData, goRef["@index"], dropRef["@index"])
      end
    end, function()
      if type(m_cancelCallback) == "function" then
        m_cancelCallback()
      end
    end)
  end
end

function SetShowHint(flag)
  m_showHint = flag
end

function AllowDragDrop(confirmCallback, cancelCallback)
  m_allowDragDrop = true
  for i = 0, #REF.Grid - 1 do
    local ref = _ENV["$"](REF.Grid[i].WidgetGroupMemberLink)
    ref["$$AllowDragDrop"](m_allowDragDrop)
  end
  m_confirmCallback = confirmCallback
  m_cancelCallback = cancelCallback
end

function SetBuffActivityGroupMember(members, ratios, activityType, activityId)
  for i = 1, 3 do
    local ref = _ENV["$"](REF.Grid[i - 1].WidgetGroupMemberLink)
    SetIndex(members[i].index, ref)
    ref["$$SetActorsBuffActivity"](members[i], members[i + 3], ratios and ratios[members[i].index], ratios and ratios[members[i + 3].index], activityType, activityId, i)
  end
  if m_showHint then
    local canGroupedMain, canGroupedSub = ActorsNotGrouped(members)
    local mainCount, subCount = #canGroupedMain, #canGroupedSub
    for i = 1, 3 do
      local ref = REF.Grid[i - 1]
      ref.HintCanGroupMain.gameObject:SetActive(false)
      ref.HintCanGroupSub.gameObject:SetActive(false)
    end
    for i = 1, 3 do
      local ref = REF.Grid[i - 1]
      local showMainEffect = 0 < mainCount and members[i].actorUid == 0
      if showMainEffect then
        mainCount = mainCount - 1
      end
      ref.HintCanGroupMain.gameObject:SetActive(showMainEffect)
      ref.HintCanGroupMainLabel.UILabel.text = i
      _ENV["$"](ref.DragDropNodeMain).GroupTag.gameObject:SetActive(not showMainEffect)
      local showSubEffect = 0 < subCount and members[i + 3].actorUid == 0
      if showSubEffect then
        subCount = subCount - 1
      end
      ref.HintCanGroupSub.gameObject:SetActive(showSubEffect)
      _ENV["$"](ref.DragDropNodeSub).GroupTag.gameObject:SetActive(not showSubEffect)
    end
  end
end

function SetGroupMembers(members, ratios)
  for i = 1, 3 do
    local ref = _ENV["$"](REF.Grid[i - 1].WidgetGroupMemberLink)
    SetIndex(members[i].index, ref)
    ref["$$SetActors"](members[i], members[i + 3], ratios and ratios[members[i].index], ratios and ratios[members[i + 3].index])
  end
  if m_showHint then
    local canGroupedMain, canGroupedSub = ActorsNotGrouped(members)
    local mainCount, subCount = #canGroupedMain, #canGroupedSub
    for i = 1, 3 do
      local ref = REF.Grid[i - 1]
      ref.HintCanGroupMain.gameObject:SetActive(false)
      ref.HintCanGroupSub.gameObject:SetActive(false)
    end
    for i = 1, 3 do
      local ref = REF.Grid[i - 1]
      local showMainEffect = 0 < mainCount and members[i].actorUid == 0
      if showMainEffect then
        mainCount = mainCount - 1
      end
      ref.HintCanGroupMain.gameObject:SetActive(showMainEffect)
      ref.HintCanGroupMainLabel.UILabel.text = i
      _ENV["$"](ref.DragDropNodeMain).GroupTag.gameObject:SetActive(not showMainEffect)
      local showSubEffect = 0 < subCount and members[i + 3].actorUid == 0
      if showSubEffect then
        subCount = subCount - 1
      end
      ref.HintCanGroupSub.gameObject:SetActive(showSubEffect)
      _ENV["$"](ref.DragDropNodeSub).GroupTag.gameObject:SetActive(not showSubEffect)
    end
  end
end

function ActorsNotGrouped(members)
  local memberUids = _ENV["!"]({})
  for i = 1, #members do
    if members[i].actorUid > 0 then
      memberUids[members[i].actorUid] = true
    end
  end
  local memberActors = AU.GetActorList(memberUids:keys())
  local disabledRoleIds = _ENV["!"]({})
  if memberActors ~= nil then
    for i = 1, #memberActors do
      local actor = memberActors[i]
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig then
        disabledRoleIds[actorConfig.role] = true
      end
    end
  end
  local actors = this:GetData("fci/actor/")
  local leftMain = {}
  local leftSub = {}
  for i = 1, #actors do
    local actor = actors[i]
    if not memberUids[actor.uid] then
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig and not disabledRoleIds[actorConfig.role] then
        if actorConfig.kind == PB.enum.ActorType.Main then
          table.insert(leftMain, actor)
        elseif actorConfig.kind == PB.enum.ActorType.Sub then
          table.insert(leftSub, actor)
        end
      end
    end
  end
  return leftMain, leftSub
end

function SetBurstLinkGroupMembers(members, actorPool)
  for i = 1, 3 do
    local ref = _ENV["$"](REF.Grid[i - 1].WidgetGroupMemberLink)
    SetIndex(members[i].index, ref)
    local _, main = table.find(actorPool, function(_, v)
      return v.uid == members[i].actorUid
    end)
    local _, sub = table.find(actorPool, function(_, v)
      return v.uid == members[i + 3].actorUid
    end)
    ref["$$SetBurstLinkActors"](main, sub)
  end
end

function Set91GroupMembers(members)
  for i = 1, 3 do
    local ref = _ENV["$"](REF.Grid[i - 1].WidgetGroupMemberLink)
    SetIndex(members[i].index, ref)
    ref["$$SetActors91"](members[i], members[i + 3])
  end
end

function SetRandomCallMembers(members)
  for i = 1, 3 do
    local ref = _ENV["$"](REF.Grid[i - 1].WidgetGroupMemberLink)
    SetIndex(members[i].index, ref)
    ref["$$SetActorsRandomCall"](members[i], members[i + 3])
  end
end

function SetSpaceGroupMembers(members, notMyActors)
  for i = 1, 3 do
    local ref = _ENV["$"](REF.Grid[i - 1].WidgetGroupMemberLink)
    SetIndex(members[i].index, ref)
    ref["$$SetActorsStatic"](members[i], members[i + 3], notMyActors)
  end
end

function ClearSlot(ref, index)
  ref["@actor"] = nil
  ref["@roleId"] = nil
  ref["@uid"] = nil
  ref["@isNpc"] = nil
  ref["@isGuildActor"] = nil
  ref.WidgetActorCard["$SetEmpty"](index)
  ref["$UIDragDropItem"].enabled = false
end

function SetTowerGroupMembers(members, locked)
  for i = 1, 3 do
    local ref = _ENV["$"](REF.Grid[i - 1].WidgetGroupMemberLink)
    SetIndex(members[i].index, ref)
    ref["$$SetActorsTower"](members[i], members[i + 3], locked)
    if locked and members[i].actor then
      ref["$$SetDead"](members[i].dead)
      ref["$$SetHp"](GU.GetHpFillAmount(members, i))
    else
      ref["$$SetDead"](false)
      ref["$$SetHp"]()
    end
  end
end

function SetTowerNewGroupMembers(members)
  local hp1, hp2, pill1, pill2
  local data = this:GetData("fci/extreme-challenge/select-actors/")
  for k, v in pairs(data.actors) do
    v.actor.hp = v.hp
    v.actor.dragfast = v.dragfast
    v.actor.index = v.index
  end
  
  local function GetActorFromData(index)
    local uid = 0
    if members[index].actorUid and members[index].actorUid ~= 0 then
      uid = members[index].actorUid
    elseif members[index].actor then
      uid = members[index].actor.uid
    end
    local _, actorContainer = table.find(data.actors, function(k, v)
      return v.actor.uid == uid
    end)
    if actorContainer then
      return actorContainer.actor, actorContainer.actor.hp, actorContainer.actor.dragfast
    end
    return nil
  end
  
  for i = 1, 3 do
    local ref = _ENV["$"](REF.Grid[i - 1].WidgetGroupMemberLink)
    SetIndex(i - 1, ref)
    members[i].actor, hp1, pill1 = GetActorFromData(i)
    members[i + 3].actor, hp2, pill2 = GetActorFromData(i + 3)
    ref["$$SetActorsTowerNew"](members[i], members[i + 3])
    ref["$$SetDeadDetail"]({
      fif(hp1 == nil, 0, hp1),
      fif(hp2 == nil, 0, hp2)
    })
    local mainFill, subFill = GU.GetHpFillAmountNew(members, i)
    ref["$$SetHpDetail"](mainFill, subFill, true)
  end
end

function SetMazeGroupMembers(members)
  for i = 1, 3 do
    local ref = _ENV["$"](REF.Grid[i - 1].WidgetGroupMemberLink)
    SetIndex(members[i].index, ref)
    ref["$$SetActorsMaze"](members[i], members[i + 3])
    if members[i].actor or members[i + 3].actor then
      ref["$$SetDead"](false)
      ref["$$SetHp"]()
      ref["$$SetPill"]()
      local mainFill, subFill = GU.GetHpFillAmountNew2(members, i)
      ref["$$SetHpDetail"](mainFill, subFill, true)
      local hp1 = members[i].hp or 1
      local hp2 = members[i + 3].hp or 1
      ref["$$SetDeadDetail"]({
        fif(hp1 == 0, -1, hp1),
        fif(hp2 == 0, -1, hp2)
      })
    else
      ref["$$SetDead"](false)
      ref["$$SetHp"]()
      ref["$$SetPill"]()
      ref["$$SetDeadDetail"]()
      ref["$$SetHpDetail"]()
    end
  end
end

function ClearSelection()
  for i = 0, #REF.Grid - 1 do
    _ENV["$"](REF.Grid[i].DragDropNodeMain).WidgetActorCard["$SetHighlighted"](false)
    _ENV["$"](REF.Grid[i].DragDropNodeSub).WidgetActorCard["$SetHighlighted"](false)
  end
end

function OnActorGroupSlotChanged(eventData, successCallback, cancelCallback)
  if eventData ~= nil then
    local function SameKind(index1, index2)
      return GU.IsMainIndex(index1) == GU.IsMainIndex(index2)
    end
    
    local function GetKindStr(ref)
      return fif(ref["@kind"] == PB.enum.ActorType.Sub, "WindowGroup_ActorInGroupSub", "WindowGroup_ActorInGroupMain")
    end
    
    local index = eventData.index
    local cardSInfo = eventData.cardS
    if eventData.cardSUid then
      cardSInfo = this:GetData("fci/actor/" .. eventData.cardSUid)
    end
    local cardInfo = eventData.card
    if eventData.cardUid then
      cardInfo = this:GetData("fci/actor/" .. eventData.cardUid)
    end
    local isDrop = eventData.isDrop
    local exIdx, exRef = GetCPIndex(cardSInfo, index)
    local exRoleIdx, exRoleRef = GetExchangeIndex(cardSInfo)
    if exIdx and exRoleIdx and not SameKind(index, exIdx) and not isDrop then
      WU.ShowMessageYesNo(WU.GetString(GetKindStr(exRef)), function(msg)
        if msg == "YES" then
          successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exIdx))
          successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exRoleIdx))
        elseif cancelCallback then
          cancelCallback()
        end
      end)
    elseif exRoleIdx and exRoleIdx ~= index then
      if isDrop then
        if not KindOfIndexValidate(index, exRoleIdx) then
          return
        end
        if exIdx then
          if GU.IsMainIndex(index) ~= GU.IsMainIndex(exIdx) then
            WU.ShowHintText(WU.GetString("Group_DropOperationRoleIdConflict"))
            return
          end
          WU.ShowMessageYesNo(WU.GetString(GetKindStr(exRef)), function(msg)
            if msg == "YES" then
              successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exIdx))
              successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exRoleIdx))
            else
              cancelCallback()
            end
          end)
        elseif DropLegalCheck(index, cardSInfo) and DropLegalCheck(exRoleIdx, cardInfo) then
          successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exRoleIdx, cardInfo))
        else
          successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exRoleIdx))
        end
      elseif GU.IsMainIndex(index) ~= GU.IsMainIndex(exRoleIdx) then
        successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exRoleIdx))
      else
        successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exRoleIdx, cardInfo))
      end
    elseif exIdx and exIdx ~= index then
      if not SameKind(index, exIdx) then
        if isDrop then
          WU.ShowHintText(WU.GetString("Group_DropOperationNotAllowed"))
          return
        end
        WU.ShowMessageYesNo(WU.GetString(GetKindStr(exRef)), function(msg)
          if msg == "YES" then
            successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exIdx))
          else
            cancelCallback()
          end
        end)
      elseif cardInfo then
        if isDrop then
          successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exIdx, cardInfo))
        else
          WU.ShowMessageYesNo(WU.GetString("WindowGroup_ActorForceExchange"), function(msg)
            if msg == "YES" then
              successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exIdx, cardInfo))
            else
              cancelCallback()
            end
          end)
        end
      else
        successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exIdx))
      end
    elseif isDrop then
      exIdx = GetIndexById(cardSInfo.id)
      if not KindOfIndexValidate(index, exIdx) then
        return
      end
      if DropLegalCheck(index, cardSInfo) and DropLegalCheck(exIdx, cardInfo) then
        successCallback(ActorGroupSlotChangedImpl(index, cardSInfo, exIdx, cardInfo))
      else
        WU.ShowHintText(WU.GetString("Group_DropOperationNotAllowed"))
      end
    else
      successCallback(ActorGroupSlotChangedImpl(index, cardSInfo))
    end
  end
end

function KindOfIndexValidate(index, targetIndex)
  if GU.IsMainIndex(index) ~= GU.IsMainIndex(targetIndex) then
    WU.ShowHintText(WU.GetString("Group_DropOperationNotAllowed"))
    return false
  end
  return true
end

function DropLegalCheck(index, actor)
  local cpIndex = fif(GU.IsMainIndex(index), index + 3, index - 3)
  local ref = _ENV["$"](GetSlotByIndex(cpIndex))
  local isSameRole = ref and SameRoleCheck(ref["@actor"], actor)
  local isNpc = actor and actor.uid == nil
  return not isSameRole
end

function ActorGroupSlotChangedImpl(idx1, actor1, idx2, actor2)
  local memberArr = {}
  local actorPlaceHolder = {}
  if actor1 then
    actorPlaceHolder[actor1.id] = true
  end
  if actor2 then
    actorPlaceHolder[actor2.id] = true
  end
  local linkCompleteInfo
  for i = 0, 5 do
    local _, ref = table.find(m_widgetRefCache, function(_, v)
      return v["@index"] == i
    end)
    local patIndex = fif(i < 3, i + 3, i - 3)
    local _, patRef = table.find(m_widgetRefCache, function(_, v)
      return v["@index"] == patIndex
    end)
    local uid = 0
    local isGuildActor = false
    local isNpc = false
    local npcId = 0
    if i ~= idx1 and i ~= idx2 then
      if ref["@actor"] and actorPlaceHolder[ref["@actor"].id] == nil then
        uid = ref["@actor"].uid
        isGuildActor = ref["@actor"].isGuildActor
        isNpc = ref["@isNpc"]
        npcId = ref["@actor"].npcId
      end
    elseif i == idx1 and actor1 then
      uid = actor1.uid
      isGuildActor = actor1.isGuildActor
      isNpc = actor1.npcId and actor1.npcId ~= 0
      npcId = actor1.npcId or 0
      local linkInfo = LinkAchievedInfo(actor1, patRef["@actor"])
      linkCompleteInfo = linkInfo or linkCompleteInfo
    elseif i == idx2 and actor2 then
      uid = actor2.uid
      isNpc = actor2.npcId and actor2.npcId ~= 0
      npcId = actor2.npcId or 0
      isGuildActor = actor2.isGuildActor
      local linkInfo2 = LinkAchievedInfo(actor2, patRef["@actor"])
      linkCompleteInfo = linkInfo2 or linkCompleteInfo
    end
    local member = {
      isNpc = uid == nil,
      isGuildActor = isGuildActor or false,
      index = i,
      actorUid = uid or 0,
      actorGuildUid = 0,
      npcId = npcId or 0
    }
    if isGuildActor then
      member.actorUid = 0
      member.actorGuildUid = uid or 0
    end
    if isNpc then
      member.actorUid = 0
    end
    table.insert(memberArr, member)
  end
  if linkCompleteInfo then
    this:DelayInvokeInFrames(1, function()
      ShowLinkComplete(linkCompleteInfo)
    end)
  end
  this:BroadcastGameEvent("WidgetGroupMembersDrop", true)
  return {members = memberArr}
end

function LinkAchievedInfo(actor1, actor2)
  if actor1 == nil or actor2 == nil then
    return
  end
  if actor1.kind ~= actor2.kind then
    local actorMain = fif(actor1.kind == 1, actor1, actor2)
    local actorSub = fif(actor1.kind == 1, actor2, actor1)
    if AU.IsLinked(actorMain, actorSub) then
      local linkTable = {}
      local link
      local linkInfo = PB.all("ActorLink")
      for i = 1, #linkInfo do
        if U.IsTimeOpen(linkInfo[i].openTime) then
          for l = 1, #linkInfo[i].link do
            if linkInfo[i].link[l].actorID == actorMain.id then
              table.insert(linkTable, linkInfo[i])
            end
          end
        end
      end
      for i = 1, #linkTable do
        for l = 1, #linkTable[i].link do
          if linkTable[i].link[l].actorID == actorSub.id then
            link = linkTable[i]
            break
          end
        end
      end
      return link
    end
  end
end

function ShowLinkComplete(link)
  if link then
    local showActorLink = this:GetData("ShowActorLink")
    local curTutorial = this:GetData("CurrentTutorial")
    local inTutorialFight
    if curTutorial and (curTutorial == 23 or curTutorial == 33) then
      inTutorialFight = true
    end
    if inTutorialFight and this:GetData("TutorialLinkShown") then
    elseif showActorLink ~= false then
      local hasShown = WU.GetGameDataCache(link.linkID .. this:GetData("playerId"))
      if not (hasShown or inTutorialFight) or inTutorialFight and curTutorial == 23 and link.linkID == 10024 then
        WU.SetGameDataCache(link.linkID .. this:GetData("playerId"), true)
        this:SetData("ShowActorLink", false)
        if inTutorialFight then
          this:SetData("TutorialLinkShown", true)
        end
        WU.AcquireWindowAsync("ActorLinkComplete", function(win)
          _ENV["$"](win)["$$SetData"](link)
        end)
      end
    end
  end
end

function SameRoleCheck(actor1, actor2)
  if actor1 and actor2 then
    local actorConfig1 = PB.get("ActorConfig", actor1.id)
    local actorConfig2 = PB.get("ActorConfig", actor2.id)
    return actorConfig1.role == actorConfig2.role
  end
end

function GetExchangeIndex(actor)
  if actor then
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig == nil then
      error("Actor", "ActorConfig.xlsx error , Can't find by id " .. actor.id)
      return
    end
    if actorConfig.isLimited == 0 then
      for i = 1, #m_widgetRefCache do
        local ref = m_widgetRefCache[i]
        if ref["@roleId"] and ref["@roleId"] == actorConfig.role then
          local targetActor = ref["@actor"]
          local actorConfig1 = PB.get("ActorConfig", targetActor.id)
          if actorConfig1.isLimited == actorConfig.isLimited then
            return ref["@index"], ref
          end
        end
      end
    end
  end
end

function GetCPIndex(actor, index)
  if actor then
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig == nil then
      error("Actor", "ActorConfig.xlsx error , Can't find by id " .. actor.id)
      return
    end
    local cpIndex = fif(GU.IsMainIndex(index), index + 3, index - 3)
    for i = 1, #m_widgetRefCache do
      local ref = m_widgetRefCache[i]
      if ref["@actor"] then
        local actorConfig1 = PB.get("ActorConfig", ref["@actor"].id)
        if ref["@index"] == cpIndex and actorConfig.role == actorConfig1.role then
          return ref["@index"], ref
        end
      end
    end
  end
end

function GetIndexByUid(uid)
  for i = 1, #m_widgetRefCache do
    if m_widgetRefCache[i]["@uid"] == uid then
      return m_widgetRefCache[i]["@index"]
    end
  end
end

function GetIndexById(id)
  for i = 1, #m_widgetRefCache do
    if m_widgetRefCache[i]["@actor"] and m_widgetRefCache[i]["@actor"].id == id then
      return m_widgetRefCache[i]["@index"]
    end
  end
end

function GetSlotByIndex(index)
  for i = 0, #REF.Grid - 1 do
    if index == i then
      local go = REF.Grid[i].DragDropNodeMain
      _ENV["$"](go)["@index"] = i
      return go
    elseif index == i + 3 then
      local go = REF.Grid[i].DragDropNodeSub
      _ENV["$"](go)["@index"] = i + 3
      return go
    end
  end
end

function GetLinksActorIdByIndex(index, allActors)
  local index = fif(GU.IsMainIndex(index), index + 3, index - 3)
  if table.empty(m_widgetRefCache) then
    return
  end
  local _, ref = table.find(m_widgetRefCache, function(_, v)
    return v["@index"] == index
  end)
  if ref == nil then
    return
  end
  local actor = ref["@actor"]
  if allActors == nil then
    allActors = this:GetData("fci/actor/")
  end
  if actor then
    local rtn = {}
    local activeLinks = AU.GetActorLinks(actor, allActors)
    for i = 1, #activeLinks do
      local row = activeLinks[i]
      rtn[row.link[1].actorID] = true
      rtn[row.link[2].actorID] = true
    end
    return rtn
  end
end

function GetBurstLinkActorIdByIndex(index, actorPool)
  local index = fif(GU.IsMainIndex(index), index + 3, index - 3)
  local _, ref = table.find(m_widgetRefCache, function(_, v)
    return v["@index"] == index
  end)
  local uid = ref["@uid"]
  if uid ~= nil and 0 < uid then
    local actor = ref["@actor"]
    if actor ~= nil then
      local rtn = {}
      if actorPool then
        local activeLinks = AU.GetActorLinks(actor, actorPool)
        if activeLinks then
          for i = 1, #activeLinks do
            local row = activeLinks[i]
            rtn[row.link[1].actorID] = true
            rtn[row.link[2].actorID] = true
          end
        end
      end
      return rtn
    end
  end
end

function SetIndex(index, ref)
  ref["$"][0]["@index"] = index
  ref["$"][1]["@index"] = index + 3
  ClearSlot(ref["$"][0], index)
  ClearSlot(ref["$"][1], index + 3)
  ref["$"][0]["@kind"] = fif(GU.IsMainIndex(index), PB.enum.ActorType.Main, PB.enum.ActorType.Sub)
  ref["$"][1]["@kind"] = fif(GU.IsMainIndex(index + 3), PB.enum.ActorType.Main, PB.enum.ActorType.Sub)
end

function PlayActorCardEffect(changedIndex)
  for i = 1, #changedIndex do
    if changedIndex[i] < 3 then
      local ref = REF.Grid[changedIndex[i]]
      _ENV["$"](ref.DragDropNodeMain).WidgetActorCard.UIPlayTween:Play(true)
      ref.WidgetActorCardEffectMain.EffectGenerator:Play()
    else
      local ref = REF.Grid[changedIndex[i] - 3]
      _ENV["$"](ref.DragDropNodeSub).WidgetActorCard.UIPlayTween:Play(true)
      ref.WidgetActorCardEffectSub.EffectGenerator:Play()
    end
  end
end

function DisplayAttrs(flag)
  for i = 0, 2 do
    local ref = _ENV["$"](REF.Grid[i].WidgetGroupMemberLink)
    ref["$$DisplayAttrs"](flag)
  end
end

function ShowCustom(customs)
  for i = 0, #REF.Grid - 1 do
    _ENV["$"](REF.Grid[i].DragDropNodeMain).WidgetActorCard["$ShowCustom"](customs)
    _ENV["$"](REF.Grid[i].DragDropNodeSub).WidgetActorCard["$ShowCustom"](customs)
  end
end

function SetDungeonGuildGroupMembers(members)
  for i = 1, 3 do
    local ref = _ENV["$"](REF.Grid[i - 1].WidgetGroupMemberLink)
    SetIndex(members[i].index, ref)
    ref["$$SetActorsDungeonGuild"](members[i], members[i + 3])
  end
end

function SetAsyncPvpNewGroupMembers(members, ratios)
  for i = 1, 3 do
    local ref = _ENV["$"](REF.Grid[i - 1].WidgetGroupMemberLink)
    SetIndex(members[i].index, ref)
    ref["$$SetActorsAsyncPvpNew"](members[i], members[i + 3], ratios)
  end
end
