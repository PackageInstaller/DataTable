---@class BuyTicketPanel : BuyTicketPanel_Generate
---##################### 【BuyTicketPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BuyTicketPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local BuyTicketPanel = require "BuyTicketPanel_Generate"
local SetNumView = require("SetNumView")

function BuyTicketPanel:InitLogic(data)
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self.ItemList = {
        110012,110013,Config.GetConfigInfo("ApBuy")[1]
    }
    self.nowSelect = 1
    self.itemBoxList = {}
    self.useNum = 1
    self.nowSelectData = {}
    self.nowMode = 1
    self.AddCount = 0

    ---@type SetNumView
    local lua_setNumView = SetNumView:new(self.setNumView.gameObject)
    lua_setNumView:InitGenerate()
    self.lua_setNumView = lua_setNumView
end

--function BuyTicketPanel:StartCreating(time)
--
--end

--function BuyTicketPanel:StartEnter(time)
--
--end

--function BuyTicketPanel:StartRemoving(time)
--
--end

--function BuyTicketPanel:StartExit(time)
--
--end

function BuyTicketPanel:OnOpen(data, initiative)
    self:SetView()
    self:DefaultSelect()
    self:SelectBoxNew(self.nowSelect)
end

--设置显示
function BuyTicketPanel:SetView()
    if self.recoverTicketCountDownTimer then
        DLuaTimer:RemoveTimer(self.recoverTicketCountDownTimer)
    end
    self:TimeChange()
    self.recoverTicketCountDownTimer = DLuaTimer:DoRepeatForever(1, function()
        self:TimeChange()
    end)

    local curCreateCount = 0
    self:FillTemplateContent(self.itemBox, self.itemList, #self.ItemList, function(index, itemBox)
        itemBox:SetActive(true)
        local temp = {index = index, obj = itemBox, data = self.ItemList[index]}
        table.insert(self.itemBoxList, temp)
        local itemData = ClientData:getItemById(self.ItemList[index])
        local item = {
            num = 0,
            id = self.ItemList[index],
            addTicket = 0,
        }
        local customBox = itemBox.transform:Find("CustomBox").gameObject
        EngineUtil.FillPeer(self.customBox, customBox)
        local data = {
            id = self.ItemList[index],
            type = GE.RewardType.ItemProp,
            num = 0,
        }
        --体力药
        if itemData and itemData.num > 0 then
            data.num = itemData.num
            item.num = itemData.num
        end
        --货币购买
        local buyData = Me:getItemNumById(self.ItemList[index])    --货币拥有数量
        local buyCount = Me:getTicketData().todayBuyCount + 1       --购买次数
        if self.ItemList[index] == Config.GetConfigInfo("ApBuy")[1] then
            data.num = buyData
            item.num = buyData
        end

        local itemConfig = Config.GetItemInfo(self.ItemList[index])
        local todayBuyCount = Me:getTicketData().todayBuyCount
        local maxBuyCount = Config.GetConfigInfo("ApBuy")[2]
        local addBuyCount = Me:GetCycleCardPrivilegeAddCount(PrivilegeType.ApBuyAddCount)
        maxBuyCount = maxBuyCount + addBuyCount
        if itemConfig then
            itemBox.nameTxt.text.text = itemConfig.itemName
            customBox.customBox.itemNum.text.text = 0
            customBox.customBox:setMono(self)
            customBox.customBox:SetUIData(data, {disableClick = true})
            if self.ItemList[index] == Config.GetConfigInfo("ApBuy")[1] then
                itemBox.maxBg:SetActive(true)
                if buyCount > maxBuyCount then
                    itemBox.buyMaxTxt.text.text = "0/"..maxBuyCount
                else
                    item.addTicket = Config.GetConfigInfo("ApBuyRestore")
                    itemBox.buyMaxTxt.text.text = maxBuyCount - todayBuyCount.."/"..maxBuyCount
                end
                itemBox.itemCountTxt.text.text = string.format(LocalStrEnum.EnergyExchangeTip_1, Config.GetConfigInfo("ApBuyRestore"))
            else
                itemBox.maxBg:SetActive(false)
                itemBox.itemCountTxt.text.text = string.format(LocalStrEnum.EnergyExchangeTip_1, itemConfig.effect[2])
                item.addTicket = itemConfig.effect[2]
            end
            customBox.customBox.countObj:SetActive(true)
        end
        
        self.nowSelectData[index] = item

        itemBox.scaleButton.onClick:RemoveAllListeners()
        itemBox.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self:SelectBoxNew(index)
        end)
        curCreateCount = curCreateCount + 1
        if curCreateCount >= #self.ItemList then
            self:SelectBoxNew(self.nowSelect)
        end
    end)
    self.nowCount.text.text = UICommonUtils.SetResourceFormatByType(GE.ResourceType.Strength)

    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..GE.ResourceType.Strength), self.ticketIcon.image)
