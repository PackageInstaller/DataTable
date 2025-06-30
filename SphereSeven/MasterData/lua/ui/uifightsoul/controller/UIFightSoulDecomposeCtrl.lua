
--
-- <代码文件解释说明>
--

---@class UIFightSoulDecomposeCtrl
---@field model UIFightSoulDecomposeModel
local UIFightSoulDecomposeCtrl = BaseClass("UIFightSoulDecomposeCtrl",UIBaseCtrl)
local this = UIFightSoulDecomposeCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIFightSoulDecompose)
end

return this
