
--
-- <代码文件解释说明>
--

---@class UIFightSoulMergeMaterialsCtrl
---@field model UIFightSoulMergeMaterialsModel
local UIFightSoulMergeMaterialsCtrl = BaseClass("UIFightSoulMergeMaterialsCtrl",UIBaseCtrl)
local this = UIFightSoulMergeMaterialsCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIFightSoulMergeMaterials)
end

return this