end

--默认选中
function BuyTicketPanel:DefaultSelect()
    for key, value in pairs(self.ItemList) do
        if value == Config.GetConfigInfo("ApBuy")[1] then
            local buyData = Me:getItemNumById(Config.GetConfigInfo("ApBuy")[1])
            if buyData and buyData > 0 then
                self.nowSelect = key
                return
            end
        else
            local temp = ClientData:getItemById(value)
            if temp and next(temp) then
                self.nowSelect = key
                return
            end
        end
    end
end

--选择格子
--index {int} 格子索引
function BuyTicketPanel:SelectBoxNew(index)
    if self.nowSelectData == nil or self.nowSelectData[self.nowSelect] == nil then
       return 
    end
    local nowData = self.ItemList[index]
    self.nowSelect = index
    if nowData == Config.GetConfigInfo("ApBuy")[1] then
        self.nowMode = 2
        self.lua_setNumView.gameObject:SetActive(false)
        local buyCount = Me:getTicketData().todayBuyCount + 1
        if buyCount > Config.GetConfigInfo("ApBuy")[2] then
            self.msgTxt.text.text = LocalStrEnum.EnergyExchangeTip_3
        else
            self.msgTxt.text.text = string.format(LocalStrEnum.BuyTicketNumTips, Config.GetConfigInfo("ApBuyCost")[buyCount], self.nowSelectData[self.nowSelect].addTicket)
        end
    else
        self.nowMode = 1
        self.useNum = 1

        local itemData = self.nowSelectData[self.nowSelect]
        local maxCount = math.floor((Config.GetConfigInfo("ApMaxHold") - Me:getTicketData().num) / itemData.addTicket)

        local maxNum = 0
        if itemData and next(itemData) then
            maxNum = itemData.num
        end
        maxCount = math.min(maxNum, maxCount)
        self.lua_setNumView.gameObject:SetActive(true)
        self.lua_setNumView:SetData({
            maxNum = maxCount,
            onValueChange = function(curVal)
                self:ChangeUserCount(curVal)
            end
        })
        self.msgTxt.text.text = ""
    end

    for k,v in pairs(self.itemBoxList) do
        if v.index == self.nowSelect then
            v.obj.isSelect:SetActive(true)
        else
            v.obj.isSelect:SetActive(false)
        end
    end

    if self.nowMode == 1 then
        self.addCount.text.text = (self.nowSelectData[self.nowSelect].addTicket * self.useNum) + UICommonUtils.SetResourceFormatByType(GE.ResourceType.Strength)
    elseif self.nowMode == 2 then
        self.addCount.text.text = self.nowSelectData[self.nowSelect].addTicket + UICommonUtils.SetResourceFormatByType(GE.ResourceType.Strength)
    end

end

--更改购买数量
function BuyTicketPanel:ChangeUserCount(count)
    local maxNum = 0
    local itemData = self.nowSelectData[self.nowSelect]
    local maxCount = 0
    if itemData and next(itemData) then
        maxNum = itemData.num
        maxCount = math.floor((Config.GetConfigInfo("ApMaxHold") - Me:getTicketData().num) / itemData.addTicket)
        if (count * itemData.addTicket) + Me:getTicketData().num >= Config.GetConfigInfo("ApMaxHold") then
            count = maxCount
        end
    end
    if count > maxNum or count <= 0 then
        return
    end
    self.useNum = count

    if self.nowMode == 1 then
        self.addCount.text.text = (itemData.addTicket * self.useNum) + UICommonUtils.SetResourceFormatByType(GE.ResourceType.Strength)
    elseif self.nowMode == 2 then
        self.addCount.text.text = itemData.addTicket + UICommonUtils.SetResourceFormatByType(GE.ResourceType.Strength)
    end
end

function BuyTicketPanel:TimeChange()
    local timeRemainingNext, timeRemainingAll = ClientData:SetTicketRecoverTimeRemaining()
    timeRemainingNext = DLuaUtil.GetDHMSStr(timeRemainingNext)
    timeRemainingAll = DLuaUtil.GetDHMSStr(timeRemainingAll)
    local isMax = Me:getTicketData().num >= Config.GetConfigInfo("LimitNormalTicketNum")  --TODO: 这个可能要跟其他系统修改
    if not isMax then
        self.nextTimeTxt.text.text = timeRemainingNext
        self.allTimeTxt.text.text = timeRemainingAll
    end
    self.recoveryTimeBox:SetActive(not isMax)
    self.completeBox:SetActive(isMax)
