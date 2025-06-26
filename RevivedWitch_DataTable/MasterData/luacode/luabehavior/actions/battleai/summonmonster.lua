-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/summonmonster.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local SummonMonster = class("SummonMonster", Task)
SummonMonster.Ctor = function(self, context, camp, posid, monsterid)
  -- function num : 0_0 , upvalues : SummonMonster, _ENV
  ((SummonMonster.super).Ctor)(self)
  self._context = context
  self._monsterid = monsterid
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
    self._utility = (BattleECS.Utility).Utility
    self._dataUtility = (BattleECS.Utility).DataUtility
  end
end

SummonMonster.OnStart = function(self)
  -- function num : 0_1
end

SummonMonster.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  local TypeComponent = (BattleECS.Components).TypeComponent
  if self._entity then
    local config = ((self._dataUtility).cMonsterCfgTable)[self._monsterid]
    if config then
      local entityLevelNum = ((self._entity):GetComponent(TypeComponent))._level
      local totalHp = 0
      local bosshpstage = {}
      local hpConstant = (string.split)(config.hpConstant, ";")
      for i,hp in ipairs(hpConstant) do
        local value = ((self._utility).CalculateConfigAttrFunc)(hp, {lv = entityLevelNum})
        totalHp = totalHp + value
        bosshpstage[i] = value
      end
      local camp = self._camp
      local posId = self._posid
      local Enum_Camp = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
      local bean = (BattleClientProtocolManager.CreateBean)("data.attribute")
      bean.id = self._monsterid
      bean.key = posId
      bean.pos = posId
      bean.camp = camp
      bean.hp = totalHp
      bean.hpmax = totalHp
      bean.atk = ((self._utility).CalculateConfigAttrFunc)(config.attackConstant, {lv = entityLevelNum})
      bean.def = ((self._utility).CalculateConfigAttrFunc)(config.defConstant, {lv = entityLevelNum})
      bean.mdef = ((self._utility).CalculateConfigAttrFunc)(config.magicDefConstant, {lv = entityLevelNum})
      bean.speed = ((self._utility).CalculateConfigAttrFunc)(config.speedConstant, {lv = entityLevelNum})
      bean.damagereduce = ((self._utility).CalculateConfigAttrFunc)(config.damagereduce, {lv = entityLevelNum})
      bean.bosshpstage = bosshpstage
      local shapeRecorder = ((self._dataUtility).cNPCShapeTable)[config.shapeID]
      bean.assetbundlename = shapeRecorder.assetBundleName
      bean.prefabname = shapeRecorder.prefabName
      bean.level = entityLevelNum
      for _,v in ipairs(config.skillid) do
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
  do
    return TaskStatus.Failure
  end
end

SummonMonster.OnEnd = function(self)
  -- function num : 0_3
end

return SummonMonster

