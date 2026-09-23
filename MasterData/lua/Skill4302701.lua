-- 火焰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4302701 = oo.class(SkillBase)
function Skill4302701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill4302701:OnAddBuff(caster, target, data, buffer)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8428
	local count28 = SkillApi:BuffCount(self, caster, target,2,3,1002)
	-- 8111
	if SkillJudger:Greater(self, caster, self.card, true,count28,0) then
	else
		return
	end
	-- 4302701
	self:OwnerAddBuffCount(SkillEffect[4302701], caster, target, data, 4302701,1,1)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill4302701:OnBefourCritHurt(caster, target, data)
	-- 4302711
	local count2711 = SkillApi:GetAttr(self, caster, target,1,"crit_rate")
	-- 4302712
	local count2712 = SkillApi:GetAttr(self, caster, target,2,"crit_rate")
	-- 8428
	local count28 = SkillApi:BuffCount(self, caster, target,2,3,1002)
	-- 8111
	if SkillJudger:Greater(self, caster, self.card, true,count28,0) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4302706
	self:AddTempAttr(SkillEffect[4302706], caster, caster, data, "crit",math.min(math.max((count2711-count2712)*0.2,0),0.2))
end
-- 回合结束时
function Skill4302701:OnRoundOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8734
	local count734 = SkillApi:BuffCount(self, caster, target,1,3,1002)
	-- 8947
	if SkillJudger:Less(self, caster, self.card, true,count734,1) then
	else
		return
	end
	-- 4302721
	self:DelBufferForce(SkillEffect[4302721], caster, caster, data, 4302701)
end
-- 回合开始时
function Skill4302701:OnRoundBegin(caster, target, data)
	-- 4302731
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		-- 8428
		local count28 = SkillApi:BuffCount(self, caster, target,2,3,1002)
		-- 8823
		if SkillJudger:Less(self, caster, self.card, true,count28,1) then
		else
			return
		end
		-- 4302732
		self:DelBufferTypeForce(SkillEffect[4302732], caster, target, data, 4302701)
	end
end
