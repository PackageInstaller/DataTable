-- 天赋效果310105
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310105 = oo.class(SkillBase)
function Skill310105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310105:OnActionBegin(caster, target, data)
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
	-- 8206
	if SkillJudger:IsCtrlType(self, caster, target, true,3) then
	else
		return
	end
	-- 310105
	self:AddBuff(SkillEffect[310105], caster, self.card, data, 4506)
end
-- 行动结束
function Skill310105:OnActionOver(caster, target, data)
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
	-- 8206
	if SkillJudger:IsCtrlType(self, caster, target, true,3) then
	else
		return
	end
	-- 310115
	self:DelBuff(SkillEffect[310115], caster, self.card, data, 4506,1)
end
