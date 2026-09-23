-- 赤夕技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704000303 = oo.class(SkillBase)
function Skill704000303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704000303:DoSkill(caster, target, data)
	-- 704000303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704000303], caster, target, data, 704000303)
	-- 704000311
	self.order = self.order + 1
	self:Cure(SkillEffect[704000311], caster, target, data, 1,0.1)
end
-- 死亡时
function Skill704000303:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4704006
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:SetShareDamage(SkillEffect[4704006], caster, target, data, 0)
	end
end
