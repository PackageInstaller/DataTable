-- 兄妹同心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill323002 = oo.class(SkillBase)
function Skill323002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill323002:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8607
	local count607 = SkillApi:SkillLevel(self, caster, target,3,3023003)
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 323002
	if self:Rand(900) then
		self:BeatBack(SkillEffect[323002], caster, self.card, data, 302300300+count607,2)
	end
end
