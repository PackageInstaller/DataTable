local AchievementSelectItemCtrl = BaseClass("AchievementSelectItemCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = AchievementSelectItemCtrl



function M:ClickToggleCallback(callback)
    self._callback = callback
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self._data = data
    self._isFriend = (self._data.FriendId or 0) > 0

    if self._isFriend then
        self._id = self._data.Id
        self._level = self._data.Level
        self._cfg = ConfigHelper.GetCfg("achievementGroup", self._id)
        self:_SetFriendUI()
    else
        self._id = self._data:Id()
        self._level = self._data:Level()
        self._cfg = self._data:Config()
        self:_SetMineUI()
    end
end

function M:_SetFriendUI()
    self._view.bar:SetFillAmount(0)
    self._view.barValue:SetText("")
    self._view.select:SetActive(false)
    self._view.icon:SetPic(self._cfg.icon[self._level])
end

function M:_SetMineUI()
    self:_SetProgress()
    self:_SetSelect()
    self._view.icon:SetPic(self._cfg.icon[self._level])
end

function M:_SetProgress()
    local progerss = self._data:ProgressValue()
    self._view.bar:SetFillAmount(progerss)
    self._view.barValue:SetText(tostring(math.floor(progerss * 100)) .. "%")
end

function M:_SetSelect()
    local curList = AchievementDataMgr:GetInstance():AchievementInfoData()
    local key = MapUtil.FindKey(curList, function(v) return v.Id == self._id end)
    if key then
        self._view.select:SetActive(true)
    end
end

function M:Init()
    self._view.selectBtn:onClick(Bind(self, self._OnClickItem))
    self:ShowPanel()
end

function M:_OnClickItem()
    if self._isFriend then
        return
    end

    self._callback(self._id, self._data:Score(), Bind(self, self._SelectItem))
end

function M:_SelectItem(index)
    self._view.select:SetActive(index == 0)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return AchievementSelectItemCtrl
