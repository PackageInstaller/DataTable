-- 感电I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20601 = oo.class(SkillBase)
function Skill20601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill20601:OnActionBegin(caster, target, data)
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
	-- 20601
	self:AddBuff(SkillEffect[20601], caster, self.card, data, 22601)
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
	-- 8438
	local count38 = SkillApi:BuffCount(self, caster, target,2,3,3009)
	-- 8121
	if SkillJudger:Greater(self, caster, self.card, true,count38,0) then
	else
		return
	end
	-- 206010
	self:ShowTips(SkillEffect[206010], caster, self.card, data, 2,"麻醉",true,206010)
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
	-- 8438
	local count38 = SkillApi:BuffCount(self, caster, target,2,3,3009)
	-- 8121
	if SkillJudger:Greater(self, caster, self.card, true,count38,0) then
	else
		return
	end
	-- 206010
	self:ShowTips(SkillEffect[206010], caster, self.card, data, 2,"麻醉",true,206010)
end
