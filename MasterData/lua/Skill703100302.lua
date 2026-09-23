-- 子弹风暴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703100302 = oo.class(SkillBase)
function Skill703100302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703100302:DoSkill(caster, target, data)
	-- 12007
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12007], caster, target, data, 0.143,7)
end
-- 伤害后
function Skill703100302:OnAfterHurt(caster, target, data)
	-- 703100411
	self:tFunc_703100411_703100301(caster, target, data)
	self:tFunc_703100411_703100311(caster, target, data)
end
function Skill703100302:tFunc_703100411_703100301(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8822
	if SkillJudger:Less(self, caster, self.card, true,count29,1) then
	else
		return
	end
	-- 703100301
	self:HitAddBuff(SkillEffect[703100301], caster, target, data, 3000,1003,2)
end
function Skill703100302:tFunc_703100411_703100311(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
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
	-- 8702
	local count702 = SkillApi:BuffCount(self, caster, target,2,3,1051)
	-- 8917
	if SkillJudger:Less(self, caster, target, true,count702,1) then
	else
		return
	end
	-- 703100311
	self:HitAddBuff(SkillEffect[703100311], caster, target, data, 3000,1051,2)
end
