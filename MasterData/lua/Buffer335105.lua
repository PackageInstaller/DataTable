-- 暴擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer335105 = oo.class(BuffBase)
function Buffer335105:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer335105:OnCreate(caster, target)
	-- 335105
	self:AddMaxHpPercent(BufferEffect[335105], self.caster, target or self.owner, nil,0.10)
	-- 4708
	self:AddAttr(BufferEffect[4708], self.caster, target or self.owner, nil,"becure",0.15)
end
