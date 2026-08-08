---@class ItemExchagnePanel : ItemExchagnePanel_Generate
---##################### 【ItemExchagnePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ItemExchagnePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ItemExchagnePanel = require "ItemExchagnePanel_Generate"
local SetNumView = require("SetNumView")
function ItemExchagnePanel:InitLogic(data)
    self.maxCount = 0
    self.price = 0
    ---@type boolean
    self.isCanBy = false
    self.priceItemId = 0
    self.curItemCount = 0

    ---@type SetNumView
    local lua_setNumView = SetNumView:new(self.setNumView.gameObject)
    lua_setNumView:InitGenerate()
    self.lua_setNumView = lua_setNumView

    self.customBox_1.customBox:setMono(self)
    self.customBox_2.customBox:setMono(self)
end

function ItemExchagnePanel:SetItemCount(count)
    self.curItemCount = count
    local isCanBuy = count > 0 and count <= self.maxCount
    self.buyBtn.gameObject:SetActive(isCanBuy)
    self.disableBuyBtn.gameObject:SetActive(not isCanBuy)
end

function ItemExchagnePanel:OnOpen(data, initiative)
    local goodsId = data.goodsId
    local minCount = data.minCount or 1
    self.goodsId = goodsId

    local goodsInfo = Me:GetGoodsServerData(goodsId)
    if goodsInfo == nil then
        LuaLogger.es("商品信息错误 未找到服务器数据  goodsId:" .. tostring(goodsId))
        return
    end

    local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
    if goodsCfg == nil then
        return    
    end
    --判断是否限购
    local curBuyCount, maxBuyCount, limitType = Me:GetGoodLimitCount(goodsId)

    local maxCount = goodsCfg.buylimit
    if limitType ~= GE.ShopLimitType.None then
        maxCount = math.min(maxCount, curBuyCount)
    end

    --计算可以购买的最大数量
    local picId, picNum, picRate  = Me:GetShopItemPic(goodsId)

    local ownPicNum = Me:getItemCountById(picId)
    
    local picByCount = math.floor(ownPicNum / picNum)
    maxCount = math.min(maxCount, picByCount)
    self.maxCount = maxCount
    self.lua_setNumView:SetData(
        {
            maxNum = maxCount,
            onValueChange = function(curVal)
                self:SetItemCount(curVal)
            end
    })
    self.customBox_1.customBox:SetUIData({
        id = picId,
        type = GE.RewardType.ItemProp,
        num = picNum,
        showItemName = true,
    })
    local cfg = Config.GetItemInfo(picId)
    self.itemNameText_1.text.text = cfg.itemName


    local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
    local getId = goodsCfg.content[1][2]

    self.customBox_2.customBox:SetUIData({
        id = getId,
        type = GE.RewardType.ItemProp,
        num = goodsCfg.content[1][3],
    })
    local cfg = Config.GetItemInfo(getId)
    self.itemNameText_2.text.text = cfg.itemName
    self.goodsDescribeText.text.text = goodsCfg.merchandiseDesc
end

--function ItemExchagnePanel:OnClose(initiative)
--
--end

--function ItemExchagnePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ItemExchagnePanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function ItemExchagnePanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

--[[
/content/titleInfo/closeBtn onClick 
--]]
function ItemExchagnePanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end
--[[
/content/buyInfo/cancleBtn onClick 
--]]
function ItemExchagnePanel:cancleBtn_ScaleButton_onClick(cancleBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

--[[
/content/buyInfo/buyBtn onClick 
--]]
function ItemExchagnePanel:buyBtn_ScaleButton_onClick(buyBtn)

    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local picId, picNum, picRate  = Me:GetShopItemPic(self.goodsId)
    picNum = picNum * self.curItemCount
    if picId == GE.ResourceType.PayDiamond  then
        local itemCfg = Config.GetItemInfo(picId)
        local costStr = string.format("<size=200%%><sprite name=%s></size>", itemCfg.icon)
        local name, desc, icon, quality = Me:GetGoodsItemDisplayInifo(self.goodsId)
        UICommonUtils.PopMsgBox(LocalStrEnum.merchandiseBuyPrompt_2, string.format(LocalStrEnum.merchandiseBuyPromptDesc_2, costStr,picNum, self.curItemCount,name), MsgBoxType.Msg_Emoji, function()
            UIMgr:closeCurrentUI(self)
            Me:ShopBuyReq(self.goodsId, self.curItemCount, nil)
        end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)
        return
    end
    self:playCloseAnim()
    Me:ShopBuyReq(self.goodsId, self.curItemCount, nil)
end

--[[
/Mask onClick 
--]]
function ItemExchagnePanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

--[[
/content/buyInfo/disableBuyBtn onClick 
--]]
function ItemExchagnePanel:disableBuyBtn_ScaleButton_onClick(disableBuyBtn)
    local picId, picNum, picRate  = Me:GetShopItemPic(self.goodsId)
    local itemCfg = Config.GetItemInfo(picId)
    if picId == GE.ResourceType.PayDiamond then
        local curBuyCount, maxBuyCount, limitType = Me:GetGoodLimitCount(self.goodsId)
        if curBuyCount > 0 then --提示钻石不足
            local costStr = string.format("<size=200%%><sprite name=%s></size>", itemCfg.icon)
            UICommonUtils.PopMsgBox(LocalStrEnum.merchandiseBuyPrompt_1, string.format(LocalStrEnum.merchandiseBuyPromptDesc_1, costStr), MsgBoxType.Msg_Emoji, function()
                local trunToId = 1310002
                UICommonUtils.CommonTurnTo(trunToId, self)
                --跳转
            end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)
        end
    else
	    UICommonUtils.PopToast(string.format(LocalStrEnum.merchandiseBuyTip_1, itemCfg.itemName))
    end
end

function ItemExchagnePanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--[[
/BoxBg/SetNumView/minusBtn onClick 
--]]
function ItemExchagnePanel:minusBtn_ScaleButton_onClick(minusBtn)

end

--[[
/BoxBg/SetNumView/plusBtn onClick 
--]]
function ItemExchagnePanel:plusBtn_ScaleButton_onClick(plusBtn)

end

--[[
/BoxBg/SetNumView/numSlider onValueChanged 
--]]
function ItemExchagnePanel:numSlider_Slider_onValueChanged(numSlider,value)

end

--[[
/BoxBg/SetNumView/maxBtn onClick 
--]]
function ItemExchagnePanel:maxBtn_ScaleButton_onClick(maxBtn)

end

return ItemExchagnePanel
