-- 寒冰巨剑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702400304 = oo.class(SkillBase)
function Skill702400304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702400304:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 加buff时
function Skill702400304:OnAddBuff(caster, target, data, buffer)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8651
	local count651 = SkillApi:BuffCount(self, caster, target,2,3,702400301)
	-- 8854
	if SkillJudger:Greater(self, caster, target, true,count651,0) then
	else
		return
	end
	-- 8256
	if SkillJudger:IsCtrlBuff(buffer or self, caster, target, true) then
	else
		return
	end
	-- 702400302
	if self:Rand(4000) then
		self:AddNp(SkillEffect[702400302], caster, target, data, -5)
	end
end
-- 伤害前
function Skill702400304:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8434
	local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
	-- 8117
	if SkillJudger:Greater(self, caster, self.card, true,count34,0) then
	else
		return
	end
	-- 702400304
	self:AddBuff(SkillEffect[702400304], caster, target, data, 702400301)
end
