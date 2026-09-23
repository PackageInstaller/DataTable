-- 放逐者
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4803401 = oo.class(SkillBase)
function Skill4803401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4803401:OnBornSpecial(caster, target, data)
	-- 8239
	if SkillJudger:IsCasterMech(self, caster, self.card, true,6) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4803401
	local targets = SkillFilter:Group(self, caster, target, 3,6)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4803401], caster, target, data, 4803401)
	end
end
-- 伤害前
function Skill4803401:OnBefourHurt(caster, target, data)
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
	-- 4803403
	self:AddTempAttr(SkillEffect[4803403], caster, target, data, "defense",-200)
end
-- 行动结束
function Skill4803401:OnActionOver(caster, target, data)
	-- 8239
	if SkillJudger:IsCasterMech(self, caster, self.card, true,6) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4803402
	self:AddProgress(SkillEffect[4803402], caster, self.card, data, 100)
end
