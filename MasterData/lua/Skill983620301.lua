-- 摩羯座小怪2技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983620301 = oo.class(SkillBase)
function Skill983620301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983620301:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 983620302
	local r = self.card:Rand(4)+1
	if 1 == r then
		-- 983620303
		self.order = self.order + 1
		self:AddBuff(SkillEffect[983620303], caster, target, data, 984020806)
	elseif 2 == r then
		-- 983620304
		self.order = self.order + 1
		self:AddBuff(SkillEffect[983620304], caster, target, data, 984020807)
	elseif 3 == r then
		-- 983620305
		self.order = self.order + 1
		self:AddBuff(SkillEffect[983620305], caster, target, data, 984020808)
	elseif 4 == r then
		-- 983620306
		self.order = self.order + 1
		self:AddBuff(SkillEffect[983620306], caster, target, data, 984020809)
	end
end
