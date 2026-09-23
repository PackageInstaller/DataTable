-- 芭贝拉·红
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4750203 = oo.class(SkillBase)
function Skill4750203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4750203:OnActionOver(caster, target, data)
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
	-- 4750203
	self:AddBuffCount(SkillEffect[4750203], caster, self.card, data, 4750201,1,999)
end
-- 行动结束2
function Skill4750203:OnActionOver2(caster, target, data)
	-- 8720
	local count720 = SkillApi:SkillLevel(self, caster, target,3,7502001)
	-- 8719
	local count719 = SkillApi:GetCount(self, caster, target,3,4750201)
	-- 8929
	if SkillJudger:Greater(self, caster, target, true,count719,4) then
	else
		return
	end
	-- 4750213
	self:AddBuffCount(SkillEffect[4750213], caster, self.card, data, 4750201,-5,999)
	-- 4750216
	local targets = SkillFilter:MinAttr(self, caster, target, 4,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[4750216], caster, target, data, 750200100+count720)
	end
end
-- 攻击结束
function Skill4750203:OnAttackOver(caster, target, data)
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
	-- 4750223
	if self:Rand(6000) then
		self:AddBuffCount(SkillEffect[4750223], caster, self.card, data, 750200201,1,20)
	end
end
