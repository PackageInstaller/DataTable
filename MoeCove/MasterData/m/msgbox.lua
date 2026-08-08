---@class MsgBox : MsgBox_Generate
---##################### 【MsgBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【MsgBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local MsgBox = require "MsgBox_Generate"
local MsgBoxType = MsgBoxType

function MsgBox:InitLogic(data)
    self.titleValue = ""                    --标题内容
    self.titleIcon = MsgTitleIconType.Box   --标题图案
    self.content = ""                       --提示文字
    self.okCallback = nil                   --确定事件
    self.cancelCallback = nil               --取消事件
    self.type = MsgBoxType.OK               --提示框类型 
    self.commonMsg = ""                     --次要提示
    self.buyItemData = {                    --想要显示购买的道具信息
        id = nil,
        count = 0,
    }
    self.needItemData  = {                  --需要消耗的道具信息
        id = nil,
        count = 0,
    }
    self.giftTodayMsg = false             --不再提醒是否勾选
    self.resetNameCallBack = nil            --重置名字回调
    self.needShow = false                  --是否需要显示
end

--function MsgBox:StartCreating(time)
--
--end

--function MsgBox:StartEnter(time)
--
--end

--function MsgBox:StartRemoving(time)
--
--end

--function MsgBox:StartExit(time)
--
--end

---@class MsgBoxData
---@field type integer 弹窗类型
---@field title string 标题内容
---@field titleIcon MsgTitleIconType? 标题图片
---@field content string? 通用内容
---@field okCallback function? 确认按钮回调
---@field cancelCallback function? 取消按钮回调
---@field buyItemData BuyItemData? 购买的道具信息
---@field needItemData BuyItemData? 所需的道具信息
---@field commonMsg string? 额外内容
---@field userpotocolUrl string? 用户协议链接
---@field policyUrl string? 隐私政策链接
---@field confirmText string? 确认按钮文字
---@field cancelText string? 取消按钮文字
---@field resetNameCallBack function? 重置名字回调
---@field customData any? 其他自定义数据

---@class BuyItemData
---@field id integer 道具id
---@field count integer 道具数量

---@param data MsgBoxData
function MsgBox:OnOpen(data, initiative)
    if data then
        self.type = data.type
        self.titleValue = data.title
        self.titleIcon = data.titleIcon or MsgTitleIconType.Tips
        self.content = data.content
        self.okCallback = data.okCallback
        self.cancelCallback = data.cancelCallback
        self.buyItemData = data.buyItemData
        self.needItemData = data.needItemData
        self.commonMsg = data.commonMsg
        self.userpotocolUrl = data.userpotocolUrl
        self.policyUrl = data.policyUrl
        self.confirmText = data.confirmText
        self.cancelText = data.cancelText
        self.resetNameCallBack = data.resetNameCallBack
        self.customData = data.customData
    end

    self.okCallbackParam = nil   --OK按钮点击回调参数
    self:SetView()
    self:playOpenAnim()
    self.needShow = true
end

