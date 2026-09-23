-- 莫拉鲁塔
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603004 = oo.class(SkillBase)
function Skill4603004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4603004:OnActionOver(caster, target, data)
	-- 4603004
	self:tFunc_4603004_4603024(caster, target, data)
	self:tFunc_4603004_4603014(caster, target, data)
end
function Skill4603004:tFunc_4603004_4603014(caster, target, data)
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
	-- 4603014
	self:OwnerAddBuff(SkillEffect[4603014], caster, caster, data, 4603004)
end
function Skill4603004:tFunc_4603004_4603024(caster, target, data)
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
	-- 4603024
	self:OwnerAddBuff(SkillEffect[4603024], caster, caster, data, 4603004)
end
