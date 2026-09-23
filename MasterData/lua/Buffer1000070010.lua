-- 我方全體+8%攻擊（1級）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070010 = oo.class(BuffBase)
function Buffer1000070010:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000070010:OnCreate(caster, target)
	-- 1000070010
	self:AddAttrPercent(BufferEffect[1000070010], self.caster, target or self.owner, nil,"attack",0.8)
end
