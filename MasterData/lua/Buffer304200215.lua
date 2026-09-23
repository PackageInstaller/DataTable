-- 喵之守護標記
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer304200215 = oo.class(BuffBase)
function Buffer304200215:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer304200215:OnActionOver2(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8414
	local c14 = SkillApi:GetBeDamage(self, self.caster, target or self.owner,3)
	-- 8619
	if SkillJudger:Greater(self, self.caster, self.card, true,c14,0) then
	else
		return
	end
	-- 304200215
	self:OwnerAddBuff(BufferEffect[304200215], self.caster, self.card, nil, 304200205)
	-- 304200216
	self:DelBufferTypeForce(BufferEffect[304200216], self.caster, self.card, nil, 30421)
end
