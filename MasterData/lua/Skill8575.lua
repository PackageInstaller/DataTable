-- 耐久重筑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8575 = oo.class(SkillBase)
function Skill8575:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill8575:OnBorn(caster, target, data)
	-- 22814
	self:AddBuff(SkillEffect[22814], caster, self.card, data, 6112)
end
-- 行动结束2
function Skill8575:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8106
	if SkillJudger:Less(self, caster, self.card, true,count20,2) then
	else
		return
	end
	-- 30012
	self:Cure(SkillEffect[30012], caster, self.card, data, 2,1)
end
-- 回合开始处理完成后
function Skill8575:OnAfterRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8106
	if SkillJudger:Less(self, caster, self.card, true,count20,2) then
	else
		return
	end
	-- 30012
	self:Cure(SkillEffect[30012], caster, self.card, data, 2,1)
end
