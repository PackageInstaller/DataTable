-- 截击横挞
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801000301 = oo.class(SkillBase)
function Skill801000301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801000301:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
end
-- 死亡时
function Skill801000301:OnDeath(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8447
	local count47 = SkillApi:GetOverDamageTotal(self, caster, target,2)
	-- 801000301
	local targets = SkillFilter:MaxAttr(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[801000301], caster, target, data, -count47)
	end
end
