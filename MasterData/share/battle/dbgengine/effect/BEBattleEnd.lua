local bc = require("Battle.BattleConst")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEBattleEnd, Super = System.NewClass("BEBattleEnd", BattleEffectServer)

function BEBattleEnd:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEBattleEnd:Dispose()
  Super.Dispose(self)
end

function BEBattleEnd:DoEffect()
  self.battleEngine:LogBattle("【战斗结束前】")
  Super.DoEffect(self)
  if self.effectConfig.winCamp then
    self.winCamp = self.effectConfig.winCamp
    self:TryFinishBattle(self.winCamp)
    return true
  end
  local playerList = self.battleEngine.roleMgr:GetAliveRoleListByCamp(bc.BattleCamp.Camp1)
  local monsterRoleList = self.battleEngine.roleMgr:GetAliveRoleListByCamp(bc.BattleCamp.Camp2)
  if 0 == #playerList then
    self:TryFinishBattle(bc.BattleCamp.Camp2)
    self.winCamp = bc.BattleCamp.Camp2
  elseif 0 == #monsterRoleList then
    self:TryFinishBattle(bc.BattleCamp.Camp1)
    self.winCamp = bc.BattleCamp.Camp1
  end
  return true
end

function BEBattleEnd:TryFinishBattle(winCamp)
  local eventData = {
    winCamp = winCamp,
    IsExtraBout = self.battleEngine.boutMgr:GetIsExtraBout()
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.BFBattleEnd, eventData)
end

function BEBattleEnd:EffectEnd()
  if self.winCamp then
    self.battleEngine:SetBattleFinishInfo(self.winCamp, self.effectConfig.isShow)
  end
  self.battleEngine:LogBattle("【战斗结束后】")
  if self.battleEngine:IsPVE() then
    local player1 = self.battleEngine.roleMgr:GetPlayer()
    local hp1 = player1 and player1:GetProperty(bc.BattleProperty.hp) or 0
    local maxHp1 = player1 and player1:GetProperty(bc.BattleProperty.max_hp) or 0
    local boutTotal = self.battleEngine.boutMgr:GetBoutNum()
    self.battleEngine:LogBattleWithTab("最终玩家血量:%s/%s 总回合数 %s", hp1, maxHp1, boutTotal)
  end
  do return Super.EffectEnd end
  return Super.EffectEnd, self, 0, self.battleEngine.boutMgr:GetBoutNum(), self.battleEngine.LogBattleWithTab, self.battleEngine, "最终玩家血量:%s/%s 总回合数 %s", hp1, maxHp1, boutTotal
end

return BEBattleEnd
