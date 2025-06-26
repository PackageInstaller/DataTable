
--
-- <代码文件解释说明>
--

---@class UIUseOptionalItemCtrl
---@field model UIUseOptionalItemModel
local UIUseOptionalItemCtrl = BaseClass("UIUseOptionalItemCtrl",UIBaseCtrl)
local this = UIUseOptionalItemCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIUseOptionalItem)
end

return this
