-- 反击修改次数技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill933100603 = oo.class(SkillBase)
function Skill933100603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill933100603:OnAttackOver(caster, target, data)
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
	-- 933101601
	self:AddBuffCount(SkillEffect[933101601], caster, self.card, data, 933101601,1,10)
end
-- 行动结束2
function Skill933100603:OnActionOver2(caster, target, data)
	-- 933101608
	local count933101601 = SkillApi:GetCount(self, caster, target,3,933101601)
	-- 933101609
	if SkillJudger:Greater(self, caster, target, true,count933101601,9) then
	else
		return
	end
	-- 933100606
	self:DelBuffQuality(SkillEffect[933100606], caster, self.card, data, 2,4)
	-- 933100607
	self:DelBufferForce(SkillEffect[933100607], caster, self.card, data, 933101601)
	-- 933100608
	self:CallOwnerSkill(SkillEffect[933100608], caster, self.card, data, 933100201)
end
-- 行动结束
function Skill933100603:OnActionOver(caster, target, data)
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
	-- 933101605
	if self:Rand(5000) then
		self:AddNp(SkillEffect[933101605], caster, target, data, -5)
	end
end
-- 入场时
function Skill933100603:OnBorn(caster, target, data)
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
