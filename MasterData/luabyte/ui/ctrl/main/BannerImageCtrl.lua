local BannerImageCtrl = BaseClass("BannerImageCtrl", UIBaseComponent)
local M = BannerImageCtrl

function M:__init(view)
    self._view = view
    self._view.img:onClick(Bind(self, self._click))
end

function M:UpdateData(data)
    self._data = data
    local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=data.activityId})
    if #activityCopys <= 0 then
        Logger.LogError("配置错误：" .. data.activityId)
        return
    end
    local banner = activityCopys[1].banner
    self._view.img:SetPic(banner)
    local relationId = ConfigHelper.GetCfgPropByLua("activity", data.activityId, "relationId")
    if #relationId < 1 then
        return
    end
    self._view.redPoint:SetParam(0, relationId[1])
    if activityCopys[1].achievementGroupId > 0 then
        self._view.redPoint:SetParam(1, data.activityId)
    else
        self._view.redPoint:SetParam(1, 0)
    end
    if #activityCopys[1].allReward > 0 then
        self._view.redPoint:SetParam(2, data.activityId)
    else
        self._view.redPoint:SetParam(2, 0)
    end
    self._view.redPoint:Check()
end

function M:_click()
    if self._data and self._data.callBack then
        self._data.callBack(self._data.activityId)
    end
end

function M:SetActive(state)
    self._view:SetActive(state)
end

return BannerImageCtrl
