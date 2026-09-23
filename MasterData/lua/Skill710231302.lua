-- 子弹风暴（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill710231302 = oo.class(SkillBase)
function Skill710231302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill710231302:DoSkill(caster, target, data)
	-- 13047
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13047], caster, target, data, 0.2,5)
	-- 8791
	local count791 = SkillApi:GetCount(self, caster, target,3,710230301)
	-- 710230301
	if SkillJudger:Greater(self, caster, target, true,count791,0) then
	else
		return
	end
	-- 13048
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13048], caster, target, data, 0.2,1)
	-- 8791
	local count791 = SkillApi:GetCount(self, caster, target,3,710230301)
	-- 710230302
	if SkillJudger:Greater(self, caster, target, true,count791,1) then
	else
		return
	end
	-- 13049
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13049], caster, target, data, 0.2,1)
	-- 8791
	local count791 = SkillApi:GetCount(self, caster, target,3,710230301)
	-- 710230303
	if SkillJudger:Greater(self, caster, target, true,count791,2) then
	else
		return
	end
	-- 13050
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13050], caster, target, data, 0.2,1)
end
-- 行动结束
function Skill710231302:OnActionOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 710230304
	self:DelBufferForce(SkillEffect[710230304], caster, self.card, data, 710230301)
end
