---@class RechargePanel : RechargePanel_Generate
---##################### 【RechargePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RechargePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RechargePanel = require "RechargePanel_Generate"

function RechargePanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
    }
    self.shopListInited = false
end

--function RechargePanel:StartCreating(time)
--
--end

--function RechargePanel:StartEnter(time)
--
--end

--function RechargePanel:StartRemoving(time)
--
--end

--function RechargePanel:StartExit(time)
--
--end

function RechargePanel:OnOpen(data, initiative)
    if initiative then
        self:RefreshRechargeList()
        --设置特殊资源列表
        self.customBackPanel.customBackPanel:OverrideSpecificRes({100001})
    end
end

--刷新充值列表
function RechargePanel:RefreshRechargeList()
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.ShopRechargePanel, self)
    local tempList = ClientData:GetPremiumShopData()
    local goodsList = {}
    for k, v in pairs(tempList) do
        local configData = Config.GetGiftInfo(v.id)
        --没过期 没购买限制或者有限制没到上限
        if not v.isDated and (configData.LimitType == 0 or (configData.LimitType ~= 0 and v.buyTimes > configData.Limit))then
            table.insert(goodsList, v)
        end
    end
    table.sort(goodsList, function (a, b)
        local aconfig = Config.GetGiftInfo(a.id)
        local bconfig = Config.GetGiftInfo(b.id)
        return aconfig.index > bconfig.index
    end)
    if not self.shopListInited then
        self.shopList.loopGridView:InitGridView(tablex.size(goodsList), function(gridView, index, row, col)
            --LuaLogger.ds("index", index)
            local loopGridViewItem = gridView:GetShownItemByItemIndex(index)
            if loopGridViewItem == nil then
                loopGridViewItem = gridView:NewListViewItem("ShopBox")
            end
            local obj = loopGridViewItem.gameObject
            EngineUtil.FillPeer(self.shopBox, obj)
            local ShopBox = obj.shopBox
            index = index + 1
            local goodsInfo = goodsList[index]
    
            --购买
            ShopBox:SetBuyListener(function()
                UICommonUtils:Pay(goodsInfo.id, function()
                    self:RefreshRechargeList()
                end)
            end)
            local giftConfigInfo = Config.GetGiftInfo(goodsInfo.id)
            --icon
            self:LoadSpriteAsync(string.format(Config.SpritePath.shopItem, giftConfigInfo.Icon), function (s)
                ShopBox:SetIconSprite(s)
            end)
            --价格
            local price = giftConfigInfo.Cost
            if goodsInfo.discount then
                
            end
            --价格
            ShopBox:SetBuyText("￥" .. price)
            --描述
            ShopBox:SetDescText(giftConfigInfo.Name)
            --首充双倍
            local alreadyNum = goodsInfo.allBuyTimes
            -- local isDouble = giftConfigInfo.
            ShopBox:DoubleTipsSetActive(false)
            
            return loopGridViewItem
        end)
        self.shopListInited = true
    else
        self.shopList.loopGridView:RefreshAllShownItem2()
    end
end

--function RechargePanel:OnClose(initiative)
--
--end

--function RechargePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function RechargePanel:OnRefresh(data)
--
--end

return RechargePanel
