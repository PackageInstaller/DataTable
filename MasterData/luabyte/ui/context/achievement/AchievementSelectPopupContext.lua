local AchievementSelectPopupContext = BaseClass("AchievementSelectPopupContext", BaseContext)
local M = AchievementSelectPopupContext


function M:Init()
end


function M:Open(data, isFriend, callback)
    if isFriend then
        self._curList = {}
        self._data = data
    else
        local info = AchievementDataMgr:GetInstance():AchievementInfoData()
        self._curList = MapUtil.Clone(info)
        self._data = AchievementDataMgr:GetInstance():AchievementData()
    end

    self:_Show(self._curList, self._data, callback, isFriend)
end


function M:OnClose()
    M.super.OnClose(self)
end


return AchievementSelectPopupContext