-- 速度永久+10buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913100801 = oo.class(BuffBase)
function Buffer913100801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913100801:OnCreate(caster, target)
	-- 913100801
	self:AddAttr(BufferEffect[913100801], self.caster, self.card, nil, "speed",1*self.nCount)
end
