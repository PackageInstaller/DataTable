
--
-- <代码文件解释说明>
--

---@class UIOptionalSkinCtrl
---@field model UIOptionalSkinModel
local UIOptionalSkinCtrl = BaseClass("UIOptionalSkinCtrl",UIBaseCtrl)
local this = UIOptionalSkinCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIOptionalSkin)
end

return this
