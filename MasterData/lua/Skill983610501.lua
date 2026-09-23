-- 魔羯座小怪通用技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983610501 = oo.class(SkillBase)
function Skill983610501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill983610501:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 950400318
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 983610501
	self:AddTempAttr(SkillEffect[983610501], caster, target, data, "bedamage",1)
end
-- 死亡时
function Skill983610501:OnDeath(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 983610502
	self:AddSp(SkillEffect[983610502], caster, caster, data, 20)
	-- 983610503
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuffCount(SkillEffect[983610503], caster, target, data, 332516,1,9)
	end
end
