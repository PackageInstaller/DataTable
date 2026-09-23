-- 閃擊指令
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer102200301 = oo.class(BuffBase)
function Buffer102200301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer102200301:OnCreate(caster, target)
	-- 8762
	local c762 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41022)
	-- 102200301
	self:AddAttr(BufferEffect[102200301], self.caster, self.card, nil, "defense",(25+25*c762)*self.nCount)
	-- 8762
	local c762 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41022)
	-- 102200311
	self:AddAttr(BufferEffect[102200311], self.caster, self.card, nil, "attack",(100+100*c762)*self.nCount)
end
-- 回合结束时
function Buffer102200301:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8764
	local c764 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,1022003)
	-- 102200321
	self:AddProgress(BufferEffect[102200321], self.caster, self.card, nil, 50+math.floor((c764+1)/2)*50)
end
