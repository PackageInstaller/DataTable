-- 能量计
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill403100101 = oo.class(SkillBase)
function Skill403100101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill403100101:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 伤害前
function Skill403100101:OnBefourHurt(caster, target, data)
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
	-- 8635
	local count635 = SkillApi:BuffCount(self, caster, target,3,4,403100201)
	-- 8835
	if SkillJudger:Greater(self, caster, target, true,count635,0) then
	else
		return
	end
	-- 403100101
	self:AddTempAttr(SkillEffect[403100101], caster, self.card, data, "damage",0.5)
end
