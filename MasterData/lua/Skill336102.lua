-- 灼碧2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336102 = oo.class(SkillBase)
function Skill336102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill336102:OnRoundBegin(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8415
	local count15 = SkillApi:BuffCount(self, caster, target,1,2,2)
	-- 8896
	if SkillJudger:Greater(self, caster, target, true,count15,0) then
	else
		return
	end
	-- 336102
	if self:Rand(2000) then
		self:DelBuffQuality(SkillEffect[336102], caster, caster, data, 2,1)
		-- 336111
		self:AddBuff(SkillEffect[336111], caster, caster, data, 4004,1)
	end
end
