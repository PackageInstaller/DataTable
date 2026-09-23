-- 赫格尼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603212 = oo.class(SkillBase)
function Skill4603212:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill4603212:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8745
	local count745 = SkillApi:SkillLevel(self, caster, target,3,6032103)
	-- 8744
	local count744 = SkillApi:GetCount(self, caster, target,3,4603201)
	-- 8957
	if SkillJudger:Greater(self, caster, self.card, true,count744,4) then
	else
		return
	end
	-- 8746
	local count746 = SkillApi:BuffCount(self, caster, target,3,3,4603215)
	-- 8961
	if SkillJudger:Greater(self, caster, self.card, true,count746,0) then
	else
		return
	end
	-- 4603211
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[4603211], caster, target, data, 603210300+count745)
	end
	-- 4603212
	self:OwnerAddBuffCount(SkillEffect[4603212], caster, self.card, data, 4603211,5,60)
	-- 4603214
	self:OwnerAddBuffCount(SkillEffect[4603214], caster, self.card, data, 4603201,-5,10)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4603216
	self:DelBufferForce(SkillEffect[4603216], caster, self.card, data, 4603215)
end
-- 行动结束
function Skill4603212:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4603215
	self:AddBuff(SkillEffect[4603215], caster, self.card, data, 4603215)
end
