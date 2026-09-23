-- 火力支援
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103300102 = oo.class(SkillBase)
function Skill103300102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103300102:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 行动结束2
function Skill103300102:OnActionOver2(caster, target, data)
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
function Skill103300102:OnActionOver(caster, target, data)
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
	-- 103300103
	self:CallOwnerSkill(SkillEffect[103300103], caster, caster, data, 103300402)
	-- 8981
	local count981 = SkillApi:SkillLevel(self, caster, target,3,41033)
	-- 103300108
	self:AddProgress(SkillEffect[103300108], caster, self.card, data, 300)
	-- 103300113
	self:AddBuffCount(SkillEffect[103300113], caster, self.card, data, 4103300+count981,1,999)
	-- 103300118
	self:AddBuffCount(SkillEffect[103300118], caster, caster, data, 4103305+count981,1,999)
	-- 103300123
	self:AddBuff(SkillEffect[103300123], caster, caster, data, 103300104)
	-- 103300128
	self:AddBuff(SkillEffect[103300128], caster, self.card, data, 103300102)
	-- 103300133
	self:DelBufferForce(SkillEffect[103300133], caster, self.card, data, 103300101)
	-- 8989
	local count989 = SkillApi:SkillLevel(self, caster, target,3,3409)
	-- 103300143
	if self:Rand(count989*2000) then
		self:AddSp(SkillEffect[103300143], caster, self.card, data, 10)
	end
end
-- 回合开始时
function Skill103300102:OnRoundBegin(caster, target, data)
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
	-- 103300138
	local targets = SkillFilter:Rand(self, caster, target, 4,1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[103300138], caster, target, data, 103300402)
	end
	-- 103300145
	self:DelBufferForce(SkillEffect[103300145], caster, self.card, data, 103300101)
end
