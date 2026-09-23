-- 戰鬥開始給敵方全體-20%速度，每場戰鬥持續5回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010120 = oo.class(BuffBase)
function Buffer1000010120:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010120:OnCreate(caster, target)
	-- 1000010120
	self:AddBuffCount(BufferEffect[1000010120], self.caster, self.card, nil, 1000010121,1,1)
end
