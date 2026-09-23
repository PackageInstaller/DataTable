-- 启动2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980100702 = oo.class(SkillBase)
function Skill980100702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill980100702:OnActionOver(caster, target, data)
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
	-- 980100710
	self:tFunc_980100710_980100704(caster, target, data)
	self:tFunc_980100710_980100709(caster, target, data)
end
-- 攻击结束
function Skill980100702:OnAttackOver(caster, target, data)
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
	-- 980100705
	self:AddBuffCount(SkillEffect[980100705], caster, self.card, data, 980100705,1,100000)
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
	-- 980100711
	self:tFunc_980100711_980100712(caster, target, data)
	self:tFunc_980100711_980100718(caster, target, data)
end
-- 攻击结束2
function Skill980100702:OnAttackOver2(caster, target, data)
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
	-- 980100714
	local count980100706 = SkillApi:GetCount(self, caster, target,3,980100706)
	-- 980100715
	if SkillJudger:Equal(self, caster, target, true,count980100706,2) then
	else
		return
	end
	-- 980100713
	self:AddBuffCount(SkillEffect[980100713], caster, self.card, data, 980100706,-1,2)
end
function Skill980100702:tFunc_980100710_980100704(caster, target, data)
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
	-- 980100706
	local count980100705 = SkillApi:GetCount(self, caster, target,3,980100705)
	-- 980100707
	if SkillJudger:Equal(self, caster, target, true,(count980100705%2),1) then
	else
		return
	end
	-- 980100704
	self:AddNp(SkillEffect[980100704], caster, target, data, -20)
end
function Skill980100702:tFunc_980100711_980100718(caster, target, data)
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
	-- 980100714
	local count980100706 = SkillApi:GetCount(self, caster, target,3,980100706)
	-- 980100717
	if SkillJudger:Less(self, caster, target, true,count980100706,1) then
	else
		return
	end
	-- 980100718
	self:AddBuffCount(SkillEffect[980100718], caster, self.card, data, 980100706,1,2)
end
function Skill980100702:tFunc_980100711_980100712(caster, target, data)
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
	-- 980100714
	local count980100706 = SkillApi:GetCount(self, caster, target,3,980100706)
	-- 980100716
	if SkillJudger:Equal(self, caster, target, true,count980100706,1) then
	else
		return
	end
	-- 980100712
	self:AddBuffCount(SkillEffect[980100712], caster, self.card, data, 980100706,1,2)
end
function Skill980100702:tFunc_980100710_980100709(caster, target, data)
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
	-- 980100706
	local count980100705 = SkillApi:GetCount(self, caster, target,3,980100705)
	-- 980100708
	if SkillJudger:Equal(self, caster, target, true,(count980100705%2),0) then
	else
		return
	end
	-- 980100709
	self:AddNp(SkillEffect[980100709], caster, target, data, 20)
end
