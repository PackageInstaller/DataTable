local M = BaseClass('MessageCtrl')

function M:Refresh(mission)
    local showStorys = mission.showStory
    if (not showStorys or showStorys.Length <= 0) then return end

    local fmtStr = ConfigHelper.GetLocalString(512)
    for i = 1, 5 do
        local name, showStory, herostory, heroCfg = "tip" .. tostring(i), showStorys[i - 1], nil, nil
        if showStory then herostory = ConfigHelper.GetCfg("heroStory", showStory) end
        if herostory then heroCfg = ConfigHelper.GetCfg("hero", herostory.hero) end
        if heroCfg then
            local message = string.format(fmtStr, ConfigHelper.GetLocalString(heroCfg.name))
            self.view[name]:SetMessage(message)
            self.view[name]:SetActive(true)
        end
    end
end

function M:OnDispose()
    if self.view then
        for i = 1, 5 do self.view["tip" .. i]:OnDispose() end
        self.view:OnDispose()
        self.view = nil
    end
end

return M
