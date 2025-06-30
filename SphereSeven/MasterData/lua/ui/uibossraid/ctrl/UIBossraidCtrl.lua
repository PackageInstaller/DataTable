
--
-- <代码文件解释说明>
--

---@class UIBossraidCtrl
---@field model UIBossraidModel
local UIBossraidCtrl = BaseClass("UIBossraidCtrl",UIBaseCtrl)
local this = UIBossraidCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIBossraid)
end

---@param currentCount number @用来记录下面有多少个(移动y轴)
function this:RequestLeaderboard(startRank, endRank, currentCount)
    if startRank < 1 then
        startRank = 1
    end
    if self.model.bossraid.leaderboard[startRank] ~= nil and self.model.bossraid.leaderboard[endRank] ~= nil then
        Logger.LogError("leader data already exist, startRank:" .. startRank .. ", endRank:" .. endRank)
        return
    end

    self.model:RefreshLeaderboard(startRank, endRank, currentCount)
end

return this
