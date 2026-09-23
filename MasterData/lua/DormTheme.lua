--[[	主题购买界面，此界面不仅仅使用于系统主题
	1、系统主题
	2、排行榜她人数据
	3、房间数据(仅看)
]] function Awake()
    UIUtil:AddTop2("DormTheme", gameObject, function()
        view:Close()
    end, nil, {})

    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Dorm/DormThemeItem", LayoutCallBack, true)

    InitData()
end

function OnInit()
    eventMgr:AddListener(EventType.Dorm_Furniture_Buy, OnOpen)
end
function OnDestroy()
    eventMgr:ClearListener()
end
function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data.id, _data.needNum)
    end
end

-- function SetCBs(_lrCB)
-- 	lrCB = _lrCB
-- end
-- function SetLen(_curLen, _maxLen)
-- 	curLen = _curLen
-- 	maxLen = _maxLen
-- end
function InitData()
    if (not dormThemeData) then
        local DormThemeData = require "DormThemeData"
        dormThemeData = DormThemeData.New()
    end
end

-- sys:{cfg.id, DormThemeOpenType.Shop}) ; isRoom and {_data, DormThemeOpenType.Room} or {_data, DormThemeOpenType.Theme, AllBuyCB}
function OnOpen()
    openType = data[2]
    allBuyCB = data[3]
    SetDormThemeData()
    RefreshPanel()
end

-- 根据类似初始化房间数据
function SetDormThemeData()
    if (openType == DormThemeOpenType.Shop) then
        themeID = data[1]
        dormThemeData:InitDataByCfgID(themeID)
        cfg = dormThemeData:GetCfg()
        dormThemeData:SetInfos(cfg.sName, cfg.icon, cfg.desc, cfg.sEnName)
    elseif (openType == DormThemeOpenType.Theme) then
        local theme = data[1]
        dormThemeData:InitDataBuyThemeData(theme)
        dormThemeData:SetInfos(theme.name, theme.img)
        -- tips
        -- SetTips()
    elseif (openType == DormThemeOpenType.Room) then
        local roomData = data[1]
        dormThemeData:InitByFurnitureDatas(roomData:GetFurnitures())
        dormThemeData:SetInfos(roomData:GetName(), roomData:GetImg())
    end
end

-- function SetTips()
-- 	local isBuy = dormThemeData:CheckIsBuy()
-- 	local showTips = dormThemeData:CheckTips()
-- 	CSAPI.SetGOActive(tips, isBuy and showTips)
-- end

function RefreshPanel()
    -- CSAPI.SetGOActive(btnL, maxLen and maxLen > 1) --左右切换页签
    -- CSAPI.SetGOActive(btnR, maxLen and maxLen > 1)
    -- left
    SetLeft()
    -- right
    SetRight()
    -- lrbtn
    -- SetLRBtns()
end

function SetLeft()
    if (not isFirst) then
        isFirst = true
        curDatas = dormThemeData:Arr()
        layout:IEShowList(#curDatas)
    else
        layout:UpdateList()
    end
end

function SetRight()
    -- name
    local str1, str2 = dormThemeData:GetName()
    CSAPI.SetText(txtName1, str1)
    CSAPI.SetText(txtName2, str2)
    -- desc
    local strDesc = dormThemeData:GetDesc()
    CSAPI.SetGOActive(descObj, not StringUtil:IsEmpty(strDesc))
    CSAPI.SetText(txtDesc, strDesc)
    -- icon
    if (openType == DormThemeOpenType.Shop) then
        ResUtil:LoadBigImg(icon, "UIs/Dorm/" .. cfg.icon, true)
        CSAPI.SetScale(icon, 2, 2, 1)
    else
        DormIconUtil.SetIcon(icon, dormThemeData:GetIcon())
        CSAPI.SetScale(icon, 3, 3, 1)
    end
    -- spend,btn 
    if (openType ~= DormThemeOpenType.Room) then
        local isBuy = dormThemeData:CheckIsBuy()
        CSAPI.SetGOActive(spend, not isBuy)
        CSAPI.SetGOActive(btnBuy, not isBuy)
        if (not isBuy) then
            local str = dormThemeData:GetSpendStr()
            CSAPI.SetText(txtSpend2, str)
        end
    else
        CSAPI.SetGOActive(spend, false)
        CSAPI.SetGOActive(btnBuy, false)
    end
end

-- function SetLRBtns()
-- 	if(btnL.activeSelf) then
-- 		if(not lcgroup) then
-- 			lcgroup = ComUtil.GetCom(btnL, "CanvasGroup")
-- 		end
-- 		lcgroup.alpha = curLen == 1 and 0.5 or 1
-- 	end
-- 	if(btnR.activeSelf) then
-- 		if(not rcgroup) then
-- 			rcgroup = ComUtil.GetCom(btnR, "CanvasGroup")
-- 		end
-- 		rcgroup.alpha = curLen == maxLen and 0.5 or 1
-- 	end
-- end
function OnClickBuy()
    -- 购买主题
    local b, cost = dormThemeData:CheckIsEnough()
    if (b) then
        local cost = dormThemeData:GetCost()
        local name = Cfgs.ItemInfo:GetByID(cost.id).name
        local content = LanguageMgr:GetByID(32032, cost.num, name)
        UIUtil:OpenDialog(content, function()
            if (dormThemeData:CheckIsSys()) then
                -- 购买系统主题
                DormProto:BuyTheme(themeID,"")
                view:Close()
            else
                -- 购买别人的主题 直接购买家具
                local infos = dormThemeData:GetBuyList()
                DormProto:BuyFurniture(infos, "price_1", allBuyCB)
            end
        end)
    else
        LanguageMgr:ShowTips(21002)
    end
end
-- --全部购买回调
-- function SetAllBuyCB(_cb)
-- 	allBuyCB = _cb
-- end
-- function OnClickL()
-- 	if(curLen > 1) then
-- 		lrCB(true)
-- 	end
-- end
-- function OnClickR()
-- 	if(curLen < maxLen) then
-- 		lrCB(false)
-- 	end
-- end
