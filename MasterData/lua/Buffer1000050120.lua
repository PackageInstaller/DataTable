-- 自身當前生命值百分比小於50%時，造成的傷害提高40%。
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050120 = oo.class(BuffBase)
function Buffer1000050120:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer1000050120:OnActionBegin(caster, target)
	-- 8084
	if SkillJudger:CasterPercentHp(self, self.caster, target, false,0.5) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000050120
	self:AddTempAttrPercent(BufferEffect[1000050120], self.caster, self.card, nil, "damage",0.4)
end
