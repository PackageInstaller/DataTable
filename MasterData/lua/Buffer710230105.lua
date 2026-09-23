-- 光耀錨點
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer710230105 = oo.class(BuffBase)
function Buffer710230105:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer710230105:OnBefourHurt(caster, target)
	-- 8065
	if SkillJudger:CasterIsSelf(self, self.caster, target, false) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8789
	local c789 = SkillApi:GetAttr(self, self.caster, target or self.owner,1,"sMech")
	-- 8790
	local c790 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"sMech")
	-- 710130111
	if SkillJudger:Equal(self, self.caster, target, true,c789,c790) then
	else
		return
	end
	-- 8788
	local c788 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,47102)
	-- 710230110
	if self:Rand(c788*1000+5000) then
		self:AddTempAttr(BufferEffect[710230110], self.caster, self.caster, nil, "damage",0.15*self.nCount)
	end
end
-- 创建时
function Buffer710230105:OnCreate(caster, target)
	-- 710230105
	self:AddAttr(BufferEffect[710230105], self.caster, self.card, nil, "damage",0.15*self.nCount)
end
