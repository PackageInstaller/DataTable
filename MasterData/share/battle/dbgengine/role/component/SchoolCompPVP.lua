local System = require("System.System")
local BattleComponent = require("Battle.Ecs.BattleComponent")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local SchoolCompPVP, Super = System.NewClass("SchoolCompPVP", BattleComponent)

function SchoolCompPVP:ctor(entity, battleEngine)
  Super.ctor(self, entity)
  self.role = entity
  self.battleEngine = battleEngine
  self.schoolConfigId = self.role:GetData("schoolConfigId")
end

function SchoolCompPVP:AddSchoolState(schoolConfigId)
  local DT = self.battleEngine.battleDT
  local schoolConfig = DT.SchoolConfig[schoolConfigId]
  if schoolConfig.PVPStateList == nil then
    return
  end
  for _, stateId in ipairs(schoolConfig.PVPStateList) do
    if self.battleEngine.stateMgr:GetState(self.role, stateId) then
    else
      local createArgs = {
        stateId = stateId,
        castRoleUid = self.role.uid,
        stateParams = schoolConfig.StatePara
      }
      self.battleEngine.stateMgr:CreateState(self.role, createArgs)
    end
  end
end

function SchoolCompPVP:InitSchoolState()
  self:AddSchoolState(self.schoolConfigId)
end

function SchoolCompPVP:GetSchoolArgs()
  local DT = self.battleEngine.battleDT
  local schoolConfig = DT.SchoolConfig[self.schoolConfigId]
  local ctorData = {
    castRoleUid = self.role.uid
  }
  local BattleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")
  local cmdParser = BattleCmdParser(self.battleEngine, ctorData)
  local params = cmdParser:GetValueByCmdList(schoolConfig.StatePara)
  print("UpdateSchoolArgs", table.tostring(params))
  for i, v in ipairs(params) do
    if type(v) == "number" then
      params[i] = math.ceil(v)
    end
  end
  return params
end

function SchoolCompPVP:UpdateSchoolArgs()
  local schoolArgs = self:GetSchoolArgs()
  self.battleEngine.recordMgr:OnUpdateSchoolArgs(self.role.uid, schoolArgs)
end

return SchoolCompPVP
