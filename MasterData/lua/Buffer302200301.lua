-- 恐懼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer302200301 = oo.class(BuffBase)
function Buffer302200301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer302200301:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 302200307
	if self:Rand(4000) then
		self:AddSp(BufferEffect[302200307], self.caster, self.card, nil, -20)
		-- 302200308
		if self:Rand(4000) then
			self:AddNp(BufferEffect[302200308], self.caster, self.card, nil, -10)
		end
	end
end
