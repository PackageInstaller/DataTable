-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3602 = oo.class(BuffBase)
function Buffer3602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3602:OnCreate(caster, target)
	-- 3204
	self:DelBufferGroupForce(BufferEffect[3204], self.caster, self.card, nil, 7,999)
end
