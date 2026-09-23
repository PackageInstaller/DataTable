-- 赫格妮2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338505 = oo.class(SkillBase)
function Skill338505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill338505:OnRoundBegin(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8088
	if SkillJudger:CasterPercentHp(self, caster, target, false,0.7) then
	else
		return
	end
	-- 8748
	local count748 = SkillApi:BuffCount(self, caster, target,3,3,603210401)
	-- 8963
	if SkillJudger:Greater(self, caster, self.card, true,count748,0) then
	else
		return
	end
	-- 338505
	self:Cure(SkillEffect[338505], caster, caster, data, 1,0.15)
end
-- 治疗时
function Skill338505:OnCure(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338515
	self:AddBuff(SkillEffect[338515], caster, target, data, 338505)
end
