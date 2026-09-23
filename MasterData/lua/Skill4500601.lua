-- 风之翼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4500601 = oo.class(SkillBase)
function Skill4500601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill4500601:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8473
	local count73 = SkillApi:BuffCount(self, caster, target,3,4,4500601)
	-- 8165
	if SkillJudger:Less(self, caster, target, true,count73,5) then
	else
		return
	end
	-- 4500601
	self:AddBuff(SkillEffect[4500601], caster, self.card, data, 4500601)
	-- 4500606
	self:ShowTips(SkillEffect[4500606], caster, self.card, data, 2,"凌波翩跹",true,4500606)
end
