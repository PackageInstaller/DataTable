local M = BaseClass("EncounterTitleCtrl")

--设置赛季名、难度以及周期
function M:SetInfo(diffculty, cycleId)
    local engagementCfg = ConfigHelper.GetCfg("engagement", cycleId)
    local season = engagementCfg.season
    -- if diffculty + 1 == 3 then
    --     local cycleImgPath = "UI/SpritePics/encounter/ui_sidecabin_number_" .. string.format("%02d",diffculty+1 ) .. "_" .. string.format("%02d",cycleId)
    --     self.view.img_cycleNum:SetPic(cycleImgPath)
    -- end
    if self.view.img_cycleNum then
        self.view.img_cycleNum:SetActive(false)
    end

    local seasonPath = "UI/SpritePics/encounter/ui_encounter_season" .. string.format("%03d", season) .. "_" .. string.format("%02d", diffculty + 1)
    self.view.img_season:SetPic(seasonPath)
end

function M:OnDispose()
    if self.view then
        self.view:OnDispose()
        self.view = nil
    end
end

return M
