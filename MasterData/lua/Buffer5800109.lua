-- 暴擊增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800109 = oo.class(BuffBase)
function Buffer5800109:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5800109:OnCreate(caster, target)
	-- 5800109
	self:AddAttr(BufferEffect[5800109], self.caster, self.card, nil, "crit_rate",0.02*self.nCount)
end
