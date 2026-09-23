local isBuy = false
local cfg = nil
local comm = nil
local isShow = false

local layout1 = nil
local layout2 = nil
local curDatas = nil
local priceItem = nil

function Awake()
    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    layout1:Init("UIs/RegressionActivity7/RegressionRebateItem2", LayoutCallBack1, true)

    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/RegressionActivity7/RegressionRebateItem3", LayoutCallBack2, true)

    SetShow()
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    isShow = b
    if isBuy then
        isShow = true
    end
    SetShow()
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data, true)
    end
end

function Refresh(_data, _elseData)
    cfg = _data
    isBuy = _elseData
    if isBuy then
        isShow = true
    end
    if cfg then
        comm = ShopMgr:GetFixedCommodity(cfg.shopId)
        SetTitle()
        SetIcon()
        SetPrice()
        SetShow()
        SetWidth()
    end
end

function SetIcon()
    local iconName = "icon_0" .. cfg.level
    if iconName and iconName ~= "" then
        ResUtil.Regression:Load(icon, iconName)
    end
end

function SetTitle()
    CSAPI.SetGOActive(titleObj1,not isBuy)
    if comm then
        local list = comm:GetCommodityList()
        if list and list[1] then
            local goodsData = list[1].data
            local iconName = goodsData:GetIcon()
            if iconName and iconName ~= "" then
                ResUtil.IconGoods:Load(goodIcon1, iconName .. "_1")
                ResUtil.IconGoods:Load(goodIcon2, iconName .. "_1")
            end
            CSAPI.SetText(txtNum1, list[1].num .. "")
            CSAPI.SetText(txtNum2, (list[1].num + GetInfoNum()) .. "")
        end
    end
end

function GetInfoNum()
    local num = 0
    if cfg.infos then
        for i, v in ipairs(cfg.infos) do
            if v.reward and v.reward[1] then
                num = num + v.reward[1][2]
            end
        end
    end
    return num
end

function SetPrice()
    CSAPI.SetGOActive(priceParent, not isBuy)
    CSAPI.SetGOActive(txt_select, isBuy)
    if not isBuy and comm then
        priceItem = ShopCommFunc.InitPriceItem(comm, priceParent, priceItem, "ShopComm/ShopPriceItem3");
            end
        end

function SetWidth()
    if isBuy then
        CSAPI.SetRectSize(node, 1289, 582)
    end
end

function SetShow()
    CSAPI.SetScale(showImg, isShow and -1 or 1, 1, 1)
    CSAPI.SetGOActive(vsv1, isShow and not isBuy)
    CSAPI.SetGOActive(vsv2, isShow and isBuy)
    if isShow then
        SetSV()
    end
end

function SetSV()
    curDatas = {}
    if cfg.infos then
        local info = RegressionMgr:GetRebateInfo()
        local arr = info and info.gainArr or nil
        for i, v in ipairs(cfg.infos) do
            local data = {
                cfg = v
            }
            if arr then
                data.isGet = arr[v.idx] and arr[v.idx] == 1
                data.isFinish = info.day >= v.param
            end
            table.insert(curDatas,data)
        end
        if #curDatas > 0 and arr then
            table.sort(curDatas, function(a, b)
                if a.isGet == b.isGet then
                    if a.isFinish == b.isFinish then
                        return a.cfg.idx < b.cfg.idx
                    else
                        return a.isFinish
                    end
                else
                    return not a.isGet
                end
            end)
        end
    end
    if isBuy then
        layout2:IEShowList(#curDatas)
    else
        layout1:IEShowList(#curDatas)
    end
end

function OnClickShow()
    if cb then
        cb(this)
    end
end

function OnClickBuy()
    if isBuy then
        return
    end
    local key = (comm:GetCfg() and comm:GetCfg().jCosts ~= nil) and ShopPriceKey.jCosts or ShopPriceKey.jCosts1
    ShopCommFunc.HandlePayLogic(comm, 1, nil, OnBuySuccess, key)
end

function OnBuySuccess()
    -- EventMgr.Dispatch(EventType.Regression_Rebate_Refresh)
end

function IsShow()
    return isShow
end

function SetRTAnim(b)
    UIUtil:SetObjSizeDelta(node,b and 370 or 970,b and 970 or 370,582,582,nil,300)
end

function SetMoveAnim(b)
    local x,y = CSAPI.GetLocalPos(gameObject)
    UIUtil:SetPObjMove(gameObject,x,x+(b and 606 or -606),y,y,0,0,nil,150)
end