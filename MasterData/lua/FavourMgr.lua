local this = MgrRegister("FavourMgr")

function this:Init()
    self:Clear()

end

function this:Clear()
    self.phyGameCnt = 0 -- 已催眠次数
end

function this:DailyData(phy_game_cnt)
    self.phyGameCnt = phy_game_cnt or 0 
end

-- -- 催眠次数(服务器主动推送)
-- function this:UpdateDailyData(data)
--     self.phyGameCnt = data["phyGameCnt"] or self.phyGameCnt
-- end

-- 设置次数
function this:SetCMCount(phyGameCnt)
    self.phyGameCnt = self.phyGameCnt
end
-- 可催眠次数
function this:GetCMCount()
    return self.phyGameCnt
end

-- 催眠总次数
function this:GetCMMaxCount()
    local buildData = MatrixMgr:GetBuildingDataByType(BuildsType.PhyRoom)
    if (buildData) then
        return buildData:GetCfg().dailyRewardCnt
    end
    return 0
end

return this
