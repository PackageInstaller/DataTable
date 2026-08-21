---使用道具命令
local UseItemCommand = BaseClass("UseItemCommand", BaseCommand)
local M = UseItemCommand

---packageId 使用道具PackageId
---useItemNum 使用道具数量
---isCompose 是否为合成
---composeNum 合成的数量
function M:Execute(packageId, useItemNum, isCompose, composeNum, isLimitItem)
    if not packageId or not useItemNum then return end

    if useItemNum == 0 then
        GameHelper.TipsById(4182)
        return
    end

    local itemData = ItemDataMgr:GetInstance():GetItemByPackageId(packageId, isLimitItem)
    if not itemData then return end

    local EItemEffType = BagConst.ItemEffectType
    if itemData:IsEqualEffectType(EItemEffType.FreeChooseItem) then
        useItemNum = ItemDataMgr:GetInstance():GetItemNumById(packageId)
        UIContextMgr:GetInstance():Show("FreeChoose", itemData.Id, packageId, useItemNum)
    elseif itemData:IsEqualEffectType(EItemEffType.FreeChooseHero) then
        local FreeChooseHeroSceneCtrl = require "UI.Ctrl.Bag.FreeChooseHeroSceneCtrl"
        FreeChooseHeroSceneCtrl:GetInstance():OnDispose()
        FreeChooseHeroSceneCtrl:GetInstance():LoadScene("Scene/FreeChoose/FreeChooseHeroRoom", function()
            UIContextMgr:GetInstance():Show("FreeChooseHero", itemData.Id, packageId, 1)
        end)
    else
        EventMgr:Broadcast(UIMessageNames.BAG_USE_ITEM, packageId, useItemNum, nil, isLimitItem)
    end
end

return UseItemCommand
