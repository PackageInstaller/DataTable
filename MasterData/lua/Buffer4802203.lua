-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4802203 = oo.class(BuffBase)
function Buffer4802203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4802203:OnCreate(caster, target)
	-- 4802203
	self:AddTempAttr(BufferEffect[4802203], self.caster, self.card, nil, "damage",0.1*self.nCount)
end
