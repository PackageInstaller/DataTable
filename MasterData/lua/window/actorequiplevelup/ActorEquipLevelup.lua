local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local EA = require("Common/EquipAttr")
local LU = require("Common/ListUtil")
local TU = require("Common/TaskUtil")
local DBH = require("Manager/DataBindingHandler")
local m_actor, m_equipPos, m_equipUid, m_equip, m_selectedMaterials
local m_selectedExp = 0
local m_enhanceExpWithLoss = 0
local m_previousLevel = 0
local m_targetLevel, m_resourceCost

function SetupWindow()
  for i = 0, #REF.EquipSlotGrid - 1 do
    REF.EquipSlotGrid[i]["$$SetEquipPos"](i)
  end
  WU.BindButtonEvent(REF.ButtonEnhance, OnEnhanceClick)
  WU.BindButtonEvent(REF.ButtonFastChoose, OnFastChooseClick)
  WU.BindButtonEvent(REF.ButtonEquip, OnEquipClick)
  WU.BindButtonEvent(REF.ButtonClear, function()
    m_targetLevel = m_equip.level
    m_resourceCost = nil
    this:SetData("Equip/LevelUp/SelectedMaterial", nil)
  end)
  REF.LabelReturn.ResourcePrinter.m_format = WU.GetString("Window_EquipExpReturn") .. REF.LabelReturn.ResourcePrinter.m_format
end

function InitWindow()
  local specified = this:GetData("ActorEquipLevelup/EquipSpecified")
  for i = 0, #REF.EquipSlotGrid - 1 do
    local slotRef = REF.EquipSlotGrid[i]
    slotRef["$gameObject"]:SetActive(true)
    slotRef["$$SetEquipPos"](fif(specified, nil, i))
    slotRef["$$SetClickCallback"](fif(specified, nil, function()
    end))
  end
  if not specified then
    this:Bind("fci/actor/{Actor/SelectedUid}", OnActorChange)
    this:Bind("Actor/Equip/SelectedPos", OnSelectedEquipPosChange)
  end
  this:Bind("Equip/SelectedUid", OnSelectedEquipUidChange)
  this:Bind("Equip/LevelUp/SelectedMaterial", OnSelectedMaterialsChange)
  WU.PreloadWindow("ActorEquipLevelupResult")
end

function UninitWindow()
  this:SetData("ActorEquipLevelup/EquipSpecified", false)
  this:SetData("Actor/Equip/SelectedPos", nil)
end

function OnMaterialSlotClick()
  if m_equip and EU.ValidateEquipLevelup(m_equip) then
    WU.AcquireWindowAsync("ActorEquipLevelupMaterial")
  end
end

function OnActorChange(actor)
  m_actor = actor
  if m_actor then
    UpdateSelectedEquipUid()
  end
end

function OnSelectedEquipPosChange(equipPos)
  m_equipPos = equipPos
  if m_equipPos then
    UpdateSelectedEquipUid()
  elseif m_actor then
    local actorConfig = PB.get("ActorConfig", m_actor.id)
    this:SetData("Actor/Equip/SelectedPos", PB.enum.EquipPos.Head)
  end
end

function UpdateSelectedEquipUid()
  if m_actor and m_equipPos then
    local equipUid = m_actor.bodyEquips[tostring(m_equipPos)]
    this:SetData("Equip/SelectedUid", equipUid)
  end
end

function OnSelectedEquipUidChange(equipUid)
  if m_equipUid then
    this:Unbind("fci/equip/" .. m_equipUid, OnSelectedEquipChange)
  end
  m_targetLevel = nil
  m_resourceCost = nil
  m_equip = nil
  this:SetData("Equip/LevelUp/SelectedMaterial", nil)
  m_equipUid = equipUid
  if m_equipUid then
    this:Bind("fci/equip/" .. equipUid, OnSelectedEquipChange)
  end
end

