-- 時序返還
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9038 = oo.class(BuffBase)
function Buffer9038:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer9038:OnCreate(caster, target)
	-- 9040
	self:AlterBufferByGroup(BufferEffect[9040], self.caster, self.card, nil, 1,1)
end
-- 回合结束时
function Buffer9038:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 9038
	self:AddStep(BufferEffect[9038], self.caster, self.card, nil, 1,1)
	-- 9039
	self:DelBufferForce(BufferEffect[9039], self.caster, self.card, nil, 9038)
end
