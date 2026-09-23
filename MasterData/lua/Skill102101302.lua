-- 戏言轰炸（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102101302 = oo.class(SkillBase)
function Skill102101302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102101302:DoSkill(caster, target, data)
	-- 11121
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11121], caster, target, data, 0.1667,4)
	-- 11122
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11122], caster, target, data, 0.333,1)
end
-- 行动结束
function Skill102101302:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8463
	local count63 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 102100304
	self:RandAddBuff(SkillEffect[102100304], caster, self.card, data, 2000+count63*2,6113,1)
end
