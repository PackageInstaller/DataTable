-- 甘露祝福
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984110301 = oo.class(BuffBase)
function Buffer984110301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984110301:OnCreate(caster, target)
	-- 984110301
	self:AddAttrPercent(BufferEffect[984110301], self.caster, target or self.owner, nil,"attack",0.05*self.nCount)
	-- 984110302
	self:AddAttrPercent(BufferEffect[984110302], self.caster, target or self.owner, nil,"damage",0.05*self.nCount)
end
