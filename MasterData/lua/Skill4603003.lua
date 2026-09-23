-- 莫拉鲁塔
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603003 = oo.class(SkillBase)
function Skill4603003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4603003:OnActionOver(caster, target, data)
	-- 4603003
	self:tFunc_4603003_4603023(caster, target, data)
	self:tFunc_4603003_4603013(caster, target, data)
end
function Skill4603003:tFunc_4603003_4603013(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8239
	if SkillJudger:IsCasterMech(self, caster, self.card, true,6) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4603013
	self:OwnerAddBuff(SkillEffect[4603013], caster, caster, data, 4603003)
end
function Skill4603003:tFunc_4603003_4603023(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8239
	if SkillJudger:IsCasterMech(self, caster, self.card, true,6) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4603023
	self:OwnerAddBuff(SkillEffect[4603023], caster, caster, data, 4603003)
end
