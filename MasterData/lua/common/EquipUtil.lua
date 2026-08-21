local WU, DB = require("Common/WindowUtil")()
local U = require("Common/Util")
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local EU = {
  QualityColorTable = {
    [0] = 2325785855,
    [1] = 229212671,
    [2] = 10682367,
    [3] = 3194417919,
    [4] = 4288413951,
    [5] = 4234043135
  },
  QualityColorTableLight = {
    [0] = 2966347007,
    [1] = 517180927,
    [2] = 1188167679,
    [3] = 3683516415,
    [4] = 4189981951,
    [5] = 4234043135
  },
  EquipPosSpriteNameTable = {
    "equip_pos_1",
    "equip_pos_2",
    "equip_pos_3",
    "equip_pos_4"
  }
}
local m_suitTable
local m_equipMaxLevel = {}

function EU.GetQualityColorString(quality, light)
  local targetTable = fif(light, EU.QualityColorTableLight, EU.QualityColorTable)
  return string.format("#%08X", targetTable[quality] or targetTable[0])
end

function EU.GetQualityColorValue(quality, light)
  local targetTable = fif(light, EU.QualityColorTableLight, EU.QualityColorTable)
  return targetTable[quality] or targetTable[0]
end

function EU.GetEquipQualityById(id)
  local quality = 0
  if id then
    local equipInfo = PB.get("EquipInfo", id)
    if equipInfo then
      quality = equipInfo.quality
    end
  end
  return quality
end

function EU.GetEquipQualityByUid(uid)
  return GetEquipQualityById(DB:GetData("fci/equip/" .. uid).id)
end

function EU.GetEquipRandAttrCount(equip, fromLevel, toLevel)
  local result = 0
  if equip then
    local maxLevel = EU.GetEquipMaxLevel(equip)
    fromLevel = math.max(1, fromLevel or 1)
    toLevel = math.min(maxLevel, toLevel or maxLevel)
    local equipInfo = PB.get("EquipInfo", equip.id)
    if equipInfo then
      for i = fromLevel, toLevel do
        local equipEnhance = PB.get("EquipEnhance", equipInfo.quality, i)
        if equipEnhance.genNewRandAttr then
          result = result + 1
        end
      end
    end
  end
  return result
end

function EU.IsEquipReachMaxLevel(equip)
  local equipInfo = PB.get("EquipInfo", equip.id)
  if equipInfo then
    local equipEnhance = PB.get("EquipEnhance", equipInfo.quality, equip.level + 1)
    return equipEnhance == nil
  end
  return false
end

function EU.GetEquipMaxLevel(equip)
  local equipInfo = PB.get("EquipInfo", equip.id)
  if equipInfo == nil then
    return 0
  end
  if not m_equipMaxLevel[equipInfo.quality] then
    local targetLevel = equip.level or 0
    local equipEnhance = PB.get("EquipEnhance", equipInfo.quality, targetLevel + 1)
    while equipEnhance do
      targetLevel = targetLevel + 1
      equipEnhance = PB.get("EquipEnhance", equipInfo.quality, targetLevel + 1)
    end
    m_equipMaxLevel[equipInfo.quality] = targetLevel
  end
  return m_equipMaxLevel[equipInfo.quality]
end

function EU.GetEquipLevelLimit(equip)
  local playerLevel = DB:GetData("fci/baseinfo/").level
  local playerLevelInitConfig = PB.get("PlayerLevelInitConfig", playerLevel)
  return math.min(playerLevelInitConfig.equipLevelLimit, EU.GetEquipMaxLevel(equip))
end

function EU.ExpSum(quality, fromLv, toLv)
  local expSum = 0
  for i = fromLv, toLv do
    local levelInfo = PB.get("EquipEnhance", quality, i)
    if levelInfo ~= nil then
      expSum = expSum + levelInfo.levelUpExp
    end
  end
  return expSum
end

function EU.SimulateEatExpFood(curLevel, curExp, foodExp, levelLimit, quality)
  local targetLevel = curLevel
  local totalRemainExp = curExp + foodExp
  local targetTotalExp = 0
  local valid = true
  local leftExp
  while valid do
    valid = false
    if levelLimit >= targetLevel then
      local levelInfo = PB.get("EquipEnhance", quality, targetLevel)
      if levelInfo ~= nil then
        targetTotalExp = targetTotalExp + levelInfo.levelUpExp
        totalRemainExp = totalRemainExp - levelInfo.levelUpExp
        leftExp = totalRemainExp
        if 0 <= totalRemainExp then
          if levelLimit > targetLevel then
            targetLevel = targetLevel + 1
            valid = true
          else
            valid = false
          end
        end
      end
    end
  end
  return targetLevel, targetTotalExp, targetLevel == levelLimit, leftExp
end

