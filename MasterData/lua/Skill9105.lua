-- 不朽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9105 = oo.class(SkillBase)
function Skill9105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill9105:OnBefourHurt(caster, target, data)
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
	-- 8233
	if SkillJudger:IsCasterMech(self, caster, self.card, true,3) then
	else
		return
	end
	-- 9105
	self:AddTempAttr(SkillEffect[9105], caster, caster, data, "damage",0.5)
end
