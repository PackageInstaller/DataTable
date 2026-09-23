-- 獲得能量值
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer401900201 = oo.class(BuffBase)
function Buffer401900201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer401900201:OnCreate(caster, target)
	-- 401900201
	self:AddNp(BufferEffect[401900201], self.caster, self.card, nil, 10)
end
