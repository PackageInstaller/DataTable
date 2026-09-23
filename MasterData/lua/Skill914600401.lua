-- 6.2版本机神被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914600401 = oo.class(SkillBase)
function Skill914600401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914600401:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
-- 回合结束时
function Skill914600401:OnRoundOver(caster, target, data)
	-- 914600401
	self:AddBuffCount(SkillEffect[914600401], caster, self.card, data, 914600101,1,5)
end
-- 行动结束2
function Skill914600401:OnActionOver2(caster, target, data)
	-- 914600402
	local count914600101 = SkillApi:GetCount(self, caster, target,3,914600101)
	-- 914600404
	if SkillJudger:Greater(self, caster, target, true,count914600101,4) then
	else
		return
	end
	-- 914600405
	self:DelBufferForce(SkillEffect[914600405], caster, self.card, data, 914600101,5)
	-- 914600403
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuffCount(SkillEffect[914600403], caster, target, data, 914600301,1,5)
	end
end
