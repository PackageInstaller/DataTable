-- 重装
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4101105 = oo.class(SkillBase)
function Skill4101105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4101105:OnBefourHurt(caster, target, data)
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
	-- 8222
	if SkillJudger:IsDamageType(self, caster, target, true,1) then
	else
		return
	end
	-- 4101105
	self:AddTempAttr(SkillEffect[4101105], caster, caster, data, "damage",-0.20)
	-- 4101106
	self:ShowTips(SkillEffect[4101106], caster, self.card, data, 2,"重装",true,4101106)
end
