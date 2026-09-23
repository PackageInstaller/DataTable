-- 額外行動
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer317001 = oo.class(BuffBase)
function Buffer317001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer317001:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 317002
	self:ExtraRound(BufferEffect[317002], self.caster, self.card, nil, nil)
	-- 317001
	self:DelBufferForce(BufferEffect[317001], self.caster, self.card, nil, 317001)
end
