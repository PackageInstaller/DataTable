-- +100%速度，持續2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010111 = oo.class(BuffBase)
function Buffer1000010111:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010111:OnCreate(caster, target)
	-- 1000010111
	self:AddAttrPercent(BufferEffect[1000010111], self.caster, self.card, nil, "speed",1)
end
