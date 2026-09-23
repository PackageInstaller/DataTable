-- 利兹3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304500301 = oo.class(SkillBase)
function Skill304500301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill304500301:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 伤害后
function Skill304500301:OnAfterHurt(caster, target, data)
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
	-- 8750
	local count750 = SkillApi:SkillLevel(self, caster, target,3,43045)
	-- 304500301
	if self:Rand(3000) then
		self:AddBuffCount(SkillEffect[304500301], caster, target, data, 304500300+count750,1,20)
	end
end
