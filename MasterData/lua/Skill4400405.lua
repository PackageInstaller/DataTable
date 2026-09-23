-- 马赫火环
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4400405 = oo.class(SkillBase)
function Skill4400405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4400405:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4400406
	self:AddUplimitBuff(SkillEffect[4400406], caster, self.card, data, 3,3,4400401,5,4400401)
end
-- 伤害前
function Skill4400405:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4400405
	self:AddTempAttr(SkillEffect[4400405], caster, caster, data, "damage",-0.3)
end
