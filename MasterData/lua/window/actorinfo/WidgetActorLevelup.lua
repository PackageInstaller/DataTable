local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local DBH = require("Manager/DataBindingHandler")
local m_actor, m_expItems, m_holdItemSlot, m_holdItemInfo, m_holdItem
local m_reserveCount = 0
local m_speedOnCount = 1
local m_maxLevel = 0
local m_levelLimit = 0
local m_predictLevel = 0
local m_predictExp = 0
local m_overflowedExp = 0
local m_progressTotalLength = 0
local m_init = true
local m_pressStart
local m_BubbleOn = false
local m_pressHold
local m_attrAnimationDuration = 1
local m_attrAnimationElapsedTime = 1
local m_startAttrsPromotion, m_endAttrsPromotion
local m_materialClickedTime = 0

function Awake()
  InitMaterials()
end

function OnEnable()
  m_maxLevel = AU.GetActorMaxLevel()
  m_progressTotalLength = REF.NodeProgress.UIPanel.finalClipRegion.z
  this:Bind("fci/item", OnItemChange)
  this:Bind("fci/baseinfo", OnBaseInfoChange)
  this:Bind("ActorInfo/CurrentActor", OnCurrentActorChange)
  REF["$Animator"]:Play("Open", -1, 0)
  WU.TriggerUnforcedTutorial(1105)
end

function OnDisable()
  this:Unbind("fci/item", OnItemChange)
  this:Unbind("fci/baseinfo", OnBaseInfoChange)
  this:Unbind("ActorInfo/CurrentActor", OnCurrentActorChange)
end

function OnBaseInfoChange(baseInfo)
  if baseInfo then
    m_levelLimit = math.min(m_maxLevel, baseInfo.level)
  end
end

function OnCurrentActorChange(actor)
  m_actor = actor
  if m_actor then
    UpdateLevelupInfo()
    RenderAttrList(AU.GetActorLevelPromotion(m_actor.id, m_actor.quality, 1, m_actor.level))
  end
end

function OnItemChange(items)
  for i = 0, #REF.MaterialList - 1 do
    if i + 1 <= #m_expItems then
      local itemCount = this:GetData("fci/item/" .. m_expItems[i + 1].id).count
      REF.GrayList[i]["$gameObject"]:SetActive(itemCount <= 0)
    end
  end
  REF.MaterialList.UIGrid:Reposition()
end

function UpdateLevelupInfo(overflowLevelUp)
  if m_actor then
    local actorConfig = PB.get("ActorConfig", m_actor.id)
    REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. actorConfig.animRes
    REF.TextureActor.transform.localPosition = CS.UnityEngine.Vector3(actorConfig.portraitOffsetX, actorConfig.portraitOffsetY, 0)
    REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", m_actor.level)
    REF.LabelLevelB.UILabel.text = WU.GetString("Window_Level", m_actor.level)
    if not m_init then
      showCountEffect(false)
    end
    local isMaxLevel = m_actor.level >= m_maxLevel
    REF.NodeMaxDecoration.gameObject:SetActive(isMaxLevel)
    REF.NodeNormal.gameObject:SetActive(not isMaxLevel)
    REF.NodeProgress.gameObject:SetActive(true)
    if isMaxLevel then
      REF.NodeProgress.UIPanel.clipOffset = {
        x = 0,
        y = 0,
        z = 0
      }
      REF.NodeProgressBg.UIPanel.clipOffset = {
        x = m_progressTotalLength,
        y = 0,
        z = 0
      }
    else
      local actorLevelupNext = PB.get("ActorLevelup", m_actor.level + 1)
      REF.NodeProgress.UIPanel.clipOffset = {
        x = (m_actor.curExp / actorLevelupNext.exp - 1) * m_progressTotalLength,
        y = 0
      }
      REF.NodeProgressBg.UIPanel.clipOffset = {
        x = m_actor.curExp / actorLevelupNext.exp * m_progressTotalLength,
        y = 0
      }
      REF.LabelExp.UIHtmlLabel.text = m_actor.curExp .. "/" .. actorLevelupNext.exp
    end
    if overflowLevelUp then
      REF.LineGlow.EffectGenerator:Play()
    end
    m_init = false
  end
end

