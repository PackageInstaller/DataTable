-- 仲裁者
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4803501 = oo.class(SkillBase)
function Skill4803501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4803501:OnActionOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 4803501
	self:AddProgress(SkillEffect[4803501], caster, self.card, data, 200)
end
-- 伤害前
function Skill4803501:OnBefourHurt(caster, target, data)
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
	-- 4803502
	self:AddTempAttr(SkillEffect[4803502], caster, target, data, "defense",-200)
end
-- 攻击结束2
function Skill4803501:OnAttackOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 4803503
	self:BeatBack(SkillEffect[4803503], caster, self.card, data, nil,12)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4803501:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4803504
	local targets = SkillFilter:Teammate(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:AddSkill(SkillEffect[4803504], caster, target, data, 803400401)
	end
end
