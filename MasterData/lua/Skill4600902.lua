-- 哀矜惩创
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4600902 = oo.class(SkillBase)
function Skill4600902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4600902:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600903
	self:AddBuffCount(SkillEffect[4600903], caster, self.card, data, 4600901,4,8)
	-- 4600911
	self:AddBuff(SkillEffect[4600911], caster, self.card, data, 6103,1)
end
-- 回合结束时
function Skill4600902:OnRoundOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4600901
	self:AddBuffCount(SkillEffect[4600901], caster, self.card, data, 4600901,1,8)
	-- 8647
	local count647 = SkillApi:GetCount(self, caster, target,3,4600901)
	-- 8847
	if SkillJudger:Greater(self, caster, target, true,count647,7) then
	else
		return
	end
	-- 4600924
	self:DelBuffQuality(SkillEffect[4600924], caster, self.card, data, 2,10)
	-- 4600917
	self:AddBuffCount(SkillEffect[4600917], caster, self.card, data, 4600901,-8,8)
	-- 8646
	local count646 = SkillApi:BuffCount(self, caster, target,3,4,600900301)
	-- 4600921
	if SkillJudger:Greater(self, caster, target, true,count646,0) then
		-- 4600913
		local targets = SkillFilter:All(self, caster, target, 3)
		for i,target in ipairs(targets) do
			self:AddProgress(SkillEffect[4600913], caster, target, data, 150)
		end
	else
		-- 4600916
		self:CallOwnerSkill(SkillEffect[4600916], caster, self.card, data, 600900601)
	end
end
