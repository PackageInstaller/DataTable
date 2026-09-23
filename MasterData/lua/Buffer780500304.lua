-- 裁量秘儀
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer780500304 = oo.class(BuffBase)
function Buffer780500304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer780500304:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 780500301
	self:ImmuneDeath(BufferEffect[780500301], self.caster, self.creater, nil, nil)
end
