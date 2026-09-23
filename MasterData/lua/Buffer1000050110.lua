-- 大招對敵方造成傷害時概率對目標附加【弱化】效果
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050110 = oo.class(BuffBase)
function Buffer1000050110:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer1000050110:OnAfterHurt(caster, target)
	-- 1000050110
	self:AddBuff(BufferEffect[1000050110], self.caster, target or self.owner, nil,1000050091)
end
