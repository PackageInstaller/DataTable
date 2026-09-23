-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer60000075 = oo.class(BuffBase)
function Buffer60000075:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer60000075:OnActionBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8225
	if SkillJudger:IsTypeOf(self, self.caster, target, true,4) then
	else
		return
	end
	-- 60000075
	if self:Rand(5000) then
		self:ImmuneBuffID(BufferEffect[60000075], self.caster, self.card, nil, 3003)
	end
end
