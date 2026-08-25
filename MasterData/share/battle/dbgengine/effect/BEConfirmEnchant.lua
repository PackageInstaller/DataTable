local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEConfirmEnchant, Super = System.NewClass("BEConfirmEnchant", BattleEffectServer)

function BEConfirmEnchant:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEConfirmEnchant:DoEffect()
  Super.DoEffect(self)
  local enchantTid = self.params[1]
  local stateMgr = self.battleEngine.stateMgr
  local DT = self.battleEngine.battleDT
  local castRoleUid = self.cmdServer.castRoleUid
  local cmdParser = self.cmdServer.cmdParser
  for _, card in ipairs(self.targets) do
    cmdParser:PutEnchant(card, enchantTid)
  end
  return true
end

return BEConfirmEnchant
