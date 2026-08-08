

---@class CoveSkill
---@field skillId integer 技能ID
---@field hurt integer 伤害
---@field cd number cd时间
---@field backSwingTime number 后摇时间
---@field mpCost integer 消耗蓝量
---@field priority integer 释放优先级
---@field releaseTime number 上次释放时间


---@class CoveSkillCtrl
local CoveSkillCtrl = class("CoveSkillCtrl")

function CoveSkillCtrl:ctor()
    ---@type CoveSkill[]
    self.skillTab = nil
    ---@type integer[]
    self.skillPriorityTab = nil
end

function CoveSkillCtrl:ResetSkill(skillInfo)
 ---@type CoveSkill[]
    self.skillTab = {}
    ---@type integer[]
    self.skillPriorityTab = {}
    for i = 1, #skillInfo do
        local info = skillInfo[i]
        ---@type CoveSkill
        local skillData = {
            skillId = info[1],
            priority = info[2],
            hurt = info[3],
            cd = info[4],
            backSwingTime = info[5],
            mpCost = info[6],
            releaseTime = 0,
        }
        self.skillTab[skillData.skillId] = skillData
        table.insert(self.skillPriorityTab, skillData.skillId)
    end

    table.sort(self.skillPriorityTab, function(a, b)
        local aInfo = self.skillTab[a]
        local bInfo = self.skillTab[b]
        if aInfo == nil then
           return false 
        end
        if bInfo == nil then
           return true 
        end
        if aInfo.priority ~= bInfo.priority then
            return aInfo.priority > bInfo.priority 
        end
        return aInfo.skillId < bInfo.skillId
    end)
end

---@return CoveSkill?
function CoveSkillCtrl:GetSkillInfo(skillId)
    local skillData = self.skillTab[skillId]
    return skillData
end

function CoveSkillCtrl:CanUseSkillId(skillId, mp)
    local skillData = self.skillTab[skillId]
    if skillData == nil then
       return false 
    end
    local time = Time.time
    if time <= skillData.releaseTime + skillData.cd then
        return false
    end
    if mp < skillData.mpCost then
       return false 
    end
    return true
end


---获取可以使用的技能id
---@param mp integer
---@return integer
function CoveSkillCtrl:GetCanUseSkillId(mp)
    for i = 1, #self.skillPriorityTab do
        local skillId = self.skillPriorityTab[i]
        if self:CanUseSkillId(skillId, mp) then
            return skillId
        end
    end
    return 0
end


---使用技能
---@param skillId integer
---@return boolean
function CoveSkillCtrl:UseSkill(skillId)
    local skillData = self.skillTab[skillId]
    if skillData == nil then
       return false 
    end
    skillData.releaseTime = Time.time
    return true
end

return CoveSkillCtrl



