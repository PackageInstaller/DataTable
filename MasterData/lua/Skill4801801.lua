-- 延时之能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4801801 = oo.class(SkillBase)
function Skill4801801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill4801801:OnBefourCritHurt(caster, target, data)
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
	-- 8787
	local count787 = SkillApi:GetAttr(self, caster, target,1,"sMech")
	-- 9767
	local count9767 = SkillApi:ClassCount(self, caster, target,1,count787)
	-- 4801801
	self:AddTempAttr(SkillEffect[4801801], caster, caster, data, "crit",0.05*count9767)
end
-- 行动结束2
function Skill4801801:OnActionOver2(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8787
	local count787 = SkillApi:GetAttr(self, caster, target,1,"sMech")
	-- 8789
	local count789 = SkillApi:GetAttr(self, caster, target,3,"sMech")
	-- 4801803
	if SkillJudger:Equal(self, caster, target, true,count787,count789) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 4801802
	if self:Rand(5000) then
		self:Help(SkillEffect[4801802], caster, target, data, 2)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill4801801:OnBornSpecial(caster, target, data)
	-- 4801804
	self:tFunc_4801804_4801805(caster, target, data)
	self:tFunc_4801804_4801806(caster, target, data)
end
function Skill4801801:tFunc_4801804_4801805(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4801805
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[4801805], caster, target, data, 4801801)
	end
end
function Skill4801801:tFunc_4801804_4801806(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8281
	if SkillJudger:CasterIsSelf(self, caster, target, false) then
	else
		return
	end
	-- 4801806
	self:OwnerAddBuff(SkillEffect[4801806], caster, caster, data, 4801801)
end
