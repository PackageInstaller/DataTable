-- 狂战I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24301 = oo.class(SkillBase)
function Skill24301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill24301:OnAfterHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 24301
	if self:Rand(4000) then
		self:OwnerAddBuffCount(SkillEffect[24301], caster, self.card, data, 24301,1,10)
		-- 243010
		self:ShowTips(SkillEffect[243010], caster, self.card, data, 2,"精准",true,243010)
	end
end
