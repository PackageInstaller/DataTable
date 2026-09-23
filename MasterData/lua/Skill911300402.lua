-- 雷鸣洞悉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911300402 = oo.class(SkillBase)
function Skill911300402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill911300402:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 回合开始时
function Skill911300402:OnRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 911300401
	self:OwnerAddBuffCount(SkillEffect[911300401], caster, self.card, data, 911300401,1,8)
end
-- 伤害前
function Skill911300402:OnBefourHurt(caster, target, data)
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
	-- 8438
	local count38 = SkillApi:BuffCount(self, caster, target,2,3,3009)
	-- 8121
	if SkillJudger:Greater(self, caster, self.card, true,count38,0) then
	else
		return
	end
	-- 911300402
	self:AddTempAttr(SkillEffect[911300402], caster, self.card, data, "damage",0.4)
end
-- 回合结束时
function Skill911300402:OnRoundOver(caster, target, data)
	-- 8675
	local count675 = SkillApi:GetCount(self, caster, self.card,3,911300401)
	-- 8887
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count675,6) then
	else
		return
	end
	-- 911300404
	self:DelBufferForce(SkillEffect[911300404], caster, self.card, data, 911300401)
	-- 911300405
	self:CallOwnerSkill(SkillEffect[911300405], caster, self.card, data, 911300301)
end
