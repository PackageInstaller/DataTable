
--
-- <代码文件解释说明>
--

---@class UIThingsDetailCardCtrl
---@field model UIThingsDetailCardModel
local UIThingsDetailCardCtrl = BaseClass("UIThingsDetailCardCtrl",UIBaseCtrl)
local this = UIThingsDetailCardCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIThingsDetailCard)
end

return this
