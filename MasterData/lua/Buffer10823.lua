-- 源源不斷-等級4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10823 = oo.class(BuffBase)
function Buffer10823:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer10823:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4823
	if self:Rand(4000) then
		self:AddNp(BufferEffect[4823], self.caster, target or self.owner, nil,5)
	end
end
