local OpenSystemMgr = BaseClass("OpenSystemMgr", Singleton)
local M = OpenSystemMgr
local tInsert = table.insert

function M:__init()

end

function M:IsOpenNewTips(missionId)
    if not self.functionOpens then
        self.functionOpens = ConfigHelper.GetCfgs("functionOpen")
    end
    local openIds = nil
    for id, functionOpen in pairs(self.functionOpens) do
        if functionOpen.ifShow == 1 and functionOpen.missionId == missionId then
            openIds = openIds or {}
            tInsert(openIds, id)
        end
    end
    return openIds
end

function M:SetMissionId(missionId)
    self.missionId = missionId
end

function M:GetMissionId()
    return self.missionId
end

return OpenSystemMgr
