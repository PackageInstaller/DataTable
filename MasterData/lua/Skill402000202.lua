-- 精准打击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill402000202 = oo.class(SkillBase)
function Skill402000202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill402000202:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
-- 攻击结束
function Skill402000202:OnAttackOver(caster, target, data)
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
	-- 402000101
	self:HitAddBuffCount(SkillEffect[402000101], caster, target, data, 10000,402000101,2,6)
	-- 402000102
	self:ShowTips(SkillEffect[402000102], caster, target, data, 2,"磷雾",true,402000102)
end
