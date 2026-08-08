---@class MsgBoxMiddle : MsgBoxMiddle_Generate
---##################### 【MsgBoxMiddle Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【MsgBoxMiddle Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local MsgBoxMiddle = require "MsgBoxMiddle_Generate"

function MsgBoxMiddle:InitLogic(data)

end

--function MsgBoxMiddle:StartCreating(time)
--
--end

--function MsgBoxMiddle:StartEnter(time)
--
--end

--function MsgBoxMiddle:StartRemoving(time)
--
--end

--function MsgBoxMiddle:StartExit(time)
--
--end

function MsgBoxMiddle:OnOpen(data, initiative)
    if data then
        self.type = data.type
        self.titleValue = data.title
        self.titleIcon = data.titleIcon or MsgTitleIconType.Tips
        self.confirmText = data.confirmText
        self.cancelText = data.cancelText
        self.okCallback = data.okCallback
        self.cancelCallback = data.cancelCallback
        self.needData = data.needData
    end

    self.okCallbackParam = nil   --OK按钮点击回调参数

    self:setView()
end

function MsgBoxMiddle:setView()
    self.cancelBtn:SetActive(true)
    self.confirmBtn:SetActive(true)
    self.closeBtn:SetActive(true)
    self.useItemPanel:SetActive(false)
    --设置标题内容与图标
    self.titleText.text.text = self.titleValue
    local iconPath = string.format(Config.SpritePath.MsgTitlePath,self.titleIcon)
    self:LoadSpriteAsync(iconPath, function(_sprite)
        self.titleImage.image.sprite = _sprite
    end)
    --设置确认取消提示
    if self.confirmText then
        self.confirmBtn.txt.text.text = self.confirmText
    else
        self.confirmBtn.txt.text.text = LocalStrEnum.MsgboxConfirm
    end
    if self.cancelText then
        self.cancelBtn.txt.text.text = self.cancelText
    else
        self.cancelBtn.txt.text.text = LocalStrEnum.MsgboxCancel
    end
    --根据不同类型显示不同样式内容
    if self.type == MsgBoxType.ItemBatchUse then
        self.useItemPanel:SetActive(true)
        local itemId = self.needData.id
        local itemData = Me:getItemById(itemId)
        self.useItemPanel.haveNumTxt.text.text = string.format(LocalStrEnum.HoldingGift, itemData.num)
        self.useItemPanel.slider.slider.maxValue = itemData.num
        self:setUseItemPanelUseCount(1)
    elseif self.type == MsgBoxType.BuyRaffleTicket then
        self.buyRaffleTicket:SetActive(true)
        self.buyRaffleTicket.frontTxt.text.text = self.needData.frontTxt or ""
        self.buyRaffleTicket.andTxt.text.text = self.needData.andTxt or ""
        self.buyRaffleTicket.middleTxt.text.text = self.needData.middleTxt or ""
        self.buyRaffleTicket.afterTxt.text.text = self.needData.afterTxt or ""
        local needfreeTips = self.needData.freeDiamond ~= 0 and true or false
        self.buyRaffleTicket.freeIcon:SetActive(needfreeTips)
        self.buyRaffleTicket.freeNum:SetActive(needfreeTips)
        self.buyRaffleTicket.freeNum.text.text = self.needData.freeDiamond or ""
        local needPayTips = self.needData.payDiamond ~= 0 and true or false
        self.buyRaffleTicket.payIcon:SetActive(needPayTips)
        self.buyRaffleTicket.payNum:SetActive(needPayTips)
        self.buyRaffleTicket.payNum.text.text = self.needData.payDiamond or ""
        self.buyRaffleTicket.andTxt:SetActive(needPayTips and needfreeTips)
        self.buyRaffleTicket.ticketNum.text.text = self.needData.buyCount or ""
        local itemInfo = Config.GetItemInfo(self.needData.itemId)
        self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemInfo.icon), function (s)
            self.buyRaffleTicket.ticketIcon.image.sprite = s
        end)
    end
end

function MsgBoxMiddle:setUseItemPanelUseCount(newCount)
    local itemId = self.needData.id
    local itemData = Me:getItemById(itemId)
    if newCount >= itemData.num then
        newCount = itemData.num
        self.useItemPanel.plusBtnGray:SetActive(true)
    else
        self.useItemPanel.plusBtnGray:SetActive(false)
    end
    if newCount <= 0 then
        newCount = 0
        self.useItemPanel.minusBtnGray:SetActive(true)
    else
        self.useItemPanel.minusBtnGray:SetActive(false)
    end
    self.useItemPanel.slider.slider.value = newCount
    self.useItemPanel.useItemCount.text.text = tostring(newCount)
    if not self.okCallbackParam then
        self.okCallbackParam = {}
    end
    self.okCallbackParam.num = newCount
end

--function MsgBoxMiddle:OnClose(initiative)
--
--end

--function MsgBoxMiddle:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function MsgBoxMiddle:OnRefresh(data)
--
--end

--[[
/PanelBg/TypeContent/UseItemPanel/PlusBtn onClick 
--]]
function MsgBoxMiddle:plusBtn_ScaleButton_onClick(plusBtn)
    local nowCount = self.useItemPanel.slider.slider.value
    self:setUseItemPanelUseCount(nowCount + 1)
end

--[[
/PanelBg/TypeContent/UseItemPanel/MinusBtn onClick 
--]]
function MsgBoxMiddle:minusBtn_ScaleButton_onClick(minusBtn)
    local nowCount = self.useItemPanel.slider.slider.value
    self:setUseItemPanelUseCount(nowCount - 1)
end

--[[
/PanelBg/TypeContent/UseItemPanel/Slider onValueChanged 
--]]
function MsgBoxMiddle:slider_Slider_onValueChanged(slider,value)
    self:setUseItemPanelUseCount(value)
end

--[[
/PanelBg/BtnsGroup/CancelBtn onClick 
--]]
function MsgBoxMiddle:cancelBtn_ScaleButton_onClick(cancelBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.animator:SetTrigger("Out")
    self.cancelBtn.scaleButton.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.cancelBtn.scaleButton.interactable = true
        UIMgr:closeUI(self)
        if self.cancelCallback then
            self.cancelCallback()
        end
    end)
end

--[[
/PanelBg/BtnsGroup/ConfirmBtn onClick 
--]]
function MsgBoxMiddle:confirmBtn_ScaleButton_onClick(confirmBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.cancelBtn.scaleButton.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.cancelBtn.scaleButton.interactable = true
        UIMgr:closeUI(self)
        if self.okCallback then
            self.okCallback(self.okCallbackParam)
        end
    end)
end

--[[
/PanelBg/CloseBtn onClick 
--]]
function MsgBoxMiddle:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.cancelBtn.scaleButton.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.cancelBtn.scaleButton.interactable = true
        UIMgr:closeUI(self)
        if self.cancelCallback then
            self.cancelCallback()
        end
    end)
end

--[[
/PanelBg/TypeContent/BuyRaffleTicket/SkipTips/TickBg onClick 
--]]
function MsgBoxMiddle:tickBg_ScaleButton_onClick(tickBg)
    self.buyRaffleTicket.tick:SetActive(not self.buyRaffleTicket.tick.activeSelf)
    if self.needData.payDiamond ~= 0 then
        RaffleMgr:setIsSkipBuyRaffleTicketTipsPay(self.buyRaffleTicket.tick.activeSelf)
    else
        RaffleMgr:setIsSkipBuyRaffleTicketTipsFree(self.buyRaffleTicket.tick.activeSelf)
    end
end

return MsgBoxMiddle
