-- 914600301_Buff_name##
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer914600301 = oo.class(BuffBase)
function Buffer914600301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer914600301:OnCreate(caster, target)
	-- 4323
	self:AddAttr(BufferEffect[4323], self.caster, self.card, nil, "crit_rate",0.1*self.nCount)
end
