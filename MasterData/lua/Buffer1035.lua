-- 傷害引爆（把自己的存儲傷害分攤到敵人身上）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1035 = oo.class(BuffBase)
function Buffer1035:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1035:OnCreate(caster, target)
	-- 1042
	local dmg4022 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"dmg4022")
	-- 8413
	local c13 = SkillApi:LiveCount(self, self.caster, target or self.owner,2)
	-- 1047
	self:AddHp(BufferEffect[1047], self.caster, target or self.owner, nil,math.floor(-dmg4022/c13*0.35))
end
