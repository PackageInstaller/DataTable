-- 暴擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer335102 = oo.class(BuffBase)
function Buffer335102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer335102:OnCreate(caster, target)
	-- 335102
	self:AddMaxHpPercent(BufferEffect[335102], self.caster, target or self.owner, nil,0.04)
	-- 4707
	self:AddAttr(BufferEffect[4707], self.caster, target or self.owner, nil,"becure",0.05)
end
