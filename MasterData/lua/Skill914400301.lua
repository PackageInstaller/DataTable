-- 蜘蛛召唤物2技能2（使角色获得buff）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914400301 = oo.class(SkillBase)
function Skill914400301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914400301:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 914400201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[914400201], caster, target, data, 4010)
end
