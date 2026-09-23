-- 身上有護盾時增傷80%，持續1場戰鬥
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020040 = oo.class(BuffBase)
function Buffer1000020040:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000020040:OnBefourHurt(caster, target)
	-- 8738
	local c134 = SkillApi:BuffCount(self, self.caster, target or self.owner,3,4,3)
	-- 1000020199
	if SkillJudger:Greater(self, self.caster, self.card, true,c134,0) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020040
	self:AddTempAttrPercent(BufferEffect[1000020040], self.caster, self.card, nil, "damage",1)
end
