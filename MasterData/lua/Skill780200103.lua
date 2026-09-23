-- 卡提那·联域1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780200103 = oo.class(SkillBase)
function Skill780200103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780200103:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 伤害前
function Skill780200103:OnBefourHurt(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8767
	local count767 = SkillApi:BuffCount(self, caster, target,2,4,780200201)
	-- 780200102
	if SkillJudger:Greater(self, caster, target, true,count767,0) then
	else
		return
	end
	-- 780200101
	self:AddTempAttr(SkillEffect[780200101], caster, self.card, data, "damage",0.5)
end
