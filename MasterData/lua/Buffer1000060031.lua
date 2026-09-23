-- 全體+16%攻擊（2級）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060031 = oo.class(BuffBase)
function Buffer1000060031:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000060031:OnCreate(caster, target)
	-- 1000060031
	self:AddAttrPercent(BufferEffect[1000060031], self.caster, self.card, nil, "attack",0.33)
end
