-- 天使之音
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill323703 = oo.class(SkillBase)
function Skill323703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill323703:OnDeath(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 323703
	if self:Rand(6000) then
		local r = self.card:Rand(4)+1
		if 1 == r then
			-- 4201406
			local targets = SkillFilter:All(self, caster, target, 3)
			for i,target in ipairs(targets) do
				self:AddBuff(SkillEffect[4201406], caster, target, data, 4004,1)
			end
		elseif 2 == r then
			-- 4201407
			local targets = SkillFilter:All(self, caster, target, 3)
			for i,target in ipairs(targets) do
				self:AddBuff(SkillEffect[4201407], caster, target, data, 4304,1)
			end
		elseif 3 == r then
			-- 4201408
			local targets = SkillFilter:All(self, caster, target, 3)
			for i,target in ipairs(targets) do
				self:AddProgress(SkillEffect[4201408], caster, target, data, 200)
			end
		elseif 4 == r then
			-- 4201409
			local targets = SkillFilter:All(self, caster, target, 3)
			for i,target in ipairs(targets) do
				self:Cure(SkillEffect[4201409], caster, target, data, 2,0.2)
			end
		end
	end
end
