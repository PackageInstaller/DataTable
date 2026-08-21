---@class TechnologyTreePagePanel : TechnologyTreePagePanel_Generate
---##################### 【TechnologyTreePagePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【TechnologyTreePagePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local TechnologyTreePagePanel = require "TechnologyTreePagePanel_Generate"

function TechnologyTreePagePanel:InitLogic(data)

end

--function TechnologyTreePagePanel:StartCreating(time)
--
--end

--function TechnologyTreePagePanel:StartEnter(time)
--
--end

--function TechnologyTreePagePanel:StartRemoving(time)
--
--end

--function TechnologyTreePagePanel:StartExit(time)
--
--end

function TechnologyTreePagePanel:OnOpen(data, initiative)
    if initiative then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.TechnologyTree)
    end
    self.btn1.canvasGroup.alpha = 0
    self.btn2.canvasGroup.alpha = 0
    self.btn3.canvasGroup.alpha = 0
    self.circle.canvasGroup.alpha = 0
    self.anchor.canvasGroup.alpha = 0
    self.circle.rectTransform.anchoredPosition = Vector2.New(0, -160)
    DLuaTimer:DoAfter(0.2, function()
        self:donOpenAni()
    end)   
    self.customBackPanel.customBackPanel:RefreshTopResource()
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        if self.anchorTween then
            self.anchorTween:Kill()
            self.anchorTween = nil
        end
        if self.sCircleTween then
            self.sCircleTween:Kill()
            self.sCircleTween = nil
        end
        if self.btnTimer then
            DLuaTimer:RemoveTimer(self.btnTimer)
            self.btnTimer = nil
        end
        --self:doCloseAni()
        UIMgr:closeCurrentUI()
    end)

    self.idList = {
        [1] = GE.FunctionOpenModule.TechTreeDestroyerCruiser,
        [2] = GE.FunctionOpenModule.TechTreeBattleshipCarrier,
        [3] = GE.FunctionOpenModule.TechTreeSubmarineLogistics,
        --[4] = GE.FunctionOpenModule.Home,
    }
    -- self.btnRoot.animation:Play("PageIn")
    for i = 1, 3 do
        local btn = self["btn"..i]
        local state, tips = UICommonUtils.CheckFunctionOpen(self.idList[i])
        state = state == 2 and true or false
        btn.normal:SetActive(state)
        btn.lock:SetActive(not state)
        btn.lockTip.text.text = tips
        self["btn"..i].redPoint:SetActive(state and RedPointMgr:TechnologyTreePageRedJudge(i))
        self["btn"..i].scaleButton.interactable = state
    end

    --Me:technologyTreeInfoReq()
    GuideMgr:StartGuideTrigger("TechnologyTreePagePanel")
end

function TechnologyTreePagePanel:donOpenAni()
    
    self.circle.canvasGroup:DOFade(1, 0.3):SetEase(DG.Tweening.Ease.OutQuart)
    self.circle.rectTransform:DOAnchorPosY(-60, 0.3):SetEase(DG.Tweening.Ease.OutQuart)
    self.anchor.canvasGroup:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.InOutSine):OnComplete(function()
        self.anchorTween = self.anchor.canvasGroup:DOFade(0.6, 1):SetEase(DG.Tweening.Ease.InOutSine):SetLoops(-1, DG.Tweening.LoopType.Yoyo)
    end)
    self.btnTimer = DLuaTimer:DoAfter(0.4, function()
        self.btn1.canvasGroup:DOFade(1, 0.1):SetEase(DG.Tweening.Ease.OutQuart)
        self.btn2.canvasGroup:DOFade(1, 0.2):SetEase(DG.Tweening.Ease.OutQuart)
        self.btn3.canvasGroup:DOFade(1, 0.3):SetEase(DG.Tweening.Ease.OutQuart)
        self.sCircleTween = self.sCircle.image:DOFade(0.6, 1):SetEase(DG.Tweening.Ease.InOutSine):SetLoops(-1, DG.Tweening.LoopType.Yoyo)
    end)
end

function TechnologyTreePagePanel:doCloseAni()
    self.circle.canvasGroup:DOFade(0, 0.3):SetEase(DG.Tweening.Ease.InQuart)
    self.anchor.canvasGroup:DOFade(0, 0.3):SetEase(DG.Tweening.Ease.InQuart)
    self.btn1.canvasGroup:DOFade(0, 0.3):SetEase(DG.Tweening.Ease.InQuart)
    self.btn2.canvasGroup:DOFade(0, 0.3):SetEase(DG.Tweening.Ease.InQuart)
    self.btn3.canvasGroup:DOFade(0, 0.3):SetEase(DG.Tweening.Ease.InQuart):OnComplete(function()
        UIMgr:closeCurrentUI()
    end)
end

-- function TechnologyTreePagePanel:OnClose(initiative)
    
-- end

--function TechnologyTreePagePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function TechnologyTreePagePanel:OnRefresh(data)
--
--end

--[[
/Btn1 onClick 
--]]
function TechnologyTreePagePanel:btn1_ScaleButton_onClick(btn1)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    UIMgr:popUI("TechnologyTreePanel", {pageId = GE.TechnologyTreeType.page1})
end

--[[
/Btn2 onClick 
--]]
function TechnologyTreePagePanel:btn2_ScaleButton_onClick(btn2)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    UIMgr:popUI("TechnologyTreePanel", {pageId = GE.TechnologyTreeType.page2})
end

--[[
/Btn3 onClick 
--]]
function TechnologyTreePagePanel:btn3_ScaleButton_onClick(btn3)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    UIMgr:popUI("TechnologyTreePanel", {pageId = GE.TechnologyTreeType.page3})
end

return TechnologyTreePagePanel
