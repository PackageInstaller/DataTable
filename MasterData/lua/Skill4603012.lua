-- 莫拉鲁塔
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603012 = oo.class(SkillBase)
function Skill4603012:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4603012:OnActionOver(caster, target, data)
	-- 4603002
	self:tFunc_4603002_4603022(caster, target, data)
	self:tFunc_4603002_4603012(caster, target, data)
end
-- 解体时
function Skill4603012:OnResolve(caster, target, data)
	-- 8735
	local count735 = SkillApi:SkillLevel(self, caster, target,3,6030102)
	-- 603010401
	self:CallSkill(SkillEffect[603010401], caster, self.card, data, 603010200+count735)
end
-- 攻击结束
function Skill4603012:OnAttackOver(caster, target, data)
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
	-- 603001306
	self:HitAddBuffCount(SkillEffect[603001306], caster, target, data, 10000,603000101,1,6)
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 603001309
	self:HitAddBuffCount(SkillEffect[603001309], caster, target, data, 10000,603000101,1,6)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4603012:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304316
	self:AddBuff(SkillEffect[4304316], caster, self.card, data, 6209)
end
function Skill4603012:tFunc_4603002_4603022(caster, target, data)
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
	-- 4603022
	self:OwnerAddBuff(SkillEffect[4603022], caster, caster, data, 4603002)
end
function Skill4603012:tFunc_4603002_4603012(caster, target, data)
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
	-- 4603012
	self:OwnerAddBuff(SkillEffect[4603012], caster, caster, data, 4603002)
end
