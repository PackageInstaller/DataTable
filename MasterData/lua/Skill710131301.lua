-- 子弹风暴（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill710131301 = oo.class(SkillBase)
function Skill710131301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill710131301:DoSkill(caster, target, data)
	-- 13039
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13039], caster, target, data, 0.2,5)
	-- 8785
	local count785 = SkillApi:GetCount(self, caster, target,3,710130301)
	-- 710130301
	if SkillJudger:Greater(self, caster, target, true,count785,0) then
	else
		return
	end
	-- 13040
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13040], caster, target, data, 0.2,1)
	-- 8785
	local count785 = SkillApi:GetCount(self, caster, target,3,710130301)
	-- 710130302
	if SkillJudger:Greater(self, caster, target, true,count785,1) then
	else
		return
	end
	-- 13041
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13041], caster, target, data, 0.2,1)
	-- 8785
	local count785 = SkillApi:GetCount(self, caster, target,3,710130301)
	-- 710130303
	if SkillJudger:Greater(self, caster, target, true,count785,2) then
	else
		return
	end
	-- 13042
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13042], caster, target, data, 0.2,1)
end
-- 行动结束
function Skill710131301:OnActionOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 710130304
	self:DelBufferForce(SkillEffect[710130304], caster, self.card, data, 710130301)
end
