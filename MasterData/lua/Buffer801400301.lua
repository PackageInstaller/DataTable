-- 磁暴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer801400301 = oo.class(BuffBase)
function Buffer801400301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer801400301:OnCreate(caster, target)
	-- 8444
	local c44 = SkillApi:BuffRound(self, self.caster, target or self.owner,3,3009)
	-- 801400202
	self:LimitDamage(BufferEffect[801400202], self.caster, self.card, nil, 1,0.6*c44)
	-- 6205
	self:DelBufferForce(BufferEffect[6205], self.caster, self.card, nil, 3009)
end
