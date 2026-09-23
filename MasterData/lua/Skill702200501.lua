-- 火焰护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702200501 = oo.class(SkillBase)
function Skill702200501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702200501:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8625
	local count625 = SkillApi:SkillLevel(self, caster, target,1,7022002)
	-- 4702207
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4702207], caster, self.card, data, 702200200+count625)
end
