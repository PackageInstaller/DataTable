-- 傷害提高
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer983600501 = oo.class(BuffBase)
function Buffer983600501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer983600501:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 983600501
	self:AddHp(BufferEffect[983600501], self.caster, self.card, nil, -math.floor(c116,1))
end
