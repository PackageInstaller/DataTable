local normalSize = 1
local iconSize = 1.3
local roleSize = 0.75
local isBig=false;

------------------------------------------------------------
-- 私有函数
------------------------------------------------------------
function CreateGoodsDataByCid(cid)
    return GoodsData({ id = cid })
end

function LoadGoodsIcon(goodsData, openSetting)
    local gType = goodsData:GetType()
    local cfg = goodsData:GetCfg()
    local state=1;
    if gType == ITEM_TYPE.CARD then
        state=2;
        GridUtil.LoadCIcon(icon, tIcon, cfg, isBig)
    elseif gType == ITEM_TYPE.CARD_CORE_ELEM then
        state=3;
        ResUtil.IconGoods:Load(icon, goodsData:GetIcon())
        GridUtil.LoadTIcon(tIcon, tBorder, cfg, isBig)
    elseif gType == ITEM_TYPE.PanelImg and openSetting == 2 then
        ResUtil.MultiIcon:Load(icon, cfg.itemPicture)
    elseif gType == ITEM_TYPE.EQUIP_MATERIAL or gType == ITEM_TYPE.EQUIP then
        state=gType == ITEM_TYPE.EQUIP_MATERIAL and 1 or 2;
        GridUtil.LoadEquipIcon(icon, tIcon, goodsData:GetIcon(), goodsData:GetQuality(),
        gType == ITEM_TYPE.EQUIP_MATERIAL, isBig)
    else
        goodsData:GetIconLoader():Load(icon, goodsData:GetIcon())
    end
    CSAPI.SetGOActive(tIcon,state>=2);
end

------------------------------------------------------------
-- CommodityType == 1 时的类型分发表
------------------------------------------------------------
local CommodityHandlers = {
    [CommodityItemType.Item] = function(data, openSetting)
        local item = data:GetCommodityList()[1]
        local goodsData = CreateGoodsDataByCid(item.cid)
        LoadGoodsIcon(goodsData, openSetting)
    end,

    [CommodityItemType.Package]   = function(data) 
        if data:GetIcon()~=nil and data:GetIcon()~="" then
            ResUtil.IconGoods:Load(icon, data:GetIcon())
        elseif data:GetPackageIcon()~=nil then
            ResUtil.VCommodity:Load(icon, data:GetPackageIcon()) 
        end    
    end,
    [CommodityItemType.Skin]   = function(data) 
        if data:GetIcon()~=nil and data:GetIcon()~="" then
            ResUtil.IconGoods:Load(icon, data:GetIcon())
        else
            local item = data:GetCommodityList()[1]
            local goodsData = CreateGoodsDataByCid(item.cid)
            LoadGoodsIcon(goodsData, openSetting)
        end    
    end,
    [CommodityItemType.Deposit]   = function(data) ResUtil.IconGoods:Load(icon, data:GetIcon()) end,
    [CommodityItemType.MonthCard] = function(data) ResUtil.IconGoods:Load(icon, data:GetIcon()) end,

    [CommodityItemType.FORNITURE] = function(data)
        local item = data:GetCommodityList()[1]
        local goodsData = CreateGoodsDataByCid(item.cid)
        ResUtil.Furniture:Load(icon, goodsData:GetIcon())
    end,
    [CommodityItemType.THEME] = function(data)
        local item = data:GetCommodityList()[1]
        local goodsData = CreateGoodsDataByCid(item.cid)
        ResUtil.Furniture:Load(icon, goodsData:GetIcon())
    end,

    [CommodityItemType.ChoiceCard] = function(data, openSetting)
        local infos = data:GetCommodityList()
        if infos and infos[1] then --已选择
            local item = infos[1]
            local goodsData = CreateGoodsDataByCid(item.cid)
            if goodsData then
                LoadGoodsIcon(goodsData, openSetting)
            else
                LogError("物品表不存在物品配置：" .. tostring(item.cid))
            end
        else  --未选择
            CSAPI.SetGOActive(tBorder,false)
            CSAPI.SetGOActive(tIcon,false)
            CSAPI.LoadImg(icon,"UIs/Shop/img_08_01.png",true,nil,true);
        end
    end,

    [CommodityItemType.SkinPass] = function(data, openSetting)
        local item = data:GetCommodityList()[1]
        local goodsData = CreateGoodsDataByCid(item.cid)
        LoadGoodsIcon(goodsData, openSetting)
    end,

    [CommodityItemType.SingleSelection] = function(data, openSetting)
        local item = data:GetCommodityList()[1]
        local goodsData = CreateGoodsDataByCid(item.cid)
        LoadGoodsIcon(goodsData, openSetting)
    end,

    [CommodityItemType.DoubleSelection] = function(data, openSetting)
        local item = data:GetCommodityList()[1]
        local goodsData = CreateGoodsDataByCid(item.cid)
        LoadGoodsIcon(goodsData, openSetting)
    end,

    [CommodityItemType.RoleTrainGuide] = function(data, openSetting)
        local item = data:GetCommodityList()[1]
        local goodsData = CreateGoodsDataByCid(item.cid)
        LoadGoodsIcon(goodsData, openSetting)
    end,
}

