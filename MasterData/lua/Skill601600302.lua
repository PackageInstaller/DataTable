-- 艾穆尔3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601600302 = oo.class(SkillBase)
function Skill601600302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill601600302:DoSkill(caster, target, data)
	-- 12005
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12005], caster, target, data, 0.2,5)
end
-- 行动结束
function Skill601600302:OnActionOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 601600301
	self:OwnerAddBuffCount(SkillEffect[601600301], caster, target, data, 601600301,1,10)
end
-- 攻击结束
function Skill601600302:OnAttackOver(caster, target, data)
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
	-- 8700
	local count700 = SkillApi:GetCount(self, caster, target,2,601600301)
	-- 8913
	if SkillJudger:Greater(self, caster, target, true,count700,0) then
	else
		return
	end
	-- 601600302
	self:OwnerAddBuffCount(SkillEffect[601600302], caster, target, data, 601600301,1,10)
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 601600303
	self:OwnerAddBuffCount(SkillEffect[601600303], caster, target, data, 601600301,1,10)
end
-- 攻击结束2
function Skill601600302:OnAttackOver2(caster, target, data)
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
	-- 8700
	local count700 = SkillApi:GetCount(self, caster, target,2,601600301)
	-- 8914
	if SkillJudger:Greater(self, caster, target, true,count700,9) then
	else
		return
	end
	-- 601600312
	self:LimitDamage(SkillEffect[601600312], caster, target, data, 1,5)
	-- 601600316
	self:DelBufferForce(SkillEffect[601600316], caster, target, data, 601600301)
	-- 601600317
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuffCount(SkillEffect[601600317], caster, target, data, 4601611,1,99)
	end
end
