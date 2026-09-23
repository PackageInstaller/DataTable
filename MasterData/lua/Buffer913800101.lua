-- 聖痕
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913800101 = oo.class(BuffBase)
function Buffer913800101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer913800101:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 913800101
	self:LimitDamage(BufferEffect[913800101], self.caster, target or self.owner, nil,0.5,0.3+self.nCount*0.05)
end
-- 创建时
function Buffer913800101:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 913800101
	self:LimitDamage(BufferEffect[913800101], self.caster, target or self.owner, nil,0.5,0.3+self.nCount*0.05)
end
