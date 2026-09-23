-- 总队长在场上时，其他队员退场时复活回复10%血量，受到的伤害增加20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020232 = oo.class(SkillBase)
function Skill1100020232:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100020232:OnBorn(caster, target, data)
	-- 9744
	if SkillJudger:IsCasterMech(self, caster, self.card, true,8) then
	else
		return
	end
	-- 1100020230
	local targets = SkillFilter:Teammate(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[1100020230], caster, target, data, 1100020230)
	end
end
-- 死亡时
function Skill1100020232:OnDeath(caster, target, data)
	-- 11000202300
	self:tFunc_11000202300_1100020231(caster, target, data)
	self:tFunc_11000202300_11000202310(caster, target, data)
	self:tFunc_11000202300_11000202311(caster, target, data)
	self:tFunc_11000202300_11000202312(caster, target, data)
end
-- 特殊入场时(复活，召唤，合体)
function Skill1100020232:OnBornSpecial(caster, target, data)
	-- 11000202301
	self:tFunc_11000202301_11000202314(caster, target, data)
	self:tFunc_11000202301_11000202315(caster, target, data)
	self:tFunc_11000202301_11000202316(caster, target, data)
	self:tFunc_11000202301_11000202317(caster, target, data)
end
-- 伤害前
function Skill1100020232:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 11000202313
	self:AddTempAttrPercent(SkillEffect[11000202313], caster, self.card, data, "bedamage",0.2)
end
function Skill1100020232:tFunc_11000202301_11000202317(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020239
	if SkillJudger:HasRole(self, caster, target, true,1,71022) then
	else
		return
	end
	-- 11000202317
	self:AddBuff(SkillEffect[11000202317], caster, self.card, data, 1100020230)
end
function Skill1100020232:tFunc_11000202300_11000202312(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100020235
	if SkillJudger:IsSibling(self, caster, target, true,71022) then
	else
		return
	end
	-- 11000202312
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[11000202312], caster, target, data, 1100020230,10)
	end
end
function Skill1100020232:tFunc_11000202300_1100020231(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100020232
	if SkillJudger:IsSibling(self, caster, target, true,71010) then
	else
		return
	end
	-- 1100020231
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[1100020231], caster, target, data, 1100020230,10)
	end
end
function Skill1100020232:tFunc_11000202301_11000202316(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020238
	if SkillJudger:HasRole(self, caster, target, true,1,71020) then
	else
		return
	end
	-- 11000202316
	self:AddBuff(SkillEffect[11000202316], caster, self.card, data, 1100020230)
end
function Skill1100020232:tFunc_11000202300_11000202311(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100020234
	if SkillJudger:IsSibling(self, caster, target, true,71020) then
	else
		return
	end
	-- 11000202311
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[11000202311], caster, target, data, 1100020230,10)
	end
end
function Skill1100020232:tFunc_11000202301_11000202314(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020236
	if SkillJudger:HasRole(self, caster, target, true,1,71010) then
	else
		return
	end
	-- 11000202314
	self:AddBuff(SkillEffect[11000202314], caster, self.card, data, 1100020230)
end
function Skill1100020232:tFunc_11000202301_11000202315(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020237
	if SkillJudger:HasRole(self, caster, target, true,1,71012) then
	else
		return
	end
	-- 11000202315
	self:AddBuff(SkillEffect[11000202315], caster, self.card, data, 1100020230)
end
function Skill1100020232:tFunc_11000202300_11000202310(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100020233
	if SkillJudger:IsSibling(self, caster, target, true,71012) then
	else
		return
	end
	-- 11000202310
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[11000202310], caster, target, data, 1100020230,10)
	end
end
