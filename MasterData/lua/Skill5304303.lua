-- 莉普丝
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5304303 = oo.class(SkillBase)
function Skill5304303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill5304303:OnActionOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsCanHurt(self, caster, target, false) then
	else
		return
	end
	-- 8281
	if SkillJudger:CasterIsSelf(self, caster, target, false) then
	else
		return
	end
	-- 5304311
	self:OwnerAddBuff(SkillEffect[5304311], caster, caster, data, 5304301)
end
-- 行动开始
function Skill5304303:OnActionBegin(caster, target, data)
	-- 5304308
	self:tFunc_5304308_5304303(caster, target, data)
	self:tFunc_5304308_5304307(caster, target, data)
end
-- 加buff时
function Skill5304303:OnAddBuff(caster, target, data, buffer)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8281
	if SkillJudger:CasterIsSelf(self, caster, target, false) then
	else
		return
	end
	-- 8258
	if SkillJudger:IsCtrlBuff(buffer or self, caster, target, true,2) then
	else
		return
	end
	-- 5304301
	self:OwnerAddBuff(SkillEffect[5304301], caster, caster, data, 5304301)
end
-- 伤害前
function Skill5304303:OnBefourHurt(caster, target, data)
	-- 5304315
	self:tFunc_5304315_5304316(caster, target, data)
	self:tFunc_5304315_5304317(caster, target, data)
end
function Skill5304303:tFunc_5304315_5304317(caster, target, data)
	-- 8233
	if SkillJudger:IsCasterMech(self, caster, self.card, true,3) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 9764
	if SkillJudger:IsCrit(self, caster, target, false) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 5304317
	if self:Rand(6000) then
		self:AddBuffCount(SkillEffect[5304317], caster, self.card, data, 5304306,1,999)
	end
end
function Skill5304303:tFunc_5304308_5304307(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8276
	if SkillJudger:IsTypeOf(self, caster, target, true,7) then
	else
		return
	end
	-- 5304307
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[5304307], caster, target, data, 5304305)
	end
end
function Skill5304303:tFunc_5304315_5304316(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 9752
	if SkillJudger:IsTargetMech(self, caster, target, true,3) then
	else
		return
	end
	-- 9764
	if SkillJudger:IsCrit(self, caster, target, false) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 5304316
	if self:Rand(6000) then
		self:AddBuffCount(SkillEffect[5304316], caster, self.card, data, 5304306,1,999)
	end
end
function Skill5304303:tFunc_5304308_5304303(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8276
	if SkillJudger:IsTypeOf(self, caster, target, true,7) then
	else
		return
	end
	-- 8980
	local count980 = SkillApi:BuffCount(self, caster, target,2,4,5304301)
	-- 5304306
	if SkillJudger:Greater(self, caster, target, false,count980,0) then
	else
		return
	end
	-- 5304303
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[5304303], caster, target, data, 5304305)
	end
end
