-- 芭贝拉·红
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4750202 = oo.class(SkillBase)
function Skill4750202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4750202:OnActionOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 4750202
	self:AddBuffCount(SkillEffect[4750202], caster, self.card, data, 4750201,1,999)
end
-- 行动结束2
function Skill4750202:OnActionOver2(caster, target, data)
	-- 8720
	local count720 = SkillApi:SkillLevel(self, caster, target,3,7502001)
	-- 8719
	local count719 = SkillApi:GetCount(self, caster, target,3,4750201)
	-- 8930
	if SkillJudger:Greater(self, caster, target, true,count719,5) then
	else
		return
	end
	-- 4750212
	self:AddBuffCount(SkillEffect[4750212], caster, self.card, data, 4750201,-6,999)
	-- 4750216
	local targets = SkillFilter:MinAttr(self, caster, target, 4,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[4750216], caster, target, data, 750200100+count720)
	end
end
-- 攻击结束
function Skill4750202:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 4750222
	if self:Rand(4000) then
		self:AddBuffCount(SkillEffect[4750222], caster, self.card, data, 750200201,1,20)
	end
end
