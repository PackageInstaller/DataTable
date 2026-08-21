local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local EA = require("Common/EquipAttr")
local LU = require("Common/ListUtil")
local m_effectTable = {}
local m_displayList
local m_returnedItems = {}

function SetupWindow()
  WU.BindButtonEvent(REF.Black, function()
    WU.RecycleWindow("ActorEquipLevelupResult")
  end)
  m_displayList = PB.index("AttrTypeSortOrder", 1).list
  LU.Bind(REF.WrapContentEffects, {
    updateRow = UpdateEffect
  })
  LU.Bind(REF.WrapContentResources, {
    updateRow = UpdateSlot
  })
end

function InitWindow()
  REF.ConenteBGEffect.gameObject:SetActive(false)
end

function UpdateEffect(slotRef, wrapIndex, realIndex)
  local dataIndex = realIndex + 1
  if dataIndex <= #m_effectTable then
    local effect = m_effectTable[dataIndex]
    slotRef.LabelLeft.UILabel.text = effect.title
    slotRef.SpriteNew.gameObject:SetActive(effect.new)
    slotRef.LabelRight.UILabel.text = effect.value
    slotRef.LabelRightOld.UILabel.text = effect.valueOld
    if effect.color then
      slotRef.LabelRight.UILabel.color = effect.color
    end
  end
end

function UpdateSlot(slotRef, wrapIndex, realIndex)
  local dataIndex = realIndex + 1
  if dataIndex <= #m_returnedItems then
    local data = m_returnedItems[dataIndex]
    slotRef["$$SetData"](data.type, data.id, data.countDelta)
  end
end

function SetResult(result, equipUid, equipLevelOld)
  local _, change = table.find(result.resChange, function(_, change)
    return change.equip and change.equip.uid == equipUid
  end)
  local equip = change.equip
  REF.LabelTitle.UIHtmlLabel.text = WU.GetString("EquipName_" .. equip.id) .. "&nbsp;&nbsp;&nbsp;&nbsp;" .. WU.GetString("Window_Level", equip.level)
  m_effectTable = {}
  local equipInfo = PB.get("EquipInfo", equip.id)
  if equipInfo then
    local attrBase = EA.GetBaseAttrMap(equipInfo.baseAttrId, equip.level)
    local attrBaseOld = EA.GetBaseAttrMap(equipInfo.baseAttrId, equipLevelOld)
    for i = 1, #m_displayList do
      local type = m_displayList[i]
      if attrBase[type] then
        table.insert(m_effectTable, AttrToDesc(attrBase[type], attrBaseOld[type]))
      end
    end
    local genNewRandAttrCount = EU.GetEquipRandAttrCount(equip, equipLevelOld + 1, equip.level)
    if 0 < genNewRandAttrCount then
      local randAttrCount = #equip.randomAttrs
      for i = randAttrCount - genNewRandAttrCount + 1, randAttrCount do
        local attrRand = equip.randomAttrs[i]
        table.insert(m_effectTable, AttrToDesc(attrRand, {
          type = attrRand.type,
          isRatio = attrRand.isRatio,
          value = 0
        }))
      end
    end
    m_returnedItems = {}
    for _, change in pairs(result.resChange) do
      if change.baseRes and 0 < change.baseRes.countDelta then
        table.insert(m_returnedItems, change.baseRes)
      end
    end
    REF.NodeExtra.gameObject:SetActive(0 < #m_returnedItems)
    LU.Set(REF.WrapContentResources, #m_returnedItems)
    REF.EffectTitle.EffectGenerator:Play(function()
      REF.ConenteBGEffect.gameObject:SetActive(true)
      REF.ConenteBGEffect.EffectGenerator:Play()
    end)
    REF.PanelContent.gameObject:SetActive(false)
    this:DelayInvokeInScaledSeconds(1.48, function()
      REF.PanelContent.gameObject:SetActive(true)
      PopulateEffects()
      REF.WrapContentEffects.UIPlayTween:Play(true)
    end)
  end
end

function PopulateEffects()
  LU.Set(REF.WrapContentEffects, #m_effectTable)
end

function AttrToDesc(attr, attrOld)
  local result
  if attr then
    local valueOld = 0
    if attrOld then
      valueOld = U.FormatAttrValue(attrOld)
    end
    local color
    if not attrOld or attr.value > attrOld.value then
      color = CS.NGUIMath.HexToColor(1927741439)
    end
    result = {
      title = WU.GetString("Window_ActorAttrName_" .. attr.type),
      value = U.FormatAttrValue(attr),
      valueOld = valueOld,
      color = color
    }
    if attrOld.value == 0 then
      result.new = true
    end
  end
  return result
end
