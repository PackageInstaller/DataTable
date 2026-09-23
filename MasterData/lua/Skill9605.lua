-- 物理屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9605 = oo.class(SkillBase)
function Skill9605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9605:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9605
	self:OwnerAddBuffCount(SkillEffect[9605], caster, self.card, data, 9601,5,10)
end
-- 回合开始处理完成后
function Skill9605:OnAfterRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9602
	self:OwnerAddBuffCount(SkillEffect[9602], caster, self.card, data, 9601,2,10)
end
-- 伤害后
function Skill9605:OnAfterHurt(caster, target, data)
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
	-- 8223
	if SkillJudger:IsDamageType(self, caster, target, true,2) then
	else
		return
	end
	-- 9611
	self:OwnerAddBuffCount(SkillEffect[9611], caster, self.card, data, 9601,-1,10)
end
