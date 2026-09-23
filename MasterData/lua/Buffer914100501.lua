-- 滾燙灼燒
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer914100501 = oo.class(BuffBase)
function Buffer914100501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始处理完成后
function Buffer914100501:OnAfterRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 914100501
	self:LimitDamage2(BufferEffect[914100501], self.caster, target or self.owner, nil,0.2,2)
end
