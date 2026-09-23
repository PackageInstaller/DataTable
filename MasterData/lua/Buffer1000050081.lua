-- 共鳴：殘音
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050081 = oo.class(BuffBase)
function Buffer1000050081:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000050081:OnCreate(caster, target)
	-- 1000050081
	self:AddAttrPercent(BufferEffect[1000050081], self.caster, self.card, nil, "attack",0.2)
end
