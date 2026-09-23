-- 天赋效果310603
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310603 = oo.class(SkillBase)
function Skill310603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310603:OnActionBegin(caster, target, data)
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
	-- 8211
	if SkillJudger:IsCtrlType(self, caster, target, true,8) then
	else
		return
	end
	-- 310603
	self:AddBuff(SkillEffect[310603], caster, self.card, data, 4504)
end
-- 行动结束
function Skill310603:OnActionOver(caster, target, data)
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
	-- 8211
	if SkillJudger:IsCtrlType(self, caster, target, true,8) then
	else
		return
	end
	-- 310613
	self:DelBuff(SkillEffect[310613], caster, self.card, data, 4504,1)
end
