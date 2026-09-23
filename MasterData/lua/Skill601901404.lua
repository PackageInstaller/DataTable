-- 折光斩
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601901404 = oo.class(SkillBase)
function Skill601901404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill601901404:DoSkill(caster, target, data)
	-- 11004
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
end
-- 回合开始时
function Skill601901404:OnRoundBegin(caster, target, data)
	-- 601900303
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:SetProtect(SkillEffect[601900303], caster, target, data, 0)
	end
	-- 601900313
	local targets = SkillFilter:MinAttr(self, caster, target, 3,"hp",2,3)
	for i,target in ipairs(targets) do
		self:SetProtect(SkillEffect[601900313], caster, target, data, 10000)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 601900304
	self:AutoFight(SkillEffect[601900304], caster, self.card, data, 601900401)
end
-- 行动结束
function Skill601901404:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 601900306
	self:AddBuff(SkillEffect[601900306], caster, self.card, data, 1009)
end
