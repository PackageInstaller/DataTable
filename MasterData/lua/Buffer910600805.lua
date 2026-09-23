-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer910600805 = oo.class(BuffBase)
function Buffer910600805:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer910600805:OnActionOver2(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8145
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.5) then
	else
		return
	end
	-- 910600807
	self:OwnerAddBuff(BufferEffect[910600807], self.caster, self.card, nil, 910600806)
	-- 910600809
	self:DelBufferForce(BufferEffect[910600809], self.caster, self.card, nil, 910600805)
end
