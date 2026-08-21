local EncounterFriendHeroItemCtrl = BaseClass("EncounterFriendHeroItemCtrl" ,require("UI.Ctrl.Mission.EncounterHeroItemCtrl"))
local M = EncounterFriendHeroItemCtrl

function M:UpdateItem(data)
    M.super.UpdateItem(self,data)
    self.view.friendName:SetText(data.nickName)
    self.view.btnFri:SetActive(data.isFriend)
end

function M:_OnClickItem(go)
    if self._data.isSame then 
        return 
    end
    if self.onClickCallback then 
        self._data.isup = not self._data.isup
        self.onClickCallback(self._data.heroId,self._data.isup,self._data.friendId)
    end
end

return EncounterFriendHeroItemCtrl