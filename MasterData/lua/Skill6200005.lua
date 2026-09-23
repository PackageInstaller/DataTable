-- 每周boss异态稽查者角色buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6200005 = oo.class(SkillBase)
function Skill6200005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill6200005:OnAfterHurt(caster, target, data)
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
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 6200018
	local count6200018 = SkillApi:GetCount(self, caster, target,3,6200018)
	-- 6200017
	if self:Rand(6000) then
		self:LimitDamage(SkillEffect[6200017], caster, target, data, 0.06,math.min((1.2+count6200018*0.03),3))
	end
end
-- 行动结束
function Skill6200005:OnActionOver(caster, target, data)
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
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 6200016
	self:AddBuffCount(SkillEffect[6200016], caster, self.card, data, 6200018,1,999)
end
-- 伤害前
function Skill6200005:OnBefourHurt(caster, target, data)
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
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 6200020
	self:AddTempAttr(SkillEffect[6200020], caster, self.card, data, "damage2",0.5)
end
