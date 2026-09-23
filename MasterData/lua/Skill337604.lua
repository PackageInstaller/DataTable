-- 裂骨4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337604 = oo.class(SkillBase)
function Skill337604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill337604:OnRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8452
	local count52 = SkillApi:BuffCount(self, caster, target,1,3,1002)
	-- 8154
	if SkillJudger:Greater(self, caster, target, true,count52,0) then
	else
		return
	end
	-- 337604
	self:OwnerAddBuff(SkillEffect[337604], caster, caster, data, 337604)
end
