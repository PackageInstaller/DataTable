-- 丰盈之喜
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4701305 = oo.class(SkillBase)
function Skill4701305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4701305:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4701305
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[4701305], caster, target, data, 4701305)
	end
	-- 4701307
	self:ShowTips(SkillEffect[4701307], caster, self.card, data, 2,"丰盈之喜",true,4701307)
end
-- 死亡时
function Skill4701305:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4701306
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[4701306], caster, target, data, 4701301)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill4701305:OnBornSpecial(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4701315
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[4701315], caster, target, data, 4701305)
	end
end
