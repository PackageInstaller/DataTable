local RoleProfileItemCtrl = BaseClass("RoleProfileItemCtrl", UIBaseComponent)
local M = RoleProfileItemCtrl

--设置单个人设item
function M:SetPersonItemInfo(heroCfg, favorLevel, index)
    self._view.title:SetText(ConfigHelper.GetLocalString(heroCfg.personTitle[index]))
    local isUnLock = index <= #heroCfg.personLimit and favorLevel >= heroCfg.personLimit[index]
    self._view.textBg:SetActive(isUnLock)
    self._view.lockBg:SetActive(not isUnLock)
    
    if isUnLock then
        self._view.value:SetText(heroCfg.personInformation[index])
    else
        local str = ConfigHelper.GetLocalString(1244)
        self._view.lockLabel:SetText(string.format(str, heroCfg.personLimit[index]))
    end
    
    self._view.state:SetState(isUnLock and 1 or 2)
    
    if index % 2 == 0 then
        self._view.bgAlpha:SetAlpha(1)
    else
        self._view.bgAlpha:SetAlpha(0)
    end
end


return RoleProfileItemCtrl