------------------------------------------------------------
-- 随机奖励类型分发表 (commodityType ~= 1)
------------------------------------------------------------
local RandRewardHandlers = {
    [RandRewardType.EQUIP] = function(data)
        local goodsData = data.goods
        GridUtil.LoadEquipIcon(icon, tIcon, goodsData:GetIcon(), goodsData:GetQuality(), false, false)
    end,

    [RandRewardType.CARD] = function(data, openSetting)
        local goodsData = CreateGoodsDataByCid(data:GetID())
        LoadGoodsIcon(goodsData, openSetting)
    end,

    [RandRewardType.ITEM] = function(data, openSetting)
        local goodsData = CreateGoodsDataByCid(data:GetID())
        LoadGoodsIcon(goodsData, openSetting)
    end,
}

------------------------------------------------------------
-- 主逻辑函数：Refresh
------------------------------------------------------------
function Refresh(data, commodityType, _isBig, openSetting)
    openSetting = openSetting or 1
    isBig=_isBig
    local iSize = isBig and iconSize or normalSize
    local iName = data:GetIcon()
    local cType = data:GetType()
    CSAPI.SetGOActive(tBorder,false);
    ResUtil.Commodity:Load(tBorder,"btn_02_03");
    --------------------------------------------------------
    -- 固定商品类型
    --------------------------------------------------------
    if commodityType == 1 then
        if iName and iName ~= "" and openSetting == 2 and cType ~= CommodityItemType.ChoiceCard and cType~=CommodityItemType.FORNITURE and cType~=CommodityItemType.THEME and cType~=CommodityItemType.Package then
            iSize = 1
            ResUtil.IconGoods:Load(icon, iName)
        else
            local handler = CommodityHandlers[cType]
            if handler then
                handler(data, openSetting)
            else
                LogError(string.format("[Refresh] 未处理的 Commodity 类型: %s", tostring(cType)))
            end
        end

    --------------------------------------------------------
    -- 随机奖励类型
    --------------------------------------------------------
    else
        local handler = RandRewardHandlers[cType]
        if handler then
            handler(data, openSetting)
        else
            LogError(string.format("[Refresh] 未处理的 RandReward 类型: %s", tostring(cType)))
        end
    end

    --------------------------------------------------------
    -- 设置缩放
    --------------------------------------------------------
    CSAPI.SetScale(icon, iSize, iSize, iSize)
end

--只读取单个图标
function LoadIconByName(iconName,iconLoader)
    if iconLoader and iconName then
        iconLoader:Load(icon,iconName,true)
    end
    CSAPI.SetGOActive(icon,true);
    CSAPI.SetGOActive(tBorder,false);
    CSAPI.SetGOActive(tIcon,false);
end