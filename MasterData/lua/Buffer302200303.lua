-- 陷落標記
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer302200303 = oo.class(BuffBase)
function Buffer302200303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer302200303:OnActionOver(caster, target)
	-- 302200310
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(BufferEffect[302200310], self.caster, target, nil, 302200301,1)
	end
	-- 302200311
	self:DelBufferForce(BufferEffect[302200311], self.caster, self.card, nil, 302200303)
end
