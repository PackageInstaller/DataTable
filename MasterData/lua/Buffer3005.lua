-- 冰凍
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3005 = oo.class(BuffBase)
function Buffer3005:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 死亡时
function Buffer3005:OnDeath(caster, target)
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1201
	self:DelBufferForce(BufferEffect[1201], self.caster, self.card, nil, 3005)
end
-- 创建时
function Buffer3005:OnCreate(caster, target)
	-- 5204
	self:AddAttr(BufferEffect[5204], self.caster, target or self.owner, nil,"speed",-20)
end
