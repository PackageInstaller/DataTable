-- 持續修復
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2001 = oo.class(BuffBase)
function Buffer2001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer2001:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 2001
	self:Cure(BufferEffect[2001], self.caster, target or self.owner, nil,8,0.05)
end
