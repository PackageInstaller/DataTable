-- 飛羽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4500401 = oo.class(BuffBase)
function Buffer4500401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer4500401:OnAttackOver(caster, target)
	-- 4500401
	self:CreaterAddBuff(BufferEffect[4500401], self.caster, self.card, nil, 4500402)
	-- 4500405
	self:DelBufferForce(BufferEffect[4500405], self.caster, self.card, nil, 4500401)
end
