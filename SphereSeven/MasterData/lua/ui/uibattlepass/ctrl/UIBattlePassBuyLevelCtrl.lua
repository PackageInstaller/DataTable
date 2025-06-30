
--
-- <代码文件解释说明>
--

---@class UIBattlePassBuyLevelCtrl
---@field model UIBattlePassBuyLevelModel
local UIBattlePassBuyLevelCtrl = BaseClass("UIBattlePassBuyLevelCtrl",UIBaseCtrl)
local this = UIBattlePassBuyLevelCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattlePassBuyLevel)
end

return this
