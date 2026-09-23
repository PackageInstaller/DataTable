-- 治疗时获得随机强化效果（攻击+15％，防御+15％，暴击+15％，机动性+30，受治疗效果+30％）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020321 = oo.class(SkillBase)
function Skill1100020321:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill1100020321:OnCure(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020320
	local r = self.card:Rand(5)+1
	if 1 == r then
		-- 4002
		self:AddBuff(SkillEffect[4002], caster, target, data, 4002)
	elseif 2 == r then
		-- 4102
		self:AddBuff(SkillEffect[4102], caster, target, data, 4102)
	elseif 3 == r then
		-- 4204
		self:AddBuff(SkillEffect[4204], caster, target, data, 4204)
	elseif 4 == r then
		-- 4302
		self:AddBuff(SkillEffect[4302], caster, target, data, 4302)
	elseif 5 == r then
		-- 4702
		self:AddBuff(SkillEffect[4702], caster, target, data, 4702)
	end
end
