-- 沉默
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3501 = oo.class(BuffBase)
function Buffer3501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3501:OnCreate(caster, target)
	-- 3002
	self:Silence(BufferEffect[3002], self.caster, target or self.owner, nil,nil)
	-- 4201502
	self:OwnerAddBuffCount(BufferEffect[4201502], self.caster, self.caster, nil, 4201501,1,10)
end
