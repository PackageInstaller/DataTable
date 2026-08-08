---@class PassLevelBuyPanel : PassLevelBuyPanel_Generate
---##################### 【PassLevelBuyPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【PassLevelBuyPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local PassLevelBuyPanel = require "PassLevelBuyPanel_Generate"
local SetNumView = require("SetNumView")
function PassLevelBuyPanel:InitLogic(data)

    self:bindAdvRewardList()

    ---@type SetNumView
    local lua_setNumView = SetNumView:new(self.setNumView.gameObject)
    lua_setNumView:InitGenerate()
    self.lua_setNumView = lua_setNumView

end

--function PassLevelBuyPanel:StartCreating(time)
--
--end

--function PassLevelBuyPanel:StartEnter(time)
--
--end

--function PassLevelBuyPanel:StartRemoving(time)
--
--end

--function PassLevelBuyPanel:StartExit(time)
--
--end

function PassLevelBuyPanel:OnOpen(data, initiative)

    self.goodId = data.goodId
    self.activityId = data.activityId
    self.m_activityData = Config.GetActivityInfo(self.activityId)
    local passdataMap = Me:getPassDataMap()
    self.m_passServeData = passdataMap[self.activityId]

    self.m_passRwdList = {}
    local passPortTables = Config.GetAllConfig("PassportTable")
    for i, value in pairs(passPortTables) do
        if value.PassportId == self.m_activityData.id then
            table.insert(self.m_passRwdList,value)
        end
    end
    table.sort(self.m_passRwdList, function(a, b)
            return a.id < b.id
    end)
    local maxCount = #self.m_passRwdList - self.m_passServeData.level

    local picId, picNum, picRate  = Me:GetShopItemPic(self.goodId)
    local ownPicNum = Me:getItemCountById(picId)
    local picByCount = math.floor(ownPicNum / picNum)
    maxCount = math.min(maxCount, picByCount)
    self.isCanBy = maxCount >= 1
    if maxCount < 1 then
       maxCount = 1 
    end

    local itemCfg = Config.GetItemInfo(picId)
 
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemCfg.icon), self.priceItemImg_1.image)

    self.buyBtn.gameObject:SetActive(self.isCanBy)
    self.disableBuyBtn.gameObject:SetActive(not self.isCanBy)
    self.price = picNum
    self.maxCount = maxCount
    self.priceItemId = picId
    self.curItemCount = -1

    self.lua_setNumView:SetData({
        maxNum = maxCount,
        onValueChange = function(curVal)
            self:SetItemCount(curVal)
        end
    })
    self:RefreshRwdList()
end

--function PassLevelBuyPanel:OnClose(initiative)
--
--end

--function PassLevelBuyPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function PassLevelBuyPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function PassLevelBuyPanel:mask_Button_onClick(mask)
    UIMgr:closeCurrentUI(self)
end

--[[
/content/titleInfo/closeBtn onClick 
--]]
function PassLevelBuyPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UIMgr:closeCurrentUI(self)
end

--[[
/content/buyInfo/cancleBtn onClick 
--]]
function PassLevelBuyPanel:cancleBtn_ScaleButton_onClick(cancleBtn)
    UIMgr:closeCurrentUI(self)
end

--[[
/content/buyInfo/buyBtn onClick 
--]]
function PassLevelBuyPanel:buyBtn_ScaleButton_onClick(buyBtn)
    local picId, picNum, picRate  = Me:GetShopItemPic(self.goodId)

    if picId == 100001 then
            local itemCfg = Config.GetItemInfo(picId)
            local costStr = string.format("<size=200%%><sprite name=%s></size>", itemCfg.icon)

            local contentStr = LocalStrEnum.passport_011--"确定消耗%sX%s，购买%s级通行证等级吗？"

            local passdataMap = Me:getPassDataMap()
            self.m_passServeData = passdataMap[self.activityId]
            local prevLevel = self.m_passServeData.level
            UICommonUtils.PopMsgBox(LocalStrEnum.passport_010, string.format(contentStr, costStr,picNum * self.curItemCount, self.curItemCount), MsgBoxType.Msg_Emoji, function()
                UIMgr:closeCurrentUI(self)
                Me:ShopBuyReq(self.goodId, self.curItemCount, function()
                     local passdataMap = Me:getPassDataMap()
                    self.m_passServeData = passdataMap[self.activityId]

                    local currLevel = self.m_passServeData.level
                    UIMgr:popUICover("PassBuyLevelResutPanel", {prevLevel = prevLevel,nextLevel = currLevel })

                    GameMsgMgr:sendEvent(GameMsgType.PassMainUpdate)

                end)
            end, nil, LocalStrEnum.passport_012, LocalStrEnum.passport_013)
            return
    end
end

function PassLevelBuyPanel:SetItemCount(count)
    self.curItemCount = count
    self.unitPriceText.text.text = tostring(self.price * count)
    local itemCount = Me:getItemCountById(self.priceItemId)
    if itemCount >= self.price * count then
        self.unitPriceText.text.text = tostring(self.price * count)
    else
        local s = tostring(self.price * count)
        s = "<color=#FF0000>" .. s .. "</color>"
        self.unitPriceText.text.text = s
    end
    self:RefreshRwdList()
end

