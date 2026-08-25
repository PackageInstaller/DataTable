local System = require("System.System")
local BattleUnitBase = require("Battle.DbgEngine.Role.BattleUnitBase")
local MonsterBehaviorComp = require("Battle.DbgEngine.Role.Component.MonsterBehaviorComp")
local BattleConst = require("Battle.BattleConst")
local PathUtils = require("Battle.Util.PathUtils")
local BP = BattleConst.BattleProperty
local BattleUnitMonster, Super = System.NewClass("BattleUnitMonster", BattleUnitBase)

function BattleUnitMonster:OnInit()
  self.roleType = BattleConst.RoleType.Monster
  local DT = self.battleEngine.battleDT
  self.configData = DT.MonsterConfig[self.tid]
  self.monsterBehaviorComp = self:AddBattleComponent(MonsterBehaviorComp, self.battleEngine)
  self.tagManager:InitTagState()
  self:InitTagConfig()
end

function BattleUnitMonster:InitTagConfig()
  local tag = self.configData.MonsterTag
  if not tag then
    return
  end
  for _, tag in ipairs(tag) do
    self.tagManager:AddTag(tag)
  end
end

function BattleUnitMonster:GetSpineName()
  local animIdx = self.data.animIdx or 0
  local animationConfig, animationId
  if 0 == animIdx then
    if self.battleEngine:IsPVP() then
      animationId = self.configData.PVPAnimationID
    else
      animationId = self.configData.AnimationID
    end
  else
    local exAnimations = self.configData.ExAnimations or {}
    animationId = exAnimations[animIdx]
  end
  if not animationId then
    return
  end
  animationConfig = self.battleEngine.battleDT.AnimationConfig[animationId]
  if not animationConfig then
    return
  end
  do return PathUtils.GetBaseName end
  return PathUtils.GetBaseName, animationConfig.spineName
end

function BattleUnitMonster:OnAfterInit_PVE()
  local stateMgr = self.battleEngine.stateMgr
  if self.affixList and next(self.affixList) then
    for _, stateId in pairs(self.affixList) do
      local createArgs = {
        stateId = stateId,
        castRoleUid = self.uid,
        layer = 1
      }
      stateMgr:CreateState(self, createArgs)
    end
  end
end

function BattleUnitMonster:HasHpBar()
  return true
end

function BattleUnitMonster:GetBattleLogName()
  local cfg = self.battleEngine.battleDT.MonsterConfig[self.tid]
  do return string.format, "[怪物-位置%s-%s]", (self:GetBattleFieldPos()) end
  return string.format, "[怪物-位置%s-%s]", self:GetBattleFieldPos(), cfg.CnID
end

function BattleUnitMonster:OnBoutBegin_PVE()
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  if self.camp ~= curCamp then
    return
  end
  local blockReserverValue = self:GetProperty(BP.block_reserve) or 0
  if blockReserverValue <= 0 then
    local extraData = {
      castRoleUid = self.uid,
      reason = BattleConst.PropertyChangeReason.BlockReset
    }
    self.property:SetProperty(BP.block, 0, extraData)
  end
end

function BattleUnitMonster:GetID()
  return self.configData.ID
end

function BattleUnitMonster:GetType()
  return self.configData.BattleTag
end

function BattleUnitMonster:GetCfgCol(name)
  return self.configData[name]
end

function BattleUnitMonster:PreCheckDeathEvent()
  return true
end

function BattleUnitMonster:NeedAfterPhase()
  return true
end

function BattleUnitMonster:GetTargetType()
  return BattleConst.ObjType.TypeMonster
end

function BattleUnitMonster:GetMaxHpNum()
  return self.data.maxHpNum or 1
end

function BattleUnitMonster:GetHpNum()
  return self.data.hpNum
end

function BattleUnitMonster:SubHpNum(num)
  self.data.hpNum = math.max(0, self.data.hpNum - num)
  self.battleEngine.recordMgr:OnMonsterHpNumChange(self.uid, self.data.hpNum)
end

function BattleUnitMonster:AddHpNum(num, ignoreLimit)
  local hpNum = self.data.hpNum + num
  if not ignoreLimit then
    local DT = self.battleEngine.battleDT
    local configData = DT.MonsterConfig[self.tid]
    local hpNumLimit = (configData and configData.MonsterHpNum or 1) - 1
    if hpNum > hpNumLimit then
      hpNum = hpNumLimit
    end
  end
  self.data.hpNum = hpNum
  self.data.maxHpNum = math.max(self.data.maxHpNum or 1, hpNum or 0)
  self.battleEngine.recordMgr:OnMonsterHpNumChange(self.uid, hpNum)
end

function BattleUnitMonster:ChangeName(showNameKey)
  self.data.showName = showNameKey
  self.battleEngine.recordMgr:OnMonsterChangeName(self.uid, showNameKey)
end

function BattleUnitMonster:OnSnapShot()
  local baseSnapshot = Super.OnSnapShot(self)
  return baseSnapshot
end

function BattleUnitMonster:OnRecover(snapshotData)
  Super.OnRecover(self, snapshotData)
end

return BattleUnitMonster
