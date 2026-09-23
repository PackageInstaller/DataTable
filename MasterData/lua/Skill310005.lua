-- 天赋效果310005
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310005 = oo.class(SkillBase)
function Skill310005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310005:OnActionBegin(caster, target, data)
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
	-- 8205
	if SkillJudger:IsCtrlType(self, caster, target, true,2) then
	else
		return
	end
	-- 310005
	self:AddBuff(SkillEffect[310005], caster, self.card, data, 4506)
end
-- 行动结束
function Skill310005:OnActionOver(caster, target, data)
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
	-- 8205
	if SkillJudger:IsCtrlType(self, caster, target, true,2) then
	else
		return
	end
	-- 310015
	self:DelBuff(SkillEffect[310015], caster, self.card, data, 4506,1)
end
