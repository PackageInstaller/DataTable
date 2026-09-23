-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5700006 = oo.class(BuffBase)
function Buffer5700006:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer5700006:OnActionOver(caster, target)
	-- 8072
	if SkillJudger:TargetIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8414
	local c14 = SkillApi:GetBeDamage(self, self.caster, target or self.owner,3)
	-- 8201
	if SkillJudger:IsSingle(self, self.caster, target, true) then
	else
		return
	end
	-- 5700006
	self:AddHp(BufferEffect[5700006], self.caster, self.card, nil, -math.floor(c14))
end
