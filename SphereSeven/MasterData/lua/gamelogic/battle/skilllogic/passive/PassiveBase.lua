local PassiveBase = BaseClass("PassiveBase")

local function __init(self)
    local battleComponent = Game.Scene:GetComponent("BattleComponent")
    self.CurActSkill = battleComponent.CurActSkill
    self.CurActUnit = battleComponent.CurActUnit
end

PassiveBase.__init = __init

return PassiveBase