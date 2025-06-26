
--
-- <代码文件解释说明>
--

---@class UIHandBookPropertyCtrl
---@field model UIHandBookPropertyModel
local UIHandBookPropertyCtrl = BaseClass("UIHandBookPropertyCtrl",UIBaseCtrl)
local this = UIHandBookPropertyCtrl

function this.CloseSelf()
   UIManager:GetInstance():DestroyWindowNoRecycle(UIWindowNames.UIHandBookProperty)
end

return this