function EU.TryEnhanceEquip(equip, expAdd)
  local levelLimit = EU.GetEquipLevelLimit(equip)
  local expLeft = equip.curExp + expAdd
  local targetLevel = equip.level
  local equipInfo = PB.get("EquipInfo", equip.id)
  if equipInfo then
    while levelLimit > targetLevel do
      local equipEnhance = PB.get("EquipEnhance", equipInfo.quality, targetLevel)
      if expLeft >= equipEnhance.levelUpExp and levelLimit >= targetLevel + 1 then
        expLeft = expLeft - equipEnhance.levelUpExp
        targetLevel = targetLevel + 1
      else
        break
      end
    end
    local equipEnhance = PB.get("EquipEnhance", equipInfo.quality, targetLevel)
    local expToNextLevel = equipEnhance.levelUpExp
    local expOverflow = math.max(expLeft - expToNextLevel, 0)
    return {
      targetLevel = targetLevel,
      expToNextLevel = expToNextLevel,
      expUsed = expAdd - expOverflow,
      expLeft = expLeft,
      expOverflow = expOverflow
    }
  end
end

function EU.FoodsExp(foods)
  local exp = 0
  if foods then
    for i = 1, #foods do
      exp = exp + foods[i].cnt * foods[i].exp
    end
  end
  return exp
end

function EU.ItemEquipExp(itemId)
  local exp = 0
  if itemId and 0 < itemId then
    local itemInfo = PB.get("ItemInfo", itemId)
    if itemInfo.funcType == PB.enum.ItemFuncType.EquipExp then
      exp = itemInfo.param[1]
    end
  end
  return exp
end

function EU.GetEquipExp(equip)
  local enhanceExp = 0
  local baseExp = 0
  if equip then
    enhanceExp = equip.curExp
    local equipInfo = PB.get("EquipInfo", equip.id)
    if equipInfo then
      baseExp = equipInfo.baseExp
      for i = 1, equip.level - 1 do
        local equipEnhance = PB.get("EquipEnhance", equipInfo.quality, i)
        enhanceExp = enhanceExp + equipEnhance.levelUpExp
      end
    end
  end
  return baseExp, enhanceExp
end

function EU.DecomposedExp(equip)
  local baseExp, enhanceExp = EU.GetEquipExp(equip)
  local totalExp = 0
  local enhanceExpWithLoss = 0
  if equip then
    local equipInfo = PB.get("EquipInfo", equip.id)
    if equipInfo then
      local equipEnhance = PB.get("EquipEnhance", equipInfo.quality, equip.level)
      enhanceExpWithLoss = math.floor(enhanceExp * (1 - equipEnhance.enhanceLostRate / 10000))
      totalExp = enhanceExpWithLoss + baseExp
    end
  end
  return totalExp, enhanceExpWithLoss
end

function EU.DecomposedRes(equip)
  local _, enhanceExpWithloss = EU.DecomposedExp(equip)
  local result
  if 0 < enhanceExpWithloss and equip then
    local equipExpToResource = PB.all("Misc")[1].equipExpToResource
    result = {
      type = equipExpToResource.type,
      id = equipExpToResource.id,
      count = equipExpToResource.count * enhanceExpWithloss
    }
  end
  return result
end

function EU.GetEquips(actor)
  local equips = _ENV["!"]({})
  if actor then
    for _, uid in pairs(actor.bodyEquips) do
      local equip = DB:GetData("fci/equip/" .. uid)
      if equip then
        table.insert(equips, equip)
      else
        warning("Equip", "fci/equip/ doesn't contains bodyEquip. uid:" .. uid .. ", actorId: " .. actor.id)
      end
    end
  end
  return equips
end

function EU.GetEquipsSortedByPos(actor)
  local equips = _ENV["!"]({})
  if actor then
    for i = 0, 3 do
      local uid = actor.bodyEquips[tostring(i)]
      if uid then
        local equip = DB:GetData("fci/equip/" .. uid)
        if equip then
          table.insert(equips, equip)
        else
          warning("Equip", "fci/equip/ doesn't contains bodyEquip. uid:" .. uid .. ", actorId: " .. actor.id)
        end
      end
    end
  end
  return equips
end

function EU.ValidateEquipLevelup(equip)
  local result = false
  local levelLimit = EU.GetEquipLevelLimit(equip)
  if levelLimit <= equip.level then
    WU.ShowHintText(WU.GetString("Window_EquipLevelLimitedByAccountLevel"))
  elseif EU.IsEquipReachMaxLevel(equip) then
    WU.ShowHintText(WU.GetString("Window_EquipLevelUpLimit"))
  else
    result = true
  end
  return result
end

function EU.GetEquipRequireLevel(id)
  local result = 0
  local equipInfo = PB.get("EquipInfo", id)
  if equipInfo then
    result = equipInfo.requireLevel
  end
  return result
end

