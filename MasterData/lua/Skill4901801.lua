-- 报复特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4901801 = oo.class(SkillBase)
function Skill4901801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4901801:OnAttackOver(caster, target, data)
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
	-- 21601
	self:AddProgress(SkillEffect[21601], caster, self.card, data, 100)
	-- 21611
	self:AddBuffCount(SkillEffect[21611], caster, self.card, data, 21611,1,3)
	-- 216010
	self:ShowTips(SkillEffect[216010], caster, self.card, data, 2,"暴怒",true,216010)
end
