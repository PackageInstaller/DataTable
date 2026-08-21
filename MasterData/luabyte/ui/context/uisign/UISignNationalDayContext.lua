local UISignContext = BaseClass("UISignNationalDayContext", BaseContext)
local M = UISignContext

function M:Init()
end

function M:Open(activityId, callback)
    self.activityId = activityId
    self.m_CallBack = callback
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(activityId, Bind(self, self.AsynActCallBack))
end

function M:AsynActCallBack(data)
    if not data then
        data = {}
    end

    self:_Show(self.activityId, data[1], self.m_CallBack)
end

return UISignContext
