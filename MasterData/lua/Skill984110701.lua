-- 巨蟹座普通形态被动2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984110701 = oo.class(SkillBase)
function Skill984110701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill984110701:OnAddBuff(caster, target, data, buffer)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8258
	if SkillJudger:IsCtrlBuff(buffer or self, caster, target, true,2) then
	else
		return
	end
	-- 984110701
	self:AddBuffCount(SkillEffect[984110701], caster, self.card, data, 984110701,1,10)
end
-- 行动结束2
function Skill984110701:OnActionOver2(caster, target, data)
	-- 984110704
	local countjuxie = SkillApi:GetCount(self, caster, target,3,984110701)
	-- 984110705
	if SkillJudger:GreaterEqual(self, caster, target, true,countjuxie,10) then
	else
		return
	end
	-- 984110702
	self:AddBuffCount(SkillEffect[984110702], caster, self.card, data, 984110701,-10,10)
	-- 984110703
	self:CallOwnerSkill(SkillEffect[984110703], caster, self.card, data, 984110301)
end
