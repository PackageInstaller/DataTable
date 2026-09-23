-- 火力支援
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103300104 = oo.class(SkillBase)
function Skill103300104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103300104:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 行动结束2
function Skill103300104:OnActionOver2(caster, target, data)
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
function Skill103300104:OnActionOver(caster, target, data)
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
	-- 103300105
	self:CallOwnerSkill(SkillEffect[103300105], caster, caster, data, 103300404)
	-- 8981
	local count981 = SkillApi:SkillLevel(self, caster, target,3,41033)
	-- 103300110
	self:AddProgress(SkillEffect[103300110], caster, self.card, data, 300)
	-- 103300115
	self:AddBuffCount(SkillEffect[103300115], caster, self.card, data, 4103300+count981,1,999)
	-- 103300120
	self:AddBuffCount(SkillEffect[103300120], caster, caster, data, 4103305+count981,1,999)
	-- 103300125
	self:AddBuff(SkillEffect[103300125], caster, caster, data, 103300106)
	-- 103300130
	self:AddBuff(SkillEffect[103300130], caster, self.card, data, 103300102)
	-- 103300135
	self:DelBufferForce(SkillEffect[103300135], caster, self.card, data, 103300101)
	-- 8989
	local count989 = SkillApi:SkillLevel(self, caster, target,3,3409)
	-- 103300143
	if self:Rand(count989*2000) then
		self:AddSp(SkillEffect[103300143], caster, self.card, data, 10)
	end
end
-- 回合开始时
function Skill103300104:OnRoundBegin(caster, target, data)
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
	-- 103300140
	local targets = SkillFilter:Rand(self, caster, target, 4,1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[103300140], caster, target, data, 103300404)
	end
	-- 103300147
	self:DelBufferForce(SkillEffect[103300147], caster, self.card, data, 103300101)
end
