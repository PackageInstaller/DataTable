-- 多队战斗最后一关关卡3buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070308 = oo.class(SkillBase)
function Skill1100070308:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070308:OnBefourHurt(caster, target, data)
	-- 1100071318
	self:tFunc_1100071318_1100071308(caster, target, data)
	self:tFunc_1100071318_1100071313(caster, target, data)
end
function Skill1100070308:tFunc_1100071318_1100071313(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100071313
	self:AddTempAttr(SkillEffect[1100071313], caster, self.card, data, "bedamage",0.2)
end
function Skill1100070308:tFunc_1100071318_1100071308(caster, target, data)
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
	-- 1100071308
	self:AddTempAttr(SkillEffect[1100071308], caster, self.card, data, "bedamage",0.2)
end
