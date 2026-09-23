-- 天赋效果310505
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310505 = oo.class(SkillBase)
function Skill310505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310505:OnActionBegin(caster, target, data)
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
	-- 310505
	self:AddBuff(SkillEffect[310505], caster, self.card, data, 4506)
end
-- 行动结束
function Skill310505:OnActionOver(caster, target, data)
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
	-- 310515
	self:DelBuff(SkillEffect[310515], caster, self.card, data, 4506,1)
end
