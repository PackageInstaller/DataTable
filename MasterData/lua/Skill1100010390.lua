-- 释放护盾技能时候，全体角色永久增加5%攻击力，5%暴击伤害，降低20%防御力，最高5层
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010390 = oo.class(SkillBase)
function Skill1100010390:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100010390:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8267
	if SkillJudger:IsCtrlType(self, caster, target, true,13) then
	else
		return
	end
	-- 1100010390
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuffCount(SkillEffect[1100010390], caster, target, data, 1100010390,1,5)
	end
end
