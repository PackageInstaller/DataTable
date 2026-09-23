-- 电击火花
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4400705 = oo.class(SkillBase)
function Skill4400705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4400705:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8438
	local count38 = SkillApi:BuffCount(self, caster, target,2,3,3009)
	-- 8121
	if SkillJudger:Greater(self, caster, self.card, true,count38,0) then
	else
		return
	end
	-- 4400705
	self:AddBuff(SkillEffect[4400705], caster, target, data, 4400705)
end