function OnSelectedEquipChange(equip)
  if equip then
    m_equip = equip
    local equipInfo = PB.get("EquipInfo", m_equip.id)
    if equipInfo then
      REF.EquipSlotGrid[equipInfo.pos]["$$SetEquipPos"](equipInfo.pos)
      REF.EquipSlotGrid[equipInfo.pos]["$$BindEquip"](m_equip.uid)
      m_targetLevel = m_equip.level
      m_resourceCost = nil
      local indicatorPos = REF.SpriteIndicator.transform.localPosition
      REF.SpriteIndicator.TweenPosition.from = indicatorPos
      indicatorPos.x = REF.EquipSlotGrid[equipInfo.pos]["$transform"].localPosition.x
      REF.SpriteIndicator.TweenPosition.to = indicatorPos
      REF.SpriteIndicator.TweenPosition:ResetToBeginning()
      REF.SpriteIndicator.TweenPosition:PlayForward()
      this:SetData("Equip/LevelUp/SelectedMaterial", nil)
    end
  end
end

function OnSelectedMaterialsChange(selectedMaterials)
  if selectedMaterials then
    m_selectedMaterials = selectedMaterials
  else
    m_selectedMaterials = _ENV["!"]({})
  end
  m_selectedExp = 0
  m_enhanceExpWithLoss = 0
  for _, selection in pairs(m_selectedMaterials) do
    if selection.type == PB.enum.ResourceType.ResItem then
      m_selectedExp = m_selectedExp + EU.ItemEquipExp(selection.id) * selection.count
    elseif selection.type == PB.enum.ResourceType.ResEquip then
      local decomposedExp, enhanceExpWithLoss = EU.DecomposedExp(this:GetData("fci/equip/" .. selection.param))
      m_selectedExp = m_selectedExp + decomposedExp
      m_enhanceExpWithLoss = m_enhanceExpWithLoss + enhanceExpWithLoss
    end
  end
  local enhanceInfo
  if m_equip then
    enhanceInfo = EU.TryEnhanceEquip(m_equip, m_selectedExp)
    m_targetLevel = enhanceInfo.targetLevel
  end
  UpdatePreview(enhanceInfo)
  UpdateMaterials(enhanceInfo)
end

function UpdatePreview(enhanceInfo)
  if m_equip then
    UpdateProgressBar(enhanceInfo)
  end
  UpdateAttrCompareTable()
  REF.NodeEquipDetail.gameObject:SetActive(m_equip)
  REF.NodeEmpty.gameObject:SetActive(not m_equip)
end

function UpdateProgressBar(enhanceInfo)
  if enhanceInfo then
    local levelText = WU.GetString("Window_ActorLevelHint") .. "&nbsp;" .. m_equip.level
    if enhanceInfo.targetLevel > m_equip.level then
      levelText = levelText .. "&nbsp;<img src='Common.arrow_right' width=73% height=73%/>&nbsp;" .. enhanceInfo.targetLevel
    end
    REF.LabelLevel.UIHtmlLabel.text = levelText
    REF.LabelExp.UIHtmlLabel.text = fif(enhanceInfo.expLeft >= enhanceInfo.expToNextLevel, WU.GetString("Window_EquipLevelMax"), enhanceInfo.expLeft .. "/" .. enhanceInfo.expToNextLevel)
    local equipInfo = PB.get("EquipInfo", m_equip.id)
    if equipInfo then
      local equipEnhance = PB.get("EquipEnhance", equipInfo.quality, m_equip.level)
      REF.WidgetProgressBar.UIProgressBar.value = math.min(1, m_equip.curExp / math.max(1, equipEnhance.levelUpExp))
    end
    REF.SpriteExp.gameObject:SetActive(enhanceInfo.targetLevel == m_equip.level)
    REF.SpriteExpPredict.UISprite.fillAmount = fif(enhanceInfo.expLeft >= enhanceInfo.expToNextLevel, 1, math.min(1, enhanceInfo.expLeft / math.max(1, enhanceInfo.expToNextLevel)))
  end
