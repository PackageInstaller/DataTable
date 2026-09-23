-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6200020 = oo.class(BuffBase)
function Buffer6200020:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer6200020:OnActionOver(caster, target)
	-- 6200019
	self:AddBuffCount(BufferEffect[6200019], self.caster, self.card, nil, 6200019,1,20)
end
