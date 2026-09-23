-- 世界树武器技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill923800301 = oo.class(SkillBase)
function Skill923800301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill923800301:DoSkill(caster, target, data)
	-- 923800301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[923800301], caster, self.card, data, 923800301)
end
-- 行动结束2
function Skill923800301:OnActionOver2(caster, target, data)
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
	-- 923800305
	local count923800305 = SkillApi:BuffCount(self, caster, target,3,4,923800301)
	-- 923800304
	if SkillJudger:Equal(self, caster, target, true,count923800305,1) then
	else
		return
	end
	-- 923800302
	self:DelBufferTypeForce(SkillEffect[923800302], caster, self.card, data, 923800301)
	-- 923800303
	local targets = SkillFilter:MinAttr(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[923800303], caster, target, data, 923800601)
	end
end
