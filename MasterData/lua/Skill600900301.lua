-- 慈悲模式
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600900301 = oo.class(SkillBase)
function Skill600900301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600900301:DoSkill(caster, target, data)
	-- 600900303
	self.order = self.order + 1
	self:AddProgress(SkillEffect[600900303], caster, target, data, 100)
end
-- 行动结束
function Skill600900301:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 600900301
	self:AddBuff(SkillEffect[600900301], caster, self.card, data, 600900301)
end
-- 回合结束时
function Skill600900301:OnRoundOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8644
	local count644 = SkillApi:BuffCount(self, caster, target,3,3,600900301)
	-- 8845
	if SkillJudger:Greater(self, caster, target, true,count644,0) then
	else
		return
	end
	-- 600900311
	self:OwnerAddBuff(SkillEffect[600900311], caster, caster, data, 600900311)
	-- 600900321
	local targets = SkillFilter:HasBuff(self, caster, target, 4,328801,4)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[600900321], caster, target, data, 600900501)
	end
end
