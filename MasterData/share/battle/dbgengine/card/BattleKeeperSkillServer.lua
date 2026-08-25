local System = require("System.System")
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local BattleEntity = require("Battle.Ecs.BattleEntity")
local BattleKeeperSkillData = require("Battle.DbgEngine.DataCenter.BattleKeeperSkillData")
local BattleKeeperSkillServer, Super = System.NewClass("BattleKeeperSkillServer", BattleEntity)

function BattleKeeperSkillServer:ctor(battleEngine, config)
  Super.ctor(self)
  self.battleEngine = battleEngine
  self.data = BattleKeeperSkillData.Create(config)
  self.data.uid = battleEngine:GenObjUid(self, config.uid)
  self.uid = self.data.uid
  self:InitByConfigId(config.tid)
end

function BattleKeeperSkillServer:GetData(key)
  return self.data[key]
end

function BattleKeeperSkillServer:InitByConfigId(tid)
  local camp = self:GetData("camp")
  local player = self.battleEngine.roleMgr:GetPlayer(camp)
  self.configData = self.battleEngine.battleDT.Skill[tid]
  local cmdCtorData = {}
  cmdCtorData.skillLevel = 1
  cmdCtorData.skillConfigId = self:GetData("tid")
  cmdCtorData.cmdId = self:GetCmdID()
  cmdCtorData.castRoleUid = player.uid
  self.cmdServer = BattleCmdServer(self.battleEngine, cmdCtorData)
  if self.configData.PreCmd then
    local preData = {}
    preData.skillLevel = 1
    preData.skillConfigId = self:GetData("tid")
    preData.cmdId = self:GetPreCmdID()
    preData.castRoleUid = player.uid
    self.preCmdServer = BattleCmdServer(self.battleEngine, preData)
  end
end

function BattleKeeperSkillServer:GetClientInfo()
  local _, descArgs = self.cmdServer:GetSkillArgs()
  local data = {
    tid = self.data.tid,
    uid = self.data.uid,
    descArgs = descArgs
  }
  return data
end

function BattleKeeperSkillServer:GetID()
  return self.configData.ID
end

function BattleKeeperSkillServer:GetCmdID()
  if self.configData.IsPVP then
    local camp = self:GetData("camp")
    local player = self.battleEngine.roleMgr:GetPlayer(camp)
    local ctorData = {
      castRoleUid = player.uid,
      skillConfigId = self:GetID(),
      skillLevel = 1
    }
    do return self.battleEngine.GetValByCondList, self.battleEngine, ctorData, (self:GetID()) end
    return self.battleEngine.GetValByCondList, self.battleEngine, ctorData, self:GetID(), "CmdList"
  end
  return self.configData.CmdList
end

function BattleKeeperSkillServer:GetPreCmdID()
  if self.configData.IsPVP then
    local camp = self:GetData("camp")
    local player = self.battleEngine.roleMgr:GetPlayer(camp)
    local ctorData = {
      castRoleUid = player.uid,
      skillConfigId = self:GetID(),
      skillLevel = 1
    }
    do return self.battleEngine.GetValByCondList, self.battleEngine, ctorData, (self:GetID()) end
    return self.battleEngine.GetValByCondList, self.battleEngine, ctorData, self:GetID(), "PreCmd"
  end
  return self.configData.PreCmd
end

function BattleKeeperSkillServer:IsRoleType()
  return false
end

function BattleKeeperSkillServer:GetCmdServer()
  return self.cmdServer
end

function BattleKeeperSkillServer:GetCmdTarget()
  local camp = self:GetData("camp")
  local player = self.battleEngine.roleMgr:GetPlayer(camp)
  local castRoleUid = player.uid
  local skillId = self:GetID()
  local skillLevel = 1
  do return self.battleEngine.GetSkillTargetType, self.battleEngine, castRoleUid, skillId end
  return self.battleEngine.GetSkillTargetType, self.battleEngine, castRoleUid, skillId, skillLevel
end

function BattleKeeperSkillServer:ClearCmdServerStats()
  if self.preCmdServer then
    self.preCmdServer:ClearStats()
  end
  if self.cmdServer then
    self.cmdServer:ClearStats()
  end
end

return BattleKeeperSkillServer
