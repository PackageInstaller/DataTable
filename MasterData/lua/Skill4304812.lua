-- 掩护弹幕
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304812 = oo.class(SkillBase)
function Skill4304812:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4304812:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304803
	self:OwnerAddBuffCount(SkillEffect[4304803], caster, self.card, data, 304800101,3,8)
end
-- 攻击结束
function Skill4304812:OnAttackOver(caster, target, data)
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
	-- 4304814
	self:OwnerAddBuffCount(SkillEffect[4304814], caster, self.card, data, 304800101,1,8)
end
-- 解体时
function Skill4304812:OnResolve(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304832
	self:CallSkill(SkillEffect[4304832], caster, self.card, data, 304810402)
end
