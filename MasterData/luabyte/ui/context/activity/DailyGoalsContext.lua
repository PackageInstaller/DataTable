local DailyGoalsContext = BaseClass("DailyGoalsContext", BaseContext)
local M = DailyGoalsContext


function M:Init()
end


function M:Open()
    DailyGolasDataMgr:GetInstance():GetActivityData(Bind(self, self.AsynActCallBack))
end


function M:AsynActCallBack(data)
    self.m_actData = data
    self.m_actCfg = ConfigHelper.GetCfg("activity", self.m_actData:ActivityId())
    DailyGolasDataMgr:GetInstance():GetActivityScoreData(Bind(self, self.AsynScoreCallBack))
end


function M:AsynScoreCallBack(data)
    if data == nil then 
        return 
    end
    local sevenCfg = DailyGolasDataMgr:GetInstance():GetTaskByActivityId(self.m_actData:ActivityId())
    self:_Show(self.m_actData, self.m_actCfg, sevenCfg, data)
end


function M:OnClose()
    M.super.OnClose(self)
end


return DailyGoalsContext