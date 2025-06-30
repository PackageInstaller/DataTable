
--
-- <代码文件解释说明>
--

---@class ToolTipFirstChooseCountCtrl
---@field model ToolTipFirstChooseCountModel
local ToolTipFirstChooseCountCtrl = BaseClass("ToolTipFirstChooseCountCtrl",UIBaseCtrl)
local this = ToolTipFirstChooseCountCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipFirstChooseCount)
end

return this
