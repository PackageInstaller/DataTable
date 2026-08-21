---@class RaffleAnimationPanel : RaffleAnimationPanel_Generate
---##################### 【RaffleAnimationPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RaffleAnimationPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RaffleAnimationPanel = require "RaffleAnimationPanel_Generate"

function RaffleAnimationPanel:InitLogic(data)
    self.rejectInput = false
    self.fristClick = true
    self.haveSSR = false
    self.canSkip = true
    self.canTouchEta = true
end

--function RaffleAnimationPanel:StartCreating(time)
--
--end

--function RaffleAnimationPanel:StartEnter(time)
--
--end

--function RaffleAnimationPanel:StartRemoving(time)
--
--end

--function RaffleAnimationPanel:StartExit(time)
--
--end

function RaffleAnimationPanel:Update()
    
end

function RaffleAnimationPanel:OnOpen(data, initiative)
    self.rejectInput = false
    self.fristClick = true
    self:setRaffleAniData()
    LoadingMgr:SetUIQuickSwitchOver()
    self:setTipsAnimation()
end

function RaffleAnimationPanel:setRaffleAniData()
    if RaffleMgr.isSimpleShow then
       return 
    end
    self.resultList = RaffleMgr:getRaffleResultList()
    self.raffleController = RaffleMgr:getRaffleController()

    if self.raffleController ~= nil then
        
        self.raffleController.srEtaCallBack:SetCallBackOfName(function(name)
            if name == "PlayOpen" then
                self.canTouchEta = false
                self.raffleController.effectZZZ:SetActive(false)
                self.raffleController.effectsrQiPao:SetActive(false)
                self.raffleController.effectJingXing:SetActive(true)
            elseif name == "OpenDoorEnd" then
                self:doClickPlay()
            elseif name == "ShowStar" then
                self.raffleController.effectXingXing:SetActive(true)
            elseif name == "ShowLine" then
                self.raffleController.effectSuDuXian:SetActive(true)
            end
        end)
        self.raffleController.ssrEtaCallBack:SetCallBackOfName(function(name)
            if name == "PlayOpen" then
                self.canTouchEta = false
                self.raffleController.effectZZZ:SetActive(false)
                self.raffleController.effectssrQiPao:SetActive(false)
                self.raffleController.effectJingXing:SetActive(true)
            elseif name == "OpenDoorEnd" then
                self:doClickPlay()
            elseif name == "ShowStar" then
                self.raffleController.effectXingXing:SetActive(true)
            elseif name == "ShowLine" then
                self.raffleController.effectSuDuXian:SetActive(true)
            end
        end)
        --播放完成获得sr动画回调
        self.raffleController.getSRCallBack:SetCallBackOfName(function(name)
            if name == "Finish" then
                RaffleMgr:showWriteMask(function()
                    UIMgr:popUICover("ShowCharacterPanel", {closeFunc = function()
                        RaffleMgr:playGetRoleEnterAnimation()
                    end})
                end)
            end
        end)
        --播放完成获得ssr动画回调
        self.raffleController.getSSRCallBack:SetCallBackOfName(function(name)
            if name == "Finish" then
                RaffleMgr:showWriteMask(function()
                    UIMgr:popUICover("ShowCharacterPanel", {closeFunc = function()
                        RaffleMgr:playGetRoleEnterAnimation()
                    end})
                end)
            end
        end)
    end
  

    --根据结果播放动画
    self:playIdleRaffleAnimation()
end

--根据结果播放动画
function RaffleAnimationPanel:playIdleRaffleAnimation()
    if self.raffleController == nil then
        return
    end
    self.raffleController.effectRoot:SetActive(true)
    self.raffleController.ssrEta:SetActive(true)
    self.raffleController.srEta:SetActive(true)
    local closeEta = self.raffleController.ssrEta
    for _, resultData in pairs(self.resultList) do
        if resultData.isSSR then
            closeEta = self.raffleController.srEta
            self.haveSSR = true
            break
        end
    end
    closeEta:SetActive(false)
end

--设置提示动画
function RaffleAnimationPanel:setTipsAnimation()
    self.tipsAnimTimer = DLuaTimer:DoAfter(2, function()
        self.clickTipsRoot:SetActive(true)
        self.tipsAnimTimer = nil
    end)
end

