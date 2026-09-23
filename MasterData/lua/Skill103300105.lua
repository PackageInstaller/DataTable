-- 火力支援
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103300105 = oo.class(SkillBase)
function Skill103300105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103300105:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 行动结束2
function Skill103300105:OnActionOver2(caster, target, data)
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
	-- 8965
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 103300101
	self:AddBuff(SkillEffect[103300101], caster, self.card, data, 103300101)
end
-- 行动结束
function Skill103300105:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8965
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 8982
	local count982 = SkillApi:BuffCount(self, caster, target,3,4,103300101)
	-- 103300142
	if SkillJudger:Greater(self, caster, target, true,count982,0) then
	else
		return
	end
	-- 103300106
	self:CallOwnerSkill(SkillEffect[103300106], caster, caster, data, 103300405)
	-- 8981
	local count981 = SkillApi:SkillLevel(self, caster, target,3,41033)
	-- 103300111
	self:AddProgress(SkillEffect[103300111], caster, self.card, data, 300)
	-- 103300116
	self:AddBuffCount(SkillEffect[103300116], caster, self.card, data, 4103300+count981,1,999)
	-- 103300121
	self:AddBuffCount(SkillEffect[103300121], caster, caster, data, 4103305+count981,1,999)
	-- 103300126
	self:AddBuff(SkillEffect[103300126], caster, caster, data, 103300107)
	-- 103300131
	self:AddBuff(SkillEffect[103300131], caster, self.card, data, 103300102)
	-- 103300136
	self:DelBufferForce(SkillEffect[103300136], caster, self.card, data, 103300101)
	-- 8989
	local count989 = SkillApi:SkillLevel(self, caster, target,3,3409)
	-- 103300143
	if self:Rand(count989*2000) then
		self:AddSp(SkillEffect[103300143], caster, self.card, data, 10)
	end
end
-- 回合开始时
function Skill103300105:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8982
	local count982 = SkillApi:BuffCount(self, caster, target,3,4,103300101)
	-- 103300142
	if SkillJudger:Greater(self, caster, target, true,count982,0) then
	else
		return
	end
	-- 103300141
	local targets = SkillFilter:Rand(self, caster, target, 4,1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[103300141], caster, target, data, 103300405)
	end
	-- 103300148
	self:DelBufferForce(SkillEffect[103300148], caster, self.card, data, 103300101)
end
