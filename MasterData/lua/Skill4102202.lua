-- 力场残留
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4102202 = oo.class(SkillBase)
function Skill4102202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4102202:OnAttackOver(caster, target, data)
	-- 4102222
	self:tFunc_4102222_4102202(caster, target, data)
	self:tFunc_4102222_4102212(caster, target, data)
end
function Skill4102202:tFunc_4102222_4102212(caster, target, data)
	-- 8712
	local count712 = SkillApi:SkillLevel(self, caster, target,3,1022003)
	-- 8715
	local count715 = SkillApi:BuffCount(self, caster, target,2,4,102200301)
	-- 8926
	if SkillJudger:Greater(self, caster, target, true,count715,0) then
	else
		return
	end
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
	-- 4102212
	if self:Rand(1000) then
		self:CallOwnerSkill(SkillEffect[4102212], caster, caster, data, 102200400+count712)
	end
end
function Skill4102202:tFunc_4102222_4102202(caster, target, data)
	-- 8717
	local count717 = SkillApi:SkillLevel(self, caster, target,3,1022001)
	-- 8716
	local count716 = SkillApi:BuffCount(self, caster, target,2,4,102200201)
	-- 8927
	if SkillJudger:Greater(self, caster, target, true,count716,0) then
	else
		return
	end
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
	-- 4102202
	if self:Rand(2000) then
		self:CallOwnerSkill(SkillEffect[4102202], caster, caster, data, 102200100+count717)
	end
end
