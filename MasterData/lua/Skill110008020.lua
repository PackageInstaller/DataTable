-- 第五章小怪被动三
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008020 = oo.class(SkillBase)
function Skill110008020:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill110008020:OnBefourHurt(caster, target, data)
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
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 8144
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 110008020
	self:AddTempAttr(SkillEffect[110008020], caster, caster, data, "damage",-0.2)
end
