-- 天赋效果309904
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309904 = oo.class(SkillBase)
function Skill309904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill309904:OnActionBegin(caster, target, data)
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
	-- 309904
	self:AddBuff(SkillEffect[309904], caster, self.card, data, 4505)
end
-- 行动结束
function Skill309904:OnActionOver(caster, target, data)
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
	-- 309914
	self:DelBuff(SkillEffect[309914], caster, self.card, data, 4505,1)
end
