local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local bc = require("Battle.BattleConst")
local BEExecuteCmdByIndex, Super = System.NewClass("BEExecuteCmdByIndex", BattleEffectServer)

function BEExecuteCmdByIndex:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEExecuteCmdByIndex:Dispose()
  Super.Dispose(self)
end

function BEExecuteCmdByIndex:DoEffect()
  Super.DoEffect(self)
  local index = self.params[1]
  local card = self.battleEngine:GetObj(self.cmdServer.cardUid)
  if not card then
    return false
  end
  local composeCardUids = card.data.composeCardUids
  if not composeCardUids then
    return false
  end
  local composeCardUid = composeCardUids[index]
  if not composeCardUid then
    return false
  end
  local composeCard = self.battleEngine:GetObj(composeCardUid)
  local skillCfg = self.battleEngine.battleDT.Skill[composeCard.tid]
  if not skillCfg then
    return false
  end
  local cmdCtorData = {}
  cmdCtorData.skillLevel = 1
  cmdCtorData.skillConfigId = card.tid
  if skillCfg.IsPVP then
    local ctorData = {
      castRoleUid = card.owner.uid,
      skillConfigId = card.tid,
      skillLevel = 1
    }
    cmdCtorData.cmdId = self.battleEngine:GetValByCondList(ctorData, card.tid, "CmdList")
  else
    cmdCtorData.cmdId = skillCfg.CmdList
  end
  cmdCtorData.castRoleUid = self.cmdServer.castRoleUid
  cmdCtorData.configPara = composeCard.cardArgs
  local cmdServer = BattleCmdServer(self.battleEngine, cmdCtorData)
  cmdServer.parentCmdServer = self.cmdServer
  local effectList = cmdServer:GenerateEffectList(cmdCtorData.cmdId)
  for _, effectObj in ipairs(effectList) do
    effectObj:PreTrigger(self.cmdServer.triggerData)
  end
  return true
end

return BEExecuteCmdByIndex
