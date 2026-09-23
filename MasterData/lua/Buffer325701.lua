-- 暴發
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer325701 = oo.class(BuffBase)
function Buffer325701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer325701:OnCreate(caster, target)
	-- 325701
	self:AddAttr(BufferEffect[325701], self.caster, target or self.owner, nil,"crit_rate",0.10)
	-- 325711
	self:AddAttr(BufferEffect[325711], self.caster, target or self.owner, nil,"crit",0.10)
end
