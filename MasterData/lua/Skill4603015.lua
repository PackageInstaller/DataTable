-- 莫拉鲁塔
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603015 = oo.class(SkillBase)
function Skill4603015:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4603015:OnActionOver(caster, target, data)
	-- 4603005
	self:tFunc_4603005_4603025(caster, target, data)
	self:tFunc_4603005_4603015(caster, target, data)
end
-- 解体时
function Skill4603015:OnResolve(caster, target, data)
	-- 8735
	local count735 = SkillApi:SkillLevel(self, caster, target,3,6030102)
	-- 603010401
	self:CallSkill(SkillEffect[603010401], caster, self.card, data, 603010200+count735)
end
-- 攻击结束
function Skill4603015:OnAttackOver(caster, target, data)
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
	-- 603001308
	self:HitAddBuffCount(SkillEffect[603001308], caster, target, data, 10000,603000101,1,8)
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 603001311
	self:HitAddBuffCount(SkillEffect[603001311], caster, target, data, 10000,603000101,1,8)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4603015:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304316
	self:AddBuff(SkillEffect[4304316], caster, self.card, data, 6209)
end
function Skill4603015:tFunc_4603005_4603025(caster, target, data)
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
	-- 4603025
	self:OwnerAddBuff(SkillEffect[4603025], caster, caster, data, 4603005)
end
function Skill4603015:tFunc_4603005_4603015(caster, target, data)
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
	-- 4603015
	self:OwnerAddBuff(SkillEffect[4603015], caster, caster, data, 4603005)
end
