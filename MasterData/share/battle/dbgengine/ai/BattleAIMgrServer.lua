local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleAIMgrServer, Super = System.NewClass("BattleAIMgrServer", BattleEngineComponent)

function BattleAIMgrServer:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.curActIndex = 0
end

function BattleAIMgrServer.SortMonster(monsterA, monsterB)
  if math.abs(monsterA:GetBattleFieldPos()) < math.abs(monsterB:GetBattleFieldPos()) then
    return true
  end
  return false
end

function BattleAIMgrServer:StartMonsterAI()
  self.monsterRoleList = self.battleEngine.roleMgr:GetAliveRoleListByCamp(bc.BattleCamp.Camp2)
  table.sort(self.monsterRoleList, BattleAIMgrServer.SortMonster)
  self:NextMonsterAct()
end

function BattleAIMgrServer:NextMonsterAct()
  self.curActIndex = self.curActIndex + 1
  if self.curActIndex > #self.monsterRoleList then
    self.battleEngine.boutMgr:EndBout()
    self.curActIndex = 0
    return
  end
  local curMonster = self.monsterRoleList[self.curActIndex]
  
  local function preFunc()
    curMonster.monsterBehaviorComp:ActByIntention()
  end
  
  local finishCb = {
    func = self.NextMonsterAct,
    target = self,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleAIMgrServer:OnSnapShot()
end

function BattleAIMgrServer:OnRecover(data)
  self.curActIndex = 0
end

return BattleAIMgrServer
