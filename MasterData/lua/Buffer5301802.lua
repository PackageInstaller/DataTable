-- 狂獵
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5301802 = oo.class(BuffBase)
function Buffer5301802:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer5301802:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5301803
	self:AddBuffCount(BufferEffect[5301803], self.caster, self.card, nil, 5301803,math.floor(self.nCount/8),3)
end
-- 行动结束
function Buffer5301802:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 8263
	if SkillJudger:IsCallSkill(self, self.caster, target, false) then
	else
		return
	end
	-- 5301804
	self:AddNp(BufferEffect[5301804], self.caster, self.card, nil, 5*math.floor(self.nCount/8))
end
-- 创建时
function Buffer5301802:OnCreate(caster, target)
	-- 5301801
	self:AddAttr(BufferEffect[5301801], self.caster, self.card, nil, "attack",200*self.nCount)
	-- 8785
	local c785 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,43018)
	-- 5301802
	self:AddAttr(BufferEffect[5301802], self.caster, self.card, nil, "crit",0.01*self.nCount*(c785+1))
end
