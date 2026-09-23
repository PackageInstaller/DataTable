-- 光耀錨點
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer710130102 = oo.class(BuffBase)
function Buffer710130102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer710130102:OnBefourHurt(caster, target)
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
	-- 8787
	local c787 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,47101)
	-- 710130107
	if self:Rand(c787*1000+5000) then
		self:AddTempAttr(BufferEffect[710130107], self.caster, self.caster, nil, "damage",0.05*self.nCount)
	end
end
-- 创建时
function Buffer710130102:OnCreate(caster, target)
	-- 710130102
	self:AddAttr(BufferEffect[710130102], self.caster, self.card, nil, "damage",0.05*self.nCount)
end
