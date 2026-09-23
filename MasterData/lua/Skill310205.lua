-- 天赋效果310205
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310205 = oo.class(SkillBase)
function Skill310205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310205:OnActionBegin(caster, target, data)
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
	-- 8207
	if SkillJudger:IsCtrlType(self, caster, target, true,4) then
	else
		return
	end
	-- 310205
	self:AddBuff(SkillEffect[310205], caster, self.card, data, 4506)
end
-- 行动结束
function Skill310205:OnActionOver(caster, target, data)
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
	-- 8207
	if SkillJudger:IsCtrlType(self, caster, target, true,4) then
	else
		return
	end
	-- 310215
	self:DelBuff(SkillEffect[310215], caster, self.card, data, 4506,1)
end
