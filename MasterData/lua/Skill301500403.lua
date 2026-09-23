-- 水能之刃（强化）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301500403 = oo.class(SkillBase)
function Skill301500403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill301500403:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill301500403:OnAttackOver(caster, target, data)
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
	-- 301500401
	self:ChangeSkill(SkillEffect[301500401], caster, target, data, 1,301500101)
end
