-- 同步率+100
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9032 = oo.class(BuffBase)
function Buffer9032:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer9032:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 9032
	self:AddSp(BufferEffect[9032], self.caster, self.card, nil, 100)
	-- 9033
	self:DelBufferForce(BufferEffect[9033], self.caster, self.card, nil, 9032)
end
