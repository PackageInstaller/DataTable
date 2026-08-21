local ItemHelper = {}
local tInsert = table.insert

--通过道具ID获得自选箱道具[{itemId=1,Count=100,selectedCount=0},...]
function ItemHelper.GetFreeItemsByItemId(itemId)
    local itemCfg = ConfigHelper.GetCfg("item", itemId)
    if not itemCfg then
        Logger.LogError("item is 空, 检查配置, id = " .. itemId)
        return nil
    end

    local items = {}
    if itemCfg.effectType == BagConst.ItemEffectType.FreeChooseItem then
        local effArgs = itemCfg.effectArgs
        if effArgs then
            local item = nil
            for i = 1, #effArgs do
                if i % 2 ~= 0 then
                    item = {}
                    item.itemId = effArgs[i]
                    item.Count = effArgs[i + 1]
                    item.selectedCount = 0
                    tInsert(items, item)
                end
            end
        end
    end
    return items
end

--通过道具ID获得自选箱英雄ID集合 [{heroId=1,selected=false},...]
function ItemHelper.GetFreeHerosByItemId(itemId)
    local itemCfg = ConfigHelper.GetCfg("item", itemId)
    if not itemCfg then
        Logger.LogError("item is 空, 检查配置, id = " .. itemId)
        return nil
    end

    if itemCfg.effectType == BagConst.ItemEffectType.FreeChooseHero then
        local arr = {}
        for _, v in ipairs(itemCfg.effectArgs) do
            local hd = IHeroDataMgr:GetMyHeroDataById(v)
            tInsert(arr, { heroId = v, selected = false, isHave = hd and hd:IsHave() or false })
        end
        return arr
    end
    return nil
end

--使用道具，含合成(非限时道具使用)
function ItemHelper.UseItem(useItemId, useItemNum, decompose, composeNum, onUseSuc, isHideItem)
    if (useItemId == 0) or (useItemNum == 0) then
        Logger.LogError("item id == 0 or useNum = 0 ")
        return
    end

    local itemCfg = ConfigHelper.GetCfg("item", useItemId)
    if not itemCfg then
        Logger.LogError("item is 空, 检查配置, id = " .. useItemNum)
        return
    end

    ItemHelper.isHideItem = isHideItem
    if decompose == nil then decompose = false end
    local request = {}
    request.Decompose = decompose
    request.PackageId = useItemId
    request.Count = useItemNum
    if decompose then
        if (itemCfg.effectType == BagConst.ItemEffectType.Frag) or (itemCfg.type == BagConst.ItemType.EIT_Fragment) then
            request.Count = composeNum or 0
        end
    end
    ItemDataMgr:GetInstance():UseItem(request, onUseSuc)
end

--使用自选道具
function ItemHelper.UseFreeItem(useItemId, useItemNum, selItemIdx, onUseSuc)
    if (useItemId == 0) or (useItemNum == 0) then
        Logger.LogError("item id == 0 or useNum = 0 ")
        return
    end

    local itemCfg = ConfigHelper.GetCfg("item", useItemId)
    if itemCfg == nil then
        Logger.LogError("item is 空, 检查配置, id = " .. useItemNum)
        return
    end

    local request = {}
    request.Decompose = (itemCfg.decompose == 1) and true or false
    request.PackageId = useItemId
    request.Count = useItemNum
    request.SelItemIdx = selItemIdx
    ItemDataMgr:GetInstance():UseItem(request, onUseSuc)
end

function ItemHelper.BagSort(data1, data2)
    local itemData1, itemData2 = data1.data, data2.data
    local a, b = itemData1.Num == 0, itemData2.Num == 0
    if (a and not b) or (not a and b) then return b end

    local cfg1, cfg2 = itemData1:GetItemCfg(), itemData2:GetItemCfg()
    --1、优先按照道具类型排序，类型数字按照1~18依次排序，配置字段type;
    if cfg1.type == cfg2.type then
        --2、同道具类型按照道具品质排序，品质高得排前面，即4在前，1最后；配置字段quality；
        if cfg1.quality == cfg2.quality then
            --3、同类型同品质，按照配置字段order
            return cfg1.order < cfg2.order
        else
            return cfg1.quality > cfg2.quality
        end
    else
        return cfg1.type < cfg2.type
    end
end

