local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BECustomizedExecuteCmd, Super = System.NewClass("BECustomizedExecuteCmd", BattleEffectServer)

function BECustomizedExecuteCmd:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BECustomizedExecuteCmd:Dispose()
  Super.Dispose(self)
end

function BECustomizedExecuteCmd:DoEffect()
  Super.DoEffect(self)
  local executeCmdId = self.params[1]
  local exeTimes = self.params[2] or 1
  if not executeCmdId or not self.cmdServer then
    return false
  end
  local childArgs = {}
  for i = 3, #self.params do
    table.insert(childArgs, self.params[i])
  end
  local cmdCfg = self.battleEngine.battleDT.Cmd[executeCmdId]
  self.battleEngine:LogBattleWithTab("（执行内容：%s  共%s次）", cmdCfg.CnID, exeTimes)
  for _ = 1, exeTimes do
    local childCmdServer = self.cmdServer:CreateChildCmdServer(childArgs)
    childCmdServer:SetUpperTargets(self.targets)
    local effectList = childCmdServer:GenerateEffectList(executeCmdId)
    for _, effectObj in ipairs(effectList) do
      effectObj:PreTrigger(self.cmdServer.triggerData)
    end
  end
  return true
end

return BECustomizedExecuteCmd
