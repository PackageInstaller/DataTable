-- 仲裁者
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4803701 = oo.class(SkillBase)
function Skill4803701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4803701:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4803701
	self:CallSkillEx(SkillEffect[4803701], caster, self.card, data, 803700401)
end
-- 入场时
function Skill4803701:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4803701
	self:CallSkillEx(SkillEffect[4803701], caster, self.card, data, 803700401)
end
-- 伤害前
function Skill4803701:OnBefourHurt(caster, target, data)
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
	-- 4803702
	self:DelBufferGroup(SkillEffect[4803702], caster, target, data, 2,1)
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
	-- 8412
	local count12 = SkillApi:BuffCount(self, caster, target,2,1,2)
	-- 8826
	if SkillJudger:Less(self, caster, target, true,count12,1) then
	else
		return
	end
	-- 4803703
	self:AddTempAttr(SkillEffect[4803703], caster, self.card, data, "damage",0.4)
end
