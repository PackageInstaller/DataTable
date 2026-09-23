-- 天赋效果309905
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309905 = oo.class(SkillBase)
function Skill309905:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill309905:OnActionBegin(caster, target, data)
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
	-- 309905
	self:AddBuff(SkillEffect[309905], caster, self.card, data, 4506)
end
-- 行动结束
function Skill309905:OnActionOver(caster, target, data)
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
	-- 309915
	self:DelBuff(SkillEffect[309915], caster, self.card, data, 4506,1)
end
