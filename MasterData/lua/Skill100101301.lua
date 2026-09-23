-- 能量爆发（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100101301 = oo.class(SkillBase)
function Skill100101301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100101301:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 行动结束
function Skill100101301:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8453
	local count53 = SkillApi:SkillLevel(self, caster, target,3,41001)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 4100108
	self:OwnerAddBuffCount(SkillEffect[4100108], caster, self.card, data, 4100100+count53,1,4)
	-- 4100106
	self:ShowTips(SkillEffect[4100106], caster, self.card, data, 2,"荣耀之心",true,4100106)
end
