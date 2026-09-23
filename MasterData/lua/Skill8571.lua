-- 炽热吐息
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8571 = oo.class(SkillBase)
function Skill8571:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill8571:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8452
	local count52 = SkillApi:BuffCount(self, caster, target,1,3,1002)
	-- 8154
	if SkillJudger:Greater(self, caster, target, true,count52,0) then
	else
		return
	end
	-- 8571
	if self:Rand(8000) then
		local targets = SkillFilter:Rand(self, caster, target, 4,1)
		for i,target in ipairs(targets) do
			self:SpreadBuff(SkillEffect[8571], caster, target, data, 3,1002)
		end
	end
end
