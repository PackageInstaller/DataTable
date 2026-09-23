-- 千机引
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600800203 = oo.class(SkillBase)
function Skill600800203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600800203:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动开始
function Skill600800203:OnActionBegin(caster, target, data)
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
	-- 8458
	local count58 = SkillApi:GetAttr(self, caster, target,2,"attack")
	-- 600800201
	self:AddTempAttr(SkillEffect[600800201], caster, self.card, data, "attack",count58*0.3)
end
