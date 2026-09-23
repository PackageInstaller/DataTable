-- 克拉肯-狂暴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911210801 = oo.class(SkillBase)
function Skill911210801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill911210801:OnActionOver2(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 911210210
	self:CallOwnerSkill(SkillEffect[911210210], caster, self.card, data, 911200201)
	-- 93001
	self:ResetCD(SkillEffect[93001], caster, target, data, 2)
end
