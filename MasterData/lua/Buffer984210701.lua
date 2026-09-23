-- 傷害增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984210701 = oo.class(BuffBase)
function Buffer984210701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984210701:OnCreate(caster, target)
	-- 984210701
	self:AddAttr(BufferEffect[984210701], self.caster, target or self.owner, nil,"damage",0.2)
end
