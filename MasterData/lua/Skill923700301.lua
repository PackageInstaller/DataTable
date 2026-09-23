-- 世界树手技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill923700301 = oo.class(SkillBase)
function Skill923700301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill923700301:DoSkill(caster, target, data)
	-- 923700301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[923700301], caster, self.card, data, 923700301)
end
-- 行动结束2
function Skill923700301:OnActionOver2(caster, target, data)
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
	-- 923700305
	local count923700305 = SkillApi:BuffCount(self, caster, target,3,4,923700301)
	-- 923700304
	if SkillJudger:Equal(self, caster, target, true,count923700305,1) then
	else
		return
	end
	-- 923700302
	self:DelBufferTypeForce(SkillEffect[923700302], caster, self.card, data, 923700301)
	-- 923700303
	local targets = SkillFilter:MaxAttr(self, caster, target, 2,"attack",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[923700303], caster, target, data, 923700601)
	end
end
