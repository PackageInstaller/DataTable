-- 岁稔被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4942302 = oo.class(SkillBase)
function Skill4942302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill4942302:OnRoundOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8707
	local count707 = SkillApi:SkillLevel(self, caster, target,3,9423001)
	-- 8704
	local count704 = SkillApi:BuffCount(self, caster, target,3,4,704300301)
	-- 8921
	if SkillJudger:Greater(self, caster, target, true,count704,0) then
	else
		return
	end
	-- 4942302
	if self:Rand(4000) then
		self:CallOwnerSkill(SkillEffect[4942302], caster, caster, data, 942300100+count707)
	end
end
