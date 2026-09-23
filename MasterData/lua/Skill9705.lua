-- 能量屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9705 = oo.class(SkillBase)
function Skill9705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9705:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9705
	self:OwnerAddBuffCount(SkillEffect[9705], caster, self.card, data, 9701,5,10)
end
-- 回合开始处理完成后
function Skill9705:OnAfterRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9702
	self:OwnerAddBuffCount(SkillEffect[9702], caster, self.card, data, 9701,2,10)
end
-- 伤害后
function Skill9705:OnAfterHurt(caster, target, data)
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
	-- 8222
	if SkillJudger:IsDamageType(self, caster, target, true,1) then
	else
		return
	end
	-- 9711
	self:OwnerAddBuffCount(SkillEffect[9711], caster, self.card, data, 9701,-1,10)
end