end

--界面关闭
function BuyTicketPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--function BuyTicketPanel:OnClose(initiative)
--
--end

function BuyTicketPanel:OnDestroy()
    if self.recoverTicketCountDownTimer then
        DLuaTimer:RemoveTimer(self.recoverTicketCountDownTimer)
    end

    self.super:OnDestroy(self)
end

--function BuyTicketPanel:OnRefresh(data)
--
--end

--[[
/mask onClick 
--]]
function BuyTicketPanel:mask_Button_onClick(mask)
    self:playCloseAnim()
end

--[[
/Bg/CountChange/MaxBtn onClick 
--]]
function BuyTicketPanel:maxBtn_ScaleButton_onClick(maxBtn)
    self:play2DSound(self.btnSoundPath)
    self:ChangeUserCount(self.nowSelectData[self.nowSelect].num)
end

--[[
/Bg/OkBtn onClick 
--]]
function BuyTicketPanel:okBtn_ScaleButton_onClick(okBtn)
    self:play2DSound(self.btnSoundPath)
    local nowData = self.nowSelectData[self.nowSelect]
    if not nowData then
        return
    end

    if self.nowMode == 1 then
        if nowData.num < self.useNum then
            UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_ItemNoEnough)
            return
        end
    elseif self.nowMode == 2 then
        local buyCount = Me:getTicketData().todayBuyCount + 1
        local maxBuyCount = Config.GetConfigInfo("ApBuy")[2]
        local addBuyCount = Me:GetCycleCardPrivilegeAddCount(PrivilegeType.ApBuyAddCount)
        maxBuyCount = maxBuyCount + addBuyCount
        if buyCount > maxBuyCount then
            UICommonUtils.PopToast(LocalStrEnum.EnergyExchangeTip_3)
            return
        end

        local needCost = Config.GetConfigInfo("ApBuyCost")[buyCount] or 0
        if nowData.num < needCost then
            UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_CurrencyNoEnough)
            return
        end
    end

    if self.nowMode == 1 then
        local temp = self.useNum * nowData.addTicket + Me:getTicketData().num
        if temp > Config.GetConfigInfo("ApMaxHold") then
            UICommonUtils.PopToast(LocalStrEnum.EnergyExchangeTip_4)
            return
        end
    elseif self.nowMode == 2 then
        local temp = nowData.addTicket + Me:getTicketData().num
        if temp > Config.GetConfigInfo("ApMaxHold") then
            UICommonUtils.PopToast(LocalStrEnum.EnergyExchangeTip_4)
            return
        end
    end

    Me:buyNormalTicketReq({mode = self.nowMode, id = nowData.id, num = self.useNum,}, function(data)
        UICommonUtils.PopToast(LocalStrEnum.EnergyExchangeTip_5)
        self:playCloseAnim()
    end)
end

--[[
/PanelBg/Art/TitleBg/CloseBtn onClick 
--]]
function BuyTicketPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:play2DSound(self.btnSoundPath)
    self:playCloseAnim()
end

--[[
/PanelBg/CountChange/MinBtn onClick 
--]]
function BuyTicketPanel:minBtn_ScaleButton_onClick(minBtn)
    self:play2DSound(self.btnSoundPath)
    self:ChangeUserCount(1)
end

--[[
/PanelBg/CountChange/MinusBtn onClick 
--]]
function BuyTicketPanel:minusBtn_ScaleButton_onClick(minusBtn)
    self:play2DSound(self.btnSoundPath)
    self:ChangeUserCount(self.useNum - 1)
end

--[[
/PanelBg/CountChange/PlusBtn onClick 
--]]
function BuyTicketPanel:plusBtn_ScaleButton_onClick(plusBtn)
    self:play2DSound(self.btnSoundPath)
    self:ChangeUserCount(self.useNum + 1)
end

--[[
/PanelBg/CacelBtn onClick 
--]]
function BuyTicketPanel:cacelBtn_ScaleButton_onClick(cacelBtn)
    self:play2DSound(self.btnSoundPath)
    self:playCloseAnim()
end

--[[
/BoxBg/SetNumView/numSlider onValueChanged 
--]]
function BuyTicketPanel:numSlider_Slider_onValueChanged(numSlider,value)

end

return BuyTicketPanel
