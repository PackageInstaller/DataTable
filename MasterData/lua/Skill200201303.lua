-- 奏响战歌（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200201303 = oo.class(SkillBase)
function Skill200201303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200201303:DoSkill(caster, target, data)
	-- 200200303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200303], caster, target, data, 200200303)
	-- 200200313
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200313], caster, target, data, 200200313)
end
-- 行动结束
function Skill200201303:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 95003
	local targets = SkillFilter:All(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:AlterBufferByGroup(SkillEffect[95003], caster, target, data, 1,1)
	end
end
