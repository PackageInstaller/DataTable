-- 能量屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2305 = oo.class(BuffBase)
function Buffer2305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2305:OnCreate(caster, target)
	-- 2305
	self:AddLightShield(BufferEffect[2305], self.caster, target or self.owner, nil,5,1,0.5,5)
end
