-- 破袭战
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4400104 = oo.class(SkillBase)
function Skill4400104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill4400104:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4400104
	self:OwnerAddBuffCount(SkillEffect[4400104], caster, self.card, data, 4400104,1,5)
	-- 4400106
	self:ShowTips(SkillEffect[4400106], caster, self.card, data, 2,"破袭战",true,4400106)
end
