local bc = require("Battle.BattleConst")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEGenerateTargets, Super = System.NewClass("BEGenerateTargets", BattleEffectServer)

function BEGenerateTargets:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEGenerateTargets:Dispose()
  Super.Dispose(self)
end

local function shuffle(list)
  for index = 1, #list do
    local targetIndex = math.random(1, #list)
    local temp = list[index]
    list[index] = list[targetIndex]
    list[targetIndex] = temp
  end
end

function BEGenerateTargets:MockSelectTargets(yieldData)
  local targets = {}
  if yieldData.targetSelectType == bc.TargetSelectType.Card then
    local num = math.random(yieldData.minNum, yieldData.selectNum)
    local targetUids = table.clone(yieldData.targetUids)
    shuffle(targetUids)
    local uids = {}
    for i = 1, num do
      if targetUids and targetUids[i] then
        table.insert(targets, self.battleEngine:GetObj(targetUids[i].uid))
      end
    end
  elseif yieldData.targetSelectType == bc.TargetSelectType.Awaker then
    local selectUid
    if self.battleEngine:IsPVP() then
      local caster = self.battleEngine:GetObj(yieldData.castRoleUid)
      local enemyCamp = bc.BattleCamp:GetEnemyCamp(caster.camp)
      selectUid = self:GetPVPSelectTargetAwaker(enemyCamp, yieldData)
    else
      selectUid = {
        yieldData.targetUids[math.random(#yieldData.targetUids)]
      }
    end
    table.insert(targets, self.battleEngine:GetObj(selectUid))
  elseif yieldData.targetSelectType == bc.TargetSelectType.KeeperSkill then
    local num = math.random(yieldData.minNum, yieldData.selectNum)
    local targetUids = table.clone(yieldData.targetUids)
    shuffle(targetUids)
    local uids = {}
    for i = 1, num do
      if targetUids and targetUids[i] then
        table.insert(targets, self.battleEngine:GetObj(targetUids[i].uid))
      end
    end
  end
  return targets
end

function BEGenerateTargets:DoEffect()
  Super.DoEffect(self)
  local targetType = self.effectConfig.targetType
  if type(targetType) == "table" then
    local awaker = self.battleEngine:GetObj(self.effectConfig.castRoleUid)
    if not awaker:IsRoleType(bc.RoleType.Awaker) then
      targetType = targetType[0]
    else
      local breakSkillLevel, potencyLevel = awaker:GetBreakSkillAndPotencyLevel()
      local matchKey = BattleUtilServer.GetMatchTQ(targetType, breakSkillLevel, potencyLevel)
      targetType = targetType[matchKey]
    end
  end
  local targetExp = self.cmdServer:GenerateTargetsExp(targetType, self.uid)
  if targetExp == bc.YIELD_FLAG then
    if 1 == self.effectConfig.randomNeedSelect then
      local targets = self:MockSelectTargets(self.effectConfig)
      self.cmdServer:SetUpperTargets(targets)
      return true
    else
      return targetExp
    end
  end
  self.cmdServer:SetUpperTargets(targetExp:GetTargetList())
  return true
end

function BEGenerateTargets:OnSelectTargets(msgData)
  print("OnSelectTargets ", table.tostring(msgData), self.uid)
  if msgData.effectUid ~= self.uid then
    self.battleEngine:Error("OnSelectTargets failed: effectUid not math " .. msgData.effectUid .. " " .. self.uid)
    return false
  end
  local effectMgr = self.battleEngine.effectMgr
  local yieldData = effectMgr.yieldData
  local selectTargets = {}
  for _, targetUid in ipairs(yieldData.targetUids) do
    if yieldData.targetSelectType == bc.TargetSelectType.KeeperSkill then
      selectTargets[targetUid.uid] = true
    else
      selectTargets[targetUid] = true
    end
  end
  local uids = msgData.targetUids
  for _, uid in ipairs(uids or {}) do
    if not selectTargets[uid] then
      self.battleEngine:Error("选择目标不匹配!!!")
      return false
    end
  end
  effectMgr:Resume()
  local targets = {}
  local selectIds = {}
  if uids then
    for _, uid in ipairs(uids) do
      local target = self.battleEngine:GetObj(uid)
      table.insert(targets, target)
      if yieldData.targetSelectType == bc.TargetSelectType.KeeperSkill and self.battleEngine:IsPVE() then
        table.insert(selectIds, target.data.tid)
      end
    end
  end
  if yieldData.targetSelectType == bc.TargetSelectType.KeeperSkill and self.battleEngine:IsPVE() then
    local skillConfigId = self.cmdServer and self.cmdServer.skillConfigId
    local stateId = self.cmdServer and self.cmdServer.stateId
    local sourceId = stateId or skillConfigId
    local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    player:OnSelectKeeperSkills(sourceId, selectIds)
  end
  self.cmdServer:SetUpperTargets(targets)
  do return self.AfterEffect end
  return self.AfterEffect, self, targets, self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1), player.OnSelectKeeperSkills, player, sourceId, selectIds, selectIds, target.data.tid
end

return BEGenerateTargets
