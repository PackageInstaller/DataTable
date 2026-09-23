-- 反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9026 = oo.class(SkillBase)
function Skill9026:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill9026:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8243
	if SkillJudger:IsSibling(self, caster, target, true,1023001) then
	else
		return
	end
	-- 9026
	self:BeatBack(SkillEffect[9026], caster, self.card, data, nil)
end
