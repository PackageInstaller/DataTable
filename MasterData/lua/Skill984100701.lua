-- 巨蟹座普通形态被动2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984100701 = oo.class(SkillBase)
function Skill984100701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill984100701:OnActionBegin(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8904
	if SkillJudger:LessEqual(self, caster, target, true,count76,3) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 984100703
	self:CallSkill(SkillEffect[984100703], caster, self.card, data, 984100301)
end
-- 行动结束
function Skill984100701:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 984100701
	if self:Rand(5000) then
		self:AddNp(SkillEffect[984100701], caster, caster, data, -10)
	end
end
-- 回合开始处理完成后
function Skill984100701:OnAfterRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 984100704
	local targets = SkillFilter:MaxAttr(self, caster, target, 1,"attack",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[984100704], caster, target, data, 984100101)
	end
end
