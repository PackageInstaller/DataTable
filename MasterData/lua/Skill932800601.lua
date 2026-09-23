-- 反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932800601 = oo.class(SkillBase)
function Skill932800601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill932800601:OnAttackOver(caster, target, data)
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
	-- 932800601
	self:AddBuffCount(SkillEffect[932800601], caster, self.card, data, 932800601,1,5)
end
-- 行动结束2
function Skill932800601:OnActionOver2(caster, target, data)
	-- 8661
	local count661 = SkillApi:GetCount(self, caster, target,3,932800601)
	-- 8868
	if SkillJudger:Greater(self, caster, target, true,count661,4) then
	else
		return
	end
	-- 932800602
	self:DelBuffQuality(SkillEffect[932800602], caster, self.card, data, 2,10)
	-- 932800603
	self:DelBufferForce(SkillEffect[932800603], caster, self.card, data, 932800601)
	-- 932800604
	self:CallOwnerSkill(SkillEffect[932800604], caster, self.card, data, 932800201)
end
-- 行动结束
function Skill932800601:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 932800605
	if self:Rand(5000) then
		self:AddNp(SkillEffect[932800605], caster, target, data, -5)
	end
end
-- 入场时
function Skill932800601:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 932800203
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[932800203], caster, target, data, 932800203)
	end
end
