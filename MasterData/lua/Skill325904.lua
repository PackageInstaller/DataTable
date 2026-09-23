-- 协助增幅
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill325904 = oo.class(SkillBase)
function Skill325904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill325904:OnActionBegin(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 325904
	if self:Rand(7000) then
		self:OwnerAddBuffCount(SkillEffect[325904], caster, self.card, data, 4303101,1,3)
	end
end
