-- 疲劳I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20401 = oo.class(SkillBase)
function Skill20401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill20401:OnActionBegin(caster, target, data)
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
	-- 8208
	if SkillJudger:IsCtrlType(self, caster, target, true,5) then
	else
		return
	end
	-- 20401
	self:AddBuff(SkillEffect[20401], caster, self.card, data, 22601)
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
	-- 8435
	local count35 = SkillApi:BuffCount(self, caster, target,2,3,3006)
	-- 8118
	if SkillJudger:Greater(self, caster, self.card, true,count35,0) then
	else
		return
	end
	-- 204010
	self:ShowTips(SkillEffect[204010], caster, self.card, data, 2,"催眠",true,204010)
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
	-- 8435
	local count35 = SkillApi:BuffCount(self, caster, target,2,3,3006)
	-- 8118
	if SkillJudger:Greater(self, caster, self.card, true,count35,0) then
	else
		return
	end
	-- 204010
	self:ShowTips(SkillEffect[204010], caster, self.card, data, 2,"催眠",true,204010)
end
