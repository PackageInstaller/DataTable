-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100071003 = oo.class(BuffBase)
function Buffer1100071003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer1100071003:OnActionOver2(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 1100071002
	self:AddProgress(BufferEffect[1100071002], self.caster, self.card, nil, 350)
	-- 1100071003
	self:DelBufferTypeForce(BufferEffect[1100071003], self.caster, self.card, nil, 1100071003)
end
