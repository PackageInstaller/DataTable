-- 潮汐
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer304900101 = oo.class(BuffBase)
function Buffer304900101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer304900101:OnCreate(caster, target)
	-- 304900101
	self:AddAttr(BufferEffect[304900101], self.caster, self.card, nil, "hit",0.05*self.nCount)
	-- 304900102
	self:AddAttr(BufferEffect[304900102], self.caster, self.card, nil, "crit",0.05*self.nCount)
end
