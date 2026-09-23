-- 圣愈
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200700204 = oo.class(SkillBase)
function Skill200700204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill200700204:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 200700402
	self:AddBuff(SkillEffect[200700402], caster, self.card, data, 200700102)
	-- 8610
	local count610 = SkillApi:SkillLevel(self, caster, target,3,2007002)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8612
	local count612 = SkillApi:BuffCount(self, caster, target,3,3,200700101)
	-- 8808
	if SkillJudger:Less(self, caster, self.card, true,count612,1) then
	else
		return
	end
	-- 200700203
	self:CallSkill(SkillEffect[200700203], caster, self.card, data, 200700400+count610)
end
-- 伤害后
function Skill200700204:OnAfterHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8421
	local count21 = SkillApi:GetLastHitDamage(self, caster, target,1)
	-- 200700214
	self:AddEnergy(SkillEffect[200700214], caster, self.card, data, count21*0.35,1)
end