end

function UpdateMaterials(enhanceInfo)
  local reachMaxLevel = m_equip and EU.IsEquipReachMaxLevel(m_equip)
  REF.NodeMax.gameObject:SetActive(reachMaxLevel)
  REF.NodeMaterialDetail.gameObject:SetActive(not reachMaxLevel)
  if not reachMaxLevel then
    local selectedCount = #m_selectedMaterials
    for i = 0, #REF.MaterialGrid - 1 do
      local slotRef = REF.MaterialGrid[i]
      if i < selectedCount then
        local selection = m_selectedMaterials[i + 1]
        if selection.type == PB.enum.ResourceType.ResItem then
          slotRef["$$SetData"](selection.type, selection.id, selection.count)
          local exp = EU.ItemEquipExp(selection.id)
          slotRef["$$SetBottomText"](WU.GetString("Window_ItemAddExp", exp))
        else
          slotRef["$$BindEquip"](selection.param)
          slotRef["$$SetBottomText"](WU.GetString("Window_ItemAddExp", EU.DecomposedExp(this:GetData("fci/equip/" .. selection.param))))
        end
      else
        slotRef["$$SetEmpty"](1)
      end
      slotRef["$$SetClickCallback"](OnMaterialSlotClick)
    end
    REF.ButtonClear.gameObject:SetActive(0 < selectedCount)
    REF.ButtonFastChoose.gameObject:SetActive(selectedCount <= 0)
    REF.ButtonFastChoose.UIButton.isEnabled = m_equip
    REF.ButtonEnhance.UIButton.isEnabled = m_equip
    m_resourceCost = 0
    local equipExpToResource = PB.all("Misc")[1].equipExpToResource
    if enhanceInfo then
      local selectedExpWithCost = m_selectedExp - m_enhanceExpWithLoss
      local usedExpWithCost = fif(selectedExpWithCost > enhanceInfo.expUsed, enhanceInfo.expUsed, selectedExpWithCost)
      local expOverflowWithLoss = 0
      if 0 < enhanceInfo.expOverflow then
        expOverflowWithLoss = math.min(enhanceInfo.expOverflow, m_enhanceExpWithLoss)
      end
      m_resourceCost = (usedExpWithCost - expOverflowWithLoss) * equipExpToResource.count
    end
    WU.SetActive(REF.NodeCost, 0 <= m_resourceCost)
    WU.SetActive(REF.NodeReturn, m_resourceCost < 0)
    if 0 <= m_resourceCost then
      REF.LabelCost.ResourcePrinter:SetResource(equipExpToResource.type, equipExpToResource.id, m_resourceCost)
    else
      REF.LabelReturn.ResourcePrinter:SetResource(equipExpToResource.type, equipExpToResource.id, -m_resourceCost)
    end
  end
end

function OnEnhanceClick()
  if EU.ValidateEquipLevelup(m_equip) then
    if #m_selectedMaterials == 0 then
      WU.ShowHintText(WU.GetString("Window_LevelupError_MaterialNotSelected"))
    else
      local equipExpToResource = PB.all("Misc")[1].equipExpToResource
      WU.TryToPay(equipExpToResource.type, equipExpToResource.id, m_resourceCost, function()
        RequestEquipLevelUp()
      end)
    end
  end
end

function RequestEquipLevelUp()
  m_previousLevel = m_equip.level
  this:GameRequest("fci/equip/" .. m_equip.uid .. "/enhance/"):Post({foodRes = m_selectedMaterials}, function(result)
    DBH.ResChange(result.resChange)
    local _, change = table.find(result.resChange, function(_, change)
      return change.equip and change.equip.uid == m_equip.uid
    end)
    local equip = change.equip
    if equip.level > m_previousLevel then
      WU.AcquireWindowAsync("ActorEquipLevelupResult", function(window)
        _ENV["$"](window)["$$SetResult"](result, m_equip.uid, m_previousLevel)
      end)
    end
    this:BroadcastGameEvent("EventEquipLevelup")
  end)
