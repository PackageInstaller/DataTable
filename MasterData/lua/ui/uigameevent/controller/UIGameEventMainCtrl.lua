
--
-- <代码文件解释说明>
--

---@class UIGameEventMainCtrl
---@field model UIGameEventMainModel
local UIGameEventMainCtrl = BaseClass("UIGameEventMainCtrl",UIBaseCtrl)
local this = UIGameEventMainCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIGameEventMain)
end

return this
