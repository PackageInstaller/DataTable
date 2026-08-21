--
-- <代码文件解释说明>
--

---@class UIBattlePassLevelUpView : UIBaseView
---@field model UIBattlePassLevelUpModel
---@field ctrl UIBattlePassLevelUpCtrl
local UIBattlePassLevelUpView = BaseClass("UIBattlePassLevelUpView",UIBaseView)
local base = UIBaseView
local this = UIBattlePassLevelUpView

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    self.levelText = LangUtil.BindText(self.rc:GetObject("LevelText"))
    local confirmImage = self.cancelButton.transform:Find("Text"):GetComponent("Image")
    LangUtil.GetSpriteLang(580, function(sprite) -- 确定
        confirmImage.sprite = sprite 
        confirmImage:SetNativeSize()
    end)
    local receiveImage = self.receiveButton.transform:Find("Text"):GetComponent("Image")
    LangUtil.GetSpriteLang(579, function(sprite) -- 领取奖励
        receiveImage.sprite = sprite 
        receiveImage:SetNativeSize()
    end)
end

function this:OnCreate()
    base.OnCreate(self)
    local eventBg = self.rc:GetObject("Self")
    UIUtil.AddBtnEvent(eventBg,function()self.ctrl.CloseSelf()end,"Back")
    self.cancelButton = self.rc:GetObject("CancelButton")
    UIUtil.AddBtnEvent(self.cancelButton,function()self.ctrl.CloseSelf()end,"Back")
    self.receiveButton = self.rc:GetObject("ReceiveButton")
    UIUtil.AddBtnEvent(self.receiveButton,function()self:ReceiveButtonClick()end)
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    self.levelText.text = self.model.level
end

function this:ReceiveButtonClick()
    local beginLevel = self.model.pass.normal_received_stage + 1
    local endLevel = self.model.level
    PublicRequest.SendRequest(
        PROTOCOL.ReceivePassRewardsReq,
        {
            pass_id = self.model.pass.id,
        },
        function(response)
            self.ctrl.CloseSelf()
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattlePassReward,
            {
                beginLevel = beginLevel,
                endLevel = endLevel,
                passId = self.model.pass.id,
                response = response,
            }
        )
        end,
        function(error)
            Logger.LogError(error)
        end
    )
end

function this:OnAddListener()
    base.OnAddListener(self)
    -- self:AddUIListener(UIMessageNames.xxx, func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- self:RemoveUIListener(UIMessageNames.xxx)
end


function this:OnDisable()
    base.OnDisable(self)
end

function this:OnDestroy()
    base.OnDestroy(self)
end

return this
