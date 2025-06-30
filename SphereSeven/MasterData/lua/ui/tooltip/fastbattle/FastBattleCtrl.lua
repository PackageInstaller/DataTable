local FastBattleCtrl = BaseClass("FastBattleCtrl",UIBaseCtrl)
local this = FastBattleCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.FastBattle)
end

return this