function InitMaterials()
  m_expItems = PB.all("ItemInfo"):where(function(_, i)
    return i.funcType == PB.enum.ItemFuncType.ActorExp
  end):toarray()
  for i = 0, #REF.MaterialList - 1 do
    local itemIndex = i + 1
    local itemSlot = REF.MaterialList[i]
    itemSlot["$gameObject"]:SetActive(itemIndex <= #m_expItems)
    if itemIndex <= #m_expItems then
      local itemInfo = m_expItems[itemIndex]
      itemSlot["@itemId"] = itemInfo.id
      itemSlot["$$BindItem"](itemInfo.id)
      itemSlot["$$SetBottomText"](WU.GetString("Window_ItemAddExp", itemInfo.param[1]), CS.NGUIMath.HexToColor(4294967218), CS.NGUIMath.HexToColor(1619577599))
      itemSlot["$$SetPressCallback"](OnPressSlot)
      itemSlot["$$SetClickCallback"](OnClickSlot)
      itemSlot["$$SetReleaseCallback"](OnReleaseSlot)
    end
  end
end

function OnPressSlot(go)
  if m_actor then
    local itemId = _ENV["$"](go)["@itemId"]
    m_holdItemSlot = go
    m_holdItemInfo = PB.get("ItemInfo", itemId)
    m_holdItem = this:GetData("fci/item/" .. itemId)
    m_reserveCount = 0
    m_predictLevel = m_actor.level
    m_predictExp = m_actor.curExp
    m_overflowedExp = 0
    local ref = REF.Count
    local curPosition = ref.transform.localPosition
    ref.transform.localPosition = CS.UnityEngine.Vector3(go.transform.localPosition.x, curPosition.y, curPosition.z)
    REF.LabelCount.UIHtmlLabel.text = m_holdItem.count
    REF.ProgressPredict.EffectGenerator:Play()
    m_pressStart = true
    m_speedOnCount = 1
    m_pressHold = CS.System.DateTime.Now
  end
end

function OnClickSlot()
  local result = false
  local isUpgraded = false
  if m_holdItemSlot and m_holdItemInfo and m_holdItem and CanEatFood(m_predictLevel, m_levelLimit, m_predictExp) and m_holdItem ~= nil and m_holdItem.count > m_reserveCount then
    local startLevel = m_predictLevel
    local actorLevelupNext = PB.get("ActorLevelup", m_predictLevel + 1)
    if m_pressStart == false then
      SetSpeedOnCount(m_holdItemInfo.param[1], actorLevelupNext.exp)
    end
    if m_holdItem.count >= m_reserveCount + m_speedOnCount then
      m_reserveCount = m_reserveCount + m_speedOnCount
      m_predictExp = m_predictExp + m_speedOnCount * m_holdItemInfo.param[1]
    else
      m_predictExp = m_predictExp + (m_holdItem.count - m_reserveCount) * m_holdItemInfo.param[1]
      m_reserveCount = m_holdItem.count
    end
    while actorLevelupNext and m_predictExp >= actorLevelupNext.exp and CanEatFood(m_predictLevel, m_levelLimit, m_predictExp) do
      m_predictExp = m_predictExp - actorLevelupNext.exp
      m_predictLevel = m_predictLevel + 1
      isUpgraded = true
      actorLevelupNext = PB.get("ActorLevelup", m_predictLevel + 1)
    end
    if m_predictLevel == m_levelLimit then
      if not actorLevelupNext then
        m_overflowedExp = m_predictExp
      elseif m_predictExp > actorLevelupNext.exp then
        m_overflowedExp = m_predictExp - actorLevelupNext.exp
      end
      while m_overflowedExp and m_overflowedExp > m_holdItemInfo.param[1] do
        m_overflowedExp = m_overflowedExp - m_holdItemInfo.param[1]
        m_reserveCount = m_reserveCount - 1
      end
      if actorLevelupNext and m_predictExp > actorLevelupNext.exp then
        m_predictExp = actorLevelupNext.exp
      end
    end
    local levelText = WU.GetString("Window_Level", m_predictLevel)
    if m_predictLevel > m_actor.level then
      REF.NodeProgress.gameObject:SetActive(false)
    end
    REF.LabelLevel.UILabel.text = levelText
    REF.LabelLevelB.UILabel.text = levelText
    if actorLevelupNext then
      REF.LabelExp.UIHtmlLabel.text = m_predictExp .. "/" .. actorLevelupNext.exp
      REF.NodeProgressBg.UIPanel.clipOffset = {
        x = m_predictExp / actorLevelupNext.exp * m_progressTotalLength,
        y = 0
      }
    else
      REF.LabelExp.UIHtmlLabel.text = ""
      REF.NodeProgressBg.UIPanel.clipOffset = {x = m_progressTotalLength, y = 0}
    end
    REF.LabelCount.UIHtmlLabel.text = tostring(m_holdItem.count - m_reserveCount)
    if isUpgraded then
      REF.LineGlow.EffectGenerator:Play()
      ShowLevelLabelEffect()
      m_startAttrsPromotion = AU.GetActorLevelPromotion(m_actor.id, m_actor.quality, 1, startLevel)
      m_endAttrsPromotion = AU.GetActorLevelPromotion(m_actor.id, m_actor.quality, 1, m_predictLevel)
      m_attrAnimationElapsedTime = 0
    end
    if m_pressStart then
      showCountEffect(true)
      m_pressStart = false
    end
    result = true
  end
  if not result and m_holdItem and m_holdItem.count <= 0 then
    WU.ShowItemDetail(m_holdItem.id)
  end
  m_materialClickedTime = m_materialClickedTime + 1
  if 5 <= m_materialClickedTime then
    WU.TriggerUnforcedTutorial(1106)
  end
  return result
end

function OnReleaseSlot(go)
  if 0 < m_overflowedExp then
    WU.ShowMessageYesNo(WU.GetString("Window_LevelUpExpOverflow", m_overflowedExp), function(result)
      if result == "NO" then
        m_reserveCount = m_reserveCount - 1
      end
      if m_reserveCount == 0 then
        UpdateLevelupInfo(true)
      end
      DoLevelup()
    end)
  else
    if m_holdItem and m_holdItem.count > 0 then
      CheckMaxLevelLimit()
    end
    DoLevelup()
  end
  m_speedOnCount = 1
  showCountEffect(false)
end

function DoLevelup()
  local slotRef = _ENV["$"](m_holdItemSlot)
  if 0 < m_reserveCount then
    local preLevel = m_actor.level
    local itemCost = {
      type = PB.enum.ResourceType.ResItem,
      id = slotRef["@itemId"],
      count = m_reserveCount
    }
    local costList = {}
    table.insert(costList, itemCost)
    this:GameRequest("fci/actor/" .. m_actor.uid .. "/levelupgrade/"):Post({foodRes = costList}, function(result)
      local _, change = table.find(result.resChange, function(_, change)
        return change.actor
      end)
      DBH.ResChange(result.resChange)
    end)
  end
  if m_reserveCount == 1 then
    WU.RecordButtonClick("1" .. slotRef["@itemId"])
  elseif m_reserveCount == 0 then
    WU.RecordButtonClick("3" .. slotRef["@itemId"])
  elseif 1 < m_reserveCount then
    WU.RecordButtonClick("2" .. slotRef["@itemId"])
  end
  m_holdItemSlot = nil
  m_holdItemInfo = nil
  m_holdItem = nil
end

function CheckMaxLevelLimit()
  if m_actor and not CanEatFood(m_predictLevel, m_levelLimit, m_predictExp) then
    WU.ShowHintText(WU.GetString("Window_ActorLevelupReachLevelLimit"))
  end
end

function CanEatFood(curLevel, levelLimit, exp)
  local actorLevelupNext = PB.get("ActorLevelup", curLevel + 1)
  return curLevel < levelLimit or curLevel == levelLimit and actorLevelupNext and exp < actorLevelupNext.exp
end

function showCountEffect(isShow)
  if isShow then
    REF.BubbleTips01.gameObject:SetActive(true)
    REF.BubbleTips01.EffectGenerator:Play()
    REF.LabelCount.gameObject:SetActive(true)
    m_BubbleOn = true
  elseif m_BubbleOn then
    local now = CS.System.DateTime.Now
    local delayTime = 0
    local t = m_pressHold:AddSeconds(0.5)
    if now < t then
      delayTime = t:Subtract(now).Ticks / 1.0E7
    end
    this:DelayInvokeInSeconds(delayTime, function()
      REF.BubbleTips01.gameObject:SetActive(false)
      REF.LabelCount.gameObject:SetActive(false)
      REF.BubbleTips02.gameObject:SetActive(true)
      REF.BubbleTips02.EffectGenerator:Play()
      m_BubbleOn = false
    end)
  end
end

function ShowLevelLabelEffect()
  REF.LabelLevel.TweenScale:ResetToBeginning()
  REF.LabelLevelB.TweenScale:ResetToBeginning()
  REF.LabelLevelB.TweenAlpha:ResetToBeginning()
  REF.LabelLevel.TweenScale:PlayForward()
  REF.LabelLevelB.TweenScale:PlayForward()
  REF.LabelLevelB.TweenAlpha:PlayForward()
end

function Update(deltaTime)
  if m_attrAnimationElapsedTime < m_attrAnimationDuration then
    m_attrAnimationElapsedTime = math.min(m_attrAnimationElapsedTime + deltaTime, m_attrAnimationDuration)
    local progress = m_attrAnimationElapsedTime / m_attrAnimationDuration
    RenderAttrList(EvaluateAttrAnimationData(progress))
  end
end

function EvaluateAttrAnimationData(progress)
  local attrAnimationFrame = {}
  for index, startAttrPromotion in ipairs(m_startAttrsPromotion) do
    local endAttrPromotion = m_endAttrsPromotion[index]
    local promotionValue = startAttrPromotion.value + math.floor((endAttrPromotion.value - startAttrPromotion.value) * progress)
    table.insert(attrAnimationFrame, {
      type = startAttrPromotion.type,
      isRatio = startAttrPromotion.isRatio,
      value = promotionValue
    })
  end
  return attrAnimationFrame
end

function RenderAttrList(attrList)
  for index, attr in ipairs(attrList) do
    REF.NodeAttrList[index - 1].Value.UILabel.text = "+" .. U.FormatAttrValue(attr)
  end
end

function SetSpeedOnCount(itemExp, actorLevelupNextExp)
  m_speedOnCount = math.ceil(actorLevelupNextExp / (itemExp * 30))
end
