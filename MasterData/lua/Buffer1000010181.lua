-- 攻擊力+10%buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010181 = oo.class(BuffBase)
function Buffer1000010181:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010181:OnCreate(caster, target)
	-- 1000010181
	self:AddAttrPercent(BufferEffect[1000010181], self.caster, target or self.owner, nil,"attack",0.1*self.nCount)
end
