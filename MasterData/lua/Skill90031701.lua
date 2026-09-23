-- 技能17
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90031701 = oo.class(SkillBase)
function Skill90031701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90031701:DoSkill(caster, target, data)
	-- 8253
	if SkillJudger:IsLive(self, caster, target, false) then
	else
		return
	end
	-- 90001
	self.order = self.order + 1
	self:Revive(SkillEffect[90001], caster, target, data, 1,0.1,{progress=1000})
end