function ItemHelper.GetBagItems(selectable, furnitureList)
    if selectable == nil then selectable = false end

    local allItems, BagTab = {}, BagConst.Tab
    local FurnIdx = BagTab.FURNITURE.Index -- 宿舍家具
    local PlotIdx = BagTab.PLOT.Index      -- 剧情道具
    for _, tabInfo in pairs(BagTab) do
        local tabIdx, csItemDatas = tabInfo.Index, nil
        if (tabIdx == PlotIdx) or (tabIdx == FurnIdx) then
            csItemDatas = ItemDataMgr:GetInstance():GetAllItemDatas(tabInfo.types)
        else
            csItemDatas = ItemDataMgr:GetInstance():GetItemsByTypes(tabInfo.types)
        end

        local data_list = {}
        for i = 0, csItemDatas.Count - 1 do
            local d = csItemDatas[i]
            -- 指定道具不显示
            if d:IsShow() and d:IsVaild() then
                table.insert(data_list, {
                    data = d,
                    isSelect = false,
                    selectable = selectable
                })
            end
        end
        table.sort(data_list, ItemHelper.BagSort)
        allItems[tabIdx] = data_list
    end

    local furnitureDic = {}
    for _, value in pairs(furnitureList or {}) do
        local templateId = value.TemplateId
        local furniture = furnitureDic[templateId]
        if furniture then
            furniture.furnitureNum = furniture.furnitureNum + 1
        else
            furnitureDic[templateId] = { furnitureId = templateId, furnitureNum = 1, }
        end
    end

    local list = allItems[FurnIdx]
    for i = #list, 1, -1 do
        local itemData = list[i].data
        local furniture = furnitureDic[itemData.Id]
        if furniture then
            itemData:UpdateItem(itemData.Id, furniture.furnitureNum, 0)
        else
            table.remove(list, i)
        end
    end

    return allItems
end

function ItemHelper.RefreshBag()
    OtakuFurniturDataMgr:GetFurnituresByPage(-1, function(list)
        local allItems = ItemHelper.GetBagItems(false, list)
        EventMgr:Broadcast(UIMessageNames.BAG_USE_ITEM_SUC, allItems)
    end)
end

function ItemHelper.GetItemNameById(itemId)
    if itemId <= 0 then return "" end
    local item = ConfigHelper.GetCfgByLua("item", itemId)
    if item then return ConfigHelper.GetLocalString(item.name) end
    Logger.LogError("item is nil, 需检查配表, id = " .. itemId)
    return ""
end

function ItemHelper.GetItemIconById(itemId)
    if itemId <= 0 then return "" end
    local item = ConfigHelper.GetCfgByLua("item", itemId)
    if item then return item.icon end
    Logger.LogError("item is nil, 需检查配表, id = " .. itemId)
    return ""
end

function ItemHelper.ItemQuality(itemId)
    if itemId <= 0 then return 0 end
    local item = ConfigHelper.GetCfgByLua("item", itemId)
    if item then return item.quality end
    Logger.LogError("item is nil, 需检查配表, id = " .. itemId)
    return 0
end

function ItemHelper.ShowUsePanel(itemId, packagrId)
    local itemCfg = ConfigHelper.GetCfgByLua("item", itemId)
    if not itemCfg then
        Logger.LogError("item is nil, 需检查配表, id = " .. itemId)
        return
    end
    local itemData
    if packagrId then
        itemData = ItemDataMgr:GetInstance():GetItemByPackageId(packagrId, itemCfg.ifTime == 1)
    else
        itemData = ItemDataMgr:GetInstance():GetItemById(itemId)
    end
    if not itemData then
        Logger.LogError("itemData is nil id = " .. itemId)
        return
    end

    local effType, packageId = itemCfg.effectType, itemData.PackageId
    local EIET = BagConst.ItemEffectType
    if effType == EIET.FreeChooseItem then
        local useItemNum = ItemDataMgr:GetInstance():GetItemNumById(itemId)
        UIContextMgr:GetInstance():Show("FreeChoose", itemId, packageId, useItemNum)
    elseif effType == EIET.FreeChooseHero then
        local FreeChooseHeroSceneCtrl = require "UI.Ctrl.Bag.FreeChooseHeroSceneCtrl"
        FreeChooseHeroSceneCtrl:GetInstance():OnDispose()
        FreeChooseHeroSceneCtrl:GetInstance():LoadScene("Scene/FreeChoose/FreeChooseHeroRoom", function()
            UIContextMgr:GetInstance():Show("FreeChooseHero", itemId, packageId, 1)
        end)
    elseif effType == EIET.ChangeNick then
        UIContextMgr:GetInstance():Show("CreateAccountUI", true)
    else
        if (effType == EIET.Frag) or (effType == EIET.Combine) then
            local batch = itemCfg.effectArgs[0]
            if math.floor(itemData.Num / batch) <= 0 then
                local tips = ConfigHelper.GetLocalString(5164)
                local name = ConfigHelper.GetLocalString(itemCfg.name)
                GameHelper.Tips(string.format(tips, tostring(batch), name))
                return
            end
        end
        UIContextMgr:GetInstance():Show("ComPopupItemUse", itemData)
    end
end

return ItemHelper
