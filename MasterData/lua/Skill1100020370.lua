-- 角色造成的协击，反击伤害提高20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020370 = oo.class(SkillBase)
function Skill1100020370:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100020370:OnBefourHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8416
	local count16 = SkillApi:BuffCount(self, caster, target,2,2,2)
	-- 1100020376
	self:tFunc_1100020376_1100020370(caster, target, data)
	self:tFunc_1100020376_1100020373(caster, target, data)
end
function Skill1100020370:tFunc_1100020376_1100020370(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 1100020370
	self:AddTempAttr(SkillEffect[1100020370], caster, self.card, data, "damage",0.2)
end
function Skill1100020370:tFunc_1100020376_1100020373(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 9746
	if SkillJudger:IsOnHelp(self, caster, target, true) then
	else
		return
	end
	-- 1100020373
	self:AddTempAttr(SkillEffect[1100020373], caster, self.card, data, "damage",0.2)
end
