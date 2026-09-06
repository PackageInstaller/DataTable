local CUniqueEquipItem = BeanManager.GetTableByName("item.cuniqueequipitem")
local CUniqueEquipCfg = BeanManager.GetTableByName("equip.cuniqueequipcfg")
local Item = require("logic.manager.experimental.types.item")
local UniqueEquip = strictclass("UniqueEquip", Item)

function UniqueEquip:Ctor(id)
  UniqueEquip.super.Ctor(self, id)
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
      if record.level > self._maxLevel then
        self._maxLevel = record.level
      end
    end
  end
  for k, v in pairs(levelUpRecords) do
    table.insert(self._levelUpRecordList, v)
  end
  table.sort(self._levelUpRecordList, function(a, b)
    return a.level < b.level
  end)
end

function UniqueEquip:GetRoleId()
  return self._uniqueEquipItemRecord.roleid
end

function UniqueEquip:GetInitAttrs()
  local map = {}
  local record = self._levelUpRecordList[1]
  if record then
    for i, v in ipairs(record.attrid) do
      local value = record.attrnum[i]
      if value ~= 0 then
        map[v] = value
      end
    end
  else
    LogErrorFormat("UniqueEquip", "uniqueEquip with id %s is not exist in cuniqueequipcfg", self._itemId)
  end
  return map
end

function UniqueEquip:GetIndexByAttrId(attrId)
  local record = self._levelUpRecordList[1]
  if record then
    for i, v in ipairs(record.attrid) do
      if attrId == v then
        return i
      end
    end
  else
    LogErrorFormat("UniqueEquip", "uniqueEquip with id %s is not exist in cuniqueequipcfg", self._itemId)
  end
end

function UniqueEquip:GetSkillIdByLevel(level)
  local record = self._levelUpRecordList[level]
  if record then
    if record.skillid ~= 0 then
      return record.skillid
    end
  else
    LogError("UniqueEquip", "level error.")
  end
end

function UniqueEquip:GetNextLvStrengthenSkillByLevel(level)
  if level >= self._maxLevel then
    return
  end
  for i, v in ipairs(self._levelUpRecordList) do
    if level < i and v.skillid ~= 0 then
      return i
    end
  end
end

function UniqueEquip:GetCurShowSkillIdByLevel(level)
  local skillid
  for i, v in ipairs(self._levelUpRecordList) do
    if i <= level then
      if v.skillid ~= 0 then
        skillid = v.skillid
      end
    else
      break
    end
  end
  return skillid
end

function UniqueEquip:GetNextLevelCostItemList(level)
  local itemList = {}
  if level < self._maxLevel then
    local record = self._levelUpRecordList[level]
    if record then
      for i, v in ipairs(record.itemId) do
        table.insert(itemList, {
          itemId = v,
          itemNum = record.itemNum[i]
        })
      end
    else
      LogError("UniqueEquip", "level error.")
    end
  end
  return itemList
end

function UniqueEquip:GetNextLevelCostManaNum(level)
  if level < self._maxLevel then
    local record = self._levelUpRecordList[level]
    if record then
      return record.mana
    else
      LogError("UniqueEquip", "level error.")
    end
  end
  return 0
end

function UniqueEquip:GetMaxLevel()
  return self._maxLevel
end

function UniqueEquip:GetSkillList()
  local list = {}
  for i, v in ipairs(self._levelUpRecordList) do
    if v.skillid ~= 0 then
      table.insert(list, {
        uniqueEquipLv = i,
        skillId = v.skillid
      })
    end
  end
  return list
end

function UniqueEquip:GetExtraSkillDestribeByLevel(level)
  local record = self._levelUpRecordList[level]
  if record then
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(self:GetRoleId())
    local evolution = 0
    if role then
      evolution = role:GetEvolution()
    end
    if evolution == 0 then
      return TextManager.GetText(record.noevolutiontext)
    else
      local str = TextManager.GetText(record.evolutiontext)
      local paramsStr = record.evolutionnum[evolution + 1]
      local params = string.split(paramsStr, ";")
      for i, v in ipairs(params) do
        str = string.gsub(str, "%$parameter1%$", v, 1)
      end
      return str
    end
  else
    LogError("UniqueEquip", "level error.")
  end
end

function UniqueEquip:GetUnlockJumpType()
  return self._uniqueEquipItemRecord.unlockjump
end

return UniqueEquip
