local UISkillSkipView = BaseClass("UISkillSkipView",UIBaseView);
local base = UIBaseView;
local this = UISkillSkipView;
local bb=false

local function CloseBtnClick(self)
    self.ctrl.OnSkip()
    self.skip_bg:SetActive(true)
    self.bgig:DOFade(0,0)
    self.bgig:DOFade(0,0)
    self.bgig:DOFade(0,0.1):SetUpdate(true)
    self.skip_btn:SetActive(false)
    bb=false
end



function this.OnCreate(self)
    base.OnCreate(self)
    local rc = self.rc
    self.skip_btn = rc:GetObject("SkipBtn")
    self.skip_bg = rc:GetObject("Image")
    self.bgig = self.skip_bg:GetComponent("Image")
    ButtonListener.Get(self.skip_btn).OnClickHandler = function ()
        CloseBtnClick(self)
    end
end

function this.ShutDown(self)
    if bb then
        UIManager:GetInstance():CloseWindow(UIWindowNames.UISkillSkip)
    else
        self.tw = self.bgig:DOFade(0,0.3):SetUpdate(true)
        coroutine.waitforseconds(0.3)
        UIManager:GetInstance():CloseWindow(UIWindowNames.UISkillSkip)
    end
end

function this.OnEnable(self)
    base.OnEnable(self)
    if ClientData:GetInstance():GetAutoAwakenSkill() == 1 then
        self.skip_btn:SetActive(false)
        if self.tw~= nil then
            self.tw:Kill()
            self.tw=nil
        end
        CloseBtnClick(self)
    else
        self.skip_btn:SetActive(true);
        self.skip_bg:SetActive(false);
        bb=true
        if self.tw~= nil then
            self.tw:Kill()
            self.tw=nil
        end
    end
end

return this;
