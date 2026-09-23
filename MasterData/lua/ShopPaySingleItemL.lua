local comm = nil;
local iconItems = {};
local lastItemPath = nil;
local data = nil;

function Refresh(_data)
    data = _data;
    comm = data.commodity;
    CreateIconObj();
    -- 持有数
    SetHasNum()
    -- 当前剩余数量
    SetLimitNum();
    -- 显示剩余天数
    SetLimitDays()
    -- 描述和名字
    SetDesc();
end

function SetDesc()
    if data.spType==1 or data.spType==2 then
        CSAPI.SetText(txt_name, data.cfg.sName);
        CSAPI.SetText(txt_desc, data.cfg.desc);
    elseif data.spType==3 then
        local goods=comm:GetGoods();
        CSAPI.SetText(txt_name,goods:GetName());
		CSAPI.SetText(txt_desc,goods:GetDesc());
    else
        if comm:GetType() == CommodityItemType.ChoiceCard then -- 自选，特殊处理
            local getInfo = comm:GetCommodityList();
            if getInfo then
                CSAPI.SetText(txt_name, getInfo[1].data:GetName());
                CSAPI.SetText(txt_desc, getInfo[1].data:GetDesc());
            else
                CSAPI.SetText(txt_name, comm:GetName());
                LogError("未得到对应兑换信息！" .. table.tostring(comm));
            end
        else
            CSAPI.SetText(txt_name, comm:GetName());
            CSAPI.SetText(txt_desc, comm:GetDesc());
        end
    end
end

function SetLimitNum()
    local num = 0;
    if data.spType == 1 then
        num=data.cfg.buyNumLimit;
    elseif data.spType==2 then
        num=1;
    else
        num = comm:GetNum();
    end
    CSAPI.SetGOActive(limitNumObj, num ~= -1)
    if num ~= -1 then
        CSAPI.SetText(txtLimitNum, LanguageMgr:GetByID(38005, num))
    else
        CSAPI.SetText(txtLimitNum, LanguageMgr:GetByID(38009))
    end
end

function SetLimitDays()
    local tips = nil;
    if data.spType == 1 or data.spType==2 then
    elseif data.spType==3 then
    else
        tips = comm:GetEndBuyTips();
    end
    if tips ~= nil then
        CSAPI.SetGOActive(limitTimeObj, true);
        CSAPI.SetText(txtLimitTime, tips)
    else
        CSAPI.SetGOActive(limitTimeObj, false);
    end
end

function SetHasNum()
    local bagNum = 0;
    local isShow = false;
    if data.spType == 1 then
        bagNum=BagMgr:GetCount(data.cfg.itemId);
    elseif data.spType==2 then
    elseif data.spType==3 then
        local goods=comm:GetGoods();
        bagNum=BagMgr:GetCount(goods:GetID());
    else
        if (data.commodityType == 1 and comm:GetType() == CommodityItemType.Item) then -- 固定配置
            isShow = true;
            local item = comm:GetCommodityList()[1];
            if item and item.data and item.data:GetCfg().type == ITEM_TYPE.EQUIP_MATERIAL and
                item.data:GetCfg().dy_value1 ~= nil then
                local equip = EquipMgr:GetEquipByCfgID(item.data:GetCfg().dy_value1)
                if equip ~= nil then
                    bagNum = equip:GetCount();
                end
            else
                bagNum = BagMgr:GetCount(item.cid)
            end
        elseif (data.commodityType == 2 and comm:GetType() == RandRewardType.ITEM) then -- 随机配置
            isShow = true
            bagNum = BagMgr:GetCount(comm:GetID());
        end
    end
    -- 设置持有数
    CSAPI.SetText(txt_hasNum, tostring(bagNum));
    CSAPI.SetGOActive(hasObj, isShow)
end

function CreateIconObj()
    local path = "ShopComm/ShopPayIconItem";
    if data.spType==3 then
    elseif comm and (comm:GetType() == CommodityItemType.SingleSelection or comm:GetType()==CommodityItemType.DoubleSelection) then --单选双选
        path = "ShopComm/ShopPayIconItem2";
    elseif (comm and comm:GetType() == CommodityItemType.THEME) or data.spType == 2 then
        path = "ShopComm/ShopPayIconItem3";
    end
    if lastItemPath ~= path and lastItemPath and iconItems[lastItemPath] then
        CSAPI.SetGOActive(iconItems[lastItemPath].gameObject, false)
    end
    if iconItems[path] == nil then
        ResUtil:CreateUIGOAsync(path, gridNode, function(go)
            iconItems[path] = ComUtil.GetLuaTable(go);
            iconItems[path].Refresh(data);
        end)
        lastItemPath = path;
    else
        CSAPI.SetGOActive(iconItems[path].gameObject, true)
        iconItems[path].Refresh(data)
    end
end
