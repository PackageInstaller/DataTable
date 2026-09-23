-- 奥西里斯2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340501 = oo.class(SkillBase)
function Skill340501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill340501:OnRoundOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8281
	if SkillJudger:CasterIsSelf(self, caster, target, false) then
	else
		return
	end
	-- 8796
	local count796 = SkillApi:SkillLevel(self, caster, target,3,7805001)
	-- 8799
	local count799 = SkillApi:SkillLevel(self, caster, target,3,7805002)
	-- 8787
	local count787 = SkillApi:GetAttr(self, caster, target,1,"sMech")
	-- 8971
	local count971 = SkillApi:BuffCount(self, caster, target,3,3,780500181+count787+count799*20)
	-- 340506
	if SkillJudger:Greater(self, caster, target, true,count971,0) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 340501
	if self:Rand(4000) then
		self:AddHp(SkillEffect[340501], caster, self.card, data, -math.floor(0.2*count20))
		-- 8062
		if SkillJudger:CasterIsTeammate(self, caster, target, true) then
		else
			return
		end
		-- 8281
		if SkillJudger:CasterIsSelf(self, caster, target, false) then
		else
			return
		end
		-- 8796
		local count796 = SkillApi:SkillLevel(self, caster, target,3,7805001)
		-- 8799
		local count799 = SkillApi:SkillLevel(self, caster, target,3,7805002)
		-- 8787
		local count787 = SkillApi:GetAttr(self, caster, target,1,"sMech")
		-- 8971
		local count971 = SkillApi:BuffCount(self, caster, target,3,3,780500181+count787+count799*20)
		-- 340506
		if SkillJudger:Greater(self, caster, target, true,count971,0) then
		else
			return
		end
		-- 340507
		local targets = SkillFilter:Rand(self, caster, target, 4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[340507], caster, target, data, 780500100+count796)
		end
	end
end
