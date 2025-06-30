local SevenStarInfoMock = BaseClass("SevenStarInfo", Singleton);

local function SevenStar(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        Day1 = {
            Diff2Num = 0,
            Diff4Num = 0,
            OpenTime = 0,
            OpenDiff = 1,
            Diff3Num = 0,
            Diff1Num = 0,
        },
        Day2 = {
            Diff2Num = 0,
            Diff4Num = 0,
            OpenTime = 0,
            OpenDiff = 1,
            Diff3Num = 0,
            Diff1Num = 0,
        },
        Day3 = {
            Diff2Num = 0,
            Diff4Num = 0,
            OpenTime = 0,
            OpenDiff = 1,
            Diff3Num = 0,
            Diff1Num = 0,
        },
        Day4 = {
            Diff2Num = 0,
            Diff4Num = 0,
            OpenTime = 0,
            OpenDiff = 1,
            Diff3Num = 0,
            Diff1Num = 0,
        },
        Day5 = {
            Diff2Num = 0,
            Diff4Num = 0,
            OpenTime = 0,
            OpenDiff = 1,
            Diff3Num = 0,
            Diff1Num = 0,
        },
        Day6 = {
            Diff2Num = 0,
            Diff4Num = 0,
            OpenTime = 0,
            OpenDiff = 1,
            Diff3Num = 0,
            Diff1Num = 0,
        },
        Day7 = {
            Diff2Num = 0,
            Diff4Num = 0,
            OpenTime = 0,
            OpenDiff = 1,
            Diff3Num = 0,
            Diff1Num = 0,
        },
        Week = 4,
    }
    return rspMsg
end

local function sevenStarInfo()
    -- body
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_SevenStarInfo, SevenStar)
end

local function __delete(self)
end

SevenStarInfoMock.__init = __init
SevenStarInfoMock.__delete = __delete


return SevenStarInfoMock;