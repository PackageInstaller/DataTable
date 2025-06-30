
--
-- <代码文件解释说明>
--

---@class UIChooseEquipCtrl
---@field model UIChooseEquipModel
local UIChooseEquipCtrl = BaseClass("UIChooseEquipCtrl",UIBaseCtrl)
local this = UIChooseEquipCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIChooseEquip)
end 

return this
