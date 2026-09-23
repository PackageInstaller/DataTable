local commodity = nil;
local commodityType = nil;
local iconObj = nil;
local isDorm = false;
local data = nil;
local getData=nil;
function Refresh(_data)
    data = _data;
    commodity = data.commodity;
    if data.spType==3 then
        getData= commodity:GetGoods();
    elseif commodity ~= nil then
        commodityType = ShopMgr:GetCommodityTypeByData(commodity)
        local getList = commodity:GetCommodityList();
        if getList then
            getData = getList[1];
        end
    end
    -- 初始化品质
    SetQuality();
    -- 读取图标
    LoadIcon();
    -- 限时物品
    SetLimit();
    -- 详情按钮
    SetDetails();
    SetDorm();
end

function SetDetails()
    if data.spType~=nil then
        CSAPI.SetGOActive(btnDetails, false);
    elseif commodity then
        local isShow = false;
        if getData.data:GetType() == ITEM_TYPE.PANEL_IMG then -- 多人插图
            isShow = true;
        elseif getData.data:GetType() == ITEM_TYPE.BG_ITEM then -- 背景道具
            isShow = true
        elseif getData.data:GetType() == ITEM_TYPE.LIMITED_TIME_SKIN or getData.data:GetType() == ITEM_TYPE.SKIN then -- 皮肤
            isShow = true
        end
        CSAPI.SetGOActive(btnDetails, isShow);
    else
        CSAPI.SetGOActive(btnDetails, false);
    end
end

function SetDorm()
    local isPlay=false;
    local comfort=0;
    if data.spType==1 then
        comfort=data.cfg.comfort
        isPlay=data.cfg.inteActionId~=nil
    elseif data.spType==3 then
    elseif commodity and (commodity:GetType()==CommodityItemType.THEME or commodity:GetType()==CommodityItemType.FORNITURE)  then
        local id=getData.data:GetDyVal1();
        local cfg=commodity:GetType()==CommodityItemType.FORNITURE and Cfgs.CfgFurniture:GetByID(id) or Cfgs.CfgFurnitureTheme:GetByID(id)
        if cfg then
            comfort=cfg.comfort
            isPlay=cfg.inteActionId~=nil
        end
    end
    CSAPI.SetText(txtDorm,tostring(comfort));
    CSAPI.SetGOActive(dormIcon1,isPlay)
    CSAPI.SetGOActive(dormTag,comfort>0);
end

function SetLimit()
    if data.spType~=nil then
       CSAPI.SetGOActive(limitObj, false);
    elseif commodity then
        local isShow = false;
        if commodity:GetType()==CommodityItemType.MonthCard then--月卡
            local mInfo=commodity:GetMonthCardInfo();
            if mInfo then
                isShow=true;
                CSAPI.SetText(txtLimit,LanguageMgr:GetByID(18084,mInfo.l_cnt));
            end
        elseif getData then
            local tips = getData.data:GetIconDayTips();
            isShow = tips ~= nil;
            CSAPI.SetText(txtLimit, tips or "");
        end
        CSAPI.SetGOActive(limitObj, isShow);
    else
        CSAPI.SetGOActive(limitObj, false);
    end
end

function SetQuality()
    local q=1;
    if data.spType == 1 then
        --读取物品表中的数据
        local cfgId=data.cfg.itemId;
        local goods=BagMgr:GetFakeData(cfgId);
        q=goods:GetQuality();
    elseif data.spType==3 then
        local goods=commodity:GetGoods();
        q=goods:GetQuality();
    elseif commodity then
        q=commodity:GetQuality()
    end
     LoadBorderFrame(q, quality)
end

local qulityFrames={"","img9_06_05","img9_06_04","img9_06_03","img9_06_02","img9_06_01"}

function LoadBorderFrame(lvQuality, border)
    local lvQuality=lvQuality or 1
    if qulityFrames[lvQuality] and qulityFrames[lvQuality]~="" then
        CSAPI.SetGOActive(border,true);
        CSAPI.LoadImg(border, string.format("UIs/ShopComm/"..qulityFrames[lvQuality]..".png", lvQuality or 1), false,nil,true);
    else
        CSAPI.SetGOActive(border,false);
    end
end

function LoadIcon()
    if iconObj == nil then
        local go = ResUtil:CreateUIGO("ShopComm/CommodityIcon", iconNode.transform)
        iconObj = ComUtil.GetLuaTable(go)
    end
    if data.spType == 1 then -- 家具
        -- 读取表中的数据
        iconObj.LoadIconByName(data.cfg.icon,ResUtil.Furniture);
    elseif data.spType==3 then --拼图
        local goods=commodity:GetGoods();
        iconObj.LoadGoodsIcon(goods);
    elseif commodity then
        iconObj.Refresh(commodity, commodityType, true,2)
    end
end

function OnClickDetail()
    if commodity == nil or data.spType~=nil then
        do
            return
        end
    end
    if getData then
        local type = getData.data:GetType();
        if type == ITEM_TYPE.PANEL_IMG then -- 多人插图,特殊处理
            CSAPI.OpenView("MulPictureView", {
                id = getData.data:GetDyVal1(),
                showMask = true
            }, commodity:IsShowImg() and 1 or 0);
        elseif getData.data:GetType() == ITEM_TYPE.BG_ITEM then -- 背景道具
            CSAPI.OpenView("BGPictureView", {
                id = getData.data:GetDyVal1(),
                showMask = true
            });
        elseif getData.data:GetType() == ITEM_TYPE.LIMITED_TIME_SKIN or getData.data:GetType() == ITEM_TYPE.SKIN then -- 皮肤
            local d = {getData.data:GetDyVal2(), false};
            CSAPI.OpenView("RoleInfoAmplification", d, LoadImgType.Main);
        end
    end
end