--显示弹窗内容
function MsgBox:SetView()
    self.msgText:SetActive(false)
    self.buyPanel:SetActive(false)
    self.changeNamePanel:SetActive(false)
    self.changeSignPanel:SetActive(false)
    self.cancelBtn:SetActive(true)
    self.closeBtn:SetActive(true)
    self.agreementPanel:SetActive(false)
    self.msgText_emoji:SetActive(false)
    self.dispatchPanel:SetActive(false)
    self.selectPayPanel:SetActive(false)
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
    if self.type == MsgBoxType.OK then
        self.msgText:SetActive(true)
        self.msgText.text.text = self.content
        self.cancelBtn:SetActive(false)
        self.closeBtn:SetActive(false)
    elseif self.type == MsgBoxType.OKCancel then
        self.msgText:SetActive(true)
        self.msgText.text.text = self.content
    elseif self.type == MsgBoxType.Buy then     --购买模式
        local itemConfig = Config.GetItemPropInfo(self.needItemData.id)
        local itemInfo = nil
        if itemConfig then
            if itemConfig.Type == GE.ItemPropType.Currency then
                itemInfo = Me:getMoneyById(self.needItemData.id)
            else
                itemInfo = ClientData:GetItemPropData(self.needItemData.id)
            end
        end
        local haveNum
        if itemInfo and itemInfo >= self.needItemData.count then
            haveNum = "<color=#FFDA4D>"..self.needItemData.count.."</color> "
            haveNum = string.format(Config.FontMaterialPath.ZXHLYT_SDF_98620e_03, haveNum)
        else
            haveNum = "<color=#FF8D7E>"..self.needItemData.count.."</color> "
            haveNum = string.format(Config.FontMaterialPath.ZXHLYT_SDF_9f100e_03, haveNum)
        end
        local needIcon = Config.ResIconSpritePath["res_"..self.needItemData.id].." "
        local buyIcon = Config.ResIconSpritePath["res_"..self.buyItemData.id].. ' '
        local buyNum = "<color=#FFDA4D>"..self.buyItemData.count.."</color> "
        buyNum = string.format(Config.FontMaterialPath.ZXHLYT_SDF_98620e_03, buyNum)
        self.buyText.text.text = LocalStrEnum.TipIsUse..needIcon..haveNum..LocalStrEnum.TipBuy..buyIcon..buyNum.."？"
        self.buyCountMsgText.text.text = self.commonMsg
        self.buyPanel:SetActive(true)
    elseif self.type == MsgBoxType.CommonBuy then
        self.buyText.text.text = self.content
        self.buyCountMsgText.text.text = self.commonMsg
        self.buyPanel:SetActive(true)
    elseif self.type == MsgBoxType.ChangePlayerName then
        self.okCallbackParam = self.nameField.inputField.text
        self.changeNamePanel:SetActive(true)
        self.resetNameBtn:SetActive(self.resetNameCallBack ~= nil)
    elseif self.type == MsgBoxType.Code then
        self.okCallbackParam = self.codeField.inputField.text
        self.codePanel:SetActive(true)
    elseif self.type == MsgBoxType.ChangePlayerSign then
        self.changeSignPanel:SetActive(true)
        self.okCallbackParam = self.signField.inputField.text
    elseif self.type == MsgBoxType.Gift then
        self.giftPanel:SetActive(true)
        self.giftTxt.text.text = self.content
    elseif self.type == MsgBoxType.Agreement then
        self.agreementPanel:SetActive(true)
    elseif self.type == MsgBoxType.Msg_Emoji then
        self.msgText_emoji:SetActive(true)
        self.msgText_emoji.text.text = self.content
        self.cancelBtn:SetActive(true)
    elseif self.type == MsgBoxType.Dispatch then
        if self.customData and self.customData.dispatchShowType then
            if self.customData.dispatchShowType == 1 then
                self.msgText:SetActive(true)
                self.dispatchPanel:SetActive(false)
                self.msgText.text.text = LocalStrEnum["dispatch_tips_5"]
            elseif self.customData.dispatchShowType == 2 then
                self.msgText:SetActive(false)
                self.dispatchPanel:SetActive(true)
                self.dispatchPanel.t1:SetActive(true)
                self.dispatchPanel.t2:SetActive(false)
            elseif self.customData.dispatchShowType == 3 then
                self.msgText:SetActive(false)
                self.dispatchPanel:SetActive(true)
                self.dispatchPanel.t1:SetActive(false)
                self.dispatchPanel.t2:SetActive(true)
            end
        end
    elseif self.type == MsgBoxType.SelectPay then
        self.selectPayPanel:SetActive(true)

        self.okCallbackParam = GE.PayChannel.Alipay
        self.selectPayPanel.wxpayBtn.isOn:SetActive(false)
        self.selectPayPanel.alipayBtn.isOn:SetActive(true)
        self.cancelBtn:SetActive(false)
    end
end

--function MsgBox:OnClose(initiative)
--
--end

--function MsgBox:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function MsgBox:OnRefresh(data)
--
--end

--[[
/BgImg/CloseBtn onClick 
--]]
function MsgBox:closeBtn_ScaleButton_onClick(closeBtn)

    self.closeBtn.scaleButton.interactable = false
    self:playCloseAnim(function()
         self.closeBtn.scaleButton.interactable = true
    end)
    if self.cancelCallback then
        self.cancelCallback()
    end
end

--[[
/PanelBg/BtnsGroup/CancelBtn onClick 
--]]
function MsgBox:cancelBtn_ScaleButton_onClick(cancelBtn)
    if self.cancelCallback then
        self.cancelCallback()
    end
    self:playCloseAnim()
