-- 隨想曲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer201401304 = oo.class(BuffBase)
function Buffer201401304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer201401304:OnCreate(caster, target)
	-- 201401303
	self:AddSp(BufferEffect[201401303], self.caster, target or self.owner, nil,40)
	-- 201400312
	self:AddNp(BufferEffect[201400312], self.caster, target or self.owner, nil,4)
end
