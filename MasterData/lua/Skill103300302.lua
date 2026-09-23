-- 戏言轰炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103300302 = oo.class(SkillBase)
function Skill103300302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103300302:DoSkill(caster, target, data)
	-- 11004
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
end
-- 行动结束2
function Skill103300302:OnActionOver2(caster, target, data)
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
function Skill103300302:OnActionOver(caster, target, data)
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
	-- 103300303
	self:CallOwnerSkill(SkillEffect[103300303], caster, caster, data, 103300402)
	-- 8981
	local count981 = SkillApi:SkillLevel(self, caster, target,3,41033)
	-- 103300308
	self:AddProgress(SkillEffect[103300308], caster, self.card, data, 300)
	-- 103300313
	self:AddBuffCount(SkillEffect[103300313], caster, self.card, data, 4103300+count981,1,999)
	-- 103300318
	self:AddBuffCount(SkillEffect[103300318], caster, caster, data, 4103305+count981,1,999)
	-- 103300323
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[103300323], caster, target, data, 103300304)
	end
	-- 103300328
	self:AddBuff(SkillEffect[103300328], caster, self.card, data, 103300302)
	-- 103300333
	self:DelBufferForce(SkillEffect[103300333], caster, self.card, data, 103300301)
	-- 8989
	local count989 = SkillApi:SkillLevel(self, caster, target,3,3409)
	-- 103300143
	if self:Rand(count989*2000) then
		self:AddSp(SkillEffect[103300143], caster, self.card, data, 10)
	end
end
-- 回合开始时
function Skill103300302:OnRoundBegin(caster, target, data)
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
	-- 103300338
	local targets = SkillFilter:Rand(self, caster, target, 4,1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[103300338], caster, target, data, 103300402)
	end
	-- 103300344
	self:DelBufferForce(SkillEffect[103300344], caster, self.card, data, 103300301)
end
