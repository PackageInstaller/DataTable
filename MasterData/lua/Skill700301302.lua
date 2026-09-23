-- 潮汐旋涡（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill700301302 = oo.class(SkillBase)
function Skill700301302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill700301302:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 行动结束
function Skill700301302:OnActionOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8422
	local count22 = SkillApi:BuffCount(self, caster, target,1,4,650)
	-- 8902
	if SkillJudger:Greater(self, caster, target, true,count22,0) then
	else
		return
	end
	-- 8554
	self:Cure(SkillEffect[8554], caster, self.card, data, 1,math.max(count22*0.08,0.08))
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8422
	local count22 = SkillApi:BuffCount(self, caster, target,1,4,650)
	-- 8902
	if SkillJudger:Greater(self, caster, target, true,count22,0) then
	else
		return
	end
	-- 8555
	self:AddBuff(SkillEffect[8555], caster, self.card, data, 2150+count22)
end
