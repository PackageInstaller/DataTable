local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local SummonMonster = class("SummonMonster", Task)

function SummonMonster:Ctor(context, camp, posid, monsterid)
  SummonMonster.super.Ctor(self)
  self._context = context
  self._monsterid = monsterid
  self._camp = camp
  self._posid = posid
  self._entity = nil
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      self._entity = e
      break
    end
  end
  self._utility = BattleECS.Utility.Utility
  self._dataUtility = BattleECS.Utility.DataUtility
  self._config = self._dataUtility.cMonsterCfgTable[self._monsterid]
  if not self._config then
    self._entity = nil
  else
    self._monsterLevel = self._config.npcLevel
  end
end

function SummonMonster:OnStart()
end

function SummonMonster:OnUpdate(deltaTime)
  local TypeComponent = BattleECS.Components.TypeComponent
  if self._entity then
    local totalHp = 0
    local bosshpstage = {}
    local hpConstant = string.split(self._config.hpConstant, ";")
    for i, hp in ipairs(hpConstant) do
      local value = self._utility.CalculateConfigAttrFunc(hp, {
        lv = self._monsterLevel
      })
      totalHp = totalHp + value
      bosshpstage[i] = value
    end
    local camp = self._camp
    local posId = self._posid
    local Enum_Camp = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
    local bean = BattleClientProtocolManager.CreateBean("data.attribute")
    bean.id = self._monsterid
    bean.key = posId
    bean.pos = posId
    bean.camp = camp
    bean.hp = totalHp
    bean.hpmax = totalHp
    bean.atk = self._utility.CalculateConfigAttrFunc(self._config.attackConstant, {
      lv = self._monsterLevel
    })
    bean.def = self._utility.CalculateConfigAttrFunc(self._config.defConstant, {
      lv = self._monsterLevel
    })
    bean.mdef = self._utility.CalculateConfigAttrFunc(self._config.magicDefConstant, {
      lv = self._monsterLevel
    })
    bean.speed = self._utility.CalculateConfigAttrFunc(self._config.speedConstant, {
      lv = self._monsterLevel
    })
    bean.damagereduce = self._utility.CalculateConfigAttrFunc(self._config.damagereduce, {
      lv = self._monsterLevel
    })
    bean.bosshpstage = bosshpstage
    local shapeRecorder = self._dataUtility.cNPCShapeTable[self._config.shapeID]
    bean.assetbundlename = shapeRecorder.assetBundleName
    bean.prefabname = shapeRecorder.prefabName
    bean.level = self._monsterLevel
    for _, v in ipairs(self._config.skillid) do
      table.insert(bean.skilllist, v)
    end
    if Enum_Camp.LeftFighter == camp then
      self._context._battleworld:CreateLeftPlayer(bean)
    elseif Enum_Camp.RightFighter == camp then
      self._context._battleworld:CreateRightPlayer(bean)
    end
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

function SummonMonster:OnEnd()
end

return SummonMonster
