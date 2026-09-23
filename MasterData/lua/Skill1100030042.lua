-- 肉鸽不朽阵营角色回复或者受到伤害加buff，每层4%攻击力，4%防御力，最高100层，使用大招技能血量减少10%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100030042 = oo.class(SkillBase)
function Skill1100030042:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100030042:OnAttackOver(caster, target, data)
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8816
	if SkillJudger:Greater(self, caster, target, true,count616,0) then
	else
		return
	end
	-- 11000300402
	self:tFunc_11000300402_1100030042(caster, target, data)
	self:tFunc_11000300402_1100030045(caster, target, data)
end
-- 治疗时
function Skill1100030042:OnCure(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 9752
	if SkillJudger:IsTargetMech(self, caster, target, true,3) then
	else
		return
	end
	-- 9752
	if SkillJudger:IsTargetMech(self, caster, target, true,3) then
	else
		return
	end
	-- 1100030045
	self:OwnerAddBuffCount(SkillEffect[1100030045], caster, self.card, data, 1100030042,1,100)
end
-- 行动结束
function Skill1100030042:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 1100030015
	self:AddHp(SkillEffect[1100030015], caster, caster, data, -count20*0.1)
end
function Skill1100030042:tFunc_11000300402_1100030042(caster, target, data)
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
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8816
	if SkillJudger:Greater(self, caster, target, true,count616,0) then
	else
		return
	end
	-- 9752
	if SkillJudger:IsTargetMech(self, caster, target, true,3) then
	else
		return
	end
	-- 1100030042
	self:OwnerAddBuffCount(SkillEffect[1100030042], caster, self.card, data, 1100030042,1,100)
end
function Skill1100030042:tFunc_11000300402_1100030045(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 9752
	if SkillJudger:IsTargetMech(self, caster, target, true,3) then
	else
		return
	end
	-- 9752
	if SkillJudger:IsTargetMech(self, caster, target, true,3) then
	else
		return
	end
	-- 1100030045
	self:OwnerAddBuffCount(SkillEffect[1100030045], caster, self.card, data, 1100030042,1,100)
end
