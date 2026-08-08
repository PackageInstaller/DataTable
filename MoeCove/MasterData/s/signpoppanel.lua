---@class SignPopPanel : SignPopPanel_Generate
---##################### 【SignPopPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SignPopPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SignPopPanel = require "SignPopPanel_Generate"

function SignPopPanel:InitLogic(data)

end

--function SignPopPanel:StartCreating(time)
--
--end

--function SignPopPanel:StartEnter(time)
--
--end

--function SignPopPanel:StartRemoving(time)
--
--end

--function SignPopPanel:StartExit(time)
--
--end

function SignPopPanel:OnOpen(data, initiative)
self.btnMask:SetActive(true)
    self.endCallback = data.endCallback
    self:doShow()
    self:initData(data)
    self:refreshUI()
    self.showTimer = DLuaTimer:DoAfter(3, function()
        self.btnMask:SetActive(false)
        Me:getSignRewardReq({signIndex = self.curSignIndex, signId = Config.GetConfigInfo("PopSignOpen")}, function(resp)
            if resp.ret == 0 then
                resp.list = resp.list or {}
                Me:ReceiveReward(resp.list)
                self:refreshUI(true)
            end
        end)
    end)
end

function SignPopPanel:doShow()
    self.main.transform.localScale = Vector3.zero
    self.main.transform:DOScale(1, 0.3):SetEase(DG.Tweening.Ease.InOutSine)
    self.tipBg.image.color = Color.New(1,1,1,0)
    DLuaTimer:DoAfter(0.5, function()
        self.tipBg.image:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.InOutSine)
    end)
    DLuaTimer:DoAfter(1, function()
        self.showText.typewriter:StartTypewriter("为支援指挥官送来的每日物流资源，请及时签收。")
    end)
end

function SignPopPanel:initData(data)
    self.curSignIndex = data.curIndex or 0
    local signCfg = Config.GetsignInInfo(Config.GetConfigInfo("PopSignOpen"))
    if not signCfg then
        LuaLogger.e("not signCfg")
        return
    end
    self.awardList = Config.GetSignAwardInfoByGroup(signCfg.awardGroud)
    if not self.awardList then
        LuaLogger.e("not awardList, id:".. signCfg.awardGroud)
        return
    end
end

function SignPopPanel:refreshUI(curReceive)
    for i = 1,7 do
        local signNode = self["signNode"..i]
        if not signNode then return end
        signNode.getMask:SetActive(i < self.curSignIndex)
        if curReceive and i == self.curSignIndex then
            signNode.getMask:SetActive(true)
        end
        signNode.mark:SetActive(i == self.curSignIndex and not curReceive)
        signNode.tip:SetActive(i == self.curSignIndex + 1)
        if i == self.curSignIndex then
            self:tweenMark(signNode.mark)
        end
        if self.awardList and self.awardList[i] then
            -- local data = {
            --     id = self.awardList[i].award[1][2],
            --     itemType = GE.ItemTypeIndex.item,
            --     itemNum = self.awardList[i].award[1][3],
			-- 	   navType = GE.NavigationType.TaskPanel,
            -- }
            signNode.customBox.customBox:setMono(self)
            signNode.customBox.customBox:SetUIData(self.awardList[i].award[1], {navType = GE.NavigationType.TaskPanel})
        end
    end
end

function SignPopPanel:tweenMark(obj)
    obj.image:DOFade(0.3, 0.5):SetEase(DG.Tweening.Ease.InOutSine):SetLoops(-1, DG.Tweening.LoopType.Yoyo)
    -- obj.transform:DOScale(1.05, 0.8):SetEase(DG.Tweening.Ease.InOutSine):SetLoops(-1, DG.Tweening.LoopType.Yoyo)
end

--界面关闭
function SignPopPanel:animationAndClose()
    UIMgr:closeSpecificUI(self)
    if self.endCallback then
        self.endCallback()
    end
end

function SignPopPanel:OnClose(initiative)
    self.showText.typewriter:StopTypewriter()
    if self.showTimer then
        DLuaTimer:RemoveTimer(self.showTimer)
        self.showTimer = nil
    end
end

--function SignPopPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SignPopPanel:OnRefresh(data)
--
--end

--[[
/Main/CloseBtn onClick 
--]]
function SignPopPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:animationAndClose()
end

--[[
/Main/TipsBtn onClick 
--]]
function SignPopPanel:tipsBtn_ScaleButton_onClick(tipsBtn)
    UIMgr:popUICover("InstructionsPanel", {tabId = GE.NavigationType.SignPopPanel})
end

--[[
/Mask onClick 
--]]
function SignPopPanel:mask_Button_onClick(mask)
    self:animationAndClose()
end

return SignPopPanel
