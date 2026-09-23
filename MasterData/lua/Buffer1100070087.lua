-- 攻擊增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070087 = oo.class(BuffBase)
function Buffer1100070087:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070087:OnCreate(caster, target)
	-- 1100070087
	self:AddAttrPercent(BufferEffect[1100070087], self.caster, self.card, nil, "attack",0.01*self.nCount)
end
