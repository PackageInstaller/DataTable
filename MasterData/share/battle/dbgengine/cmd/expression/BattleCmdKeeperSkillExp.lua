local System = require("System.System")
local BattleCmdBaseExpression = require("Battle.DbgEngine.Cmd.Expression.BattleCmdBaseExpression")
local BattleCmdKeeperSkillExp, Super = System.NewClass("BattleCmdKeeperSkillExp", BattleCmdBaseExpression)

function BattleCmdKeeperSkillExp:ctor(cmdParser, keeperSkillList)
  Super.ctor(self)
  self.cmdParser = cmdParser
  self.keeperSkillList = keeperSkillList
  self:InitGetter(cmdParser.battleEngine.battleDT)
end

local AttrFunc = {
  ID = function(keeperSkill, battleEngine)
    if not keeperSkill then
      return 0
    end
    local cfg = battleEngine.battleDT.Skill[keeperSkill:GetData("tid")]
    return cfg.configData.ID
  end
}

function BattleCmdKeeperSkillExp:GetAttr(attrName)
  local keeperSkill = self.keeperSkillList[1]
  if AttrFunc[attrName] then
    do return AttrFunc[attrName], keeperSkill end
    return AttrFunc[attrName], keeperSkill, self.cmdParser.battleEngine
  end
  return 0
end

function BattleCmdKeeperSkillExp:RemoveByUniqueID(uid)
  local list = {}
  for _, skill in ipairs(self.keeperSkillList) do
    if skill.uid ~= uid then
      table.insert(list, skill)
    end
  end
  do return BattleCmdKeeperSkillExp, self.cmdParser end
  return BattleCmdKeeperSkillExp, self.cmdParser, list, ipairs(self.keeperSkillList)
end

function BattleCmdKeeperSkillExp:GetTargetList()
  return self.targets
end

return BattleCmdKeeperSkillExp
