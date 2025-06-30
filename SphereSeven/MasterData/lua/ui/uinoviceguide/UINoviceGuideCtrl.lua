
local UINoviceGuideCtrl = BaseClass("UINoviceGuideCtrl",UIBaseCtrl)
local this = UINoviceGuideCtrl
function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UINoviceGuide);
end
function this.OnClick()
    local guide=Game.Scene:GetComponent("GuideComponent")
    guide:ClickGuide()
end
function this.OnSkip()
    local guide=Game.Scene:GetComponent("GuideComponent")
    guide:SkipAll()
end

return this