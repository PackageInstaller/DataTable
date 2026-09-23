-- 永恒之枪
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4702612 = oo.class(SkillBase)
function Skill4702612:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4702612:OnAfterHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 4702612
	if self:Rand(2000) then
		self:OwnerAddBuffCount(SkillEffect[4702612], caster, self.card, data, 702600204,1,10)
	end
end
