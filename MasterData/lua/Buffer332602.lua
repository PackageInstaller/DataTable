-- 蠢動
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer332602 = oo.class(BuffBase)
function Buffer332602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer332602:OnBefourHurt(caster, target)
	-- 332602
	self:AddTempAttr(BufferEffect[332602], self.caster, self.card, nil, "bedamage",-0.04*self.nCount)
end
-- 行动结束
function Buffer332602:OnActionOver(caster, target)
	-- 332612
	self:AddProgress(BufferEffect[332612], self.caster, self.card, nil, 80*self.nCount)
	-- 332621
	self:DelBufferTypeForce(BufferEffect[332621], self.caster, self.card, nil, 332601)
end
