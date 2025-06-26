

---@class UIFormationChooseFightSoulCtrl : UIBaseCtrl
---@field model UIFormationChooseFightSoulModel
local UIFormationChooseFightSoulCtrl = BaseClass("UIFormationChooseFightSoulCtrl",UIBaseCtrl);
local base = UIBaseCtrl
local this = UIFormationChooseFightSoulCtrl

function this:CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIFormationChooseFightSoul)
end

---@param chooseFightSoul FightSoul | nil
function this:OnConfirmButtonClick(chooseFightSoul)
    if self.model.confirmCallBack ~= nil then
        self.model.confirmCallBack(chooseFightSoul)
    end
    self:CloseSelf()
end

return this
