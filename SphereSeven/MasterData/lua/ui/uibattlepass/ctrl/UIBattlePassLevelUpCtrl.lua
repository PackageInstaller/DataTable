
--
-- <代码文件解释说明>
--

---@class UIBattlePassLevelUpCtrl
---@field model UIBattlePassLevelUpModel
local UIBattlePassLevelUpCtrl = BaseClass("UIBattlePassLevelUpCtrl",UIBaseCtrl)
local this = UIBattlePassLevelUpCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattlePassLevelUp)
end

return this
