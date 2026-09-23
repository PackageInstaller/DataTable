-- 指引护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102200204 = oo.class(SkillBase)
function Skill102200204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102200204:DoSkill(caster, target, data)
	-- 102200201
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[102200201], caster, target, data, 102200201,3,3)
end
-- 回合开始时
function Skill102200204:OnRoundBegin(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8714
	local count714 = SkillApi:BuffCount(self, caster, target,1,4,102200201)
	-- 8925
	if SkillJudger:Greater(self, caster, target, true,count714,0) then
	else
		return
	end
	-- 102200202
	self:OwnerAddBuffCount(SkillEffect[102200202], caster, caster, data, 102200201,-1,3)
end