end

function OnFastChooseClick()
  TU.TaskFirstCheck(PB.enum.UseFuncMTimes.FastSelection)
  if EU.ValidateEquipLevelup(m_equip) then
    local candidates = AU.GetItems(PB.enum.ItemFuncType.EquipExp, function(a, b)
      return a.itemInfo.param[1] < b.itemInfo.param[1]
    end)
    if 0 < #candidates then
      local equipInfo = PB.get("EquipInfo", m_equip.id)
      local levelLimit = EU.GetEquipLevelLimit(m_equip)
      local nextNewRandAttrLevel = m_equip.level
      if equipInfo then
        for i = m_equip.level + 1, levelLimit do
          local equipEnhance = PB.get("EquipEnhance", equipInfo.quality, i)
          if equipEnhance.genNewRandAttr then
            nextNewRandAttrLevel = i - 1
            break
          end
        end
      end
      local equipExpToResource = PB.all("Misc")[1].equipExpToResource
      local resourceStock = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[equipExpToResource.type] .. "_" .. equipExpToResource.id)
      local expMax = math.floor(math.max(0, resourceStock) / equipExpToResource.count)
      local requiredExp = 0
      if equipInfo then
        requiredExp = EU.ExpSum(equipInfo.quality, m_equip.level, nextNewRandAttrLevel) - m_equip.curExp
      end
      local selectedExp = 0
      local selections = _ENV["!"]({})
      local maxSlotCount = #REF.MaterialGrid
      local usedSlotCount = 0
      for i = 1, #candidates do
        if requiredExp > selectedExp and maxSlotCount > usedSlotCount then
          selectedExp = selectedExp + candidates[i].itemInfo.param[1] * candidates[i].cnt
          table.insert(selections, candidates[i])
          usedSlotCount = usedSlotCount + 1
        else
          break
        end
      end
      for i = #selections, 1, -1 do
        if requiredExp < selectedExp then
          local selection = selections[i]
          local itemExp = selection.itemInfo.param[1]
          while itemExp <= selectedExp - requiredExp and 0 < selection.cnt do
            selectedExp = selectedExp - itemExp
            selection.cnt = selection.cnt - 1
          end
        else
          break
        end
      end
      for i = 1, #selections do
        if expMax < selectedExp then
          local selection = selections[i]
          while expMax < selectedExp and 0 < selection.cnt do
            selectedExp = selectedExp - selection.itemInfo.param[1]
            selection.cnt = selection.cnt - 1
          end
        else
          break
        end
      end
      local selectedMaterials = _ENV["!"]({})
      for i = #selections, 1, -1 do
        local selection = selections[i]
        if 0 < selection.cnt then
          table.insert(selectedMaterials, {
            type = PB.enum.ResourceType.ResItem,
            id = selection.itemInfo.id,
            count = selection.cnt
          })
        end
      end
      local enhanceInfo = EU.TryEnhanceEquip(m_equip, selectedExp)
      m_targetLevel = enhanceInfo.targetLevel
      this:SetData("Equip/LevelUp/SelectedMaterial", selectedMaterials)
    else
      WU.ShowHintText(WU.GetString("Window_NoEquipExpMaterial"))
    end
  end
end

function OnEquipClick()
  this:BroadcastGameEvent("EventSelectEquipPos", m_equipPos)
  WU.RecycleWindow(this)
end

function SortAttrs(attrMap)
  local sortedAttrList = {}
  local displayList = PB.index("AttrTypeSortOrder", 1).list
  for i = 1, #displayList do
    local type = displayList[i]
    local attr = attrMap[type]
    if attr then
      table.insert(sortedAttrList, attr)
    end
  end
  return sortedAttrList
end

