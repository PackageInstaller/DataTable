-- 永恒之枪
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4702605 = oo.class(SkillBase)
function Skill4702605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4702605:OnBefourHurt(caster, target, data)
	-- 4702645
	self:tFunc_4702645_4702625(caster, target, data)
	self:tFunc_4702645_4702635(caster, target, data)
end
-- 攻击结束
function Skill4702605:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 4702615
	if self:Rand(5000) then
		self:OwnerAddBuffCount(SkillEffect[4702615], caster, self.card, data, 702600204,1,10)
	end
end
function Skill4702605:tFunc_4702645_4702625(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8423
	local count23 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 4702625
	self:AddTempAttr(SkillEffect[4702625], caster, caster, data, "attack",count23)
end
function Skill4702605:tFunc_4702645_4702635(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8423
	local count23 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 4702635
	self:AddTempAttr(SkillEffect[4702635], caster, target, data, "defense",count23*0.30)
end
