-- 隨想曲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer201400305 = oo.class(BuffBase)
function Buffer201400305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer201400305:OnCreate(caster, target)
	-- 201400303
	self:AddSp(BufferEffect[201400303], self.caster, target or self.owner, nil,20)
	-- 201400313
	self:AddNp(BufferEffect[201400313], self.caster, target or self.owner, nil,5)
end
