local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEExecuteCmd, Super = System.NewClass("BEExecuteCmd", BattleEffectServer)

function BEExecuteCmd:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEExecuteCmd:Dispose()
  Super.Dispose(self)
end

function BEExecuteCmd:DoEffect()
  Super.DoEffect(self)
  local executeCmdId = self.params[1]
  local exeTimes = self.params[2] or 1
  if not executeCmdId or not self.cmdServer then
    return false
  end
  self.totalEffectTimes = exeTimes
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self
end

function BEExecuteCmd:__DoMultiEffect()
  local interruptCond = self.effectConfig.interruptCmdCond
  if interruptCond then
    local ret = self.cmdServer:GetValueByCmd(interruptCond)
    if ret then
      return false
    end
  end
  local executeCmdId = self.params[1]
  local childCmdServer = self.cmdServer:CreateChildCmdServer()
  local effectList = childCmdServer:GenerateEffectList(executeCmdId)
  for _, effectObj in ipairs(effectList) do
    effectObj:PreTrigger(self.cmdServer.triggerData)
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

return BEExecuteCmd
