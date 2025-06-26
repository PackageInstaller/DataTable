
--
-- <代码文件解释说明>
--

---@class UIBattlePassBuyPassCtrl
---@field model UIBattlePassBuyPassModel
local UIBattlePassBuyPassCtrl = BaseClass("UIBattlePassBuyPassCtrl",UIBaseCtrl)
local this = UIBattlePassBuyPassCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattlePassBuyPass)
end

return this
