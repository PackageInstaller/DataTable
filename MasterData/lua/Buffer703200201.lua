-- 影子印記
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer703200201 = oo.class(BuffBase)
function Buffer703200201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer703200201:OnActionOver(caster, target)
	-- 8627
	if SkillJudger:Greater(self, self.caster, self.card, true,self.nCount,1) then
	else
		return
	end
	-- 703200204
	self:OwnerAddBuff(BufferEffect[703200204], self.caster, self.card, nil, 703200202)
	-- 703200201
	self:LimitDamage(BufferEffect[703200201], self.caster, self.card, nil, 0.15,2)
	-- 703200203
	self:Cure(BufferEffect[703200203], self.caster, self.creater, nil, 8,0.03)
	-- 703200202
	self:DelBufferForce(BufferEffect[703200202], self.caster, self.card, nil, 703200201)
end
