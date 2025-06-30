
--
-- <代码文件解释说明>
--

---@class UISupportCardCtrl
---@field model UISupportCardModel
local UISupportCardCtrl = BaseClass("UISupportCardCtrl",UIBaseCtrl)
local this = UISupportCardCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UISupportCard)
end

return this
