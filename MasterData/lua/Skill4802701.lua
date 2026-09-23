-- 守护之力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4802701 = oo.class(SkillBase)
function Skill4802701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4802701:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4802701
	self:CallSkillEx(SkillEffect[4802701], caster, self.card, data, 802700401)
end
-- 回合开始时
function Skill4802701:OnRoundBegin(caster, target, data)
	-- 4802702
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		-- 8641
		local count641 = SkillApi:BuffCount(self, caster, target,2,4,4100401)
		-- 4802703
		if SkillJudger:Greater(self, caster, target, true,count641,0) then
			-- 4802704
			self:SetProtect(SkillEffect[4802704], caster, target, data, 10000)
		end
	end
end
