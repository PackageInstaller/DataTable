local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SU = require("Common/SortUtil")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local EU = require("Common/EquipUtil")
local m_usedSlotCount = 0
local m_maxSlotCount = 6
local m_equip, m_selectedMaterials
local m_showBottom = false
local m_showItem = true
local m_requiredExp = 0
local m_selectedExp = 0
local m_enhanceExpWithLoss = 0
local m_expFromItem = 0
local m_previewItems = _ENV["!"]({})
local m_currentSortMate, m_targetList

function SetupWindow()
  CS.EventDelegate.Add(REF.ItemTab.UIToggle.onChange, function()
    m_currentSortMate = nil
    if CS.UIToggle.current.value then
      m_showItem = true
      m_currentSortMate = REF.SortMateItem.SortMate
      this:BroadcastGameEvent("ApplySortAlternative", 0, true)
    end
  end)
  CS.EventDelegate.Add(REF.EquipTab.UIToggle.onChange, function()
    m_currentSortMate = nil
    if CS.UIToggle.current.value then
      m_showItem = false
      m_currentSortMate = REF.SortMateEquip.SortMate
      this:BroadcastGameEvent("ApplySortAlternative", 0, false)
    end
  end)
  WU.BindButtonEvent(REF.ButtonConfirm, function(go)
    WU.RecycleWindow("ActorEquipLevelupMaterial")
  end)
  LU.Bind(REF.WrapContentMaterial, {
    dataSource = function(dataIndex)
      return m_targetList and m_targetList[dataIndex]
    end,
    updateSlot = function(ref, data)
      fif(m_showItem, UpdateItemSlot, UpdateEquipSlot)(ref, data)
    end
  })
  LU.Bind(REF.WrapContentPreview, {
    updateRow = UpdatePreviewSlot
  })
end

function InitWindow()
  SortFocusBase.InitWindowEquip()
  SortFocusBase.InitWindowItem()
  REF.ItemTab.UIToggle.value = true
  local equipUid = this:GetData("Equip/SelectedUid")
  m_equip = this:GetData("fci/equip/" .. equipUid)
  local levelLimit = EU.GetEquipLevelLimit(m_equip)
  m_requiredExp = 0
  local equipInfo = PB.get("EquipInfo", m_equip.id)
  if equipInfo then
    m_requiredExp = EU.ExpSum(equipInfo.quality, m_equip.level, levelLimit) - m_equip.curExp
  end
  this:Bind("Equip/LevelUp/SelectedMaterial", OnSelectedMaterialsChange)
  this:Bind("SortFinished", OnSortFinished)
end

function OnSortFinished(data)
  if data ~= nil and m_currentSortMate == data.sortMate then
    local targetList = _ENV["!"]({})
    if REF.ItemTab.UIToggle.value then
      for i = 1, #data.list do
        local item = data.list[i]
        if item.funcType == PB.enum.ItemFuncType.EquipExp and item.count > 0 then
          table.insert(targetList, item)
        end
      end
    else
      for i = 1, #data.list do
        local equip = data.list[i]
        if equip.actorUid == 0 and not equip.isLock and equip.matchIndex == 0 and equip.uid ~= m_equip.uid then
          table.insert(targetList, equip)
        end
      end
    end
    UpdateMaterialList(targetList)
  end
end

