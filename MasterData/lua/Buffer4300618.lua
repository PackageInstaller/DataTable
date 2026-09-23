-- 攻擊增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4300618 = oo.class(BuffBase)
function Buffer4300618:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4300618:OnCreate(caster, target)
	-- 4300624
	self:AddAttr(BufferEffect[4300624], self.caster, self.card, nil, "attack",100*self.nCount)
end
