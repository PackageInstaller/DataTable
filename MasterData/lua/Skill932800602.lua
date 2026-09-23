-- 连锁阵线阿曼新被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932800602 = oo.class(SkillBase)
function Skill932800602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill932800602:OnAttackOver(caster, target, data)
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
	-- 932800609
	self:AddBuffCount(SkillEffect[932800609], caster, self.card, data, 932800602,1,6)
end
-- 行动结束2
function Skill932800602:OnActionOver2(caster, target, data)
	-- 932800613
	local count93280 = SkillApi:GetCount(self, caster, target,3,932800602)
	-- 932800614
	if SkillJudger:Greater(self, caster, target, true,count93280,5) then
	else
		return
	end
	-- 932800610
	self:DelBuffQuality(SkillEffect[932800610], caster, self.card, data, 2,10)
	-- 932800611
	self:DelBufferForce(SkillEffect[932800611], caster, self.card, data, 932800602)
	-- 932800612
	self:CallOwnerSkill(SkillEffect[932800612], caster, self.card, data, 932800201)
end
-- 行动结束
function Skill932800602:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsCanHurt(self, caster, target, false) then
	else
		return
	end
	-- 932800608
	if self:Rand(6000) then
		self:AddNp(SkillEffect[932800608], caster, target, data, -5)
	end
end
-- 入场时
function Skill932800602:OnBorn(caster, target, data)
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
