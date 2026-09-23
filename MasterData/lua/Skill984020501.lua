-- 双子宫-卡斯托
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984020501 = oo.class(SkillBase)
function Skill984020501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill984020501:OnActionBegin(caster, target, data)
	-- 8448
	local count48 = SkillApi:PercentHp(self, caster, target,3)
	-- 984020503
	if SkillJudger:Less(self, caster, target, true,count48,0.5) then
		-- 8448
		local count48 = SkillApi:PercentHp(self, caster, target,3)
		-- 984020603
		if SkillJudger:Less(self, caster, target, true,count48,0.3) then
			-- 984020501
			self:AddBuff(SkillEffect[984020501], caster, self.card, data, 984020501)
		else
			-- 984020601
			self:AddBuff(SkillEffect[984020601], caster, self.card, data, 984020601)
		end
	else
		-- 984020701
		self:AddBuff(SkillEffect[984020701], caster, self.card, data, 984020701)
	end
end
