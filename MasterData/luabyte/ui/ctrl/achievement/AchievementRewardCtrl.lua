local AchievementRewardCtrl = BaseClass("AchievementRewardCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))
local M = AchievementRewardCtrl


function M:SetActive(b)
    self._view:SetActive(b)
end


function M:UpdateItem(id, num, path)
    if id <=0 then
        return
    end 
    if path then
        self._view.item:EnablePopItem(false)
    else
        self._view.item:EnablePopItem(true)
    end
    self:SetInfo(id, ItemNumberType.TOTLE, num)
end


return AchievementRewardCtrl