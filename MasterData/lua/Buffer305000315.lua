-- 混元盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer305000315 = oo.class(BuffBase)
function Buffer305000315:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer305000315:OnCreate(caster, target)
	-- 305000315
	self:AddShieldWall(BufferEffect[305000315], self.caster, target or self.owner, nil,1,0.80)
end
