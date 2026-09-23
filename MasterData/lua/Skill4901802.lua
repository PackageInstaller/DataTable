-- 报复特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4901802 = oo.class(SkillBase)
function Skill4901802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4901802:OnAttackOver(caster, target, data)
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
	-- 21602
	self:AddProgress(SkillEffect[21602], caster, self.card, data, 200)
	-- 21612
	self:AddBuffCount(SkillEffect[21612], caster, self.card, data, 21612,1,3)
	-- 216010
	self:ShowTips(SkillEffect[216010], caster, self.card, data, 2,"暴怒",true,216010)
end
