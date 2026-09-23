-- 機神守護
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6207 = oo.class(BuffBase)
function Buffer6207:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6207:OnRoundBegin(caster, target)
	-- 8416
	local c16 = SkillApi:LiveCount(self, self.caster, target or self.owner,3)
	-- 8621
	if SkillJudger:Greater(self, self.caster, self.card, true,c16,1) then
	else
		return
	end
	-- 6207
	self:ImmuneDeath(BufferEffect[6207], self.caster, target or self.owner, nil,nil)
end
