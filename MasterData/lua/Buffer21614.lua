-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer21614 = oo.class(BuffBase)
function Buffer21614:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer21614:OnCreate(caster, target)
	-- 21614
	self:AddAttr(BufferEffect[21614], self.caster, self.card, nil, "attack",150*self.nCount)
end
