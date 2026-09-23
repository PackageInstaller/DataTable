-- 追击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill908800601 = oo.class(SkillBase)
function Skill908800601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill908800601:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8419
	local count19 = SkillApi:GetAttr(self, caster, target,3,"xp")
	-- 8153
	if SkillJudger:Greater(self, caster, self.card, true,count19,2) then
	else
		return
	end
	-- 908800601
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[908800601], caster, target, data, 908800201)
	end
	-- 907800603
	self:AddXp(SkillEffect[907800603], caster, self.card, data, -4)
end