function PassLevelBuyPanel:bindAdvRewardList()
    self.advRewardList.loopGridView:InitGridView(0, function(gridView, index, row, col)
        --LuaLogger.ds("index", index)
        local loopGridViewItem = gridView:GetShownItemByItemIndex(index)
        if loopGridViewItem == nil then
            loopGridViewItem = gridView:NewListViewItem("CustomBox")
        end
        local  indexUse = index + 1
        local itemObj = loopGridViewItem.gameObject
        EngineUtil.FillPeer(self.customBox, itemObj)
        local customBox = itemObj.customBox
        customBox.transform.localScale = Vector3.New(1, 1, 1)
        
        --[[local data = {
            id = self.m_getRewardList[indexUse][2],
            itemType = GE.ItemTypeIndex.item,
            itemNum = self.m_getRewardList[indexUse][3],
            navType = GE.NavigationType.PassPanel,
        }]]
        customBox:setMono(self)
        customBox:SetUIData(self.m_getRewardList[indexUse], {navType = GE.NavigationType.PassPanel})
        return loopGridViewItem
    end)

end
function PassLevelBuyPanel:RefreshRwdList()

    --"购买后通行证升至<color=#1b83d9>%s</color>级，可以获得以下奖励"
    self.giftNameText.text.text = string.format(LocalStrEnum.passport_014,tostring(self.m_passServeData.level + self.curItemCount))

    
    self.m_getRewardList = {}

    for index = self.m_passServeData.level + 1, self.m_passServeData.level + self.curItemCount do
        self.m_getRewardList = tablex.combine(self.m_getRewardList,self.m_passRwdList[index].Award)
        if self.m_passServeData.openAdvance == 1 then
            self.m_getRewardList = tablex.combine(self.m_getRewardList,self.m_passRwdList[index].AdvancedAward)
        end
    end
    self.m_getRewardList = self:mergePassRewardList(self.m_getRewardList)
    self:sortPassBuyPreviewRewardList(self.m_getRewardList)

    self.advRewardList.loopGridView:SetListItemCount(0)
    self.advRewardList.loopGridView:SetListItemCount(#self.m_getRewardList)
end

function PassLevelBuyPanel:mergePassRewardList(rewardList)
    local rewardMap = {}
    -- ipairs 保留「先加入列表」的顺序；合并同 key 时保留首次出现下标
    for i, reward in ipairs(rewardList) do

        local type, id, num = reward[1], reward[2], reward[3]
        -- 只按 id+类型 合并；不要写入 num，否则同种货币/道具份数不同会变成多条无法合并
        local key = id .. "_" .. type
        if rewardMap[key] then
            rewardMap[key][3] = rewardMap[key][3] + num
        else
            local r = clone(reward)
            r._passBuyPreviewOrder = i
            rewardMap[key] = r
        end
    end

    local rewards = {}
    for _, reward in pairs(rewardMap) do
        tablex.insertproxy(rewards, reward)
    end

    return rewards
end

---通行证购买预览列表排序：1.先加入列表的最前（merge 后仍为首次出现顺序）2.皮肤 rank 3.品质 4.id
---@param rewardList table[]
function PassLevelBuyPanel:sortPassBuyPreviewRewardList(rewardList)
    if rewardList == nil or #rewardList < 2 then
        return
    end
    table.sort(rewardList, function(a, b)
        local ao = a._passBuyPreviewOrder or math.huge
        local bo = b._passBuyPreviewOrder or math.huge
        if ao ~= bo then
            return ao < bo
        end
        local ar, aq, aid = self:_passBuyPreviewRewardSortKeys(a)
        local br, bq, bid = self:_passBuyPreviewRewardSortKeys(b)
        if ar ~= br then
            return ar > br
        end
        if aq ~= bq then
            return aq > bq
        end
        if aid ~= bid then
            return aid < bid
        end
        local at, bt = a[1], b[1]
        if at ~= bt then
            return at < bt
        end
        return (a[3] or 0) < (b[3] or 0)
    end)
end

---@return integer skinRankOr0ForNonSkin, integer quality, integer id
function PassLevelBuyPanel:_passBuyPreviewRewardSortKeys(reward)
    local rType = reward[1]
    local id = reward[2] or 0
    local skinRank = 0
    local quality = 0
    if rType == GE.RewardType.Skin then
        local skinCfg = Config.GetCharacterSkinInfo(id)
        if skinCfg then
            skinRank = skinCfg.rank or 0
        end
    elseif rType == GE.RewardType.ItemProp then
        local itemCfg = Config.GetItemInfo(id)
        if itemCfg then
            quality = itemCfg.quality or 0
        end
    elseif rType == GE.RewardType.Weapon then
        local wCfg = Config.GetWeaponInfo(id)
        if wCfg then
            quality = wCfg.rare or 0
        end
    elseif rType == GE.RewardType.Equipment then
        local eCfg = Config.GetEquipmentInfo(id)
        if eCfg then
            quality = eCfg.quality or 0
        end
    elseif rType == GE.RewardType.Character then
        local cCfg = Config.GetCharacterInfo(id)
        if cCfg then
            quality = cCfg.baseStar or 0
        end
    end
    return skinRank, quality, id
end

--[[
/content/SetNumView/minusBtn onClick 
--]]
function PassLevelBuyPanel:minusBtn_ScaleButton_onClick(minusBtn)

end

--[[
/content/SetNumView/plusBtn onClick 
--]]
function PassLevelBuyPanel:plusBtn_ScaleButton_onClick(plusBtn)

end

--[[
/content/SetNumView/maxBtn onClick 
--]]
function PassLevelBuyPanel:maxBtn_ScaleButton_onClick(maxBtn)

end

--[[
/content/SetNumView/numSlider onValueChanged 
--]]
function PassLevelBuyPanel:numSlider_Slider_onValueChanged(numSlider,value)

end

--[[
/content/buyInfo/disableBuyBtn onClick 
--]]
function PassLevelBuyPanel:disableBuyBtn_ScaleButton_onClick(disableBuyBtn)

end

return PassLevelBuyPanel
