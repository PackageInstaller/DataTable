-- 童話印記
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603000101 = oo.class(BuffBase)
function Buffer603000101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer603000101:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 603000102
	self:LimitDamage2(BufferEffect[603000102], self.caster, target or self.owner, nil,0.05*self.nCount,1.5*self.nCount)
end
-- 创建时
function Buffer603000101:OnCreate(caster, target)
	-- 4603000
	local c60301 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,46030)
	-- 4603005
	local c60305 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,460301)
	-- 4603001
	self:AddAttr(BufferEffect[4603001], self.caster, self.card, nil, "defense",-15*self.nCount*c60301+(-20*self.nCount*c60305))
	-- 4603000
	local c60301 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,46030)
	-- 4603005
	local c60305 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,460301)
	-- 4603002
	self:AddAttr(BufferEffect[4603002], self.caster, self.card, nil, "bedamage",0.01*self.nCount*c60301+(0.01*self.nCount*c60305))
end
