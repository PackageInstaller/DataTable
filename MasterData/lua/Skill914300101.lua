-- 蜘蛛召唤物1技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914300101 = oo.class(SkillBase)
function Skill914300101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914300101:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 入场时
function Skill914300101:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914300203
	self:CallSkillEx(SkillEffect[914300203], caster, self.card, data, 914300201)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9143002031
	self:CallSkillEx(SkillEffect[9143002031], caster, self.card, data, 914300202)
end
