-- 天赋效果310502
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310502 = oo.class(SkillBase)
function Skill310502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310502:OnActionBegin(caster, target, data)
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
	-- 310502
	self:AddBuff(SkillEffect[310502], caster, self.card, data, 4503)
end
-- 行动结束
function Skill310502:OnActionOver(caster, target, data)
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
	-- 310512
	self:DelBuff(SkillEffect[310512], caster, self.card, data, 4503,1)
end
