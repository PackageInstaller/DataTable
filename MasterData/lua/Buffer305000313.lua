-- 混元盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer305000313 = oo.class(BuffBase)
function Buffer305000313:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer305000313:OnCreate(caster, target)
	-- 305000313
	self:AddShieldWall(BufferEffect[305000313], self.caster, target or self.owner, nil,1,0.60)
end