function EU.GetSuit(equipId)
  if m_suitTable == nil then
    local allSuit = PB.all("EquipSuitAttr")
    m_suitTable = {}
    for _, v in pairs(allSuit) do
      for i = 1, #v.equipId do
        m_suitTable[v.equipId[i]] = v
      end
    end
  end
  return m_suitTable[equipId]
end

function EU.GetSuits(actor)
  local suits = _ENV["!"]({})
  local marks = {}
  if actor then
    for _, equipUid in pairs(actor.bodyEquips) do
      if 0 < equipUid then
        local equip = DB:GetData("fci/equip/" .. equipUid)
        if equip then
          local suit = EU.GetSuit(equip.id)
          if suit and not marks[suit] then
            table.insert(suits, suit)
            marks[suit] = true
          end
        else
          warning("Equip", "fci/equip/ doesn't contains bodyEquip. uid:" .. equipUid .. ", actorId: " .. actor.id)
        end
      end
    end
  end
  return suits
end

function EU.InitEquipMinRequireLevelByPos()
  local equipList = DB:GetData("fci/equip")
  local posMap = {}
  if equipList ~= nil then
    for i = 1, #equipList do
      if equipList[i].actorUid == 0 then
        local equipInfo = PB.get("EquipInfo", equipList[i].id)
        if equipInfo then
          if posMap[equipInfo.pos] == nil or posMap[equipInfo.pos].requireLevel > equipInfo.requireLevel then
            posMap[equipInfo.pos] = {
              uid = equipList[i].uid,
              requireLevel = equipInfo.requireLevel
            }
          end
        else
          error("Equip with id [" .. tostring(equipList[i].id) .. "] was not found in EquipInfo.xlsx")
        end
      end
    end
  end
  DB:SetData("equipMinRequireLevelPosMap", posMap)
end

function EU.HasPosToEquip(actor)
  return #EU.GetAvailableEquipPosList(actor) > 0
end

function EU.GetAvailableEquipPosList(actor)
  local result = {}
  local posMap = DB:GetData("equipMinRequireLevelPosMap")
  if posMap == nil then
    EU.InitEquipMinRequireLevelByPos()
    posMap = DB:GetData("equipMinRequireLevelPosMap")
  end
  if posMap then
    local posList = {
      0,
      1,
      2,
      3
    }
    for _, pos in pairs(posList) do
      local equipUid = actor.bodyEquips[tostring(pos)]
      if (not equipUid or equipUid == 0) and posMap[pos] and posMap[pos].requireLevel <= actor.level then
        table.insert(result, pos)
      end
    end
  end
  return result
end

function EU.CheckEquipOverflow()
  local equips = DB:GetData("fci/equip/")
  if #equips >= PB.index("Misc", 1).maxEquipWarningCount then
    WU.ShowMessageYesNo(WU.GetString("EquipOverflowWarning"), function(result)
      if result == "YES" then
        WU.AcquireWindowAsync("Bag")
      end
    end, WU.GetString("Window_BagDecompose"))
    return true
  end
  return false
end

function EU.IsEquipOpen(equipId)
  local isOpen = false
  local openTime = PB.get("EquipInfo", equipId).openTime
  if openTime == nil or openTime == "" then
    warning("Equipid:" .. tostring(equipId) .. "is lack of opentime")
    isOpen = true
  else
    local equipOpenTime = CS.GameTime.ServerTimeStrToUtc(openTime)
    local now = CS.GameTime.serverUtc
    if equipOpenTime <= now then
      isOpen = true
    end
  end
  return isOpen
end

function EU.SetArmUnNew(list, callback)
  if list == nil then
    list = DB:GetData("fci/arms/")
  end
  if list == nil or #list <= 0 then
    return
  end
  local req = {}
  for k, v in pairs(list) do
    if v.isNew then
      v.isNew = false
      local pattern = {
        type = PB.enum.ResourceType.ResUniqueWeapon,
        idOrUid = v.id
      }
      table.insert(req, pattern)
    end
  end
  if req == nil or #req <= 0 then
    return
  end
  DB:GameRequest("fci/new-flag"):Patch({isNew = false, resInfo = req}, function(resp)
    if callback then
      callback(resp)
    end
  end)
end

function EU.GetArmByType(type, list, defaultSort)
  local arms = list or DB:GetData("fci/arms/")
  if arms == nil or #arms <= 0 then
    return {}
  end
  local clist = {}
  for k, v in pairs(arms) do
    if v.position == type then
      table.insert(clist, v)
    end
  end
  if defaultSort then
    local function customSort(a, b)
      if a.quality ~= b.quality then
        return a.quality > b.quality
      elseif a.level ~= b.level then
        return a.level > b.level
      elseif a.phase ~= b.phase then
        return a.phase > b.phase
      elseif a.id ~= b.id then
        return a.id < b.id
      end
    end
    
    table.sort(clist, customSort)
  end
  return clist
end

return EU