function UpdateMaterialList(targetList)
  if targetList then
    m_targetList = targetList
    local count = #targetList
    local row = math.ceil(count / #REF.WrapContentMaterial[0]["$"])
    LU.Set(REF.WrapContentMaterial, row)
    REF.BottomBarSpace.gameObject:SetActive(0 < count)
    REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContentMaterial.UIWrapContent.itemSize, 0)
    REF.WrapContentMaterial.UIPlayTween:Play(true)
    if m_showItem then
      _ENV["$"](REF.MaterialNode).NodeEmpty.gameObject:SetActive(#targetList == 0)
    else
      _ENV["$"](REF.EquipNode).NodeEmpty.gameObject:SetActive(#targetList == 0)
    end
  end
end

function UpdateItemSlot(widgetRef, context)
  if context then
    local stackCount = 0
    local _, selection = m_selectedMaterials:find(function(k, v)
      return v.type == PB.enum.ResourceType.ResItem and v.id == context.id
    end)
    if selection then
      stackCount = selection.count
    end
    widgetRef["$$BindItem"](context.id)
    widgetRef["$$SetBottomText"](WU.GetString("Window_ItemAddExp", context.exp))
    widgetRef["$$SetCount"](stackCount)
    widgetRef["$$SetSelected"](false)
    widgetRef["$$SetClickCallback"](function(widget)
      return OnExpItemClick(widget, 1)
    end)
    widgetRef["$$SetRemoveCallback"](function(widget)
      OnExpItemClick(widget, -1)
      this:SetData("Equip/LevelUp/SelectedMaterial", m_selectedMaterials)
    end)
    widgetRef["$$SetReleaseCallback"](function()
      this:SetData("Equip/LevelUp/SelectedMaterial", m_selectedMaterials)
    end)
  end
end

function OnExpItemClick(widget, delta)
  local result = false
  local widgetRef = _ENV["$"](widget)
  local item = widgetRef["@context"]
  local index, selection = m_selectedMaterials:find(function(k, v)
    return v.type == PB.enum.ResourceType.ResItem and v.id == item.id
  end)
  local selectionDirty = false
  if 0 < delta then
    if selection or m_usedSlotCount < m_maxSlotCount then
      if m_selectedExp < m_requiredExp then
        if not selection then
          selection = {
            type = PB.enum.ResourceType.ResItem,
            id = item.id,
            count = 0
          }
          table.insert(m_selectedMaterials, selection)
        end
        local stock = this:GetData("fci/item/" .. item.id).count
        selection.count = math.min(selection.count + delta, math.max(0, stock))
        selectionDirty = true
      else
        WU.ShowHintText(WU.GetString("Window_ActorLevelupMaterialFull"))
      end
    else
      WU.ShowHintText(WU.GetString("Window_EquipLevelUpSlotMax"))
    end
  elseif selection then
    selection.count = math.max(0, selection.count + delta)
    selectionDirty = true
  end
  if selectionDirty then
    if selection and 0 < selection.count then
      widgetRef["$$SetCount"](selection.count)
    elseif index then
      table.remove(m_selectedMaterials, index)
      widgetRef["$$SetCount"](0)
    end
    result = OnSelectedMaterialsChange(m_selectedMaterials)
  end
  return result
end

function UpdateEquipSlot(widgetRef, context)
  if context then
    local selected = m_selectedMaterials:find(function(k, v)
      return v.type == PB.enum.ResourceType.ResEquip and v.param == context.uid
    end)
    widgetRef["$$BindEquip"](context)
    widgetRef["$$SetBottomText"](WU.GetString("Window_ItemAddExp", EU.DecomposedExp(context)))
    widgetRef["$$SetSelected"](selected)
    widgetRef["$$SetClickCallback"](OnExpEquipClick)
  end
end

function OnExpEquipClick(widget)
  local widgetRef = _ENV["$"](widget)
  local equip = widgetRef["@context"]
  local index, selection = m_selectedMaterials:find(function(k, v)
    return v.type == PB.enum.ResourceType.ResEquip and v.param == equip.uid
  end)
  local selectionDirty = false
  if selection then
    selection = nil
    selectionDirty = true
    table.remove(m_selectedMaterials, index)
  elseif m_usedSlotCount < m_maxSlotCount then
    if m_selectedExp < m_requiredExp then
      local equipInfo = PB.get("EquipInfo", equip.id)
      if equipInfo then
        selection = _ENV["!"]({
          type = PB.enum.ResourceType.ResEquip,
          id = equip.id,
          count = 0,
          param = equip.uid,
          quality = equipInfo.quality
        })
      else
        selection = _ENV["!"]({
          type = PB.enum.ResourceType.ResEquip,
          id = equip.id,
          count = 0,
          param = equip.uid,
          quality = 0
        })
      end
      selectionDirty = true
      table.insert(m_selectedMaterials, selection)
    else
      WU.ShowHintText(WU.GetString("Window_EquipLevelUpSlotMax"))
    end
  else
    WU.ShowHintText(WU.GetString("Window_EquipLevelUpSlotMax"))
  end
  if selectionDirty then
    widgetRef["$$SetSelected"](selection)
    this:SetData("Equip/LevelUp/SelectedMaterial", m_selectedMaterials)
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
  m_expFromItem = 0
  m_usedSlotCount = #m_selectedMaterials
  for _, selection in pairs(m_selectedMaterials) do
    if selection.type == PB.enum.ResourceType.ResItem then
      local itemExp = EU.ItemEquipExp(selection.id) * selection.count
      m_selectedExp = m_selectedExp + itemExp
      m_expFromItem = m_expFromItem + itemExp
    elseif selection.type == PB.enum.ResourceType.ResEquip then
      local decomposedExp, enhanceExpWithLoss = EU.DecomposedExp(this:GetData("fci/equip/" .. selection.param))
      m_selectedExp = m_selectedExp + decomposedExp
      m_enhanceExpWithLoss = m_enhanceExpWithLoss + enhanceExpWithLoss
    end
  end
  if not m_showBottom and 0 < m_selectedExp then
    REF.PanelBottom["$Show"]()
    m_showBottom = true
  elseif m_showBottom and m_selectedExp <= 0 then
    REF.PanelBottom["$Hide"]()
    m_showBottom = false
  end
  REF.LabelSelected.UIHtmlLabel.text = m_usedSlotCount .. "/" .. m_maxSlotCount
  local enhanceInfo = EU.TryEnhanceEquip(m_equip, m_selectedExp)
  local suffix = fif(enhanceInfo.expLeft >= enhanceInfo.expToNextLevel, "Max", "Normal")
  REF.LabelExpAdd.UIHtmlLabel.text = fif(0 < m_selectedExp, WU.GetString("Window_ActorLevelup_Material_Exp_Add_" .. suffix, m_selectedExp), "")
  REF.LabelLevelMat.UIHtmlLabel.text = fif(enhanceInfo.targetLevel > m_equip.level, WU.GetString("Window_ActorLevelup_Material_Exp_" .. suffix, m_equip.level, enhanceInfo.targetLevel), WU.GetString("Window_Level", m_equip.level))
  local selectedExpWithCost = m_selectedExp - m_enhanceExpWithLoss
  local usedExpWithCost = math.min(enhanceInfo.expUsed, selectedExpWithCost)
  local expOverflowWithLoss = 0
  if 0 < enhanceInfo.expOverflow then
    expOverflowWithLoss = math.min(enhanceInfo.expOverflow, m_enhanceExpWithLoss)
  end
  m_previewItems = {}
  local expReturn = math.min(m_selectedExp - m_expFromItem, enhanceInfo.expOverflow)
  if 0 < expReturn then
    local expItems = AU.DecomposeToExpItems(expReturn, PB.enum.ItemFuncType.EquipExp)
    for _, v in pairs(expItems) do
      local res = {
        type = PB.enum.ResourceType.ResItem,
        id = v.id,
        count = v.cnt,
        exp = v.exp
      }
      table.insert(m_previewItems, res)
    end
  end
  LU.Set(REF.WrapContentPreview, #m_previewItems)
  local equipExpToResource = PB.all("Misc")[1].equipExpToResource
  local resourceCost = (usedExpWithCost - expOverflowWithLoss) * equipExpToResource.count
  WU.SetActive(REF.NodeCost, 0 <= resourceCost)
  WU.SetActive(REF.NodeReturn, resourceCost < 0)
  if 0 <= resourceCost then
    REF.LabelCost.ResourcePrinter:SetResource(equipExpToResource.type, equipExpToResource.id, resourceCost)
  else
    REF.LabelReturn.ResourcePrinter:SetResource(equipExpToResource.type, equipExpToResource.id, -resourceCost)
  end
  return suffix == "Normal"
end

function UpdatePreviewSlot(rowRef, wrapIndex, realIndex)
  if m_previewItems and realIndex ~= nil and realIndex < #m_previewItems then
    local res = m_previewItems[realIndex + 1]
    rowRef["$$SetData"](res.type, res.id, res.count)
  end
end

function Focus(on)
  SortFocusBase.FocusEquip(on)
  SortFocusBase.FocusItem(on)
end
