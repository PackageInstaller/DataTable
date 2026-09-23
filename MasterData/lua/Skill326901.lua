-- 银羽爆炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill326901 = oo.class(SkillBase)
function Skill326901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill326901:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 326901
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[326901], caster, target, data, 4500404)
	end
end
-- 回合开始时
function Skill326901:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8106
	if SkillJudger:Less(self, caster, self.card, true,count20,2) then
	else
		return
	end
	-- 326902
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[326902], caster, target, data, 4500404)
	end
end
