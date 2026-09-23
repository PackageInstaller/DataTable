-- 吞噬者
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4802301 = oo.class(SkillBase)
function Skill4802301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4802301:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4802306
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4802306], caster, target, data, 4802302)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4802309
	self:AddBuff(SkillEffect[4802309], caster, self.card, data, 4802301,2)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4802301
	self:CallSkillEx(SkillEffect[4802301], caster, target, data, 802300401)
end
-- 行动结束2
function Skill4802301:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8673
	local count673 = SkillApi:BuffCount(self, caster, target,3,4,4802301)
	-- 8883
	if SkillJudger:Less(self, caster, target, true,count673,1) then
	else
		return
	end
	-- 4802307
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4802307], caster, target, data, 4802302)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8673
	local count673 = SkillApi:BuffCount(self, caster, target,3,4,4802301)
	-- 8883
	if SkillJudger:Less(self, caster, target, true,count673,1) then
	else
		return
	end
	-- 4802302
	self:CallSkill(SkillEffect[4802302], caster, target, data, 802300401)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4802304
	self:AddBuff(SkillEffect[4802304], caster, self.card, data, 4802301,2)
end
