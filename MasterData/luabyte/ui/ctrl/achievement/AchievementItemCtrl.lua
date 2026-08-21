local AchievementItemCtrl = BaseClass("AchievementItemCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = AchievementItemCtrl



function M:UpdateItem(data)
    if data == nil then
        return
    end

    self._data = data
    self._view.redpoint:SetParam(0, self._data:Id())
    self._view.redpoint:Check()

    local cfg = self._data:Config()
    local progress = self._data:Score() / self._data:AllScore()
    self._view.icon:SetPic(cfg.icon[data:Level()])
    self._view.name:SetText(cfg.name)
    self._view.bar:SetFillAmount(progress)

    progress = progress > 1 and 1 or progress
    self._view.barValue:SetText(tostring(math.floor(progress * 100)) .. "%")
end

function M:Init()
    self._view:onClick(Bind(self, self._OnClickItem))
    self:ShowPanel()
end

function M:_OnClickItem()
    UIContextMgr:GetInstance():Show("AchievementContent", self._data)
end



return AchievementItemCtrl
