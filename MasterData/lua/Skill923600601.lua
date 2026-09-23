-- 世界树boss共用被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill923600601 = oo.class(SkillBase)
function Skill923600601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill923600601:OnBefourHurt(caster, target, data)
	-- 923600607
	self:tFunc_923600607_923600605(caster, target, data)
	self:tFunc_923600607_923600606(caster, target, data)
end
function Skill923600601:tFunc_923600607_923600605(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 923600605
	self:AddTempAttr(SkillEffect[923600605], caster, self.card, data, "bedamage2",-0.3)
end
function Skill923600601:tFunc_923600607_923600606(caster, target, data)
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
	-- 9764
	if SkillJudger:IsCrit(self, caster, target, false) then
	else
		return
	end
	-- 923600606
	self:AddTempAttr(SkillEffect[923600606], caster, self.card, data, "bedamage2",0.5)
end
