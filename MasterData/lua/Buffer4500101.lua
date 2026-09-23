-- 強化劑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4500101 = oo.class(BuffBase)
function Buffer4500101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4500101:OnCreate(caster, target)
	-- 4001
	self:AddAttrPercent(BufferEffect[4001], self.caster, target or self.owner, nil,"attack",0.05)
	-- 4201
	self:AddAttr(BufferEffect[4201], self.caster, target or self.owner, nil,"speed",5)
	-- 4501
	self:AddAttr(BufferEffect[4501], self.caster, target or self.owner, nil,"hit",0.05)
end
