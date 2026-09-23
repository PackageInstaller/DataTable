-- 戏言轰炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103300305 = oo.class(SkillBase)
function Skill103300305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103300305:DoSkill(caster, target, data)
	-- 11004
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
end
-- 行动结束2
function Skill103300305:OnActionOver2(caster, target, data)
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
	-- 103300301
	self:AddBuff(SkillEffect[103300301], caster, self.card, data, 103300301)
end
-- 行动结束
function Skill103300305:OnActionOver(caster, target, data)
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
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 8984
	local count984 = SkillApi:BuffCount(self, caster, target,3,4,103300301)
	-- 103300342
	if SkillJudger:Greater(self, caster, target, true,count984,0) then
	else
		return
	end
	-- 103300306
	self:CallOwnerSkill(SkillEffect[103300306], caster, caster, data, 103300405)
	-- 8981
	local count981 = SkillApi:SkillLevel(self, caster, target,3,41033)
	-- 103300311
	self:AddProgress(SkillEffect[103300311], caster, self.card, data, 300)
	-- 103300316
	self:AddBuffCount(SkillEffect[103300316], caster, self.card, data, 4103300+count981,1,999)
	-- 103300321
	self:AddBuffCount(SkillEffect[103300321], caster, caster, data, 4103305+count981,1,999)
	-- 103300326
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[103300326], caster, target, data, 103300307)
	end
	-- 103300331
	self:AddBuff(SkillEffect[103300331], caster, self.card, data, 103300302)
	-- 103300336
	self:DelBufferForce(SkillEffect[103300336], caster, self.card, data, 103300301)
	-- 8989
	local count989 = SkillApi:SkillLevel(self, caster, target,3,3409)
	-- 103300143
	if self:Rand(count989*2000) then
		self:AddSp(SkillEffect[103300143], caster, self.card, data, 10)
	end
end
-- 回合开始时
function Skill103300305:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8984
	local count984 = SkillApi:BuffCount(self, caster, target,3,4,103300301)
	-- 103300342
	if SkillJudger:Greater(self, caster, target, true,count984,0) then
	else
		return
	end
	-- 103300341
	local targets = SkillFilter:Rand(self, caster, target, 4,1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[103300341], caster, target, data, 103300405)
	end
	-- 103300347
	self:DelBufferForce(SkillEffect[103300347], caster, self.card, data, 103300301)
end
