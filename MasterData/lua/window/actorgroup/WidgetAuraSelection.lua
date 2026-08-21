local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local AuraCooldown = PB.all("Misc")[1].auraCooldown
local m_data, m_selection
local m_deltaTime = 0

function Awake()
  LU.Bind(REF.AuraWrapContent, {
    updateRow = UpdateSlot
  })
end

function Start()
  WU.TraverseChildren(REF.AuraWrapContent, function(go, i)
    WU.BindButtonEvent(go, function()
      WU.RecordButtonClick(5426)
      OnAuraClick(go)
    end)
  end)
end

function OnEnable()
  this:Bind("Assistant/Aura", OnSelectAssistant)
  this:Bind("fci/dungeon-assistants/", SetWrapContent)
end

function OnDisable()
  this:Unbind("Assistant/Aura", OnSelectAssistant)
  this:Unbind("fci/dungeon-assistants/", SetWrapContent)
end

function OnSelectAssistant(value)
  WU.ToggleRendering(REF.DescribeNode, value ~= nil)
  if value == nil then
    m_selection = value
    SetHighlight()
    return
  else
    m_selection = value.playerId
    SetHighlight(m_selection)
  end
  REF.ActorName.UILabel.text = WU.GetString("ActorName_" .. value.actorId)
  local actorQualityInfo = PB.get("ActorQualityInfo", value.actorId, value.quality)
  REF.ActorAuraAttr.UIHtmlLabel.text = AU.RenderAuraOrMedalAttr(actorQualityInfo, true)
end

function OnAuraClick(go)
  local ref = _ENV["$"](go)
  if not ref["@cooldown"] then
    return
  end
  if ref["@playerId"] == nil or m_selection == ref["@playerId"] then
    this:SetData("Assistant/Aura", nil)
    return
  end
  local auraInfo = {
    playerId = ref["@playerId"],
    actorId = ref["@actorId"],
    quality = ref["@quality"],
    stranger = ref["@stranger"],
    name = ref["@name"]
  }
  this:SetData("Assistant/Aura", auraInfo)
end

function Update(delta)
  if math.floor(m_deltaTime + delta) ~= math.floor(m_deltaTime) then
    WU.TraverseChildren(REF.AuraWrapContent, function(go, i)
      local ref = _ENV["$"](go)
      local countDown = ref["@countDown"]
      if countDown ~= nil then
        countDown = countDown + 1
        ref.CountDown.gameObject:SetActive(countDown < AuraCooldown)
        ref["@cooldown"] = countDown >= AuraCooldown
        if countDown < AuraCooldown then
          ref.Content.UIWidget.alpha = 0.4
          ref.CountDownTime.UIHtmlLabel.text = WU.RenderCountDownTime(math.floor(AuraCooldown - countDown), 32, false, true)
          ref["@countDown"] = countDown
        else
          ref.Content.UIWidget.alpha = 1
          ref["@countDown"] = nil
        end
      end
    end)
  end
  m_deltaTime = m_deltaTime + delta
end

function SetWrapContent(data)
  if data == nil then
    return
  end
  m_data = _ENV["!"]({})
  m_data:append(table.select(data, function(predict)
    if predict.stranger == true then
      return predict
    end
  end):toarray())
  local cooldownFriends = table.select(data, function(predict)
    if predict.stranger == false and IsCooldown(predict.lastUseTime) then
      predict.actorNameEn = WU.GetString("ActorNameEn_" .. predict.auraActorId)
      return predict
    end
  end):toarray()
  local sort = PB.get("Sort", 14)
  SU.SortOnce(cooldownFriends, sort, true)
  m_data:append(cooldownFriends)
  local others = table.select(data, function(predict)
    if predict.stranger == false and not IsCooldown(predict.lastUseTime) then
      return predict
    end
  end):toarray()
  m_data:append(others)
  REF.LoadingHint.gameObject:SetActive(false)
  REF.AuraDragScrollView.gameObject:SetActive(true)
  ClearParams()
  LU.Set(REF.AuraWrapContent, #m_data)
end

function ClearParams()
  for i = 0, #REF.AuraWrapContent - 1 do
    local ref = REF.AuraWrapContent[i]
    ref["@playerId"] = nil
    ref["@actorId"] = nil
    ref["@stranger"] = nil
    ref["@name"] = nil
    ref["@quality"] = nil
    ref["@countDown"] = nil
    ref["@cooldown"] = nil
  end
end

function UpdateSlot(rowRef, wrapIndex, realIndex)
  if m_data and realIndex ~= nil and realIndex < #m_data then
    rowRef["$$SetPlayerAura"](m_data[realIndex + 1], m_selection)
  end
end

function IsCooldown(lastUseTime)
  local countDown = CS.GameTime.serverUtc - lastUseTime
  return countDown > AuraCooldown
end

function SetLoadingHint()
  this:DelayInvokeInSeconds(0.5, function()
    if m_data == nil then
      REF.LoadingHint.gameObject:SetActive(true)
    end
  end)
end

function SetHighlight(playerId)
  for i = 0, #REF.AuraWrapContent - 1 do
    local ref = REF.AuraWrapContent[i]
    ref.PlayerAuraSelection.gameObject:SetActive(false)
    if playerId == ref["@playerId"] then
      ref.PlayerAuraSelection.gameObject:SetActive(true)
    end
  end
end
