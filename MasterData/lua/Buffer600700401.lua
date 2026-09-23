-- 淨化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer600700401 = oo.class(BuffBase)
function Buffer600700401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer600700401:OnCreate(caster, target)
	-- 600700401
	self:DelBufferGroup(BufferEffect[600700401], self.caster, target or self.owner, nil,1,1)
end