--隐藏艾塔
function RaffleAnimationPanel:hideEta()
    if self.raffleController == nil then
        return
    end
    self.raffleController.ssrEtaAni:Rebind()
    self.raffleController.srEtaAni:Rebind()
    self.raffleController.ssrEtaAni:Update(0)
    self.raffleController.srEtaAni:Update(0)
    self.raffleController.effectRoot:SetActive(false)
    self.raffleController.srEta:SetActive(false)
    self.raffleController.ssrEta:SetActive(false)
    self.raffleController.getSR:SetActive(false)
	self.raffleController.getSSR:SetActive(false)
    --self.canSkip = false
end

--重置参数
function RaffleAnimationPanel:resetParams()
    self.resultList = RaffleMgr:getRaffleResultList()
    self.rejectInput = false
    self.fristClick = true
    self.haveSSR = false
    self.canSkip = true
    self.canTouchEta = true
    if self.raffleController == nil then
        return
    end
    self.raffleController.srEta:SetActive(false)
    self.raffleController.ssrEta:SetActive(false)
    self.raffleController.getSSR:SetActive(false)
    self.raffleController.getSR:SetActive(false)

    --特效
    self.raffleController.effectZZZ:SetActive(true)
    self.raffleController.effectsrQiPao:SetActive(true)
    self.raffleController.effectssrQiPao:SetActive(true)
    self.raffleController.effectJingXing:SetActive(false)
    self.raffleController.effectXingXing:SetActive(false)
    self.raffleController.effectSuDuXian:SetActive(false)
    self.raffleController.effectCamera:SetActive(true)

    --提示动画
    self:setTipsAnimation()
end

--正常播放方法
function RaffleAnimationPanel:doClickPlay()
    if not RaffleMgr.isSkip then
        self:hideEta()
        RaffleMgr:playGetRoleEnterAnimation()
    end
    self.clickTipsRoot:SetActive(false)
end

--跳过播放方法
function RaffleAnimationPanel:doClickSkip()
    self.rejectInput = true
    self:hideEta()
    RaffleMgr:skipRaffleAnimation()

    if self.tipsAnimTimer then
        DLuaTimer:RemoveTimer(self.tipsAnimTimer)
        self.tipsAnimTimer = nil
    end
    self.clickTipsRoot:SetActive(false)
end

--控制跳过按钮显示
function RaffleAnimationPanel:setSkipBtnState(isShow)
    self.skipBtn.canvasGroup.alpha = isShow and 1 or 0
    self.skipBtn.canvasGroup.interactable = isShow
    self.skipBtn.canvasGroup.blocksRaycasts = isShow
end

-- function RaffleAnimationPanel:OnClose(initiative)
    
-- end

function RaffleAnimationPanel:OnDestroy()
	self.super:OnDestroy(self)

    if self.tipsAnimTimer then
        DLuaTimer:RemoveTimer(self.tipsAnimTimer)
        self.tipsAnimTimer = nil
    end
end

--function RaffleAnimationPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function RaffleAnimationPanel:mask_Button_onClick(mask)
    if self.canSkip then
        self:setSkipBtnState(true)
    end
end

--[[ 
/SkipBtn onClick 
--]]
function RaffleAnimationPanel:skipBtn_ScaleButton_onClick(skipBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.rejectInput then
        return
    end
    self.rejectInput = true
    self:doClickSkip()
end

--[[
/TouchEtaBtn onClick 
--]]
function RaffleAnimationPanel:touchEtaBtn_Button_onClick(touchEtaBtn)
    if self.rejectInput then
        return
    end

    if not self.canTouchEta then
        return
    end

    if self.raffleController == nil then
        return
    end
    if self.fristClick then
        local btnSoundPath = string.format(Config.AudioPath.SE, "gacha_hit")
        self:play2DSound(btnSoundPath)
        if self.haveSSR then
            self.raffleController.ssrEtaAni:SetTrigger("FristClick")
        else
            self.raffleController.srEtaAni:SetTrigger("FristClick")
        end
        self.fristClick = false
    else
        if self.haveSSR then
            self.raffleController.ssrEtaAni:SetTrigger("QuickClick")
        else
            self.raffleController.srEtaAni:SetTrigger("QuickClick")
        end 
    end
    self.clickTipsRoot.animator:SetTrigger("TipsClick")

    if self.tipsAnimTimer then
        DLuaTimer:RemoveTimer(self.tipsAnimTimer)
        self.tipsAnimTimer = nil
    end

end

return RaffleAnimationPanel
