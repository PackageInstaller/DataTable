-- 慈悲模式(OD)
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600901304 = oo.class(SkillBase)
function Skill600901304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600901304:DoSkill(caster, target, data)
	-- 600901304
	self.order = self.order + 1
	self:AddProgress(SkillEffect[600901304], caster, target, data, 250)
end
-- 行动结束
function Skill600901304:OnActionOver(caster, target, data)
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
	-- 600900302
	self:AddBuff(SkillEffect[600900302], caster, self.card, data, 600900302)
end
-- 回合结束时
function Skill600901304:OnRoundOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8645
	local count645 = SkillApi:BuffCount(self, caster, target,3,3,600900302)
	-- 8846
	if SkillJudger:Greater(self, caster, target, true,count645,0) then
	else
		return
	end
	-- 600900316
	self:OwnerAddBuff(SkillEffect[600900316], caster, caster, data, 600900314)
	-- 600900324
	local targets = SkillFilter:HasBuff(self, caster, target, 4,328801,4)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[600900324], caster, target, data, 600900505)
	end
end
