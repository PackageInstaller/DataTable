-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/summonmonstertype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local SummonMonsterType = class("SummonMonsterType", Task)
SummonMonsterType.Ctor = function(self, context, camp, posid, monstertype, level)
  -- function num : 0_0 , upvalues : SummonMonsterType, _ENV
  ((SummonMonsterType.super).Ctor)(self)
  self._context = context
  self._monsterType = monstertype
  self._camp = camp
  self._posid = posid
  self._entity = nil
  for i,e in ipairs(((self._context)._battleworld)._entitys) do
    if e._entityId == (self._context)._entityId then
      self._entity = e
      break
    end
  end
  do
    self._monsterid = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._roleID
    self._utility = (BattleECS.Utility).Utility
    self._dataUtility = (BattleECS.Utility).DataUtility
    if level == 0 then
      self._monsterLevel = (((self._dataUtility).cMonsterCfgTable)[self._monsterid]).npcLevel
    else
      self._monsterLevel = level
    end
  end
end

SummonMonsterType.OnStart = function(self)
  -- function num : 0_1
end

SummonMonsterType.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  local TypeComponent = (BattleECS.Components).TypeComponent
  if self._entity then
    local sortMonsterTable = {}
    for _,v in pairs((self._dataUtility).cMonsterCfgTable) do
      (table.insert)(sortMonsterTable, v)
    end
    ;
    (table.sort)(sortMonsterTable, function(a, b)
    -- function num : 0_2_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    for _,record in ipairs(sortMonsterTable) do
      if record.MonsterType == self._monsterType and record.npcLevel == self._monsterLevel then
        local entityLevelNum = ((self._entity):GetComponent(TypeComponent))._level
        local totalHp = 0
        local bosshpstage = {}
        local hpConstant = (string.split)(record.hpConstant, ";")
        for i,hp in ipairs(hpConstant) do
          local value = ((self._utility).CalculateConfigAttrFunc)(hp, {lv = entityLevelNum})
          totalHp = totalHp + value
          bosshpstage[i] = value
        end
        local camp = self._camp
        local posId = self._posid
        local Enum_Camp = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
        local bean = (BattleClientProtocolManager.CreateBean)("data.attribute")
        bean.id = record.id
        bean.key = posId
        bean.pos = posId
        bean.camp = camp
        bean.hp = totalHp
        bean.hpmax = totalHp
        bean.atk = ((self._utility).CalculateConfigAttrFunc)(record.attackConstant, {lv = entityLevelNum})
        bean.def = ((self._utility).CalculateConfigAttrFunc)(record.defConstant, {lv = entityLevelNum})
        bean.mdef = ((self._utility).CalculateConfigAttrFunc)(record.magicDefConstant, {lv = entityLevelNum})
        bean.speed = ((self._utility).CalculateConfigAttrFunc)(record.speedConstant, {lv = entityLevelNum})
        bean.damagereduce = ((self._utility).CalculateConfigAttrFunc)(record.damagereduce, {lv = entityLevelNum})
        bean.bosshpstage = bosshpstage
        local shapeRecorder = ((self._dataUtility).cNPCShapeTable)[record.shapeID]
        bean.assetbundlename = shapeRecorder.assetBundleName
        bean.prefabname = shapeRecorder.prefabName
        bean.level = self._monsterLevel
        for _,v in ipairs(record.skillid) do
          (table.insert)(bean.skilllist, v)
        end
        if Enum_Camp.LeftFighter == camp then
          ((self._context)._battleworld):CreateLeftPlayer(bean)
        else
          if Enum_Camp.RightFighter == camp then
            ((self._context)._battleworld):CreateRightPlayer(bean)
          end
        end
        return TaskStatus.Success
      end
    end
  end
  do
    return TaskStatus.Failure
  end
end

SummonMonsterType.OnEnd = function(self)
  -- function num : 0_3
end

return SummonMonsterType

