---@class GiftPackPanel : GiftPackPanel_Generate
---##################### 【GiftPackPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【GiftPackPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local GiftPackPanel = require "GiftPackPanel_Generate"
local SetNumView = require("SetNumView")
function GiftPackPanel:InitLogic(data)
    self.nowSelectIndex = nil     --当前选中索引
    self.nowSelectBox = nil      --当前选中奖励
    self.nowCount = 1           --当前选择数量

    ---@type SetNumView
    local lua_setNumView = SetNumView:new(self.setNumView.gameObject)
    lua_setNumView:InitGenerate()
    self.lua_setNumView = lua_setNumView
end

--function GiftPackPanel:StartCreating(time)
--
--end

--function GiftPackPanel:StartEnter(time)
--
--end

--function GiftPackPanel:StartRemoving(time)
--
--end

--function GiftPackPanel:StartExit(time)
--
--end

function GiftPackPanel:OnOpen(data, initiative)
    self.itemId = data.itemId or 0
    self:setGiftPackData()
end

--设置礼包数据
function GiftPackPanel:setGiftPackData()
    local itemConfig = Config.GetItemInfo(self.itemId)
    self.itemData = Me:getItemById(self.itemId)
    self.haveNumTxt.text.text = string.format(LocalStrEnum.HoldingGift, self.itemData and self.itemData.num or 0)
    --礼包内容
    self.awardList = itemConfig and itemConfig.effect or {}
    self:FillTemplateContent(self.giftBox, self.content, #self.awardList, function (index,giftBox)
        giftBox.canvasGroup.alpha = 0
        local awardData = self.awardList[index]
        --目前只接入道具，其他类型可能有不同界面
        local awardType = awardData[1]
        local awardId = awardData[2]
        local awardNum = awardData[3]
        local haveData = Me:getItemById(awardId)
        giftBox.haveNumTxt.text.text = string.format(LocalStrEnum.Holding, haveData and haveData.num or 0)
        local needConfig, needType = nil, 1
        if awardType == GE.RewardType.ItemProp then
            needType = GE.CustomMsgType.Item
            needConfig = Config.GetItemInfo(awardId)
        end
        if awardNum ~= 0 then
        end
        giftBox.scaleButton.onClick:RemoveAllListeners()
        giftBox.scaleButton.onClick:AddListener(function()
            self:selectedAward(index, giftBox)
        end)
        giftBox.clickLongPressListener.onLongpress = function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            Me:ShowItemTips({
                id = awardId,
                type = awardType, 
            })         
        end
        local customBox = giftBox.customBox.customBox
        customBox:setMono(self)
        customBox:SetUIData(awardData, {disableClick = true})

        --显示动画
        DLuaTimer:DoAfter(0.03 * index, function()
            giftBox.canvasGroup:DOFade(1, 0.2)
        end)
        --默认选中第一个
        if index == 1 then
            self:selectedAward(index, giftBox)
        end
    end)

    self.lua_setNumView:SetData({maxNum = self.itemData.num, onValueChange = function(curVal)
         self:setUseCount(curVal)
    end})
end

--点击选中奖励
function GiftPackPanel:selectedAward(index, giftBox)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowSelectBox then
        local awardData = self.awardList[self.nowSelectIndex]
        local customBox = self.nowSelectBox.customBox.customBox
        customBox.itemNum.text.text = awardData[3]
        self.nowSelectBox.isSelectGift:SetActive(false)
    end
    self.nowSelectIndex = index
    self.nowSelectBox = giftBox
    local awardData = self.awardList[self.nowSelectIndex]
    local customBox = self.nowSelectBox.customBox.customBox
    customBox.itemNum.text.text = awardData[3] * self.nowCount
    self.nowSelectBox.isSelectGift:SetActive(true)
    if self.noBtn.activeSelf then
        self.noBtn:SetActive(false)
        self.okBtn:SetActive(true)
    end
end

function GiftPackPanel:setUseCount(newCount)
    local itemData = self.itemData

    newCount = math.min(itemData.num, newCount)
    newCount = math.max(1, newCount)
    self.nowCount = newCount
    self:refreshSelectGetCount()
end

--刷新选中道具的可获取数量
function GiftPackPanel:refreshSelectGetCount()
    if not self.nowSelectBox then
        return
    end
    local awardData = self.awardList[self.nowSelectIndex]
    local customBox = self.nowSelectBox.customBox.customBox
    customBox.itemNum.text.text = awardData[3] * self.nowCount
end

--界面关闭
function GiftPackPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--function GiftPackPanel:OnClose(initiative)
--
--end

--function GiftPackPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function GiftPackPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function GiftPackPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

--[[
/EffectInfoPanel/TitleSideBg/CloseBtn onClick 
--]]
function GiftPackPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

--[[
/EffectInfoPanel/SetNumList/MinusBtn onClick 
--]]
function GiftPackPanel:minusBtn_ScaleButton_onClick(minusBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:setUseCount(self.nowCount - 1)
end

--[[
/EffectInfoPanel/SetNumList/PlusBtn onClick 
--]]
function GiftPackPanel:plusBtn_ScaleButton_onClick(plusBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:setUseCount(self.nowCount + 1)
end

--[[
/EffectInfoPanel/OkBtn onClick 
--]]
function GiftPackPanel:okBtn_ScaleButton_onClick(okBtn)
    if not self.nowSelectIndex then
        return
    end
    Me:openGiftPackReq({id = self.itemId, num = self.nowCount, selectIndex = self.nowSelectIndex}, function()
        GameMsgMgr:sendEvent(GameMsgType.RefreshWarehousePanel)
        self:playCloseAnim()
    end)
end

--[[
/BoxBg/NoBtn onClick 
--]]
function GiftPackPanel:noBtn_ScaleButton_onClick(noBtn)
    UICommonUtils.PopToast(LocalStrEnum.GiftChoiceItem)
end

--[[
/BoxBg/SetNumList/maxBtn onClick 
--]]
function GiftPackPanel:maxBtn_ScaleButton_onClick(maxBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:setUseCount(self.itemData.num)
end

--[[
/BoxBg/SetNumList/numSlider onValueChanged 
--]]
function GiftPackPanel:numSlider_Slider_onValueChanged(numSlider,value)

end

return GiftPackPanel
