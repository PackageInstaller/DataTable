-- 核心催动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill402900305 = oo.class(SkillBase)
function Skill402900305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill402900305:DoSkill(caster, target, data)
	-- 402900301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[402900301], caster, target, data, 402900301,1)
end
-- 行动开始
function Skill402900305:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 402900315
	self:AddHp(SkillEffect[402900315], caster, self.card, data, -math.floor(count20*0.1))
end
