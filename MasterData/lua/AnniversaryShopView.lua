local data = nil
local layout = nil
local curDatas = nil
function Awake()
    layout = ComUtil.GetCom(hsv, "UISV")
    layout:Init("UIs/Shop/VCommodityItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()    
    eventMgr:AddListener(EventType.Shop_Buy_Ret,OnBuyRet)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index);
    if lua then
        local _data = curDatas[index];
        local shopData = ShopMgr:GetPageByID(_data:GetShopID())
        lua.SetClickCB(OnClickPackage)
        lua.Refresh(_data,{commodityType=shopData:GetCommodityType(),showType=shopData:GetShowType()})
    end
end

--点击礼包类型展示的商品
function OnClickPackage(lua)
    -- local shopData = ShopMgr:GetPageByID(lua.data:GetShopID())
    ShopCommFunc.OpenPayView(lua.data);
end

function OnBuyRet()
    SetDatas()
    SetItems()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(_data)
    data = _data
    if data then
        SetDatas()
        SetTop()
        SetItems()
    end
end

function SetDatas()
    local ids = data:GetCommodityId()
    if ids then
        curDatas = {}
        for i, v in ipairs(ids) do
            local comm = ShopMgr:GetFixedCommodity(v)
            if comm:IsShow() and comm:GetNowTimeCanBuy() then
                table.insert(curDatas,comm)
            end
        end
    end
end

function SetTop()
    SetText(txtTitle,data:GetName())
    -- local sTime,eTime = data:GetStartTime(),data:GetEndTime()
    -- SetText(txtTime,TimeUtil:GetTimeHMS(sTime,"%m.%d %H:%M") .. "-" .. TimeUtil:GetTimeHMS(eTime,"%m.%d %H:%M"))
end

function SetText(obj, str)
    if obj and not IsNil(obj.gameObject) then
        str = str or ""
        CSAPI.SetText(obj.gameObject, str)
    end
end

function SetItems()
    if curDatas then
        layout:IEShowList(#curDatas)
    end
end