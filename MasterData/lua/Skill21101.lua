-- 储备I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill21101 = oo.class(SkillBase)
function Skill21101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill21101:OnActionOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsCanHurt(self, caster, target, false) then
	else
		return
	end
	-- 8965
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 21101
	if self:Rand(4000) then
		self:AddNp(SkillEffect[21101], caster, caster, data, 5)
		-- 211010
		self:ShowTips(SkillEffect[211010], caster, self.card, data, 2,"慈悲",true,211010)
	end
end
