local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local LU = require("Common/ListUtil")
local EA = require("Common/EquipAttr")
local DBH = require("Manager/DataBindingHandler")
local m_actor
local m_equipListMap = _ENV["!"]({})
local m_candidateEquips = _ENV["!"]({})
local m_recommendEquipIds = _ENV["!"]({})
local m_focusUid, m_displayInfo

function Awake()
  for i = 0, #REF.EquipSlotGrid - 1 do
    local slotRef = REF.EquipSlotGrid[i]
    slotRef["$$SetEquipPos"](i)
    slotRef["$$SetShowHighlight"](false)
    slotRef["$$SetClickCallback"](OnBodyEquipClick)
  end
end

function OnEnable()
  WU.ToggleRendering(REF["$"], false)
  this:DelayInvokeInFrames(1, function()
    WU.ToggleRendering(REF["$"], true)
    this:Bind("Space/DisplayInfo", OnDisplayInfo)
    REF["$Animator"]:Play("Open2", -1, 0)
  end)
end

function OnDisable()
  this:Unbind("Space/DisplayInfo", OnDisplayInfo)
end

function OnCurrentActorChange(actor)
  m_actor = actor
  if m_actor then
    local actorConfig = PB.get("ActorConfig", m_actor.id)
    REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. actorConfig.animRes
    REF.TextureActor.transform.localPosition = CS.UnityEngine.Vector3(actorConfig.portraitOffsetX, actorConfig.portraitOffsetY, 0)
    local hasEquip = 0 < table.count(m_actor.bodyEquips)
    REF.EquipEmpty.gameObject:SetActive(not hasEquip)
    this:DelayInvokeInFrames(1, function()
      UpdateScore()
    end)
    UpdateAttrs()
    REF.ScrollViewAttr.UIScrollView:ResetPosition()
  end
end

function OnEquipListChange(equipList)
  m_equipListMap = _ENV["!"]({})
  for _, pos in pairs(PB.enum.EquipPos) do
    m_equipListMap[pos] = _ENV["!"]({})
  end
  if equipList then
    for _, equip in pairs(equipList) do
      local equipInfo = PB.get("EquipInfo", equip.id)
      if equipInfo then
        table.insert(m_equipListMap[equipInfo.pos], equip)
      end
    end
    for _, equipListByPos in pairs(m_equipListMap) do
      table.sort(equipListByPos, function(a, b)
        local aInfo = PB.get("EquipInfo", a.id)
        local bInfo = PB.get("EquipInfo", b.id)
        local aQuality = aInfo.quality or 0
        local bQuality = bInfo.quality or 0
        if aQuality ~= bQuality then
          return aQuality > bQuality
        elseif a.level ~= b.level then
          return a.level > b.level
        else
          return a.uid > b.uid
        end
      end)
    end
    UpdateAttrs()
    REF.ScrollViewAttr.UIScrollView:ResetPosition()
  end
end

function OnBodyEquipClick(pos)
  local targetEquip = REF.EquipSlotGrid[pos]["@equip"]
  if targetEquip ~= nil and not table.empty(targetEquip) then
    WU.AcquireWindowAsync("ActorEquipDisplay", function(window)
      _ENV["$"](window)["$$SetEquipDisplay"](m_displayInfo.actorInfo, targetEquip, m_displayInfo.equips)
    end)
  end
end

function UpdateAttrs()
  local equips = _ENV["!"](m_displayInfo.equips):toarray()
  REF.WidgetEquipAttrMixedTable.gameObject:SetActive(0 < #equips)
  if 0 < #equips then
    local suitInfoList = _ENV["!"]({})
    for i = 1, #equips do
      local equip = equips[i]
      if equip then
        local suitInfo = EA.GetSuitInfo(equip.id, equips)
        if suitInfo and not suitInfoList:find(function(k, v)
          return v.id == suitInfo.id
        end) then
          table.insert(suitInfoList, suitInfo)
        end
      end
    end
    REF.WidgetEquipAttrMixedTable["$SetMixedAttrs"](suitInfoList, AU.NormalizeAttrs(m_actor.equipAttrs))
  end
end

function UpdateScore()
  local totalScore = 0
  for _, equip in pairs(m_displayInfo.equips) do
    totalScore = totalScore + math.floor(EA.GetEquipScore(equip))
  end
  if 0 < totalScore then
    REF.LabelScore.UIHtmlLabel.text = WU.GetString("WindowActorEquip_TitleScore", totalScore)
  else
    REF.LabelScore.UIHtmlLabel.text = ""
  end
end

function OnDisplayInfo(displayInfo)
  m_displayInfo = displayInfo
  OnCurrentActorChange(displayInfo.actorInfo)
  for i = 0, #REF.EquipSlotGrid - 1 do
    local slotRef = REF.EquipSlotGrid[i]
    local equip = displayInfo.equips[tostring(i)]
    slotRef["$$OnEquipChange"](equip)
    slotRef["@equip"] = equip
  end
  OnEquipListChange(displayInfo.equips)
end
