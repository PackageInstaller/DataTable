-- 赫格妮2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338501 = oo.class(SkillBase)
function Skill338501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill338501:OnRoundBegin(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8084
	if SkillJudger:CasterPercentHp(self, caster, target, false,0.3) then
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
	-- 338501
	self:Cure(SkillEffect[338501], caster, caster, data, 1,0.15)
end
-- 治疗时
function Skill338501:OnCure(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338511
	self:AddBuff(SkillEffect[338511], caster, target, data, 338501)
end
