-- 蠢動
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer332605 = oo.class(BuffBase)
function Buffer332605:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer332605:OnBefourHurt(caster, target)
	-- 332605
	self:AddTempAttr(BufferEffect[332605], self.caster, self.card, nil, "bedamage",-0.10*self.nCount)
end
-- 行动结束
function Buffer332605:OnActionOver(caster, target)
	-- 332615
	self:AddProgress(BufferEffect[332615], self.caster, self.card, nil, 200*self.nCount)
	-- 332621
	self:DelBufferTypeForce(BufferEffect[332621], self.caster, self.card, nil, 332601)
end
