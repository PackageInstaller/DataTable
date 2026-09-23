-- 岁稔技能3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942301302 = oo.class(SkillBase)
function Skill942301302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942301302:DoSkill(caster, target, data)
	-- 704301302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704301302], caster, target, data, 704301302)
end
-- 伤害后
function Skill942301302:OnAfterHurt(caster, target, data)
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8134
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.4) then
	else
		return
	end
	-- 8151
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.001) then
	else
		return
	end
	-- 8704
	local count704 = SkillApi:BuffCount(self, caster, target,3,4,704300301)
	-- 8921
	if SkillJudger:Greater(self, caster, target, true,count704,0) then
	else
		return
	end
	-- 704300311
	self:SetHP(SkillEffect[704300311], caster, target, data, 1)
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 704300321
	self:AddHp(SkillEffect[704300321], caster, self.card, data, -count49*0.4)
	-- 704300331
	self:Cure(SkillEffect[704300331], caster, target, data, 6,0.2)
end
