

local acMgr = AutoChessManager.instance()
---@type Vector3
local temp_v3 = Vector3.zero
---@class Skill_Default
local Skill = class("Skill_Default")

---技能开始
---@param skill AutoChessSkill
---@param targetId int?
---@param releastPos Vector3?
function Skill:OnStart(skill, targetId, releastPos)

	local animName = skill.skillCfg.animaName
	if not string.isNullOrEmpty(animName) then
		skill.owner:PlayAnim(animName)
	end
    local targetPos = temp_v3
    targetPos:Set(skill.releasePos:Get())
    if targetPos:SqrMagnitude() > 1e-10 then
        local ownPos = skill.owner:GetPosition()
        targetPos:Sub(ownPos)
        targetPos.y = 0
        targetPos:SetNormalize()
        skill.owner:SetRotation(targetPos)
    end
end


function Skill:OnUpdate(skill, dt)

end

---技能开始攻击
---@param skill AutoChessSkill
function Skill:OnExecuteSkillEffect(skill)
    
end

function Skill:OnComplete(skill)


   
end

function Skill:OnBreak(skill)


   
end


return Skill
