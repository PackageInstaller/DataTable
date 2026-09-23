-- 戏言轰炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103310303 = oo.class(SkillBase)
function Skill103310303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103310303:DoSkill(caster, target, data)
	-- 13051
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13051], caster, target, data, 0.167,6)
	-- 8981
	local count981 = SkillApi:SkillLevel(self, caster, target,3,41033)
	-- 8988
	local count988 = SkillApi:GetCount(self, caster, target,2,4103305+count981)
	-- 4103305
	if SkillJudger:Greater(self, caster, target, true,count988,0) then
	else
		return
	end
	-- 13052
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13052], caster, target, data, 0.167,1)
	-- 8981
	local count981 = SkillApi:SkillLevel(self, caster, target,3,41033)
	-- 8988
	local count988 = SkillApi:GetCount(self, caster, target,2,4103305+count981)
	-- 4103306
	if SkillJudger:Greater(self, caster, target, true,count988,1) then
	else
		return
	end
	-- 13053
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13053], caster, target, data, 0.167,1)
	-- 8981
	local count981 = SkillApi:SkillLevel(self, caster, target,3,41033)
	-- 8988
	local count988 = SkillApi:GetCount(self, caster, target,2,4103305+count981)
	-- 4103307
	if SkillJudger:Greater(self, caster, target, true,count988,2) then
	else
		return
	end
	-- 13054
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13054], caster, target, data, 0.167,1)
end
-- 攻击结束
function Skill103310303:OnAttackOver(caster, target, data)
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
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8981
	local count981 = SkillApi:SkillLevel(self, caster, target,3,41033)
	-- 8988
	local count988 = SkillApi:GetCount(self, caster, target,2,4103305+count981)
	-- 4103305
	if SkillJudger:Greater(self, caster, target, true,count988,0) then
	else
		return
	end
	-- 103310301
	self:AddBuffCount(SkillEffect[103310301], caster, target, data, 4103305+count981,1,999)
end
