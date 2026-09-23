-- 灼燒免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9011 = oo.class(BuffBase)
function Buffer9011:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer9011:OnRoundBegin(caster, target)
	-- 6120
	self:ImmuneBuffID(BufferEffect[6120], self.caster, target or self.owner, nil,3002)
end
