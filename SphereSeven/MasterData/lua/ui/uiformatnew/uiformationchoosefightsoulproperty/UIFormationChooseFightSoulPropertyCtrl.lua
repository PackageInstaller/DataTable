
--
-- <代码文件解释说明>
--

---@class UIFormationChooseFightSoulPropertyCtrl
---@field model UIFormationChooseFightSoulPropertyModel
local UIFormationChooseFightSoulPropertyCtrl = BaseClass("UIFormationChooseFightSoulPropertyCtrl",UIBaseCtrl)
local this = UIFormationChooseFightSoulPropertyCtrl

function this.CloseSelf()
    UIManager:GetInstance():DestroyWindowNoRecycle(UIWindowNames.UIFormationChooseFightSoulProperty)
 end

return this
