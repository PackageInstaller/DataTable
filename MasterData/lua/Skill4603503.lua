-- 伊根
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603503 = oo.class(SkillBase)
function Skill4603503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4603503:OnRoundBegin(caster, target, data)
	-- 4603501
	self:AddBuffCount(SkillEffect[4603501], caster, self.card, data, 4603501,1,999)
end
-- 回合结束时
function Skill4603503:OnRoundOver(caster, target, data)
	-- 4603533
	self:tFunc_4603533_4603513(caster, target, data)
	self:tFunc_4603533_4603523(caster, target, data)
end
-- 攻击结束2
function Skill4603503:OnAttackOver2(caster, target, data)
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
	-- 8427
	local count27 = SkillApi:BuffCount(self, caster, target,2,3,1001)
	-- 8122
	if SkillJudger:Greater(self, caster, self.card, true,count27,4) then
	else
		return
	end
	-- 4603542
	self:ClosingBuffByID(SkillEffect[4603542], caster, target, data, 2,1001)
end
-- 回合开始处理完成后
function Skill4603503:OnAfterRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4603502
	self:AddBuff(SkillEffect[4603502], caster, self.card, data, 4603502)
end
function Skill4603503:tFunc_4603533_4603523(caster, target, data)
	-- 8738
	local count738 = SkillApi:SkillLevel(self, caster, target,3,6035002)
	-- 8737
	local count737 = SkillApi:GetCount(self, caster, target,3,4603501)
	-- 8737
	local count737 = SkillApi:GetCount(self, caster, target,3,4603501)
	-- 8949
	if SkillJudger:Equal(self, caster, target, true,count737%2,0) then
	else
		return
	end
	-- 8741
	local count741 = SkillApi:SkillLevel(self, caster, target,3,6035004)
	-- 4603523
	if self:Rand(3000+count737*100) then
		local targets = SkillFilter:Rand(self, caster, target, 4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[4603523], caster, target, data, 603500401+math.min(math.max(count738+count741-2,0),4))
		end
	end
end
function Skill4603503:tFunc_4603533_4603513(caster, target, data)
	-- 8738
	local count738 = SkillApi:SkillLevel(self, caster, target,3,6035002)
	-- 8737
	local count737 = SkillApi:GetCount(self, caster, target,3,4603501)
	-- 8737
	local count737 = SkillApi:GetCount(self, caster, target,3,4603501)
	-- 8950
	if SkillJudger:Equal(self, caster, target, true,count737%2,1) then
	else
		return
	end
	-- 8741
	local count741 = SkillApi:SkillLevel(self, caster, target,3,6035004)
	-- 4603513
	if self:Rand(3000+count737*100) then
		local targets = SkillFilter:Rand(self, caster, target, 4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[4603513], caster, target, data, 603500201+math.min(math.max(count738+count741-2,0),4))
		end
	end
end
