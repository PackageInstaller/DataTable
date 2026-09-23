-- 多队战斗最后一关关卡5buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070310 = oo.class(SkillBase)
function Skill1100070310:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070310:OnBefourHurt(caster, target, data)
	-- 1100071320
	self:tFunc_1100071320_1100071310(caster, target, data)
	self:tFunc_1100071320_1100071315(caster, target, data)
end
function Skill1100070310:tFunc_1100071320_1100071315(caster, target, data)
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
	-- 1100071315
	self:AddTempAttr(SkillEffect[1100071315], caster, self.card, data, "bedamage",0.3)
end
function Skill1100070310:tFunc_1100071320_1100071310(caster, target, data)
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
	-- 1100071310
	self:AddTempAttr(SkillEffect[1100071310], caster, self.card, data, "bedamage",0.3)
end
