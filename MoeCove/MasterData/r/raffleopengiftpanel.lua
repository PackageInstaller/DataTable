---@class RaffleOpenGiftPanel : RaffleOpenGiftPanel_Generate
---##################### 【RaffleOpenGiftPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RaffleOpenGiftPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RaffleOpenGiftPanel = require "RaffleOpenGiftPanel_Generate"

function RaffleOpenGiftPanel:InitLogic(data)
    --是否跳过动画
    self.isSkip = false

    --是否处于可自己操控的状态
    self.doYouself = true

    --抽到的最高品质
    self.limitRarity = 1

    --是否显示感叹号
    self.needMark = false

    --显示感叹号
    self.showMark = false

    --当前抽卡动画比率
    self.nowAniRatio = 0

    --播放的抽卡动画名称
    self.needAniName = "OpenWithOutCat"

    --屏幕长度
    self.screenLength = UIMgr.DesignHeight

    --音效key
    self.lightSEKey = nil
end

function RaffleOpenGiftPanel:Update()
    --开启礼包
    if Input.GetMouseButtonDown(0) and self.doYouself then
        --记录按下鼠标的初始位置
        self.mousePosY = Input.mousePosition.y
        --停止提示动画
        self.gloveAndArrow.skeletonAnimation.AnimationState:SetEmptyAnimations(0)
        --刷新显示感叹号
        self.showMark = true
    end
    if Input.GetMouseButton(0) and self.doYouself then
        if not self.mousePosY then
            return
        end
        local needRatio = 0
        local nowMouseY = Input.mousePosition.y
        local yDvalue = (nowMouseY - self.mousePosY) / 20
        if yDvalue ~= 0 then
            self.box.animator.speed = 0
        end
        if yDvalue ~= 0 then
            needRatio = math.max((yDvalue / self.screenLength) + self.nowAniRatio, 0)
            self.box.animator:Play(self.needAniName, 0, needRatio)
        end
        if needRatio > 0.02 then
            self.doYouself = false
            self.box.animator.speed = 1
            self.skipBtn:SetActive(false)
        end
        --抽卡特效
        self["ui_Effect_ChouKa_"..self.limitRarity]:SetActive(needRatio > 0.01)

        --抽卡光芒音效开启判断
        if needRatio >= 0.01 and not self.isPlayOpenLightSE then
            self.isPlayOpenLightSE = true
        end
        if needRatio < 0.01 and self.isPlayOpenLightSE then
            self.isPlayOpenLightSE = false
            AudioMgr:stopSE(self.lightSEKey)
            self.lightSEKey = nil
        end

        --感叹号提示
        if needRatio > 0.01 and self.nowAniRatio == 0 and self.needMark then
            if self.showMark then
                self.mark.skeletonAnimation.AnimationState:SetAnimation(0, "!mark", false)
                self.showMark = false
            end
        end
        --停止提示动画
        self.gloveAndArrow.skeletonAnimation.AnimationState:SetEmptyAnimations(0)
    end
    --记录礼包开启状态
    if Input.GetMouseButtonUp(0) and self.doYouself then
        local aniStateInfo = self.box.animator:GetCurrentAnimatorStateInfo(0)
        if aniStateInfo:IsName(self.needAniName) then
            self.nowAniRatio = aniStateInfo.normalizedTime
        end
    end
end

function RaffleOpenGiftPanel:_SetEnterAnimation()
    --背景动画
    local completeFunc = function()
        self.background.skeletonAnimation.AnimationState:SetAnimation(0, "IdleShakeOnly", true)
    end
    self.background.skeletonAnimation.AnimationState.Complete = self.background.skeletonAnimation.AnimationState.Complete + completeFunc
    self.background.skeletonAnimation.AnimationState:SetAnimation(0, "Enter", false)

    --提示抽卡动画
    self.gloveAndArrowTimer = DLuaTimer:DoRepeatForever(3, function ()
        if self.doYouself then
            self.gloveAndArrow.skeletonAnimation.AnimationState:SetAnimation(0, "GloveAndArrow", false)
        end
    end)
    
    --处理猫信息
    for _, rewardData in pairs(self.rewardList) do
        self:_SetEffectByReward(rewardData)
    end
end

--根据奖励等级设置特效显示
function RaffleOpenGiftPanel:_SetEffectByReward(rewardData)
    if rewardData.type == GE.RewardType.Cat then
        local catConfig = Config.GetCatConfigInfo(rewardData.id)
        if catConfig.rarity > self.limitRarity then
            self.limitRarity = catConfig.rarity
        end
        if catConfig.rarity == GE.CatRarityType.SSRCat then
            self.needMark = true
        end
        self.needAniName = "OpenWithCat"
    end
end

--下一个界面
function RaffleOpenGiftPanel:_CloseAndNextPanel()
    local data = {
        rewardList = self.rewardList,
        isSkip = self.isSkip,
    }
    if self.lightSEKey then
        AudioMgr:stopSE(self.lightSEKey)
    end
    UIMgr:popUI("RaffleRewardPanel", data)
    UIMgr:closeUI(self)
end

--抽卡界面音效
function RaffleOpenGiftPanel:_SetRaffleSE()
    self.box.animOverCallBack:SetCallBackOfName(function(name)
        if name == "WhiteLight" then--转场效果(不是音效)
            self.whiteLight.canvasGroup:DOFade(1, 0.3)
            DLuaTimer:DoAfter(0.8, function ()
                self:_CloseAndNextPanel()
            end)
        end
    end)
end

--function RaffleOpenGiftPanel:StartCreating(time)
--
--end

--function RaffleOpenGiftPanel:StartEnter(time)
--
--end

--function RaffleOpenGiftPanel:StartRemoving(time)
--
--end

--function RaffleOpenGiftPanel:StartExit(time)
--
--end

function RaffleOpenGiftPanel:OnOpen(data, initiative)
    if initiative then
        self.rewardList = data and data.rewardList
        self:_SetRaffleSE()
        self:_SetEnterAnimation()
    end
end

--function RaffleOpenGiftPanel:OnClose(initiative)
--
--end

--function RaffleOpenGiftPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function RaffleOpenGiftPanel:OnRefresh(data)
--
--end

--[[
/ClickBoxBtn onClick 
--]]
function RaffleOpenGiftPanel:clickBoxBtn_Button_onClick(clickBoxBtn)
    --抽卡前动画
    local aniStateInfo = self.box.animator:GetCurrentAnimatorStateInfo(0)
    if self.doYouself and not aniStateInfo:IsName(self.needAniName) then
        self.box.animator:SetTrigger("Opening")
    end
end

--[[
/SkipBtn onClick 
--]]
function RaffleOpenGiftPanel:skipBtn_ScaleButton_onClick(skipBtn)
    self.isSkip = true
    self.doYouself = false
    self:_CloseAndNextPanel()
end

return RaffleOpenGiftPanel