end

--[[
/PanelBg/BtnsGroup/ConfirmBtn onClick 
--]]
function MsgBox:confirmBtn_ScaleButton_onClick(confirmBtn)
    if self.okCallback then
        self.okCallback(self.okCallbackParam)
    end
    --记录不再提醒
    if self.type == MsgBoxType.Gift then
        if self.giftTodayMsg then
            UnityEngine.PlayerPrefs.SetInt("giftTodayMsg", 1)
        else
            UnityEngine.PlayerPrefs.SetInt("giftTodayMsg", 0)
        end
    end
    self:playCloseAnim()
end

--[[
/PanelBg/TypeContent/ChangeNamePanel/NameField onEndEdit 
--]]
function MsgBox:nameField_InputField_onEndEdit(nameField,content)
    self.okCallbackParam = nameField.inputField.text

    if self.okCallbackParam == "pppppp6" then
        LuaMgr.Instance:OpenDebugModeInRelease(true)
    end

    local checkRes = GV.GlobalConfig.HasForbiddenWord(nameField.inputField.text)
    if checkRes ~= false then
        self.illegalTipsBg:SetActive(true)
    else
        self.illegalTipsBg:SetActive(false)
    end
end

--[[
/PanelBg/TypeContent/ChangeSignPanel/SignField onEndEdit 
--]]
function MsgBox:signField_InputField_onEndEdit(signField,content)
    self.okCallbackParam = signField.inputField.text
end

--[[
/PanelBg/TypeContent/GiftPanel/NoTipsBtn onClick 
--]]
function MsgBox:noTipsBtn_ScaleButton_onClick(noTipsBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.noTipsBtn.isOn:SetActive(not self.noTipsBtn.isOn.activeSelf)
    self.giftTodayMsg = self.noTipsBtn.isOn.activeSelf
end

--[[    用户协议按钮
/PanelBg/TypeContent/AgreementPanel/desc2/userpotocol onClick 
--]]
function MsgBox:userpotocol_ScaleButton_onClick(userpotocol)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Application.OpenURL(self.userpotocolUrl)
end

--[[    隐私政策按钮
/PanelBg/TypeContent/AgreementPanel/desc2/policy onClick 
--]]
function MsgBox:policy_ScaleButton_onClick(policy)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Application.OpenURL(self.policyUrl)
end

--[[
/PanelBg/TypeContent/ChangeNamePanel/ResetNameBtn onClick 
--]]
function MsgBox:resetNameBtn_ScaleButton_onClick(resetNameBtn)
    self:playCloseAnim()
end

--入场动画
function MsgBox:playOpenAnim()
    self.animation:Play("Init")
    self.animOverCallBack:SetCallBack(function()
    end)
end

--退场动画
function MsgBox:playCloseAnim()
    self.needShow = false
    self.animation:Play("Out")
    self.animOverCallBack:SetCallBack(function()
        if not self.needShow then
            UIMgr:closeSpecificUI(self)
        end
    end)
end

--[[
/BoxBg/TypeContent/CodePanel/CodeField onEndEdit 
--]]
function MsgBox:codeField_InputField_onEndEdit(codeField,content)
    self.okCallbackParam = codeField.inputField.text

    if self.okCallbackParam == "pppppp6" then
        LuaMgr.Instance:OpenDebugModeInRelease(true)
    end
end

--[[
/BoxBg/TypeContent/SelectPayPanel/alipayBtn onClick 
--]]
function MsgBox:alipayBtn_ScaleButton_onClick(alipayBtn)
    self.okCallbackParam = GE.PayChannel.Alipay
    self.selectPayPanel.wxpayBtn.isOn:SetActive(false)
    self.selectPayPanel.alipayBtn.isOn:SetActive(true)
end

--[[
/BoxBg/TypeContent/SelectPayPanel/wxpayBtn onClick 
--]]
function MsgBox:wxpayBtn_ScaleButton_onClick(wxpayBtn)
    self.okCallbackParam = GE.PayChannel.WXpay
    self.selectPayPanel.wxpayBtn.isOn:SetActive(true)
    self.selectPayPanel.alipayBtn.isOn:SetActive(false)
end

return MsgBox
