-- 皮肤商店
local eventMgr = nil;
local currComm = nil; -- 当前的皮肤商品
local pageData = nil;
local childPageID = nil;
local layout = nil;
local curDatas = nil;
local targetSID = nil;
local currPic = nil; -- 图册信息类
local layoutTween = nil;
local isShowImg = false;
local l2dOn = true;
local roleItem = nil;
local lastTime = 0;
local timerKey = nil
local card = nil;
local currIdx = 1;
local hasL2d = false;
local sr = nil;
local noneItem=nil;
local isTween=false;
local totalWidth=0; --sv可视区域的宽度
local width=478;--单个的宽度
local lineWidth=20;--间隔宽度
local maxShowNum=0;--折算的最大显示数量
local moveX=0;--移动位置
local svMoveTween=nil  --移动动画脚本
local tagList={};
g_FHXOpenPicture = false;

function Awake()
    layout = ComUtil.GetCom(sv, "UISV");
    sr = ComUtil.GetComInChildren(sv, "ScrollRect");
    layout:Init("UIs/ShopSkinPage/AtlasCommodityItem", LayoutCallBack, true)
    layoutTween = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.CustomTween, {
        funcName = "PlayEntry",
        delay = 48
    });
    svMoveTween=ComUtil.GetCom(svTween,"ActionUIMoveTo")
    local size=CSAPI.GetRealRTSize(sv);
    totalWidth=size[0];
    maxShowNum=math.floor((totalWidth-18)/(width+lineWidth))
    roleItem = RoleTool.AddRole(cNode, nil, nil, false)
    eventMgr = ViewEvent.New();
    SetOffset(AdaptiveConfiguration.GetOrientation());
end

function OnEnable()
    eventMgr:AddListener(EventType.Screen_Rotation_Occurs,OnScreenRotation)
end

function OnDisable()
    eventMgr:ClearListener();
    CleanCache();
end

function OnDestroy()
    eventMgr=nil;
end

function SetPlayTween(_isTween)
    isTween=_isTween
end

function OnScreenRotation(orientation)
    SetOffset(orientation);
end

function SetOffset(orientation)
    local offset=0;
    if orientation==UnityEngine.ScreenOrientation.LandscapeLeft or orientation==UnityEngine.ScreenOrientation.Portrait then --设置左边遮罩默认值
        offset=CSAPI.UIFitoffsetTop()*-1
    end
    CSAPI.SetAnchor(leftMask,offset,0);
end

function GetIsTween()
    return isTween;
end

