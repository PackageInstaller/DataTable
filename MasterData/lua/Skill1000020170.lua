-- 护盾词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000020170 = oo.class(SkillBase)
function Skill1000020170:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1000020170:OnActionOver(caster, target, data)
	-- 8688
	local count688 = SkillApi:BuffCount(self, caster, target,3,4,3)
	-- 1000020199
	if SkillJudger:Greater(self, caster, target, true,count688,0) then
	else
		return
	end
	-- 1000020170
	self:AddTempAttr(SkillEffect[1000020170], caster, self.card, data, "crit",0.8)
end
