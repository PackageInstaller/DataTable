local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local GU = require("Common/GroupUtil")
local m_displayAttr = false
local m_allowDragDrop = false
local m_buffActivityId

function AllowDragDrop(flag)
  m_allowDragDrop = flag
end

function SetActors91(main, sub)
  REF.OtherLinkInfo.gameObject:SetActive(false)
  if not SetActor91(main, REF["$"][0]) then
    main.actorUid = 0
  end
  if not SetActor91(sub, REF["$"][1]) then
    sub.actorUid = 0
  end
  OtherInfo(REF["$"][0]["@actor"], REF["$"][1]["@actor"])
end

function SetActorsDungeonTeam(main, sub, notMyActors)
  REF.OtherLinkInfo.gameObject:SetActive(false)
  SetActorStatic({actor = main}, REF["$"][0], notMyActors)
  SetActorStatic({actor = sub}, REF["$"][1], notMyActors)
  OtherInfo(REF["$"][0]["@actor"], REF["$"][1]["@actor"])
end

function SetActors(main, sub, ratioMain, ratioSub)
  REF.OtherLinkInfo.gameObject:SetActive(false)
  if not SetActor(main.actorUid, REF["$"][0]) then
    main.actorUid = 0
  end
  if not SetActor(sub.actorUid, REF["$"][1]) then
    sub.actorUid = 0
  end
  OtherInfo(REF["$"][0]["@actor"], REF["$"][1]["@actor"], nil, nil, ratioMain, ratioSub)
end

function SetActorsBuffActivity(main, sub, ratioMain, ratioSub, activityType, activityId, index)
  REF.OtherLinkInfo.gameObject:SetActive(false)
  if not SetActor(main.actorUid, REF["$"][0]) then
    main.actorUid = 0
  end
  if not SetActor(sub.actorUid, REF["$"][1]) then
    sub.actorUid = 0
  end
  m_buffActivityId = activityId
  local buffActorsInfo = PB.get("ActivityBuffActors", activityType, activityId)
  local buffActors = buffActorsInfo.buffActor
  local playerId = DB:GetData("playerId")
  local hasBuffActor = (not REF["$"][0]["@actor"] or not table.has(buffActors, REF["$"][0]["@actor"].id)) and REF["$"][1]["@actor"] and table.has(buffActors, REF["$"][1]["@actor"].id)
  local showBuffHint = not hasBuffActor and not WU.GetGameDataCache("ActivityBuffHint" .. activityId .. playerId)
  OtherInfo(REF["$"][0]["@actor"], REF["$"][1]["@actor"], nil, nil, ratioMain, ratioSub, nil, showBuffHint, hasBuffActor, index)
end

function SetActorsTower(main, sub, isLocked)
  REF.OtherLinkInfo.gameObject:SetActive(isLocked)
  if isLocked then
    SetActorTower(main.actor, REF["$"][0], true)
    SetActorTower(sub.actor, REF["$"][1], true)
  else
    if not SetActorTower(main.actorUid, REF["$"][0], false) then
      main.actorUid = 0
    end
    if not SetActorTower(sub.actorUid, REF["$"][1], false) then
      sub.actorUid = 0
    end
  end
  OtherInfo(REF["$"][0]["@actor"], REF["$"][1]["@actor"])
end

function SetActorsTowerNew(main, sub)
  if not SetActorTowerNew(main.actorUid, REF["$"][0]) then
    main.actorUid = 0
  end
  if not SetActorTowerNew(sub.actorUid, REF["$"][1]) then
    sub.actorUid = 0
  end
  SetActorTowerNew(main.actor, REF["$"][0])
  SetActorTowerNew(sub.actor, REF["$"][1])
  OtherInfo(REF["$"][0]["@actor"], REF["$"][1]["@actor"], nil, nil, nil, nil, true)
end

function SetActorsRandomCall(main, sub)
  if not SetActorRandomCall(main.actorUid, REF["$"][0]) then
    main.actorUid = 0
  end
  if not SetActorRandomCall(sub.actorUid, REF["$"][1]) then
    sub.actorUid = 0
  end
  HideOther()
end

