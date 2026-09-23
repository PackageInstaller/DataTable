-- 蠢動
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer332603 = oo.class(BuffBase)
function Buffer332603:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer332603:OnBefourHurt(caster, target)
	-- 332603
	self:AddTempAttr(BufferEffect[332603], self.caster, self.card, nil, "bedamage",-0.06*self.nCount)
end
-- 行动结束
function Buffer332603:OnActionOver(caster, target)
	-- 332613
	self:AddProgress(BufferEffect[332613], self.caster, self.card, nil, 120*self.nCount)
	-- 332621
	self:DelBufferTypeForce(BufferEffect[332621], self.caster, self.card, nil, 332601)
end
