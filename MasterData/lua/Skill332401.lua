-- 信风4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill332401 = oo.class(SkillBase)
function Skill332401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill332401:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 332401
	if self:Rand(2000) then
		self:AddBuffCount(SkillEffect[332401], caster, self.card, data, 332401,1,5)
	end
end
-- 行动结束2
function Skill332401:OnActionOver2(caster, target, data)
	-- 8672
	local count672 = SkillApi:GetCount(self, caster, target,3,332401)
	-- 8881
	if SkillJudger:GreaterEqual(self, caster, target, true,count672,5) then
	else
		return
	end
	-- 332411
	self:DelBufferGroup(SkillEffect[332411], caster, self.card, data, 1,5)
	-- 332412
	self:DelBufferForce(SkillEffect[332412], caster, self.card, data, 332401)
	-- 8685
	local count685 = SkillApi:SkillLevel(self, caster, target,3,4002002)
	-- 332413
	self:CallOwnerSkill(SkillEffect[332413], caster, target, data, 400200200+count685)
end
