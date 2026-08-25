local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEChangeMonsterHpNum, Super = System.NewClass("BEChangeMonsterHpNum", BattleEffectServer)

function BEChangeMonsterHpNum:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeMonsterHpNum:Dispose()
  Super.Dispose(self)
end

function BEChangeMonsterHpNum:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local changeNum = tonumber(self.params[1]) or 0
  local ignoreLimit = 1 == self.params[2]
  for _, target in ipairs(targets) do
    if not target:IsRoleType(bc.RoleType.Monster) then
    elseif changeNum > 0 then
      target:AddHpNum(changeNum, ignoreLimit)
    elseif changeNum < 0 then
      target:SubHpNum(-changeNum)
    end
  end
  return true
end

return BEChangeMonsterHpNum
