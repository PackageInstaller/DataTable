-- 赤夕被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4704003 = oo.class(SkillBase)
function Skill4704003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4704003:OnRoundBegin(caster, target, data)
	-- 4704003
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:SetShareDamage(SkillEffect[4704003], caster, target, data, 0.3)
	end
end
-- 伤害后
function Skill4704003:OnAfterHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8480
	local count80 = SkillApi:GetShareDamage(self, caster, target,nil)
	-- 4704011
	local targets = SkillFilter:Teammate(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[4704011], caster, target, data, -math.floor(count80))
	end
end
-- 行动结束
function Skill4704003:OnActionOver(caster, target, data)
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
	-- 8633
	local count633 = SkillApi:GetDamage(self, caster, target,1)
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 4704023
	self:AddBuff(SkillEffect[4704023], caster, caster, data, 4704021)
	-- 4704033
	self:AddHp(SkillEffect[4704033], self.card, caster, data, math.floor(-count633*0.15))
	-- 8958
	if SkillJudger:IsCasterMech(self, caster, target, true,10) then
	else
		return
	end
	-- 4704038
	self:AddHp(SkillEffect[4704038], self.card, caster, data, math.floor(-count633*4))
end
