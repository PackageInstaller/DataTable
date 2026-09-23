-- 皮洛可1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200300101 = oo.class(SkillBase)
function Skill200300101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200300101:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束
function Skill200300101:OnActionOver(caster, target, data)
	-- 8781
	local count781 = SkillApi:BuffCount(self, caster, target,3,4,200300112)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 200300101
	if SkillJudger:Greater(self, caster, target, true,count781,0) then
		-- 8200
		if SkillJudger:IsCurrSkill(self, caster, target, true) then
		else
			return
		end
		-- 200300112
		local targets = SkillFilter:MaxAttr(self, caster, target, 1,"attack",1)
		for i,target in ipairs(targets) do
			self:AddBuff(SkillEffect[200300112], caster, target, data, 200300106)
		end
	else
		-- 8200
		if SkillJudger:IsCurrSkill(self, caster, target, true) then
		else
			return
		end
		-- 200300107
		local targets = SkillFilter:MaxAttr(self, caster, target, 1,"attack",1)
		for i,target in ipairs(targets) do
			self:AddBuff(SkillEffect[200300107], caster, target, data, 200300101)
		end
		-- 8777
		local count777 = SkillApi:SkillLevel(self, caster, target,3,42003)
		-- 200300117
		self:AddBuffCount(SkillEffect[200300117], caster, self.card, data, 4200300+count777,1,10)
	end
end
-- 行动结束2
function Skill200300101:OnActionOver2(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 200300120
	self:DelBufferForce(SkillEffect[200300120], caster, self.card, data, 200300112)
end
-- 行动开始
function Skill200300101:OnActionBegin(caster, target, data)
	-- 8778
	local count778 = SkillApi:SkillLevel(self, caster, target,3,3400)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 200300106
	if self:Rand(5000+1000*count778) then
		self:AddBuff(SkillEffect[200300106], caster, self.card, data, 200300112)
	end
end
