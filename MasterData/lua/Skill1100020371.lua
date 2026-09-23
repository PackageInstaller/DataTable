-- 角色造成的协击，反击伤害提高25%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020371 = oo.class(SkillBase)
function Skill1100020371:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100020371:OnBefourHurt(caster, target, data)
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
	-- 1100020377
	self:tFunc_1100020377_1100020371(caster, target, data)
	self:tFunc_1100020377_1100020374(caster, target, data)
end
function Skill1100020371:tFunc_1100020377_1100020371(caster, target, data)
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
	-- 1100020371
	self:AddTempAttr(SkillEffect[1100020371], caster, self.card, data, "damage",0.25)
end
function Skill1100020371:tFunc_1100020377_1100020374(caster, target, data)
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
	-- 1100020374
	self:AddTempAttr(SkillEffect[1100020374], caster, self.card, data, "damage",0.25)
end
