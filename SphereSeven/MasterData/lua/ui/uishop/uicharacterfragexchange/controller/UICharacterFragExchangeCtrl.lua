
--
-- <代码文件解释说明>
--

---@class UICharacterFragExchangeCtrl
---@field model UICharacterFragExchangeModel
local UICharacterFragExchangeCtrl = BaseClass("UICharacterFragExchangeCtrl",UIBaseCtrl)
local this = UICharacterFragExchangeCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UICharacterFragExchange)
end

return this
