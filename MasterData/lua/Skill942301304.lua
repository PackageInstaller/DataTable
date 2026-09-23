-- 岁稔技能3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942301304 = oo.class(SkillBase)
function Skill942301304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942301304:DoSkill(caster, target, data)
	-- 704301304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704301304], caster, target, data, 704301304)
end
-- 伤害后
function Skill942301304:OnAfterHurt(caster, target, data)
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
	-- 704300312
	self:SetHP(SkillEffect[704300312], caster, target, data, 1)
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 704300322
	self:AddHp(SkillEffect[704300322], caster, self.card, data, -count49*0.4)
	-- 704300332
	self:Cure(SkillEffect[704300332], caster, target, data, 6,0.3)
end
