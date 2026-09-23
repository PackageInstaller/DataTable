-- 冰凍標記
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer702400301 = oo.class(BuffBase)
function Buffer702400301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer702400301:OnAttackOver(caster, target)
	-- 702400301
	self:DelBufferTypeForce(BufferEffect[702400301], self.caster, self.card, nil, 702400301)
end
