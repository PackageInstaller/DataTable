local curTabIndex = 1 -- 1:主题 2：家具
local curLIndex = 1 -- 左侧第几个

function Awake()
    sr_sv = ComUtil.GetCom(sv, "ScrollRect")

    cg_buy = ComUtil.GetCom(btnBuy, "CanvasGroup")

    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    layout1:Init("UIs/Dorm2/DormShopLItem", LayoutCallBack1, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)

    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/Dorm2/DormShopRItem", LayoutCallBack2, true)
    tlua2 = UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.Diagonal)

    UIUtil:AddTop2("DormShop", gameObject, function()
        view:Close()
    end, nil, {10013, 10002})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Dorm_Theme_Buy, RefreshPanel)
    eventMgr:AddListener(EventType.Dorm_Furniture_Buy, RefreshPanel)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curLDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB1)
        lua.Refresh(curTabIndex, _data, curLIndex, GetCount(index))
    end
end
function ItemClickCB1(index)
    curLIndex = index
    RefreshPanel()
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curRDatas[index]
        lua.Refresh(_data)
    end
end

function OnOpen()
    InitFuritureDic()

    -- 先请求系统主题
    local sysDatas = DormMgr:GetThemes(ThemeType.Sys)
    if (sysDatas == nil) then
        DormProto:GetSelfTheme({ThemeType.Sys}, function()
            RefreshPanel()
        end)
    else
        RefreshPanel()
    end
end

function RefreshPanel()
    SetTab()
    SetLDatas()
    SetRightDatas()

    -- 换了页
    local isChangeTab = false
    if (oldTabIndex and oldTabIndex ~= curTabIndex) then
        isChangeTab = true
        tlua1:AnimAgain()
    end
    oldTabIndex = curTabIndex

    local isChangeLIndex = false
    if (isChangeTab or (oldLIndex and oldLIndex ~= curLIndex)) then
        isChangeLIndex = true
    end
    oldLIndex = curLIndex
    -- L 
    layout1:IEShowList(#curLDatas)

    -- R 
    if (curTabIndex == 1) then
        if (isChangeLIndex) then
            sr_sv.velocity = UnityEngine.Vector2.zero
            CSAPI.SetAnchor(Content1, 0, 0, 0)
        end
        rThemeItems = rThemeItems or {}
        ItemUtil.AddItems("Dorm2/DormShopRNodeItem", rThemeItems, curRDatas, Content1) -- 1行4个 
    else
        if (isChangeLIndex) then
            tlua2:AnimAgain()
        end
        layout2:IEShowList(#curRDatas)
    end
end

function SetTab()
    tabItems = tabItems or {}
    ItemUtil.AddItems("Dorm2/DormShopTabItem", tabItems, {32018, 32021}, headNode, TabItemClickCB, 1, curTabIndex)
end
function TabItemClickCB(_index)
    curLIndex = 1
    curTabIndex = _index
    RefreshPanel()
end

-- 家具表==》家具字典 key：stype value:id列表
function InitFuritureDic()
    if (not furnitureDic) then
        furnitureDic = {}
        local _furnitureDic = {}
        local cfgs = Cfgs.CfgFurniture:GetAll()
        local themeHideDic = DormMgr:ThemeHideDic()
        for k, v in pairs(cfgs) do
            if (not _furnitureDic[v.sType]) then
                _furnitureDic[v.sType] = {}
            end
            --不是隐藏的主题,不是特殊家具
            if(not themeHideDic[v.theme] and not v.special) then 
                table.insert(_furnitureDic[v.sType], v.id)
            end 
        end
        for k, v in pairs(_furnitureDic) do
            local tab = v
            if (#tab > 1) then
                table.sort(tab, function(a, b)
                    return a < b
                end)
            end
            furnitureDic[k] = tab
        end
    end
end

function SetLDatas()
    curLDatas = {}
    if (curTabIndex == 1) then
        local _curLDatas = {}
        local cfgs = Cfgs.CfgFurnitureTheme:GetAll()
        for k, v in pairs(cfgs) do
            if (DormMgr:CheckIsOpen(v) and not v.hide) then
                table.insert(_curLDatas, v)
            end
        end
        if (#_curLDatas > 1) then
            table.sort(_curLDatas, function(a, b)
                return a.id < b.id
            end)
        end
        curLDatas = _curLDatas
    else
        local cfgs = Cfgs.CfgFurnitureEnum:GetAll()
        curLDatas = cfgs
    end
end

function SetRightDatas()
    CSAPI.SetGOActive(sv, curTabIndex == 1)
    CSAPI.SetGOActive(vsv2, curTabIndex ~= 1)
    CSAPI.SetGOActive(btnBuy, curTabIndex == 1)

    curRDatas = {}
    if (curTabIndex == 1) then
        -- alpha 
        SetBtnAlpha()
        -- 
        local _themeArr = GetThemeDic(curLIndex)
        curRDatas = _themeArr
    else
        local id = curLDatas[curLIndex].id
        curRDatas = furnitureDic[id - 1] or {}
    end
end

function SetBtnAlpha()
    local curTheme = curLDatas[curLIndex]
    local themeData = DormMgr:GetThemesByID(ThemeType.Sys, curTheme.id)
    isBuy = themeData ~= nil
    cg_buy.alpha = isBuy and 0.3 or 1
end

function GetThemeDic(index)
    themeDic = themeDic or {}
    if (not themeDic[index]) then
        -- 按类型分类数据
        local cfg = curLDatas[index]
        local cfgLayout = Cfgs.CfgThemeLayout:GetByID(cfg.layoutId)
        local _typeDic = {}
        local _dic = {}
        for k, v in pairs(cfgLayout.infos) do
            if (not _dic[v.cfgID]) then
                _dic[v.cfgID] = 1
                local furCfg = Cfgs.CfgFurniture:GetByID(v.cfgID)
                if(not furCfg.special) then 
                    if (not _typeDic[furCfg.sType]) then
                        _typeDic[furCfg.sType] = {}
                    end
                    table.insert(_typeDic[furCfg.sType], v.cfgID)
                end 
            end
        end
        -- 筛查存在的类型
        local typeDic = {}
        local cfgs = Cfgs.CfgFurnitureEnum:GetAll()
        for k, v in ipairs(cfgs) do
            if (_typeDic[v.id - 1]) then
                local tab = _typeDic[v.id - 1]
                table.sort(tab, function(a, b)
                    return a < b
                end)
                table.insert(typeDic, tab)
            end
        end
        themeDic[index] = typeDic
    end
    return themeDic[index]
end

function GetCount(lIndex)
    local num = 0
    if (curTabIndex == 1) then
        local _themeArr = GetThemeDic(lIndex)
        for k, v in ipairs(_themeArr) do
            num = num + #v
        end
    else
        local id = curLDatas[lIndex].id
        local ids = furnitureDic[id - 1] or {}
        num = #ids
    end
    return num
end

-- 全套购买
function OnClickBuy()
    if (not isBuy) then
        -- CSAPI.OpenView("DormThemePayView", curLDatas[curLIndex].id)
        CSAPI.OpenView("ShopPayView",{id=curLDatas[curLIndex].id,spType=2} )
    end
end
