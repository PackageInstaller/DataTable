-- 王牌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4600105 = oo.class(SkillBase)
function Skill4600105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4600105:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 4600108
	self:AddTempAttr(SkillEffect[4600108], caster, self.card, data, "damage",0.5)
end
-- 伤害后
function Skill4600105:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 4600105
	self:AddUplimitBuff(SkillEffect[4600105], caster, self.card, data, 3,3,4600105,20,4600105)
	-- 4600107
	self:ShowTips(SkillEffect[4600107], caster, self.card, data, 2,"王牌",true,4600107)
end
