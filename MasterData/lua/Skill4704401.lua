-- 朝晖
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4704401 = oo.class(SkillBase)
function Skill4704401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4704401:OnActionOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4704411
	self:OwnerAddBuffCount(SkillEffect[4704411], caster, self.card, data, 704400101,1,6)
end
-- 行动结束2
function Skill4704401:OnActionOver2(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8709
	local count709 = SkillApi:GetCount(self, caster, target,3,704400101)
	-- 4704401
	if self:Rand(700*count709) then
		local targets = SkillFilter:MinAttr(self, caster, target, 2,"hp",1)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[4704401], caster, target, data, 704400401)
		end
	end
end
