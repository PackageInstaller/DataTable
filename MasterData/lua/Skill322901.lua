-- 守护者
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill322901 = oo.class(SkillBase)
function Skill322901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill322901:OnRoundBegin(caster, target, data)
	-- 4102301
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:SetProtect(SkillEffect[4102301], caster, target, data, 0)
	end
	-- 4102302
	local targets = SkillFilter:MinAttr(self, caster, target, 3,"hp",2,3)
	for i,target in ipairs(targets) do
		self:SetProtect(SkillEffect[4102302], caster, target, data, 10000)
	end
	-- 4102303
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		-- 8609
		local count609 = SkillApi:BuffCount(self, caster, target,2,4,4102302)
		-- 4102304
		if SkillJudger:Greater(self, caster, target, true,count609,0) then
			-- 4102305
			self:SetProtect(SkillEffect[4102305], caster, target, data, 10000)
		end
	end
end
-- 攻击开始
function Skill322901:OnAttackBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 4102311
	self:AddBuff(SkillEffect[4102311], caster, caster, data, 4102311)
end
-- 入场时
function Skill322901:OnBorn(caster, target, data)
	-- 4102306
	self:AddBuff(SkillEffect[4102306], caster, self.card, data, 4102301)
end
