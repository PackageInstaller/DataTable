-- 能量屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2301 = oo.class(BuffBase)
function Buffer2301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2301:OnCreate(caster, target)
	-- 2301
	self:AddLightShield(BufferEffect[2301], self.caster, target or self.owner, nil,1,1,0.5,5)
end
