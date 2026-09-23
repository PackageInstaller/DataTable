-- 电磁力场
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill400700205 = oo.class(SkillBase)
function Skill400700205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill400700205:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 行动结束
function Skill400700205:OnActionOver(caster, target, data)
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
	-- 8621
	local count621 = SkillApi:BuffCount(self, caster, target,3,4,40070)
	-- 8819
	if SkillJudger:Less(self, caster, target, true,count621,1) then
	else
		return
	end
	-- 400700201
	self:AddBuff(SkillEffect[400700201], caster, self.card, data, 400700201)
end
-- 伤害后
function Skill400700205:OnAfterHurt(caster, target, data)
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
	-- 8622
	local count622 = SkillApi:SkillLevel(self, caster, target,3,3256)
	-- 8820
	if SkillJudger:Greater(self, caster, target, true,count622,0) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 400700202
	self:ResetCD(SkillEffect[400700202], caster, self.card, data, 0)
end
