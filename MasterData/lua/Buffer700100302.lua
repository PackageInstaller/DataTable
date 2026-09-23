-- 雷擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer700100302 = oo.class(BuffBase)
function Buffer700100302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer700100302:OnCreate(caster, target)
	-- 700100302
	self:DamageSpecial(BufferEffect[700100302], self.caster, self.card, nil, 1,1)
end
