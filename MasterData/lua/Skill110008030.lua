-- 第6章小怪被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008030 = oo.class(SkillBase)
function Skill110008030:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill110008030:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 110008030
	if self:Rand(5000) then
		self:AddBuffCount(SkillEffect[110008030], caster, self.card, data, 110008030,1,10)
	end
end
