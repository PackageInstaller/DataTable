-- 聖痕
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913910101 = oo.class(BuffBase)
function Buffer913910101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer913910101:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 913910101
	self:LimitDamage(BufferEffect[913910101], self.caster, target or self.owner, nil,0.5,0.3+self.nCount*0.05)
end
