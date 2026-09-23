-- 莉普丝
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5304306 = oo.class(SkillBase)
function Skill5304306:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill5304306:OnActionOver(caster, target, data)
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
	-- 5304314
	self:OwnerAddBuff(SkillEffect[5304314], caster, caster, data, 5304304)
end
-- 行动开始
function Skill5304306:OnActionBegin(caster, target, data)
	-- 5304308
	self:tFunc_5304308_5304303(caster, target, data)
	self:tFunc_5304308_5304307(caster, target, data)
end
-- 加buff时
function Skill5304306:OnAddBuff(caster, target, data, buffer)
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
	-- 5304310
	self:OwnerAddBuff(SkillEffect[5304310], caster, caster, data, 5304304)
end
-- 伤害前
function Skill5304306:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8462
	local count62 = SkillApi:GetAttr(self, caster, target,3,"attack")
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 5304318
	self:AddTempAttr(SkillEffect[5304318], caster, target, data, "defense",-math.floor(count62/500))
end
function Skill5304306:tFunc_5304308_5304307(caster, target, data)
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
function Skill5304306:tFunc_5304308_5304303(caster, target, data)
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
