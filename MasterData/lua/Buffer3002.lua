-- 沉默
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3002 = oo.class(BuffBase)
function Buffer3002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3002:OnCreate(caster, target)
	-- 3002
	self:Silence(BufferEffect[3002], self.caster, target or self.owner, nil,nil)
end
