-- 承傷增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984200701 = oo.class(BuffBase)
function Buffer984200701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984200701:OnCreate(caster, target)
	-- 984200701
	self:AddAttr(BufferEffect[984200701], self.caster, target or self.owner, nil,"bedamage",0.2)
end
