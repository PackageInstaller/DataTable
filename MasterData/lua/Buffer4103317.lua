-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4103317 = oo.class(BuffBase)
function Buffer4103317:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4103317:OnCreate(caster, target)
	-- 4103328
	local dmg10330 = SkillApi:GetValue(self, self.caster, target or self.owner,3,"dmg10330")
	-- 8804
	local c804 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41033)
	-- 8806
	local c806 = SkillApi:GetCount(self, self.caster, target or self.owner,3,4103305+c804)
	-- 4103322
	if SkillJudger:Greater(self, self.caster, target, true,c806,0) then
	else
		return
	end
	-- 4103323
	self:AddHp(BufferEffect[4103323], self.caster, self.card, nil, -math.floor(dmg10330*0.5))
	-- 4103329
	self:DelValue(BufferEffect[4103329], self.caster, self.card, nil, "dmg10330")
end
