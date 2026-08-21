local OnlineAwardRedPointChecker = BaseClass("OnlineAwardRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = OnlineAwardRedPointChecker

function M:Check()
    self.checkResult = ActivityHelper.CheckOnlineAwardRedPoint() and 1 or 0
end


return OnlineAwardRedPointChecker