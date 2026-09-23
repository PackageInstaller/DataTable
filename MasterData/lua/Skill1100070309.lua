-- 多队战斗最后一关关卡4buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070309 = oo.class(SkillBase)
function Skill1100070309:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070309:OnBefourHurt(caster, target, data)
	-- 1100071319
	self:tFunc_1100071319_1100071309(caster, target, data)
	self:tFunc_1100071319_1100071314(caster, target, data)
end
function Skill1100070309:tFunc_1100071319_1100071309(caster, target, data)
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
	-- 1100071309
	self:AddTempAttr(SkillEffect[1100071309], caster, self.card, data, "bedamage",0.25)
end
function Skill1100070309:tFunc_1100071319_1100071314(caster, target, data)
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
	-- 1100071314
	self:AddTempAttr(SkillEffect[1100071314], caster, self.card, data, "bedamage",0.25)
end
