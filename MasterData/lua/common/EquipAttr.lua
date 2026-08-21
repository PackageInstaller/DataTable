local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local SE = require("Common/SkillEffect")
local EA = {}

function EA.GetBaseAttrMap(baseAttrId, equipLevel)
  local baseAttrMap
  equipLevel = equipLevel or 1
  if baseAttrId ~= 0 then
    local equipBaseAttr = PB.get("EquipBaseAttr", baseAttrId, equipLevel)
    if equipBaseAttr then
      baseAttrMap = _ENV["!"]({})
      for i = 1, #equipBaseAttr.attr do
        local attr = equipBaseAttr.attr[i]
        baseAttrMap[attr.type] = {
          type = attr.type,
          value = attr.value,
          isRatio = attr.isRatio
        }
      end
    end
  end
  return baseAttrMap
end

function EA.GetBaseAttrMapByEquipId(equipId, equipLevel)
  local baseAttrMap
  if equipId ~= 0 then
    local equipInfo = PB.get("EquipInfo", equipId)
    if equipInfo then
      baseAttrMap = EA.GetBaseAttrMap(equipInfo.baseAttrId, equipLevel)
    end
  end
  return baseAttrMap
end

function EA.GetRandAttrMapByEquip(equip)
  local randAttrMap
  if equip then
    randAttrMap = _ENV["!"]({})
    local level = equip.level or 0
    if equip.randomAttrs then
      for _, attr in pairs(equip.randomAttrs) do
        if not randAttrMap[attr.type] then
          randAttrMap[attr.type] = _ENV["!"]({})
        end
        table.insert(randAttrMap[attr.type], attr)
      end
    else
      level = 0
    end
    local randAttrUnlockLevels = {}
    local equipInfo = PB.get("EquipInfo", equip.id)
    if equipInfo then
      for i = level + 1, EU.GetEquipMaxLevel(equip) do
        local equipEnhance = PB.get("EquipEnhance", equipInfo.quality, i)
        if equipEnhance.genNewRandAttr then
          table.insert(randAttrUnlockLevels, i)
        end
      end
    end
    if 0 < #randAttrUnlockLevels then
      randAttrMap.randAttrUnlockLevels = randAttrUnlockLevels
    end
  end
  return randAttrMap
end

function EA.GetSpecialAttr(specialAttrId)
  local specialAttr
  if specialAttrId ~= 0 then
    specialAttr = _ENV["!"]({
      id = specialAttrId,
      effect = SE.GetSpecialEffect(specialAttrId)
    })
  end
  return specialAttr
end

function EA.GetSpecialAttrByEquipId(equipId)
  local specialAttr
  local equipInfo = PB.get("EquipInfo", equipId)
  if equipInfo and equipInfo.specialAttrId ~= 0 then
    specialAttr = EA.GetSpecialAttr(equipInfo.specialAttrId)
  end
  return specialAttr
end

function EA.GetSuitInfo(equipId, equips)
  local suitInfo
  local suit = EU.GetSuit(equipId)
  if suit then
    suitInfo = _ENV["!"]({})
    suitInfo.id = suit.id
    suitInfo.attrList = _ENV["!"]({})
    for i = 1, #suit.suitAttr do
      local attr = suit.suitAttr[i]
      if attr.suitCount ~= 0 then
        local specialAttr = EA.GetSpecialAttr(attr.specialAttrId)
        if specialAttr then
          specialAttr.suitCount = attr.suitCount
          specialAttr.suitCul = attr.suitCul
          specialAttr.activated = false
          table.insert(suitInfo.attrList, specialAttr)
        end
      end
    end
    if equips then
      suitInfo.status = EA.GetSuitStatus(suit, equips)
      local equippedCount = suitInfo.status:where(function(_, equip)
        return type(equip) == "table"
      end):toarray():count()
      for i = 1, #suitInfo.attrList do
        local suitAttr = suitInfo.attrList[i]
        suitAttr.activated = equippedCount >= suitAttr.suitCount
      end
      local finalAttrList = _ENV["!"]({})
      for i = #suitInfo.attrList, 1, -1 do
        table.insert(finalAttrList, 1, suitInfo.attrList[i])
        if suitInfo.attrList[i].activated then
          break
        end
      end
      suitInfo.attrList = finalAttrList
    end
  end
  return suitInfo
end

function EA.GetSuitStatus(suit, equips)
  local status = _ENV["!"]({})
  if suit and equips then
    for i = 1, #suit.equipId do
      local equipId = suit.equipId[i]
      local equipInfo = PB.get("EquipInfo", equipId)
      if equipInfo then
        do
          local _, equip = _ENV["!"](equips):find(function(k, v)
            return v.id == equipId
          end)
          if equip then
            status[equipInfo.pos] = equip
          else
            status[equipInfo.pos] = equipId
          end
        end
      end
    end
  end
  return status
end

function EA.GetEquipAttr(equip, level, equips)
  local equipAttr = _ENV["!"]({})
  if equip then
    equipAttr.baseAttrMap = EA.GetBaseAttrMapByEquipId(equip.id, level or equip.level)
    equipAttr.randAttrMap = EA.GetRandAttrMapByEquip(equip)
    equipAttr.specialAttr = EA.GetSpecialAttrByEquipId(equip.id)
    equipAttr.suitInfo = EA.GetSuitInfo(equip.id, equips)
  end
  return equipAttr
end

function EA.AttrListToMap(attrList)
  local attrMap = _ENV["!"]({})
  for _, attr in pairs(attrList) do
    attrMap[attr.type] = attr
  end
  return attrMap
end

function EA.GetEquipScore(equipOrId, level)
  local result = 0
  if equipOrId ~= nil then
    local equip, equipId
    if type(equipOrId) == "number" then
      equipId = equipOrId
      level = level or 1
    else
      equip = equipOrId
      equipId = equipOrId.id
      level = level or equip.level
    end
    if equipId then
      local baseAttrMap = EA.GetBaseAttrMapByEquipId(equipId, level)
      local randAttrMap = EA.GetRandAttrMapByEquip(equip)
      local attrToScoreList = PB.all("AttrToScore")
      for type, attrToScore in pairs(attrToScoreList) do
        if 0 < attrToScore.ratio then
          local baseAttr = baseAttrMap[type]
          if baseAttr then
            result = result + attrToScore.ratio * baseAttr.value
          end
          if randAttrMap then
            local attrList = randAttrMap[type]
            if attrList then
              for _, attr in pairs(attrList) do
                result = result + attrToScore.ratio * attr.value
              end
            end
          end
        end
      end
    end
  end
  return result
end

function EA.GetEquipDetails(equipOrId, level)
  local equipId
  if type(equipOrId) == "number" then
    equipId = equipOrId
  else
    equipId = equipOrId.id
  end
  local equipInfo = PB.get("EquipInfo", equipId)
  if equipInfo then
    local score = EA.GetEquipScore(equipOrId, level)
    local details = WU.GetString("EquipName_" .. equipId) .. "<font size=28>" .. WU.GetString("WindowActorEquip_Details", math.floor(score), WU.GetString("Window_Level", equipInfo.requireLevel)) .. "</font>"
    local desc = WU.GetString("EquipDesc_" .. equipId)
    if desc ~= "" then
      details = details .. "<br/><font size=22 color=#5375a9>" .. desc .. "</font>"
    end
    return details
  end
  return ""
end

return EA
