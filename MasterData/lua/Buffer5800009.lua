-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800009 = oo.class(BuffBase)
function Buffer5800009:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5800009:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5800009
	local r = self.card:Rand(3)+1
	if 1 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
		else
			return
		end
		-- 1001
		self:LimitDamage2(BufferEffect[1001], self.caster, target or self.owner, nil,0.05,1)
	elseif 2 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
		else
			return
		end
		-- 1002
		self:LimitDamage2(BufferEffect[1002], self.caster, target or self.owner, nil,0.1,1.5)
	elseif 3 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
		else
			return
		end
		-- 1003
		self:LimitDamage2(BufferEffect[1003], self.caster, target or self.owner, nil,0.15,0.75)
	end
end
