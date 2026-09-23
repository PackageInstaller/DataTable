-- 天赋效果310501
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310501 = oo.class(SkillBase)
function Skill310501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310501:OnActionBegin(caster, target, data)
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
	-- 8210
	if SkillJudger:IsCtrlType(self, caster, target, true,7) then
	else
		return
	end
	-- 310501
	self:AddBuff(SkillEffect[310501], caster, self.card, data, 4502)
end
-- 行动结束
function Skill310501:OnActionOver(caster, target, data)
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
	-- 8210
	if SkillJudger:IsCtrlType(self, caster, target, true,7) then
	else
		return
	end
	-- 310511
	self:DelBuff(SkillEffect[310511], caster, self.card, data, 4502,1)
end
