-- 双子宫-波拉克斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984010501 = oo.class(SkillBase)
function Skill984010501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill984010501:OnActionBegin(caster, target, data)
	-- 8448
	local count48 = SkillApi:PercentHp(self, caster, target,3)
	-- 984010503
	if SkillJudger:Less(self, caster, target, true,count48,0.5) then
		-- 8448
		local count48 = SkillApi:PercentHp(self, caster, target,3)
		-- 984010603
		if SkillJudger:Less(self, caster, target, true,count48,0.3) then
			-- 984010501
			self:AddBuff(SkillEffect[984010501], caster, self.card, data, 984010501)
		else
			-- 984010601
			self:AddBuff(SkillEffect[984010601], caster, self.card, data, 984010601)
		end
	else
		-- 984010701
		self:AddBuff(SkillEffect[984010701], caster, self.card, data, 984010701)
	end
end
