-- 自身暴击高于100%时，攻击时将溢出的暴击转化为暴伤，每溢出1点暴击转化1.5点暴伤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020162 = oo.class(SkillBase)
function Skill1100020162:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill1100020162:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100020162
	self:AddBuff(SkillEffect[1100020162], caster, self.card, data, 1100020162)
end
