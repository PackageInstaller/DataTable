-- 吞噬者（怪）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4802302 = oo.class(SkillBase)
function Skill4802302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4802302:OnBornSpecial(caster, target, data)
	-- 4802303
	self:AddBuff(SkillEffect[4802303], caster, self.card, data, 4802301,5)
end
-- 行动结束2
function Skill4802302:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8673
	local count673 = SkillApi:BuffCount(self, caster, target,3,4,4802301)
	-- 8883
	if SkillJudger:Less(self, caster, target, true,count673,1) then
	else
		return
	end
	-- 4802308
	self:CallSkill(SkillEffect[4802308], caster, target, data, 802300401)
	-- 4802303
	self:AddBuff(SkillEffect[4802303], caster, self.card, data, 4802301,5)
end
