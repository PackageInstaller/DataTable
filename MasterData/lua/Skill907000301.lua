-- 夺魂指令
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907000301 = oo.class(SkillBase)
function Skill907000301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill907000301:DoSkill(caster, target, data)
	-- 907000301
	self.order = self.order + 1
	self:AddXp(SkillEffect[907000301], caster, target, data, 3)
	-- 907000401
	self.order = self.order + 1
	self:AddProgress(SkillEffect[907000401], caster, target, data, 1000)
end
-- 行动结束2
function Skill907000301:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 6202
	self:DelBufferForce(SkillEffect[6202], caster, self.card, data, 6113)
	-- 6203
	self:AddHp(SkillEffect[6203], caster, self.card, data, -99999)
end
