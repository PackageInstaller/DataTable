
--
-- <代码文件解释说明>
--

---@class UIMoreItemCtrl
---@field model UIMoreItemModel
local UIMoreItemCtrl = BaseClass("UIMoreItemCtrl",UIBaseCtrl)
local this = UIMoreItemCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIMoreItem)
end

return this
