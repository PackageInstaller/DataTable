-- 蠢動
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer332601 = oo.class(BuffBase)
function Buffer332601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer332601:OnBefourHurt(caster, target)
	-- 332601
	self:AddTempAttr(BufferEffect[332601], self.caster, self.card, nil, "bedamage",-0.02*self.nCount)
end
-- 行动结束
function Buffer332601:OnActionOver(caster, target)
	-- 332611
	self:AddProgress(BufferEffect[332611], self.caster, self.card, nil, 40*self.nCount)
	-- 332621
	self:DelBufferTypeForce(BufferEffect[332621], self.caster, self.card, nil, 332601)
end
