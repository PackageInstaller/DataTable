-- 水瓶座被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984700401 = oo.class(SkillBase)
function Skill984700401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill984700401:OnBorn(caster, target, data)
	-- 984700504
	self:tFunc_984700504_984700401(caster, target, data)
	self:tFunc_984700504_984700505(caster, target, data)
end
function Skill984700401:tFunc_984700504_984700401(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 984700401
	self:AddBuffCount(SkillEffect[984700401], caster, self.card, data, 984700401,20,20)
end
function Skill984700401:tFunc_984700504_984700505(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 984700505
	self:CallSkillEx(SkillEffect[984700505], caster, target, data, 984700501)
end