function ExpandRandAttrs(randAttrMap)
  local sortedAttrList = {}
  local displayList = PB.index("AttrTypeSortOrder", 1).list
  for i = 1, #displayList do
    local type = displayList[i]
    local attrs = randAttrMap[type]
    if attrs then
      for _, attr in ipairs(attrs) do
        table.insert(sortedAttrList, attr)
      end
    end
  end
  return sortedAttrList
end

function UpdateAttrCompareTable()
  if m_equip then
    local sourceAttrs = SortAttrs(EA.GetBaseAttrMapByEquipId(m_equip.id, m_equip.level))
    local targetAttrs
    if m_targetLevel ~= m_equip.level then
      targetAttrs = SortAttrs(EA.GetBaseAttrMapByEquipId(m_equip.id, m_targetLevel))
    end
    for index, sourceAttr in ipairs(sourceAttrs) do
      if index <= #REF.NodeBaseAttrs then
        local slotRef = REF.NodeBaseAttrs[index - 1]
        slotRef.LabelType.UIHtmlLabel.text = WU.GetAttrName(sourceAttr.type)
        slotRef.LabelValue1.UIHtmlLabel.text = U.FormatAttrValue(sourceAttr)
        WU.SetActive(slotRef.SpriteUp, targetAttrs)
        WU.SetActive(slotRef.LabelValue2, targetAttrs)
        if targetAttrs then
          local targetAttr = targetAttrs[index]
          slotRef.LabelValue2.UIHtmlLabel.text = U.FormatAttrValue(targetAttr)
        end
      else
        error("ActorEquipLevelup", "Equip base attributes doesn't match the UI structure")
      end
    end
    local randAttrMap = EA.GetRandAttrMapByEquip(m_equip)
    local randAttrs = ExpandRandAttrs(randAttrMap)
    local activeSlotCount = #randAttrs
    if randAttrMap.randAttrUnlockLevels then
      activeSlotCount = activeSlotCount + #randAttrMap.randAttrUnlockLevels
    end
    for i = 0, #REF.NodeRandAttrs - 1 do
      WU.SetActive(REF.NodeRandAttrs[i]["$"], i < activeSlotCount)
    end
    for index, attr in ipairs(randAttrs) do
      if index <= #REF.NodeRandAttrs then
        local slotRef = REF.NodeRandAttrs[index - 1]
        slotRef.LabelType.UIHtmlLabel.text = WU.GetAttrName(attr.type)
        slotRef.LabelValue.UIHtmlLabel.text = U.FormatAttrValue(attr)
        if slotRef.LabelValue.TweenColor then
          slotRef.LabelValue.UIHtmlLabel.color = slotRef.LabelValue.TweenColor.to
          slotRef.LabelValue.TweenColor.enabled = false
        end
      else
        error("ActorEquipLevelup", "Equip rand attributes doesn't match the UI structure")
      end
    end
    local genNewRandAttrCount = EU.GetEquipRandAttrCount(m_equip, m_equip.level + 1, m_targetLevel)
    if randAttrMap.randAttrUnlockLevels then
      local randAttrCount = #randAttrs
      for i = 1, #randAttrMap.randAttrUnlockLevels do
        if randAttrCount + i <= #REF.NodeRandAttrs then
          local slotRef = REF.NodeRandAttrs[randAttrCount + i - 1]
          slotRef.LabelType.UIHtmlLabel.text = WU.GetString("Window_AttrKind_Rand")
          slotRef.LabelValue.UIHtmlLabel.text = WU.GetString("Window_AttrGetLevel", randAttrMap.randAttrUnlockLevels[i])
          slotRef.LabelValue.UIHtmlLabel.color = slotRef.LabelValue.TweenColor.from
          slotRef.LabelValue.TweenColor.enabled = false
          if i <= genNewRandAttrCount then
            slotRef.LabelValue.TweenColor:PlayForward()
            slotRef.LabelValue.TweenColor:ResetToBeginning()
          end
        else
          error("ActorEquipLevelup", "Equip rand attributes doesn't match the UI structure")
        end
      end
    end
  end
end
