-- 阿努比斯技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703300307 = oo.class(SkillBase)
function Skill703300307:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703300307:DoSkill(caster, target, data)
	-- 12005
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12005], caster, target, data, 0.2,5)
end
-- 行动结束2
function Skill703300307:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 703300305
	local r = self.card:Rand(3)+1
	if 1 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 703300306
		if self:Rand(7000) then
			self:AddHp(SkillEffect[703300306], caster, self.card, data, 50000)
		end
	elseif 2 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 703300307
		if self:Rand(2000) then
			self:AddHp(SkillEffect[703300307], caster, self.card, data, 100000)
		end
	elseif 3 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 703300308
		if self:Rand(1000) then
			self:AddHp(SkillEffect[703300308], caster, self.card, data, 150000)
		end
	end
end
