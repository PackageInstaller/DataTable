-- 拘束力場
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3701 = oo.class(BuffBase)
function Buffer3701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3701:OnCreate(caster, target)
	-- 3701
	self:Cage(BufferEffect[3701], self.caster, target or self.owner, nil,1,0.1)
end
-- 回合结束时
function Buffer3701:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 3018
	self:AttackCage(BufferEffect[3018], self.caster, target or self.owner, nil,1.2)
end
