-- 暴擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010101 = oo.class(BuffBase)
function Buffer1000010101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010101:OnCreate(caster, target)
	-- 1000010101
	self:AddBuff(BufferEffect[1000010101], self.caster, self.card, nil, 1000010103)
end
