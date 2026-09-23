-- 深海射击（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301501301 = oo.class(SkillBase)
function Skill301501301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill301501301:DoSkill(caster, target, data)
	-- 12701
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12701], caster, target, data, 0.333,2)
	-- 12702
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[12702], caster, target, data, 0.333,1)
end
-- 攻击结束
function Skill301501301:OnAttackOver(caster, target, data)
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
	-- 301500301
	self:ChangeSkill(SkillEffect[301500301], caster, target, data, 1,301500401)
end
