-- 破盾表現
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2310 = oo.class(BuffBase)
function Buffer2310:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer2310:OnActionOver2(caster, target)
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
	-- 8458
	local c58 = SkillApi:GetCount(self, self.caster, target or self.owner,3,2309)
	-- 8613
	if SkillJudger:Less(self, self.caster, self.card, true,c58,1) then
	else
		return
	end
	-- 9405
	self:OwnerAddBuff(BufferEffect[9405], self.caster, self.card, nil, 9405)
end
