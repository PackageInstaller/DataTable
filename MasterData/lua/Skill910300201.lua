-- 毁伤射击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill910300201 = oo.class(SkillBase)
function Skill910300201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill910300201:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
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
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 8459
	local count59 = SkillApi:GetAttr(self, caster, target,2,"defense")
	-- 8319
	self:AddValue(SkillEffect[8319], caster, self.card, data, "fy1",count59)
	-- 8559
	self.order = self.order + 1
	self:RelevanceBuff(SkillEffect[8559], caster, target, data, 8502,8512)
	-- 8320
	self.order = self.order + 1
	self:DelValue(SkillEffect[8320], caster, self.card, data, "fy1")
end
