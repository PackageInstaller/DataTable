-- 合体机神被动技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914500401 = oo.class(SkillBase)
function Skill914500401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill914500401:OnRoundOver(caster, target, data)
	-- 914500401
	self:AddBuffCount(SkillEffect[914500401], caster, self.card, data, 914500101,1,5)
end
-- 行动结束2
function Skill914500401:OnActionOver2(caster, target, data)
	-- 914500402
	local count914500101 = SkillApi:GetCount(self, caster, target,3,914500101)
	-- 914500404
	if SkillJudger:Greater(self, caster, target, true,count914500101,4) then
	else
		return
	end
	-- 914500405
	self:DelBufferForce(SkillEffect[914500405], caster, self.card, data, 914500101,5)
	-- 914500403
	local targets = SkillFilter:MaxAttr(self, caster, target, 4,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[914500403], caster, target, data, 914500201)
	end
end
