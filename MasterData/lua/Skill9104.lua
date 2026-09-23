-- 乐团
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9104 = oo.class(SkillBase)
function Skill9104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill9104:OnBefourHurt(caster, target, data)
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
	-- 8232
	if SkillJudger:IsCasterMech(self, caster, self.card, false,2) then
	else
		return
	end
	-- 9104
	self:AddTempAttr(SkillEffect[9104], caster, caster, data, "damage",-0.5)
end
