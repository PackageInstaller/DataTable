-- 隨想曲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer201400302 = oo.class(BuffBase)
function Buffer201400302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer201400302:OnCreate(caster, target)
	-- 201400302
	self:AddSp(BufferEffect[201400302], self.caster, target or self.owner, nil,15)
	-- 201400311
	self:AddNp(BufferEffect[201400311], self.caster, target or self.owner, nil,3)
end
