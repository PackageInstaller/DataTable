-- 音符抵挡
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327501 = oo.class(SkillBase)
function Skill327501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill327501:OnAddBuff(caster, target, data, buffer)
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
	-- 8255
	if SkillJudger:HasBuff(self, caster, target, true,3,1,1) then
	else
		return
	end
	-- 8634
	local count634 = SkillApi:BuffCount(self, caster, target,3,4,200800101)
	-- 8833
	if SkillJudger:Greater(self, caster, target, true,count634,0) then
	else
		return
	end
	-- 327501
	if self:Rand(3000) then
		self:DelBufferGroup(SkillEffect[327501], caster, target, data, 1,1)
		-- 327511
		self:DelBufferForce(SkillEffect[327511], caster, self.card, data, 200800101,1)
	end
end
