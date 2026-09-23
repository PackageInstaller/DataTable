-- 天丛云·山脉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4103312 = oo.class(SkillBase)
function Skill4103312:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4103312:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4103309
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4103309], caster, target, data, 4103313)
	end
end
-- 伤害前
function Skill4103312:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8981
	local count981 = SkillApi:SkillLevel(self, caster, target,3,41033)
	-- 8988
	local count988 = SkillApi:GetCount(self, caster, target,2,4103305+count981)
	-- 4103305
	if SkillJudger:Greater(self, caster, target, true,count988,0) then
	else
		return
	end
	-- 9729
	local count816 = SkillApi:GetAttr(self, caster, target,1,"defense")
	-- 9730
	local count817 = SkillApi:GetAttr(self, caster, target,2,"defense")
	-- 8992
	if SkillJudger:Greater(self, caster, target, true,count816,count817) then
	else
		return
	end
	-- 4103314
	self:AddTempAttr(SkillEffect[4103314], caster, self.card, data, "damage2",math.floor((count816-count817)/100)*0.04)
	-- 4103334
	self:AddTempAttrPercent(SkillEffect[4103334], caster, target, data, "defense",-count988*0.1)
end
-- 解体时
function Skill4103312:OnResolve(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4103324
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4103324], caster, target, data, 4103318)
	end
	-- 4103329
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[4103329], caster, target, data, 4103313)
	end
end
