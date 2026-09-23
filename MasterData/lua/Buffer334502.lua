-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334502 = oo.class(BuffBase)
function Buffer334502:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer334502:OnCreate(caster, target)
	-- 4601502
	self:AddAttr(BufferEffect[4601502], self.caster, self.card, nil, "attack",60*self.nCount)
end
