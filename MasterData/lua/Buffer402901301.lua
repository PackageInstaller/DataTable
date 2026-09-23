-- 免疫過熱
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer402901301 = oo.class(BuffBase)
function Buffer402901301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer402901301:OnRoundBegin(caster, target)
	-- 6112
	self:ImmuneBuffID(BufferEffect[6112], self.caster, target or self.owner, nil,3003)
end
-- 创建时
function Buffer402901301:OnCreate(caster, target)
	-- 402900301
	self:AddSp(BufferEffect[402900301], self.caster, target or self.owner, nil,50)
end
-- 行动结束2
function Buffer402901301:OnActionOver2(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8225
	if SkillJudger:IsTypeOf(self, self.caster, target, true,4) then
	else
		return
	end
	-- 402901301
	self:OwnerAddBuff(BufferEffect[402901301], self.caster, self.card, nil, 402901302)
end
