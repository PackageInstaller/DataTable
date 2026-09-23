local commodity = nil;
local commodityType = nil;
local iconObj = nil;
local isDorm = false;
local data = nil;
local getData=nil;
local layout=nil;
local imgDatas={};
local cfg=nil;
function Awake()
    layout = ComUtil.GetCom(hpage, "UIInfinite")
    layout:Init("UIs/ShopComm/DormThemeImg", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        lua.Refresh(imgDatas[index])
    end
end

function Refresh(_data)
    data = _data;
    commodity = data.commodity;
    if commodity ~= nil then
        commodityType = ShopMgr:GetCommodityTypeByData(commodity)
        local getList = commodity:GetCommodityList();
        if getList then
            getData = getList[1];
        end
        local id=getData.data:GetDyVal1();
        if commodity:GetType()==CommodityItemType.THEME then
            cfg=Cfgs.CfgFurnitureTheme:GetByID(id);
        end
    elseif data.spType==2 then
        cfg=data.cfg
    end
    -- CSAPI.SetGOActive(quality,false)
    -- 读取图标
    LoadIcon();
    -- 限时物品
    SetLimit();
    SetDorm();
end

function SetDorm()
    local isPlay=false;
    local comfort=0;
    if cfg then
        comfort=cfg.comfort
        isPlay=cfg.inteActionId~=nil
    end
    CSAPI.SetText(txtDorm,tostring(comfort));
    CSAPI.SetGOActive(dormIcon1,isPlay)
    CSAPI.SetGOActive(dormTag,comfort>0);
end

function SetLimit()
    if commodity then
        local isShow = false;
        if getData then
            local tips = getData.data:GetIconDayTips();
            isShow = tips ~= nil;
            CSAPI.SetText(txtLimit, tips or "");
        end
        CSAPI.SetGOActive(limitObj, isShow);
    else
        CSAPI.SetGOActive(limitObj, false);
    end
end

function LoadIcon()
    if data.spType==2 or (commodity~=nil and commodity:GetType()==CommodityItemType.THEME) then
        imgDatas = {}
        if (cfg.PromoImage) then
            for k, v in ipairs(cfg.PromoImage) do
                local str = cfg.id .. "/" .. v
                table.insert(imgDatas, str)
            end
        end
        layout:IEShowList(#imgDatas)
    end
end