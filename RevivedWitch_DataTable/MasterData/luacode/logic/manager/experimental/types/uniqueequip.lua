-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/uniqueequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CUniqueEquipItem = (BeanManager.GetTableByName)("item.cuniqueequipitem")
local CUniqueEquipCfg = (BeanManager.GetTableByName)("equip.cuniqueequipcfg")
local Item = require("logic.manager.experimental.types.item")
local UniqueEquip = strictclass("UniqueEquip", Item)
UniqueEquip.Ctor = function(self, id)
  -- function num : 0_0 , upvalues : UniqueEquip, CUniqueEquipItem, _ENV, CUniqueEquipCfg
  ((UniqueEquip.super).Ctor)(self, id)
  self._uniqueEquipItemRecord = CUniqueEquipItem:GetRecorder(self._itemId)
  if not self._uniqueEquipItemRecord then
    LogErrorFormat("UniqueEquip", "uniqueEquip with id %s is not exist in cuniqueequipitem", self._itemId)
  end
  self._maxLevel = 0
  self._levelUpRecordList = {}
  local levelUpRecords = {}
  local allIds = CUniqueEquipCfg:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CUniqueEquipCfg:GetRecorder(allIds[i])
    if record.UniqueEquipid == self._itemId then
      levelUpRecords[record.level] = record
      if self._maxLevel < record.level then
        self._maxLevel = record.level
      end
    end
  end
  for k,v in pairs(levelUpRecords) do
    (table.insert)(self._levelUpRecordList, v)
  end
  ;
  (table.sort)(self._levelUpRecordList, function(a, b)
    -- function num : 0_0_0
    do return a.level < b.level end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

UniqueEquip.GetRoleId = function(self)
  -- function num : 0_1
  return (self._uniqueEquipItemRecord).roleid
end

UniqueEquip.GetInitAttrs = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local map = {}
  local record = (self._levelUpRecordList)[1]
  if record then
    for i,v in ipairs(record.attrid) do
      local value = (record.attrnum)[i]
      if value ~= 0 then
        map[v] = value
      end
    end
  else
    do
      LogErrorFormat("UniqueEquip", "uniqueEquip with id %s is not exist in cuniqueequipcfg", self._itemId)
      return map
    end
  end
end

UniqueEquip.GetIndexByAttrId = function(self, attrId)
  -- function num : 0_3 , upvalues : _ENV
  local record = (self._levelUpRecordList)[1]
  if record then
    for i,v in ipairs(record.attrid) do
      if attrId == v then
        return i
      end
    end
  else
    do
      LogErrorFormat("UniqueEquip", "uniqueEquip with id %s is not exist in cuniqueequipcfg", self._itemId)
    end
  end
end

UniqueEquip.GetSkillIdByLevel = function(self, level)
  -- function num : 0_4 , upvalues : _ENV
  local record = (self._levelUpRecordList)[level]
  -- DECOMPILER ERROR at PC8: Unhandled construct in 'MakeBoolean' P1

  if record and record.skillid ~= 0 then
    return record.skillid
  end
  LogError("UniqueEquip", "level error.")
end

UniqueEquip.GetNextLvStrengthenSkillByLevel = function(self, level)
  -- function num : 0_5 , upvalues : _ENV
  if self._maxLevel <= level then
    return 
  end
  for i,v in ipairs(self._levelUpRecordList) do
    if level < i and v.skillid ~= 0 then
      return i
    end
  end
end

UniqueEquip.GetCurShowSkillIdByLevel = function(self, level)
  -- function num : 0_6 , upvalues : _ENV
  local skillid = nil
  for i,v in ipairs(self._levelUpRecordList) do
    if i <= level then
      if v.skillid ~= 0 then
        skillid = v.skillid
      end
    else
      break
    end
  end
  do
    return skillid
  end
end

UniqueEquip.GetNextLevelCostItemList = function(self, level)
  -- function num : 0_7 , upvalues : _ENV
  local itemList = {}
  if level < self._maxLevel then
    local record = (self._levelUpRecordList)[level]
    if record then
      for i,v in ipairs(record.itemId) do
        (table.insert)(itemList, {itemId = v, itemNum = (record.itemNum)[i]})
      end
    else
      do
        do
          LogError("UniqueEquip", "level error.")
          return itemList
        end
      end
    end
  end
end

UniqueEquip.GetNextLevelCostManaNum = function(self, level)
  -- function num : 0_8 , upvalues : _ENV
  do
    if level < self._maxLevel then
      local record = (self._levelUpRecordList)[level]
      if record then
        return record.mana
      else
        LogError("UniqueEquip", "level error.")
      end
    end
    return 0
  end
end

UniqueEquip.GetMaxLevel = function(self)
  -- function num : 0_9
  return self._maxLevel
end

UniqueEquip.GetSkillList = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local list = {}
  for i,v in ipairs(self._levelUpRecordList) do
    if v.skillid ~= 0 then
      (table.insert)(list, {uniqueEquipLv = i, skillId = v.skillid})
    end
  end
  return list
end

UniqueEquip.GetExtraSkillDestribeByLevel = function(self, level)
  -- function num : 0_11 , upvalues : _ENV
  local record = (self._levelUpRecordList)[level]
  if record then
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(self:GetRoleId())
    local evolution = 0
    if role then
      evolution = role:GetEvolution()
    end
    if evolution == 0 then
      return (TextManager.GetText)(record.noevolutiontext)
    else
      local str = (TextManager.GetText)(record.evolutiontext)
      local paramsStr = (record.evolutionnum)[evolution + 1]
      local params = (string.split)(paramsStr, ";")
      for i,v in ipairs(params) do
        str = (string.gsub)(str, "%$parameter1%$", v, 1)
      end
      return str
    end
  else
    do
      LogError("UniqueEquip", "level error.")
    end
  end
end

UniqueEquip.GetUnlockJumpType = function(self)
  -- function num : 0_12
  return (self._uniqueEquipItemRecord).unlockjump
end

return UniqueEquip

