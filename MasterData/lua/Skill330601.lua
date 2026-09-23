-- 乌琳天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330601 = oo.class(SkillBase)
function Skill330601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill330601:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8658
	local count658 = SkillApi:GetCount(self, caster, target,3,4202404)
	-- 8864
	if SkillJudger:Greater(self, caster, target, true,count658,4) then
	else
		return
	end
	-- 330601
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddProgress(SkillEffect[330601], caster, target, data, 100)
	end
	-- 330611
	self:DelBufferTypeForce(SkillEffect[330611], caster, self.card, data, 4202401,5)
end
