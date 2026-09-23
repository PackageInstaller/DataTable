-- 巨兽撕咬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302200301 = oo.class(SkillBase)
function Skill302200301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302200301:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
-- 死亡时
function Skill302200301:OnDeath(caster, target, data)
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
	-- 302200202
	self:OwnerAddBuffCount(SkillEffect[302200202], caster, self.card, data, 302200201,-1,3)
	-- 302200205
	self:DelBufferForce(SkillEffect[302200205], caster, self.card, data, 302200204,1)
end
-- 伤害前
function Skill302200301:OnBefourHurt(caster, target, data)
	-- 302200301
	self:tFunc_302200301_302200302(caster, target, data)
	self:tFunc_302200301_302200303(caster, target, data)
end
-- 攻击开始
function Skill302200301:OnAttackBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8488
	local count88 = SkillApi:GetCount(self, caster, target,3,302200201)
	-- 8179
	if SkillJudger:Greater(self, caster, target, true,count88,0) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 302200304
	self:AddBuff(SkillEffect[302200304], caster, self.card, data, 302200302)
end
function Skill302200301:tFunc_302200301_302200302(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8488
	local count88 = SkillApi:GetCount(self, caster, target,3,302200201)
	-- 8179
	if SkillJudger:Greater(self, caster, target, true,count88,0) then
	else
		return
	end
	-- 8416
	local count16 = SkillApi:BuffCount(self, caster, target,2,2,2)
	-- 8108
	if SkillJudger:Greater(self, caster, self.card, true,count16,0) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 302200302
	self:AddTempAttr(SkillEffect[302200302], caster, self.card, data, "damage",0.3)
end
function Skill302200301:tFunc_302200301_302200303(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8488
	local count88 = SkillApi:GetCount(self, caster, target,3,302200201)
	-- 8181
	if SkillJudger:Greater(self, caster, target, true,count88,2) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 302200303
	self:AddTempAttrPercent(SkillEffect[302200303], caster, target, data, "defense",-0.25)
end
