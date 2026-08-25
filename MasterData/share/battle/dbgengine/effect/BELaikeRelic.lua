local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local bc = require("Battle.BattleConst")
local BELaikeRelic, Super = System.NewClass("BELaikeRelic", BattleEffectServer)

function BELaikeRelic:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BELaikeRelic:DoEffect()
  Super.DoEffect(self)
  local relicLost = self.battleEngine.battleDT.GetOriginalConstant("C05RelicLost")
  local relicUp = self.battleEngine.battleDT.GetOriginalConstant("C05RelicUp")
  if #relicLost ~= #relicUp then
    self.battleEngine:Error("BELaikeRelic relicLost len not equal relicUp")
    return
  end
  local targetUids = {}
  self.targetRelicList = {}
  self.battleEngine:InfoS("BELaikeRelic {relicLost} {relicUp}", table.tostring(relicLost), table.tostring(relicUp))
  for i, relicId in ipairs(relicLost) do
    local relic = self.battleEngine.relicMgr:TryAddRelic(relicId)
    local upRelic = self.battleEngine.relicMgr:TryAddRelic(relicUp[i])
    if upRelic then
      if relic then
        self.targetRelicList[relic.uid] = relic
        table.insert(targetUids, relic.uid)
      else
        self.targetRelicList[upRelic.uid] = upRelic
        table.insert(targetUids, upRelic.uid)
        if not self.up2LostTid then
          self.up2LostTid = {}
        end
        self.up2LostTid[upRelic.tid] = relicId
      end
    end
  end
  self.battleEngine:InfoS("BELaikeRelic {targetUids} {targetRelicList}", table.tostring(targetUids), table.tostring(self.targetRelicList))
  if 0 == #targetUids then
    self.battleEngine:InfoS("BELaikeRelic skip empty targetUids")
    return true
  end
  local runningEffect = self.battleEngine.effectMgr:GetRunningEffect()
  local data = {
    castRoleUid = self.castRoleUid,
    effectUid = runningEffect.uid,
    selectNum = 1,
    targetUids = targetUids,
    targetRelicList = self.targetRelicList,
    targetSelectType = bc.TargetSelectType.Relic,
    minNum = 1,
    cancelable = runningEffect:GetEffectConfig("cancelable"),
    skillConfigId = self.cmdServer and self.cmdServer.skillConfigId
  }
  self.battleEngine.recordMgr:OnSelectTargets(data)
  self.battleEngine.effectMgr:Yield(BattleCommand.lg_SelectTargets, data)
  return bc.YIELD_FLAG, data
end

function BELaikeRelic:OnSelectTargets(msgData)
  local uids = msgData.targetUids
  if not uids then
    return false
  end
  if #uids > 1 then
    self.battleEngine:Error("BELaikeRelic OnSelectTargets uid too many")
  end
  local uid = uids[1]
  local selectRelic = self.targetRelicList[uid]
  if not selectRelic then
    self.battleEngine:Error("BELaikeRelic OnSelectTargets no uid:" .. uid)
  else
    if self.up2LostTid and self.up2LostTid[selectRelic.tid] then
      self.battleEngine:InfoS("BELaikeRelic RemoveRelic {removeId}", self.up2LostTid[selectRelic.tid])
      self.battleEngine.relicMgr:RemoveRelic(self.up2LostTid[selectRelic.tid], bc.RelicLife.Battle)
    end
    self.battleEngine.relicMgr:AddRelic(self.cmdServer, selectRelic, bc.RelicLife.Battle)
    self.battleEngine:InfoS("BELaikeRelic OnSelectTargets {idMap}", table.tostring(self.up2LostTid))
  end
  self.battleEngine.effectMgr:Resume()
  do return self.AfterEffect end
  return self.AfterEffect, self, "BELaikeRelic OnSelectTargets {idMap}", table.tostring(self.up2LostTid)
end

return BELaikeRelic