function Refresh(_pageData, _topTabID, _selID)
    pageData = _pageData;
    childPageID = _topTabID;
    targetSID = _selID;
    if pageData == nil then
        do
            return
        end
    end
    timerKey = childPageID and pageData:GetID() .. "_" .. childPageID or pageData:GetID()
    local cfg=Cfgs.CfgShopTab:GetByID(childPageID);
    curDatas = pageData:GetCommodityInfos(true, childPageID);
    if isTween then
        layout:AnimAgain()
        if IsNil(roleItem)~=true then
            CSAPI.SetGOAlpha(roleItem.gameObject,1);
        end
        EventMgr.Dispatch(EventType.Shop_Tween_Mask,true)
    end
    if #curDatas>0 then
        table.sort(curDatas,function(a,b)
                local pic1=GetPicInfo(a);
                local pic2=GetPicInfo(b);
                local hasNum=pic1:IsHad() and 1 or 0;
                local hasNum2=pic2:IsHad() and 1 or 0;
                if hasNum ~= hasNum2 then
                    return hasNum < hasNum2;
                else
                    return ShopCommFunc.SortComm(a,b);
                end
        end)
        InitList();
    else
        EventMgr.Dispatch(EventType.Shop_Tween_Mask,false)
    end
    SetNone(#curDatas==0);
    CSAPI.SetGOActive(root,#curDatas>0)
end

--刷新当前选中的商品
function RefreshCurr()
    if curDatas~=nil and currIdx and #curDatas>currIdx then
        layout:UpdateOne(currIdx);
        InitContent();
    end    
end

function GetPicInfo(_comm)
    local pic=nil;
    if _comm then
        local getList = _comm:GetCommodityList();
        if getList then
            for k, v in ipairs(getList) do
                local type = v.data:GetType();
                if type == ITEM_TYPE.PANEL_IMG then -- 多人插图,特殊处理
                    pic = MulPicMgr:GetData(v.data:GetDyVal1());
                    break
                end
            end
        end
    end
    return pic;
end

function SetNone(isNone)
    if noneItem then
        noneItem.Refresh(pageData,isNone);
    else
        ResUtil:CreateUIGOAsync("ShopComm/ShopNonePage",gameObject,function(go)
            noneItem=ComUtil.GetLuaTable(go)
            noneItem.Refresh(pageData,isNone);
        end)
    end
end

function InitList()
    -- 初始化当前选中的皮肤ID
    for k, v in ipairs(curDatas) do
        if (targetSID ~= nil and v:GetID() == targetSID) or (targetSID == nil and k == 1) then
            currIdx = k;
            currComm = curDatas[k];
            InitContent();
            break
        end
    end
    layout:IEShowList(#curDatas,function()
        isTween=false;
        EventMgr.Dispatch(EventType.Shop_Tween_Mask,false)
    end,currIdx)
end

function InitContent()
    if currComm == nil then
        do
            return
        end
    end
    currPic=GetPicInfo(currComm)
    local useL2d = false;
    hasL2d = currPic:GetL2dName() ~= nil;
    isShowImg = false;
    if g_FHXOpenPicture ~= true then
        useL2d = l2dOn;
        if currComm and currComm:IsShowImg() then
            useL2d = false;
            isShowImg = true;
            CSAPI.SetGOActive(btnAction, false);
        else
            CSAPI.SetGOActive(btnAction, hasL2d);
        end
    else
        l2dOn = false;
        CSAPI.SetGOActive(btnAction, false);
    end
    -- 初始化立绘
    roleItem.Refresh(currPic:GetID(), LoadImgType.SkinFull, nil, useL2d, isShowImg)
    -- 初始化L2D按钮状态
    SetL2DState(useL2d);
    -- 设置信息
    CSAPI.SetText(txtSName, currPic:GetName());
    local sName="";
    if currPic:GetType()==1 then
        local tCfg = Cfgs.CfgMultiImageThemeType:GetByID(currPic:GetThemeType())
        sName= tCfg.sName or "";
    elseif currPic:GetType()==2 then
        local tCfg = Cfgs.CfgHalfBodyType:GetByID(currPic:GetHalfBodyType())
        sName= tCfg.sName or "";
    end
    CSAPI.SetText(txtRName, sName);
    if currComm:IsOver() then
        lastTime=0
        CSAPI.SetText(txtTime,LanguageMgr:GetByID(18510));
        EventMgr.Dispatch(EventType.Shop_Timer_Remove, timerKey)
    else
        -- 倒计时
        lastTime = currComm:GetEndBuyTime();
        if lastTime > 0 then
            ShowTime();
            EventMgr.Dispatch(EventType.Shop_Timer_Add, {
                key = timerKey,
                func = SetTimeUpdate,
                isLoop = true
            })
        elseif lastTime==0 then
            CSAPI.SetText(txtTime, LanguageMgr:GetByID(18198));
            EventMgr.Dispatch(EventType.Shop_Timer_Remove, timerKey)
        end
    end
    SetPriceNode();
    SetTags(isTween);
end

function SetTags(playTween)
    local list =currComm and currComm:GetTagsData(true) or {}; 
    ItemUtil.AddItems("ShopComm/CommodityTag", tagList, list, tagNode2, nil, 1,playTween);
end

function SetPriceNode()
    local has = currPic:IsHad();
    if has then
        CSAPI.SetGOActive(payNode2, false);
        CSAPI.SetGOActive(payNode1, false);
        CSAPI.SetGOActive(payNode3, true);
        if currComm and currComm:IsOver() then
            CSAPI.SetText(txtSuit,LanguageMgr:GetByID(18199));
        else
            CSAPI.SetText(txtSuit,LanguageMgr:GetByID(18205));
        end
    else
        -- 判断商品是否在购买期限内
        local isBtnShow = currComm:GetNowTimeCanBuy()
        local costs = currComm:GetRealPrice();
        local rmbIcon = currComm:GetCurrencySymbols();
        local SDKdisplayPrice = currComm:GetSDKdisplayPrice();
        if isBtnShow and currComm and currComm:HasOtherPrice(ShopPriceKey.jCosts1) then
            local costs2 = currComm:GetRealPrice(ShopPriceKey.jCosts1);
            CSAPI.SetGOActive(payNode1, false);
            CSAPI.SetGOActive(payNode2, true);
            CSAPI.SetGOActive(payNode3, false);
            SetPrice(txtRmb, pIconObj1, pIcon1, txtPVal1,txtFree2, costs, rmbIcon, SDKdisplayPrice)
            SetPrice(txtRmb2, pIconObj2, pIcon2, txtPVal2,txtFree3, costs2, rmbIcon, SDKdisplayPrice)
        elseif isBtnShow and currComm then
            CSAPI.SetGOActive(payNode1, true);
            CSAPI.SetGOActive(payNode2, false);
            CSAPI.SetGOActive(payNode3, false);
            SetPrice(txtSRmb, pSIconObj, pSIcon, txtSPVal,txtFree1, costs, rmbIcon, SDKdisplayPrice)
        else
            CSAPI.SetGOActive(payNode1, false);
            CSAPI.SetGOActive(payNode2, false);
            CSAPI.SetGOActive(payNode3, false);
        end
    end
end

function SetPrice(_txtRmb, _iconObj, _icon, _txtPrice,_txtFree, costs, rmbIcon, SDKdisplayPrice)
    if costs == nil or (#costs == 1 and costs[1].num <= 0) then
        CSAPI.SetText(_txtFree,LanguageMgr:GetByID(18032));
        CSAPI.SetGOActive(_txtPrice,false)
        CSAPI.SetGOActive(_txtFree,true)
        CSAPI.SetGOActive(_txtRmb,false);
        CSAPI.SetGOActive(_iconObj,false);
    else
        CSAPI.SetGOActive(_txtFree,false)
        CSAPI.SetGOActive(_txtPrice,true)
        CSAPI.SetGOActive(_txtRmb,costs[1].id==-1);
        CSAPI.SetGOActive(_iconObj,costs[1].id~=-1);
        if costs[1].id == -1 then
            ---价格显示，如果没有就不显示
            CSAPI.SetText(_txtRmb, rmbIcon)
            if CSAPI.IsADV() then
                if SDKdisplayPrice ~= nil then
                    CSAPI.SetText(_txtPrice, tostring(SDKdisplayPrice or costs[1].num));
                end
            else
                CSAPI.SetText(_txtPrice, tostring(costs[1].num));
            end
        else
            local extend=nil
            if costs[1].id==ITEM_ID.GOLD then
                extend="_2"
            elseif costs[1].id==ITEM_ID.DIAMOND then
                extend="_3"
            end
            ShopCommFunc.SetPriceIcon(_icon,costs[1],extend);
            CSAPI.SetText(_txtPrice, tostring(costs[1].num))
        end
    end
end

---滑动逻辑
local holdDownTime = 0
local holdTime = 0.1
local startPosX = 0
local tweenTime=0.5;
local endMoveTime=0;

function OnPressDown(isDrag, clickTime)
    holdDownTime = Time.unscaledTime
    startPosX = CS.UnityEngine.Input.mousePosition.x
end

function OnPressUp(isDrag, clickTime)
    if Time.unscaledTime -endMoveTime <tweenTime or curDatas==nil or (curDatas and #curDatas==0)  then
        do return end
    end
    if Time.unscaledTime - holdDownTime >= holdTime then
        local len = CS.UnityEngine.Input.mousePosition.x - startPosX
        if (math.abs(len) > 100) then
            local lastIndex = currIdx
            local index = currIdx
            if (len > 0) then
                -- 图片左移
                index = currIdx - 1 <= 1 and 1 or currIdx - 1;
                if index~=currIdx then
                    PlayMoveTween(index, true);
                end
            else
                -- 图片右移
                index = currIdx + 1 >= #curDatas and #curDatas or currIdx + 1;
                if index~=currIdx then
                    PlayMoveTween(index);
                end
            end
            if index ~= currIdx and index > 0 and index <= #curDatas then
                endMoveTime=Time.unscaledTime;
                MoveOffset(len > 0, index, function()
                    -- 更新选中物体并设置移动
                    local item1 = layout:GetItemLua(lastIndex);
                    local item2 = layout:GetItemLua(index);
                    if item1 then
                        item1.SetSelect(false, true);
                    end
                    -- LogError(tostring(item2==nil).."\t"..tostring(lastIndex).."\t"..tostring(index))
                    if item2 then
                        item2.SetSelect(true, true);
                    end
                end)
            end
        end
    end
end

-- Sr偏移量移动
function MoveOffset(isRTL, nextIdx, func)
    local indexs = layout:GetIndexs()
    local state = 2;
    local len = indexs.Length;
    for i = 0, len - 1 do
        if indexs[i] == nextIdx then
            -- LogError(i.."\t"..tostring(isRTL).."\t"..tostring(nextIdx))
            if i==0 or (indexs[i]>=maxShowNum+1 and (i>=maxShowNum-1)) then
                state = 3;
            else
                state = 1
            end
            break
        end
    end
    if state >= 2 then -- 需要移动
        -- 获取当前SR位置
        sr.velocity = UnityEngine.Vector.zero;
        local x1, y1 = CSAPI.GetAnchor(srContent)
        local size = CSAPI.GetRTSize(srContent);
        local moveIndex = nextIdx;
        if state == 3 then
            -- moveIndex=isRTL and indexs[0] or indexs[0]-1;
            moveIndex = isRTL and indexs[0] or moveIndex-(maxShowNum-1);
            if moveIndex <= 1 then
                moveIndex = 1
            elseif moveIndex > #curDatas then
                moveIndex = #curDatas;
            end
        end
        local x2 = moveIndex > 1 and (moveIndex - 1) * 478  or 0
        if not IsNil(sr) then
            local item = layout:GetItemLua(moveIndex)
            -- LogError(tostring(item and item.data:GetName() or "无预制体").."\tnextIndex:"..tostring(nextIdx).."\tmoveIndex:"..tostring(moveIndex).."\twidth:"..tostring(size[0]).."\tx1:"..tostring(x1).."\tx2:"..tostring(x2).."\t"..tostring(x2/size[0]).."\tmaxNum:"..tostring(maxShowNum))
            --播放动画
            svMoveTween:SetStartPos(x1,0);
            svMoveTween:SetTargetPos(x2*-1,0);
            svMoveTween:Play(func);
        end
    elseif func ~= nil then
        func();
    end
end

-- 播放立绘移动动画 isRTL:是否从右到左
function PlayMoveTween(index, isRTL)
    local x1 = 0
    local x2 = isRTL and 400 or -400
    -- LogError(tostring(isShowImg))
    if (not isShowImg and hasL2d) then
        UIUtil:SetObjFade(roleItem.gameObject, 1, 0, nil, 1, 300, 1)
    else
        UIUtil:SetObjFade(roleItem.gameObject, 1, 0, nil, 300, 1, 1)
    end
    UIUtil:SetPObjMove(roleItem.gameObject, x1, x2, 0, 0, 0, 0, function()
        SetCurrIndex(index);
        if (not isShowImg and hasL2d) then
            UIUtil:SetObjFade(roleItem.gameObject, 0, 1, nil, 1, 300, 0)
        else
            UIUtil:SetObjFade(roleItem.gameObject, 0, 1, nil, 300, 1, 0)
        end
        UIUtil:SetPObjMove(roleItem.gameObject, -x2, x1, 0, 0, 0, 0, nil, 300, 1)
    end, 301, 1)
end

function ShowTime()
    local timeStr = ""
    if lastTime >= 86400 then
        local nowTime = TimeUtil:GetTime();
        local count = TimeUtil:GetDiffHMS(lastTime + nowTime, nowTime);
        timeStr = LanguageMgr:GetByID(34025)..LanguageMgr:GetByID(34017, count.day >= 10 and count.day or "0" .. count.day,
            count.hour >= 10 and count.hour or "0" .. count.hour,
            count.minute >= 10 and count.minute or "0" .. count.minute,
            count.second >= 10 and count.second or "0" .. count.second);
    else
        timeStr = string.format("%s<color=#%s>%s</color>", LanguageMgr:GetByID(34025), "fc3636",
            TimeUtil:GetTimeStr(lastTime));
    end
    CSAPI.SetText(txtTime, timeStr);
end

function SetTimeUpdate()
    lastTime = lastTime - 1 > 0 and lastTime - 1 or 0;
    ShowTime();
    SetTags(isTween);
    -- 显示时间
    if lastTime <= 0 then
        lastTime = 0;
        EventMgr.Dispatch(EventType.Shop_Timer_Remove, timerKey)
    end
end

function SetL2DState(isOn)
    if isOn then
        CSAPI.SetAnchor(onImg, 22, -3);
        CSAPI.SetImgColorByCode(onObj, "FFFFFF");
    else
        CSAPI.SetAnchor(onImg, -16, -3);
        CSAPI.SetImgColorByCode(onObj, "767679");
    end
end

function SetCurrIndex(index)
    if (currIdx ~= index) then
        currIdx = index;
        currComm = curDatas[index];
        InitContent();
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index);
    local isSel = index == currIdx;
    item.Refresh(_data, isSel);
    item.SetIndex(index)
    item.SetClickCB(OnClickItem);
end

function OnClickItem(tab)
    if tab == nil then
        do
            return
        end
    end
    if currIdx ~= tab.index then
        local item1 = layout:GetItemLua(currIdx);
        local item2 = layout:GetItemLua(tab.index);
        if item1 then
            item1.SetSelect(false, true);
        end
        if item2 then
            item2.SetSelect(true, true);
        end
        SetCurrIndex(tab.index)
    end
end

function OnClickRmb()
    OnOpenPay(ShopPriceKey.jCosts);
end

function OnClickBuy2()
    OnOpenPay(ShopPriceKey.jCosts1);
end

function OnClickBuy()
    OnOpenPay(ShopPriceKey.jCosts);
end

function OnClickSuit()
    local has=currPic and currPic:IsHad() or false;
    if has then
        Tips.ShowTips(LanguageMgr:GetTips(15132));
    end
end

function OnOpenPay(shopPriceKey)
    local has=currPic and currPic:IsHad() or false;
    if currComm and has~=true then
        ShopCommFunc.OpenPayView(currComm,nil,nil,shopPriceKey);
    elseif has then

    end
end

-- 切换动态按钮
function OnClickAction()
    l2dOn = not l2dOn;
    InitContent();
end

function CleanCache()
    currComm = nil; -- 当前的皮肤商品
    pageData = nil;
    childPageID = nil;
    curDatas = nil;
    targetSID = nil;
    currPic = nil; -- 皮肤信息类
    isShowImg = false;
    l2dOn = true;
    lastTime = 0;
    timerKey = nil
    card = nil;
    currIdx = 1;
    hasL2d = false;
    -- sr = nil;
end
