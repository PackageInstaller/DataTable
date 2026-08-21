local M = BaseClass('BattleTitleCtrl')

function M:Refresh(starCount, mission)
    local fmtStr = "%s<color=#5282FF>-</color>%s"
    local strs = string.split(mission.chapterLabel, '-')
    local chapterLabel = string.format(fmtStr, strs[1], strs[2])

    local is9Star = MissionHelper.Is9StarMission(mission)
    self.view.starGroup:SetActive(not is9Star)
    self.view.Group9:SetActive(is9Star)
    self.view.missionName:SetText(mission.name)
    
    if is9Star then --新战斗..极限战役 9星模式
        self.view.StarNumber:SetText(starCount.."/9")
    else
        local is4Star = MissionHelper.Is4StarMission(mission)
        self.view.chapterText:SetText(chapterLabel)
        self.view.star4Bg:SetActive(is4Star)
        for i = 1, 4 do self.view["star" .. i]:SetActive(i <= starCount) end
        self.view.img_text:SetActive(starCount >= (is4Star and 4 or 3))
    end

end

function M:OnDispose()
    if self.view then
        self.view:OnDispose()
        self.view = nil
    end
end

return M
