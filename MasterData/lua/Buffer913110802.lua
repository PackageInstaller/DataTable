-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913110802 = oo.class(BuffBase)
function Buffer913110802:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913110802:OnCreate(caster, target)
	-- 913110802
	self:AddAttr(BufferEffect[913110802], self.caster, self.card, nil, "attack",100*self.nCount)
end
