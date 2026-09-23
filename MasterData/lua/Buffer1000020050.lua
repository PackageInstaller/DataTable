-- 每給一位擁有護盾目標提供buff時，增加10點np
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020050 = oo.class(BuffBase)
function Buffer1000020050:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 加buff时
function Buffer1000020050:OnAddBuff(caster, target, buffer)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8738
	local c134 = SkillApi:BuffCount(self, self.caster, target or self.owner,3,4,3)
	-- 1000020199
	if SkillJudger:Greater(self, self.caster, self.card, true,c134,0) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020050
	self:AddNp(BufferEffect[1000020050], self.caster, self.card, nil, 10)
end
