
--
-- <代码文件解释说明>
--

---@class UIBattlePassRewardCtrl
---@field model UIBattlePassRewardModel
local UIBattlePassRewardCtrl = BaseClass("UIBattlePassRewardCtrl",UIBaseCtrl)
local this = UIBattlePassRewardCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattlePassReward)
end

return this
