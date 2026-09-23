-- 天赋效果309901
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309901 = oo.class(SkillBase)
function Skill309901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill309901:OnActionBegin(caster, target, data)
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
	-- 8204
	if SkillJudger:IsCtrlType(self, caster, target, true,1) then
	else
		return
	end
	-- 309901
	self:AddBuff(SkillEffect[309901], caster, self.card, data, 4502)
end
-- 行动结束
function Skill309901:OnActionOver(caster, target, data)
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
	-- 8204
	if SkillJudger:IsCtrlType(self, caster, target, true,1) then
	else
		return
	end
	-- 309911
	self:DelBuff(SkillEffect[309911], caster, self.card, data, 4502,1)
end