function SetActorsMaze(main, sub)
  REF.OtherLinkInfo.gameObject:SetActive(false)
  if not SetActorMaze(main.actorUid, REF["$"][0], false) then
    main.actorUid = 0
  end
  if not SetActorMaze(sub.actorUid, REF["$"][1], false) then
    sub.actorUid = 0
  end
  if REF["$"][0]["@actor"] then
    REF["$"][0]["@actor"].exMainData = main
    REF["$"][0]["@actor"].exSubData = sub
  end
  OtherInfo(REF["$"][0]["@actor"], REF["$"][1]["@actor"], REF["$"][0]["@exAttrList"], REF["$"][1]["@exAttrList"])
end

function GetMazeBuff(uid)
  local buffList = {}
  local mazeBuff = this:GetData("MazeBuff")
  if mazeBuff then
    for k, v in pairs(mazeBuff) do
      local buffInfo = PB.get("MazeBuff", v.buffId)
      if buffInfo and buffInfo.param and buffInfo.param.type ~= PB.enum.AttrType.Hp and buffInfo.type == PB.enum.MazeBuffType.MazeBuff_AttrChange then
        if v.isAll then
          local buff = {
            type = buffInfo.param.type,
            value = buffInfo.param.value,
            isRatio = buffInfo.param.isRatio
          }
          buffList[#buffList + 1] = buff
        elseif v.actorUid then
          for i, v in ipairs(v.actorUid) do
            if v == uid then
              local buff = {
                type = buffInfo.param.type,
                value = buffInfo.param.value,
                isRatio = buffInfo.param.isRatio
              }
              buffList[#buffList + 1] = buff
            end
          end
        end
      end
    end
  end
  return buffList
end

function SetActorMaze(uidOrActor, ref, isLocked)
  local uid = uidOrActor
  if type(uidOrActor) == "table" then
    uid = uidOrActor.uid
  end
  if uid and 0 < uid then
    local actorWrap = this:GetData("fci/mazeactor/" .. uid)
    local actor
    if actorWrap then
      actor = actorWrap.actor
    end
    if type(uidOrActor) == "table" then
      actor = uidOrActor
    end
    if actor then
      ref["@uid"] = actor.uid
      ref["@actor"] = actor
      ref["@exAttrList"] = GetMazeBuff(actor.uid)
      ref["$UIDragDropItem"].enabled = m_allowDragDrop
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig then
        ref["@roleId"] = actorConfig.role
      end
      local widgetCard = ref.WidgetActorCard
      if isLocked then
        widgetCard["$SetActorOnce"](actor)
      else
        widgetCard["$SetMazeActor"](actor)
      end
      widgetCard["$SetEquipUnClickAble"](true)
      return true
    end
  end
  return false
end

function SetActorsStatic(main, sub, notMyActors)
  REF.OtherLinkInfo.gameObject:SetActive(false)
  SetActorStatic(main, REF["$"][0], notMyActors)
  SetActorStatic(sub, REF["$"][1], notMyActors)
  OtherInfo(REF["$"][0]["@actor"], REF["$"][1]["@actor"])
end

function SetActorTower(uidOrActor, ref, isLocked)
  local uid = uidOrActor
  if type(uidOrActor) == "table" then
    uid = uidOrActor.uid
  end
  if uid and 0 < uid then
    local actor = this:GetData("fci/actor/" .. uid)
    if type(uidOrActor) == "table" then
      actor = uidOrActor
    end
    if actor then
      ref["@uid"] = actor.uid
      ref["@actor"] = actor
      ref["$UIDragDropItem"].enabled = m_allowDragDrop
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig then
        ref["@roleId"] = actorConfig.role
      end
      if isLocked then
        ref.WidgetActorCard["$SetActorOnce"](actor)
      else
        ref.WidgetActorCard["$BindActor"](actor)
      end
      return true
    end
  end
  return false
end

function SetActorTowerNew(uidOrActor, ref)
  local uid = uidOrActor
  if type(uidOrActor) == "table" then
    uid = uidOrActor.uid
  end
  if uid and 0 < uid then
    local data = this:GetData("fci/extreme-challenge/select-actors/")
    local _, actorSum = table.find(data.actors, function(k, v)
      return v.actor.uid == uid
    end)
    local actor = actorSum.actor
    if type(uidOrActor) == "table" then
      actor = uidOrActor
    end
    if actor then
      ref["@uid"] = actor.uid
      ref["@actor"] = actor
      ref["$UIDragDropItem"].enabled = m_allowDragDrop
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig then
        ref["@roleId"] = actorConfig.role
      end
      ref.WidgetActorCard["$SetActorOnce"](actor)
      ref.WidgetActorCard["$SetEquipUnClickAble"](true)
      return true
    end
  end
  return false
end

function SetActorStatic(member, ref, notMyActors)
  if member ~= nil then
    local actor = member.actor
    if actor ~= nil and actor.id > 0 then
      ref["$UIDragDropItem"].enabled = m_allowDragDrop
      ref["@uid"] = actor.uid
      ref["@actor"] = actor
      ref["@equips"] = member.equips
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig then
        ref["@roleId"] = actorConfig.role
      end
      ref.WidgetActorCard["$SetActorOnce"](actor, notMyActors)
    end
  end
end

function SetBurstLinkActors(main, sub)
  REF.OtherLinkInfo.gameObject:SetActive(false)
  SetBurstLinkActor(main, REF["$"][0])
  SetBurstLinkActor(sub, REF["$"][1])
  OtherInfo(REF["$"][0]["@actor"], REF["$"][1]["@actor"])
end

function SetBurstLinkActor(actor, ref)
  if actor ~= nil then
    ref["$UIDragDropItem"].enabled = m_allowDragDrop
    actor.quality = 0
    ref["@uid"] = actor.uid
    ref["@actor"] = actor
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig then
      ref["@roleId"] = actorConfig.role
    end
    ref.WidgetActorCard["$SetActorOnce"](actor)
  end
end

function SetActorRandomCall(actorUid, ref)
  if actorUid and 0 < actorUid then
    REF.OtherLinkInfo.gameObject:SetActive(false)
    local actors = this:GetData("RandomCall/Actors")
    local _, actor = table.find(actors, function(k, v)
      return v.uid == actorUid
    end)
    if actor ~= nil then
      ref["$UIDragDropItem"].enabled = m_allowDragDrop
      actor.quality = actor.quality
      ref["@uid"] = actor.uid
      ref["@actor"] = actor
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig then
        ref["@roleId"] = actorConfig.role
      end
      ref.WidgetActorCard["$SetActorOnce"](actor, true)
    end
    return true
  end
  return false
end

function SetActor(uid, ref)
  if uid and 0 < uid then
    local actor = this:GetData("fci/actor/" .. uid)
    if actor then
      ref["$UIDragDropItem"].enabled = m_allowDragDrop
      ref["@uid"] = uid
      ref["@actor"] = actor
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig then
        ref["@roleId"] = actorConfig.role
      end
      ref.WidgetActorCard["$BindActor"](actor)
      return true
    end
  end
  return false
end

function SetActor91(info, ref)
  if info then
    local isNpcObj = ref.AlphaControl.transform:Find("IsNpc")
    WU.SetActive(isNpcObj, info.isNpc)
    ref["@isNpc"] = info.isNpc
    if info.isNpc then
      if isNpcObj == nil then
        isNpcObj = CS.UnityEngine.GameObject.Instantiate(ref.SpriteActorType1.gameObject, ref.AlphaControl.transform)
        isNpcObj.transform.name = "IsNpc"
        isNpcObj.transform.localPosition = CS.UnityEngine.Vector3(36, 288, 0)
        local sprite = isNpcObj.transform:GetComponent(typeof(CS.UISprite))
        sprite.atlasPath = "CommonWindow"
        sprite.spriteName = "actor_tips"
        sprite:SnapWithoutScale()
        isNpcObj.gameObject:SetActive(true)
        local labelObj = CS.UnityEngine.GameObject.Instantiate(ref.LevelLabel.gameObject, isNpcObj.transform)
        local label = labelObj.transform:GetComponent(typeof(CS.UILabel))
        label.text = WU.GetString("Window_ChapterNpc")
        label.effectStyle = CS.UILabel.Effect.None
        label.color = CS.NGUIMath.HexToColor(2945268223)
        label.depth = sprite.depth + 1
        labelObj.transform.localPosition = CS.UnityEngine.Vector3(20, 12, 0)
      end
      local actor = PB.get("DungeonNPC", info.npcId)
      if actor == nil then
        warning("DungeonNPC", "Can't find npc id -> " .. tostring(info.npcId))
        return false
      end
      AU.RenameDungeonNPCFields(actor)
      ref["$UIDragDropItem"].enabled = m_allowDragDrop
      ref["@actor"] = actor
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig then
        ref["@roleId"] = actorConfig.role
      end
      ref.WidgetActorCard["$SetActorOnce"](actor, true)
      return true
    else
      local actor = this:GetData("fci/actor/" .. info.actorUid)
      if actor then
        ref["$UIDragDropItem"].enabled = m_allowDragDrop
        ref["@uid"] = info.actorUid
        ref["@actor"] = actor
        local actorConfig = PB.get("ActorConfig", actor.id)
        if actorConfig then
          ref["@roleId"] = actorConfig.role
        end
        ref.WidgetActorCard["$BindActor"](actor)
        return true
      end
    end
  end
  return false
end

function SetDead(flag)
  REF.SpriteDeadMain.gameObject:SetActive(flag)
  REF.root[0].AlphaControl.UIWidget.alpha = fif(flag, 0.6, 1)
  REF.root[1].AlphaControl.UIWidget.alpha = fif(flag, 0.6, 1)
end

function SetHp(fillAmount, bShow)
  REF.OtherLinkInfo.gameObject:SetActive(true)
  REF.HpNode.gameObject:SetActive(fillAmount ~= nil and 0 < fillAmount or bShow == true)
  if fillAmount ~= nil and 0 < fillAmount or bShow == true then
    REF.SpriteRemainHp.UISprite.fillAmount = fillAmount
    REF.SpriteRemainHp.TweenScale.enabled = true
  end
end

function SetHpDetail(fillAmountMain, fillAmountSub, bShow)
  REF.OtherLinkInfo.gameObject:SetActive(true)
  if fillAmountMain == nil and fillAmountSub == nil then
    REF.HpDetailNode.gameObject:SetActive(false)
    return
  else
    REF.HpDetailNode.gameObject:SetActive(true)
  end
  local name = {"Main", "Sub"}
  local fill = {fillAmountMain, fillAmountSub}
  for i = 1, 2 do
    REF["SpriteHpBg" .. name[i]].gameObject:SetActive(fill[i])
    REF["SpriteHp" .. name[i]].gameObject:SetActive(fill[i])
    REF["SpriteHp" .. name[i]].UISprite.fillAmount = fill[i] or 0
    REF["SpriteHp" .. name[i]].TweenScale.enabled = true
  end
end

function SetDeadDetail(hpGroup)
  REF.OtherLinkInfo.gameObject:SetActive(true)
  if hpGroup == nil then
    REF.SpriteDeadMain.gameObject:SetActive(false)
    REF.SpriteDeadSub.gameObject:SetActive(false)
    return
  end
  for i = 1, 2 do
    local name = {"Main", "Sub"}
    REF.root[i - 1].AlphaControl.UIWidget.alpha = fif(hpGroup[i] < 0, 0.6, 1)
    REF["SpriteDead" .. name[i]].gameObject:SetActive(hpGroup[i] < 0)
  end
end

function SetPill(pillGroup, addAttrs)
  local total = 0
  local redVal = PB.index("Misc", 1).extremeChallengeDrugLimit
  
  local function setRed(ref)
    local str = ref.UIHtmlLabel.text
    ref.UIHtmlLabel.text = "<font color=#ec3b3e>" .. str .. "</font>"
  end
  
  if pillGroup == nil and addAttrs == nil then
    REF.NodePill.gameObject:SetActive(false)
    return
  end
  REF.NodePill.gameObject:SetActive(true)
  for i = 1, 2 do
    local name = {"Main", "Sub"}
    REF["LabelPill" .. name[i]].gameObject:SetActive(pillGroup[i] ~= nil)
    if pillGroup[i] then
      total = total + pillGroup[i]
      REF["LabelPill" .. name[i]].UIHtmlLabel.text = pillGroup[i]
    end
  end
  if redVal <= total then
    REF.LabelPillTotal.UIHtmlLabel.text = "<img src='Tournament.challenge_limit_icon_red'/>" .. total
    setRed(REF.LabelPillTotal)
    setRed(REF.LabelPillMain)
    setRed(REF.LabelPillSub)
  else
    REF.LabelPillTotal.UIHtmlLabel.text = "<img src='Tournament.challenge_limit_icon'/>" .. total
  end
end

function GetExValue(attr, buffMap)
  local exValue = 0
  local exValueRatio = 0
  if buffMap then
    for k, v in pairs(buffMap) do
      if v.type == attr.type then
        if v.isRatio then
          exValueRatio = v.value + exValueRatio
        else
          exValue = v.value + exValue
        end
      end
    end
  end
  exValue = math.floor(exValueRatio * attr.value / 10000) + exValue
  return exValue
end

function OtherInfo(main, sub, buffMainMap, buffSubMap, ratioMain, ratioSub, inTower, showActivityBuffHint, hasBuffActors, index)
  WU.SetActive(_ENV["$"](REF.ActivityBuffHint).Visual, index ~= 3)
  WU.SetActive(_ENV["$"](REF.ActivityBuffHint).Visual2, index == 3)
  WU.SetActive(REF.ActivityBuffHint, showActivityBuffHint)
  WU.SetActive(REF.ActivityBuffUp, hasBuffActors)
  if showActivityBuffHint then
    local playerId = DB:GetData("playerId")
    WU.SetGameDataCache("ActivityBuffHint" .. m_buffActivityId .. playerId, true)
  end
  ratioMain = ratioMain or 1
  ratioSub = ratioSub or 1
  local flag = main ~= nil and sub ~= nil and AU.IsLinked(main, sub)
  REF.LinkNode.gameObject:SetActive(not flag)
  REF.LinkEffectNode.gameObject:SetActive(flag)
  if flag then
    local linkTable = {}
    local link
    local linkInfo = PB.all("ActorLink")
    for i = 1, #linkInfo do
      if U.IsTimeOpen(linkInfo[i].openTime) then
        for l = 1, #linkInfo[i].link do
          if linkInfo[i].link[l].actorID == main.id then
            table.insert(linkTable, linkInfo[i])
          end
        end
      end
    end
    for i = 1, #linkTable do
      for l = 1, #linkTable[i].link do
        if linkTable[i].link[l].actorID == sub.id then
          link = linkTable[i]
          break
        end
      end
    end
    local curTutorial = this:GetData("CurrentTutorial")
    local inTutorialFight
    if curTutorial and (curTutorial == 23 or curTutorial == 33) then
      inTutorialFight = true
    end
    if inTutorialFight and this:GetData("TutorialLinkShown") then
    else
      do
        local selectedIndex = this:GetData("ActorSelect/FocusIndex") or 0
        local showActorLink = this:GetData("ShowActorLink") ~= false and this:GetData("ActorSelectWindow") and not this:GetData("ActorSelect/OnConfirm")
        if link and showActorLink and (_ENV["$"](REF.DragDropNodeMain)["@index"] == selectedIndex or _ENV["$"](REF.DragDropNodeMain)["@index"] == selectedIndex - 3) then
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
  end
  REF.AttrsLabel.UIHtmlLabel.text = ""
  REF.AttrsDisplay.gameObject:SetActive(m_displayAttr)
  if main == nil and sub == nil then
    REF.AttrsDisplay.gameObject:SetActive(false)
    return
  end
  local exMainData, exSubData
  local attrTable = _ENV["!"]({})
  if main ~= nil then
    exMainData = main.exMainData
    exSubData = main.exSubData
    for _, attr in pairs(main.attrs) do
      local exValue = GetExValue(attr, buffMainMap)
      local value = math.floor((attr.value + exValue) * fif(attr.type == PB.enum.AttrType.Speed, 1, ratioMain))
      if inTower and attr.type == PB.enum.AttrType.Hp and main.hp then
        value = fif(main.hp ~= 0, fif(main.hp == -1, 0, main.hp), value)
      end
      if exMainData and exMainData.hp and attr.type == PB.enum.AttrType.Hp then
        value = exMainData.hp
      end
      attrTable[attr.type] = {
        rightAttr = value,
        isRatio = attr.isRatio,
        totalAttr = value,
        rightExValue = exValue
      }
    end
  end
  if sub ~= nil then
    for _, attr in pairs(sub.attrs) do
      local exValue = GetExValue(attr, buffSubMap)
      local value = math.floor((attr.value + exValue) * fif(attr.type == PB.enum.AttrType.Speed, 1, ratioSub))
      if inTower and attr.type == PB.enum.AttrType.Hp and sub.hp then
        value = fif(sub.hp ~= 0, fif(sub.hp == -1, 0, sub.hp), value)
      end
      if exSubData and exSubData.hp and attr.type == PB.enum.AttrType.Hp then
        value = exSubData.hp
      end
      if attrTable[attr.type] then
        attrTable[attr.type].leftAttr = value
        attrTable[attr.type].totalAttr = attrTable[attr.type].totalAttr + value
        attrTable[attr.type].leftExValue = exValue
      else
        attrTable[attr.type] = {
          leftAttr = value,
          isRatio = attr.isRatio,
          totalAttr = value,
          leftExValue = exValue
        }
      end
    end
  end
  local enums = {
    PB.enum.AttrType.Speed,
    PB.enum.AttrType.Hp,
    PB.enum.AttrType.Attack,
    PB.enum.AttrType.PhysicalDefense,
    PB.enum.AttrType.MagicalDefense,
    PB.enum.AttrType.CriticalHitRate,
    PB.enum.AttrType.CriticalHitDamageRate
  }
  local attrStr = ""
  if not table.empty(attrTable) then
    for _, v in pairs(enums) do
      if attrTable[v] then
        local left = attrTable[v].leftAttr or 0
        local total = attrTable[v].totalAttr
        local right = attrTable[v].rightAttr or 0
        if attrTable[v].isRatio then
          left = math.floor(left / 100)
          total = math.floor(total / 100) .. "%"
          right = math.floor(right / 100)
        end
        attrStr = attrStr .. Attr2Html(left, WU.GetString("ActorSelect_ActorAttrName_" .. v), total, right, attrTable[v].leftExValue, attrTable[v].rightExValue) .. "<br>"
      else
        warning("WidgetGroupMemberLink", "no attr info : " .. v)
      end
    end
  end
  REF.AttrsLabel.UIHtmlLabel.text = attrStr
end

function Attr2Html(leftAttr, name, totalAttr, rightAttr, leftExValue, rightExValue)
  if leftExValue == nil then
    leftExValue = 0
  end
  if rightExValue == nil then
    rightExValue = 0
  end
  local strLeft = leftAttr
  if 0 < leftExValue then
    strLeft = "<font color=#0000FF>" .. leftAttr .. "</font>"
  elseif leftExValue < 0 then
    strLeft = "<font color=#FF0000>" .. leftAttr .. "</font>"
  end
  local strRight = rightAttr
  if 0 < rightExValue then
    strRight = "<font color=#0000FF>" .. rightAttr .. "</font>"
  elseif rightExValue < 0 then
    strRight = "<font color=#FF0000>" .. rightAttr .. "</font>"
  end
  local strTotal = totalAttr
  local totalEx = rightExValue + leftExValue
  if 0 < totalEx then
    strTotal = "<font color=#0000FF>" .. strTotal .. "</font>"
  elseif totalEx < 0 then
    strTotal = "<font color=#FF0000>" .. strTotal .. "</font>"
  end
  return "<l width=100%><c width=20% align=right><font size=28>" .. strLeft .. "</font></c><c width=28% align=right><i><font size=22 color=#e3f3f6ff>" .. name .. "</font></i></c><c width=32% align=left>&nbsp;" .. strTotal .. "&nbsp;&nbsp;</c><c width=20% align=left><font size=28>" .. strRight .. "</font></c></l>"
end

function DisplayAttrs(flag)
  m_displayAttr = flag
  local main = REF["$"][0]["@actor"]
  local sub = REF["$"][1]["@actor"]
  REF.AttrsDisplay.gameObject:SetActive(m_displayAttr and (main ~= nil or sub ~= nil))
  if m_displayAttr then
    REF.AttrsDisplay.UIPlayTween:Play(true)
  end
end

function SetSCardScale(v3)
  _ENV["$"](REF.DragDropNodeMain).WidgetActorCard["$SetSCard2Scacle"](v3)
  _ENV["$"](REF.DragDropNodeSub).WidgetActorCard["$SetSCard2Scacle"](v3)
end

function SetActorsDungeonGuild(main, sub)
  REF.OtherLinkInfo.gameObject:SetActive(false)
  SetActorDungeonGuild(main, REF["$"][0])
  SetActorDungeonGuild(sub, REF["$"][1])
  OtherInfo(REF["$"][0]["@actor"], REF["$"][1]["@actor"])
end

function SetActorDungeonGuild(member, ref)
  local actor, uid = GU.ChangeToActorInfo(member, true)
  local markObj = ref.AlphaControl.transform:Find("SpriteGuildActor")
  WU.SetActive(markObj, member.isGuildActor)
  if actor then
    actor.uid = uid
    ref["$UIDragDropItem"].enabled = m_allowDragDrop
    ref["@uid"] = uid
    ref["@isGuildActor"] = member.isGuildActor
    ref["@actor"] = actor
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig then
      ref["@roleId"] = actorConfig.role
    end
    if member.isGuildActor then
      ref.WidgetActorCard["$SetActorOnce"](actor, true, true)
    else
      ref.WidgetActorCard["$BindActor"](actor)
    end
    if member.isGuildActor and markObj == nil then
      markObj = CS.UnityEngine.GameObject.Instantiate(ref.SpriteActorType1.gameObject, ref.AlphaControl.transform)
      markObj.transform.name = "SpriteGuildActor"
      markObj.transform.localPosition = CS.UnityEngine.Vector3(36, 288, 0)
      local sprite = _ENV["$"](markObj)["$UISprite"]
      sprite.atlasPath = "CommonWindow"
      sprite.spriteName = "actor_tips"
      sprite:SnapWithoutScale()
      markObj.gameObject:SetActive(true)
      local labelObj = CS.UnityEngine.GameObject.Instantiate(ref.LevelLabel.gameObject, markObj.transform)
      labelObj.transform.name = "LabelGuildActor"
      labelObj.transform.localPosition = CS.UnityEngine.Vector3(20, 12, 0)
      local label = _ENV["$"](labelObj)["$UILabel"]
      label.text = WU.GetString("Window_GuildDungeonHelperCode")
      label.color = CS.NGUIMath.HexToColor(2305041919)
      label.fontSize = 32
      label.effectStyle = CS.UILabel.Effect.None
      label.depth = sprite.depth + 1
      labelObj.gameObject:SetActive(true)
    end
    return true
  end
  return false
end

function HideOther()
  REF.AttrsDisplay.gameObject:SetActive(false)
  REF.HintDisplay.gameObject:SetActive(false)
  REF.OtherLinkInfo.gameObject:SetActive(false)
end

function SetActorsAsyncPvpNew(main, sub)
  REF.OtherLinkInfo.gameObject:SetActive(false)
  SetActorAsyncPvpNew(main, REF["$"][0])
  SetActorAsyncPvpNew(sub, REF["$"][1])
  OtherInfo(REF["$"][0]["@actor"], REF["$"][1]["@actor"])
end

function SetActorAsyncPvpNew(info, ref)
  local markObj = ref.AlphaControl.transform:Find("SpriteScoreUp")
  WU.SetActive(markObj, false)
  local actor = this:GetData("fci/actor/" .. info.actorUid)
  if actor ~= nil then
    ref["$UIDragDropItem"].enabled = m_allowDragDrop
    ref["@uid"] = actor.uid
    ref["@actor"] = actor
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig then
      ref["@roleId"] = actorConfig.role
    end
    ref.WidgetActorCard["$SetActorOnce"](actor)
    local showUpFlag = AU.IsAsyncPvpNewUpActor(actor)
    if showUpFlag then
      if markObj == nil then
        markObj = CS.UnityEngine.GameObject.Instantiate(ref.SpriteActorType1.gameObject, ref.AlphaControl.transform)
        markObj.transform.name = "SpriteScoreUp"
        markObj.transform.localPosition = CS.UnityEngine.Vector3(36, 288, 0)
        local sprite = _ENV["$"](markObj)["$UISprite"]
        sprite.atlasPath = "WelfareCoffee"
        sprite.spriteName = "coffee_up"
        sprite:SnapWithoutScale()
      end
      WU.SetActive(markObj, true)
    end
    return true
  end
  return false
end
