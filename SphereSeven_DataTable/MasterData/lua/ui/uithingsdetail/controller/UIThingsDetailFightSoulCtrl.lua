
--
-- <代码文件解释说明>
--

---@class UIThingsDetailFightSoulCtrl
---@field model UIThingsDetailFightSoulModel
local UIThingsDetailFightSoulCtrl = BaseClass("UIThingsDetailFightSoulCtrl",UIBaseCtrl)
local this = UIThingsDetailFightSoulCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIThingsDetailFightSoul)
end

return this
