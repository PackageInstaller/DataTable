-- 定向爆破
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103300202 = oo.class(SkillBase)
function Skill103300202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103300202:DoSkill(caster, target, data)
	-- 103300202
	self.order = self.order + 1
	self:AddBuff(SkillEffect[103300202], caster, target, data, 103300204)
end
-- 行动结束2
function Skill103300202:OnActionOver2(caster, target, data)
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
	-- 103300206
	self:AddBuff(SkillEffect[103300206], caster, self.card, data, 103300201)
end
-- 行动结束
function Skill103300202:OnActionOver(caster, target, data)
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
	-- 8221
	if SkillJudger:IsCanHurt(self, caster, target, false) then
	else
		return
	end
	-- 8983
	local count983 = SkillApi:BuffCount(self, caster, target,3,4,103300201)
	-- 103300252
	if SkillJudger:Greater(self, caster, target, true,count983,0) then
	else
		return
	end
	-- 103300208
	self:CallOwnerSkill(SkillEffect[103300208], caster, caster, data, 103300402)
	-- 8981
	local count981 = SkillApi:SkillLevel(self, caster, target,3,41033)
	-- 103300213
	self:AddProgress(SkillEffect[103300213], caster, self.card, data, 300)
	-- 103300218
	self:AddBuffCount(SkillEffect[103300218], caster, self.card, data, 4103300+count981,1,999)
	-- 103300223
	self:AddBuffCount(SkillEffect[103300223], caster, caster, data, 4103305+count981,1,999)
	-- 103300228
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DelBufferGroup(SkillEffect[103300228], caster, target, data, 2,1)
	end
	-- 103300233
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferGroup(SkillEffect[103300233], caster, target, data, 3,1)
	end
	-- 103300238
	self:AddBuff(SkillEffect[103300238], caster, self.card, data, 103300202)
	-- 103300243
	self:DelBufferForce(SkillEffect[103300243], caster, self.card, data, 103300201)
	-- 8989
	local count989 = SkillApi:SkillLevel(self, caster, target,3,3409)
	-- 103300143
	if self:Rand(count989*2000) then
		self:AddSp(SkillEffect[103300143], caster, self.card, data, 10)
	end
end
-- 回合开始时
function Skill103300202:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8983
	local count983 = SkillApi:BuffCount(self, caster, target,3,4,103300201)
	-- 103300252
	if SkillJudger:Greater(self, caster, target, true,count983,0) then
	else
		return
	end
	-- 103300248
	local targets = SkillFilter:Rand(self, caster, target, 4,1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[103300248], caster, target, data, 103300402)
	end
	-- 103300254
	self:DelBufferForce(SkillEffect[103300254], caster, self.card, data, 103300201)
end
