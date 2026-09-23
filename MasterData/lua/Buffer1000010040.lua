-- 我方單位回合開始時，恢復7點NP
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010040 = oo.class(BuffBase)
function Buffer1000010040:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010040:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010040
	self:AddNp(BufferEffect[1000010040], self.caster, self.card, nil, 5)
end
