-- 歡快
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200800202 = oo.class(BuffBase)
function Buffer200800202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer200800202:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 200900312
	self:Cure(BufferEffect[200900312], self.caster, target or self.owner, nil,8,0.09)
end
