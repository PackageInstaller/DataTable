local TopUpActivitiesMock = BaseClass("TopUpActivitiesMock", Singleton);

local function Activities(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        Records = {},
        StartDate = 1657051200,
        EndDate = 1659470400,
        PurchasesDetail = {},
        QuotaDetail = {},
        TimeSlots = {},
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_TopUpActivities, Activities)
end

local function __delete(self)
end

TopUpActivitiesMock.__init = __init
TopUpActivitiesMock.__delete = __delete


return TopUpActivitiesMock;