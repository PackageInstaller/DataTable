-- 双子宫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984000801 = oo.class(SkillBase)
function Skill984000801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill984000801:OnActionOver(caster, target, data)
	-- 8579
	local count100 = SkillApi:BuffCount(self, caster, target,3,2,1)
	-- 984000803
	if SkillJudger:Less(self, caster, target, true,count100,5) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 984000801
	local r = self.card:Rand(6)+1
	if 1 == r then
		-- 984000804
		self:AddBuff(SkillEffect[984000804], caster, self.card, data, 984000801)
	elseif 2 == r then
		-- 984000805
		self:AddBuff(SkillEffect[984000805], caster, self.card, data, 984000802)
	elseif 3 == r then
		-- 984000806
		self:AddBuff(SkillEffect[984000806], caster, self.card, data, 984000803)
	elseif 4 == r then
		-- 984000807
		self:AddBuff(SkillEffect[984000807], caster, self.card, data, 984000804)
	elseif 5 == r then
		-- 984000808
		self:AddBuff(SkillEffect[984000808], caster, self.card, data, 984000805)
	elseif 6 == r then
		-- 984000809
		self:AddBuff(SkillEffect[984000809], caster, self.card, data, 984000806)
	end
end
