-- 漆黑_Schwarz（剑）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4802411 = oo.class(SkillBase)
function Skill4802411:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4802411:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4802401
	self:AddBuff(SkillEffect[4802401], caster, self.card.oSummonOwner, data, 4802401)
end
-- 伤害后
function Skill4802411:OnAfterHurt(caster, target, data)
	-- 4802413
	self:tFunc_4802413_4802411(caster, target, data)
	self:tFunc_4802413_4802412(caster, target, data)
end
function Skill4802411:tFunc_4802413_4802411(caster, target, data)
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
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 4802411
	self:LimitDamage(SkillEffect[4802411], caster, target, data, 1,0.4)
end
function Skill4802411:tFunc_4802413_4802412(caster, target, data)
	-- 8065
	if SkillJudger:CasterIsSummoner(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 4802412
	self:LimitDamage(SkillEffect[4802412], caster, target, data, 1,0.4)
end
