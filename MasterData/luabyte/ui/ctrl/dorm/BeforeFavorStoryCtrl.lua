local BeforeFavorStoryCtrl = BaseClass("BeforeFavorStoryCtrl", BaseUICtrl)
local M = BeforeFavorStoryCtrl

function M:Init()
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
end

function M:OnEnter(heroId, taskStoryType, taskStory)
    UIContextMgr:GetInstance():Show("FavorStory", heroId, taskStoryType, taskStory, nil, nil, nil,
    function()
        --完成个人剧情领奖后开启引导
        if taskStory == 1014 then
            IGuideMgr:ManualTriggerGuideSystem()
        end
    end, true)
    self:Close()
end

function M:OnClose()
end


return BeforeFavorStoryCtrl
