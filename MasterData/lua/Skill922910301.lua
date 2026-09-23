-- 指定坐标
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill922910301 = oo.class(SkillBase)
function Skill922910301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill922910301:DoSkill(caster, target, data)
	-- 922910301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[922910301], caster, target, data, 922910301,2)
end
-- 行动结束2
function Skill922910301:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8640
	local count640 = SkillApi:BuffCount(self, caster, target,1,4,922910302)
	-- 8840
	if SkillJudger:Greater(self, caster, target, true,count640,0) then
	else
		return
	end
	-- 922910302
	self:DelBufferForce(SkillEffect[922910302], caster, caster, data, 922910302)
	-- 922910303
	self:CallOwnerSkill(SkillEffect[922910303], caster, caster, data, 922910501)
end
