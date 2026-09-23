local RequestCooldownGuard = require "RequestCooldownGuard";
local ids={ ITEM_ID.GOLD,ITEM_ID.DIAMOND};--金币ID
local eventMgr=nil;
local svLayout=nil;
local curModule=nil;
local curLoadingInfo=nil;
local curKey=nil;
local pageDatas=nil;
local moduleViews={};--加载的子模块物体对象
local topTools=nil;--公用按钮
local currPageIndex=nil;
local currChildPageID=nil;--子页签页面ID
local isFirst=true;
local isTween=true;--控制除推荐页外的子页面下一次刷新时是否播放动画
local isJump=false;
local leftTabs={};  --一级菜单
local FirstEnterQuestionItem=false;
local showConfig={ --格式：ShowConfig=[商品类型(commodityType),table2] table2:[商品展示类型(showType),table] = 1
}
local layoutTween=nil;
local timerMgr=nil;
local lastPageIDs=nil;
local lastChildPageIDs=nil;
local timerInfos={};--计时器信息
local rTimerKey="ShopView"--检测商店页签是否刷新的计时器
local hasCloseTips=false;
local closeWindows=nil;
local selItemIdx=nil;
local singleMode=false;--单商店模式，活动商店用
local openMap={};
local openMap2={};
local childNodes={};
local autoRefreshGuard=nil;
local pendingResetRequest=nil;
local resetFailCount=3; --短期失败次数上限
local resetCooldownSeconds=900; --失败超过上限的冷却时间 秒
local resetTimeoutSeconds=30; --请求超时时间 秒
local delayTime=50;

function Awake()
    --商店bgm
    local bgm = g_bgm_shop;
    if(bgm)then
        CSAPI.PlayBGM(bgm);
    end
    svLayout = ComUtil.GetCom(leftsv, "UISV")
	svLayout:Init("UIs/Shop/ShopTabItem",LayoutCallBack,true)
    layoutTween=UIInfiniteUtil:AddUIInfiniteAnim(svLayout, UIInfiniteAnimType.CustomTween,{funcName="PlayEntry",delay=48});
    topTools=UIUtil:AddTop2("ShopView",gameObject,OnClickBack,nil,ids);
    AddEvents();
    InitShowConfig()
    --获取月卡信息
    ClientProto:GetMemberRewardInfo();
    ShopProto:GetShopResetTime();
    MenuBuyMgr:ConditionCheck(2,"shopOpen") --MenuMgr:ShopFirstOpen() --商店第一次打开记录 rui
    timerMgr=UITimerMgr.New();
    autoRefreshGuard=RequestCooldownGuard.New({
        maxFailCount=resetFailCount,
        cooldownSeconds=resetCooldownSeconds,
        timeoutSeconds=resetTimeoutSeconds
    });
end

function AddEvents()
    eventMgr = ViewEvent.New();
    -- eventMgr:AddListener(EventType.Shop_NewInfo_Refresh,SetNewInfo)
    eventMgr:AddListener(EventType.Shop_Tab_Change,OnPageChange)
    eventMgr:AddListener(EventType.Shop_TopTab_Change,OnTopTabChange)
    eventMgr:AddListener(EventType.Shop_Timer_Add,OnTimerAdd)
    eventMgr:AddListener(EventType.Shop_Timer_Remove,OnTimerRemove)
    eventMgr:AddListener(EventType.View_Lua_Opened,OnViewOpened);
    eventMgr:AddListener(EventType.Shop_OpenTime_Ret,OnOpenTimeRet)
    eventMgr:AddListener(EventType.Shop_View_Refresh,Refresh)
    eventMgr:AddListener(EventType.Shop_Buy_Ret,OnBuyRet)
    eventMgr:AddListener(EventType.Shop_Exchange_Ret,OnExchangeRet)
    eventMgr:AddListener(EventType.Shop_ResetTime_Ret,OnResetTimeRet)
    eventMgr:AddListener(EventType.Shop_Jump_Refresh,OnJumpRefresh)
    eventMgr:AddListener(EventType.Shop_RecordInfos_Refresh,OnShopRecordInfosRefresh)
    eventMgr:AddListener(EventType.Shop_Tween_Mask,SetMask)
end

--data:传入商店页ID，只显示单个商店  openSetting={商店一级页面ID，商店二级页签ID},跳转时使用openSetting
function OnOpen()
    isTween=true;
    Init(openSetting);
    isJump=openSetting~=nil
    if openSetting and openSetting[3]~=nil and openSetting[3]~="" then --打开对应的购买窗口
        ShopCommFunc.OpenBuyConfrim(openSetting[1],openSetting[2],tonumber(openSetting[3]));
    end
    singleMode=data~=nil --活动商店
    CSAPI.SetGOActive(leftNode,singleMode~=true);
    if singleMode~=true then
        InitLeftTabs();
    end
    Refresh();
    delayTime=0;
    --添加商店刷新监听
    AddTimer(rTimerKey,CheckRefresh,true);
    isFirst=false;
end

function Refresh()
    InitChild();
    SetMoney();
end

--初始化左边一级菜单
function InitLeftTabs()
    if pageDatas~=nil and #pageDatas>=1 then
        svLayout:AnimAgain();
        svLayout:IEShowList(#pageDatas);
    end
end

function OnPageChange(eventData)
    if eventData and eventData~=currPageIndex then
        isTween=false;
        isJump=false;
        selItemIdx = nil;
        SetCurrPage(eventData)
        Refresh();
    end
end

function SetCurrPage(idx, isForceTween)
    if isForceTween then
        isTween=true;
        if currPageIndex==idx and pageDatas then
            for k, v in ipairs(pageDatas) do
                local item = svLayout:GetItemLua(k);
                -- LogError(tostring(k).."\t"..tostring(item==nil))
                if item~=nil then
                    local hasTween=item.GetState()==true;
                    if item ~= nil then
                        item.SetState(false, hasTween);
                    end
                end
            end
        else
            currPageIndex=idx;
        end
    elseif currPageIndex ~= idx then
        local item = svLayout:GetItemLua(currPageIndex);
        if item ~= nil then
            item.SetState(false, true);
        end
        isTween = true
    end
    currPageIndex = idx;
    local childTabDatas = GetPageData():GetTopTabs(true);
    if childTabDatas ~= nil then -- 设置为默认子页签
        currChildPageID = childTabDatas[1].id;
    else
        currChildPageID = nil;
    end
    local item = svLayout:GetItemLua(currPageIndex);
    item.SetState(true, isTween);
end

function OnTopTabChange(eventData)
    if eventData~=nil and eventData.cfg.id~=currChildPageID then
       currChildPageID = eventData.cfg.id
       selItemIdx = nil;
       isTween=true
       isJump=false;
       Refresh();
    end
end

function LayoutCallBack(index)
    local _data=pageDatas[index]
    local item=svLayout:GetItemLua(index);
    local elseData={sIndex=currPageIndex,isFirst=isFirst}
    item.SetIndex(index)
    item.Refresh(_data, elseData);
end

function SetMask(isShow)
    CSAPI.SetGOActive(mask,isShow==true)
end

function OnRefresh()
    if curModule and curModule.GetIsTween~=nil and curModule.GetIsTween()==true then
        do return end
    end
    isTween=false;
    Refresh();
end

--刷新数据
function OnResetTimeRet()
    if data then
        pageDatas={ShopMgr:GetPageByID(data)};
    else
        pageDatas=ShopMgr:GetAllPages(true);
    end
end

function OnShopRecordInfosRefresh()
    OnResetAutoRefreshSuccess();
    OnRefresh();
end

function OnClickBack()
    if IsNil(gameObject)~=nil and IsNil(view)~=nil then
        view:Close();
    end
end

--根据商店数据获取要加载的子物体
function InitChild()
    local pageData=GetPageData()
    if pageData~=nil then
        --根据商品类型和商品展示类型进行显示
        RecordChildPageIDs();
        local commType=pageData:GetCommodityType()
        local showType=pageData:GetShowType()
        if singleMode then
            commType=CommodityType.Normal;
            showType="single"
        end
        if commType and showType and showConfig[commType]~=nil then
            --判定是否是活动商店，活动商店没有左边的tab栏
            local key=commType.."_"..showType;
            local path=nil;
            if showConfig[commType][showType]~=nil then
                path=showConfig[commType][showType];
            else
                path=showConfig[commType]["default"];
            end
            local topTabs= pageData:GetTopTabs(true);
            if currChildPageID==nil and topTabs~=nil then
                currChildPageID=topTabs[1].id;
            end
            CheckNewInfos();
            --记录道具刷新时间
            if pageData:GetCommodityType()==CommodityType.Normal then
                local key=currChildPageID and pageData:GetID().."_"..currChildPageID or pageData:GetID();
                if ShopCommFunc.IsRecordRefreshInfo(key) then --记录一次当前列表刷新时间
                    local nowTime=TimeUtil:GetTime();
                    local checkList=pageData:GetRefreshInfos(currChildPageID);
                    ShopCommFunc.IsRefreshCommodityInfos(checkList,nowTime);
                end
            end
            if curModule~=nil and curModule~=moduleViews[key] and curKey~=nil and childNodes[curKey]~=nil then
                CSAPI.SetGOActive(childNodes[curKey],false);
            end
            if moduleViews[key]~=nil then
                if childNodes[key]~=nil then
                    CSAPI.SetGOActive(childNodes[key],true);
                end
                curModule=moduleViews[key];
                curKey=key;
                if curModule.SetPlayTween then
                    curModule.SetPlayTween(isTween);
                end
                if curModule.SetIsJump then
                    curModule.SetIsJump(isJump);
                end
                curModule.Refresh(pageData,currChildPageID,selItemIdx);
                isTween=false;
                selItemIdx=nil;
            elseif curLoadingInfo==nil or (curLoadingInfo~=nil and (curLoadingInfo[key]==nil or (curLoadingInfo[key] and curLoadingInfo[key].isLoading~=true))) then
                curLoadingInfo=curLoadingInfo or {}
                curLoadingInfo[key]=curLoadingInfo[key] or {
                    key=key,isLoading=true
                }
                FuncUtil:Call(CreateChildAsync,nil,delayTime,{key=key,path=path,pageData=pageData})
                curKey=key;
            end
        end
    end
end

function CreateChildAsync(_d)
    local key=nil;
    local pageData=nil;
    local path=nil;
    if _d ==nil then
        do return end
    end
    key=_d.key;
    pageData=_d.pageData;
    path=_d.path;
    if childNodes[key] == nil then
        local go = CS.UnityEngine.GameObject(key);
        go:AddComponent(typeof(CS.UnityEngine.RectTransform));
        local size = CSAPI.GetRealRTSize(childNode);
        CSAPI.SetRTSize(go, size[0], size[1])
        CSAPI.SetParent(go, childNode);
        CSAPI.SetAnchor(go, 0, 0, 0);
        childNodes[key] = go;
    end
    ResUtil:CreateUIGOAsync(path, childNodes[key], function(go)
        local lua = ComUtil.GetLuaTable(go);
        CSAPI.SetAnchor(go, 0, 0);
        moduleViews[key] = lua;
        curModule = lua;
        if curModule.SetPlayTween then
            curModule.SetPlayTween(isTween);
        end
        if curModule.SetIsJump then
            curModule.SetIsJump(isJump);
        end
        lua.Refresh(pageData, currChildPageID, selItemIdx);
        if curLoadingInfo and curLoadingInfo[key] ~= nil then
            curLoadingInfo[key].isLoading = false;
        end
        selItemIdx = nil;
        isTween = false;
    end);
end


function CheckNewInfos()
    -- 刷新new状态
    local newInfos = ShopMgr:GetPageNewInfos();
    local pageData=GetPageData()
    local currChildPage=GetChildPageData();
    if pageData==nil then
        do return end
    end
    local pageID=pageData:GetID();
    local tempChildPageID=currChildPageID
    if pageID==4 or pageID==5 then--皮肤界面不需要判定子页签
        tempChildPageID=nil;
    end
    if tempChildPageID and tempChildPageID and newInfos and newInfos[pageID] and newInfos[pageID][tempChildPageID] and currChildPage.tips  then
        Tips.ShowTips(LanguageMgr:GetTips(currChildPage.tips)); -- 抛出刷新提示
    elseif tempChildPageID == nil and newInfos and newInfos[pageID] then
        -- 判断是否还有其它数据
        if pageData:GetTips() then
            Tips.ShowTips(LanguageMgr:GetTips(pageData:GetTips())); -- 抛出刷新提示
        end
        if pageID == 4 or pageID==5 then -- 皮肤/图册商店
            ShopMgr:SetSkinStoreNewState(pageID); -- 设置皮肤状态
        end
    end
    ShopMgr:SetCommResetInfo(pageID, tempChildPageID);
    ShopMgr:CheckCommReset();
end


function GetPageData()
    if pageDatas~=nil and currPageIndex~=nil and currPageIndex<=#pageDatas then
        return pageDatas[currPageIndex]
    end
end

function GetChildPageData()
    local pageData=GetPageData();
    if pageData~=nil then
        return pageData:GetChildPageData(currChildPageID,true);
    end
end

function OnDestroy()
    ShopMgr:SetJumpVoucherID();
    eventMgr:ClearListener();
    RoleAudioPlayMgr:StopSound();
    EventMgr.Dispatch(EventType.Replay_BGM);--重播场景背景音乐
    if timerMgr then
        timerMgr:Clear();
    end
    if autoRefreshGuard then
        autoRefreshGuard:Dispose();
        autoRefreshGuard=nil;
    end
    pendingResetRequest=nil;
    timerInfos={};
    ReleaseCSComRefs();
    UIUtil.DestoryRT();
end

function OnAddQuestionItem()
    FirstEnterQuestionItem=true;
    RefreshDeductionBouchers()
    SetDeductionBouchersIcon()
end

---设置抵扣券 介绍显示还是隐藏  初始化
function SetDeductionBouchersIcon()
    if AdvDeductionvoucher.SDKvoucherNum>0 then
        --local Item= top.transform:Find("Top").gameObject
        --Item.transform.anchorMin = UnityEngine.Vector2(0, 0)
        --Item.transform.anchorMax = UnityEngine.Vector2(1, 1)
    else
        if this["QuestionItem"] and this["QuestionItem"]~=1 then
            CSAPI.SetGOActive(this["QuestionItem"].gameObject, false);
        end
    end
end

function SetMoney()
    local infos={}
    local currChildPage=GetChildPageData();
    if currChildPage and currChildPage.goldInfo then --优先显示子页面的货币信息
        infos=currChildPage.goldInfo;
    else
        infos=GetPageData():GetGoldType();
    end
    if CSAPI.IsADV() then
        local  tableinfo={};
        if infos then
            for i, v in pairs(infos) do
                if tostring(infos[i][1])==tostring(10999) then
                    if  BagMgr:GetCount(10999)==0 then
                        --table.remove(infos,i)
                    else
                        table.insert(tableinfo,infos[i]);
                    end
                else
                    table.insert(tableinfo,infos[i]);
                end
            end
        end
        topTools.SetMoney(tableinfo and tableinfo or nil);   -- 需要加跳转id todo
    else
        topTools.SetMoney(infos and infos or nil);   -- 需要加跳转id todo
    end
end

function SetQuestionItemActive(isShow)
    QuestionItemSetActive(isShow==true);
end

---控制抵抵扣券说明显示或者隐藏
function QuestionItemSetActive(Active)
    if this["QuestionItem"] and this["QuestionItem"]~=1 then
        if FirstEnterQuestionItem then
            FirstEnterQuestionItem=false;
            local Item= this["QuestionItem"].gameObject;
            Item.transform.localPosition = UnityEngine.Vector3(Item.transform.localPosition.x-CSAPI.UIFitoffsetTop()-CSAPI.UIFoffsetBottom(), Item.transform.localPosition.y,0)
            local RectTransformItem=Item:GetComponent("RectTransform");
            RectTransformItem.pivot=UnityEngine.Vector2(1,0.5)
            RectTransformItem.anchorMax=UnityEngine.Vector2(1,1)
            RectTransformItem.anchorMin=UnityEngine.Vector2(1,1)
            RectTransformItem.anchoredPosition=UnityEngine.Vector2(-470,-60)
        end
        if AdvDeductionvoucher.SDKvoucherNum>0 then
            if CSAPI.IsADV() then
                CSAPI.SetGOActive(this["QuestionItem"].gameObject, Active);
            else
                CSAPI.SetGOActive(this["QuestionItem"].gameObject, false);
            end
        else
            CSAPI.SetGOActive(this["QuestionItem"].gameObject, false);
        end
    else
        FirstEnterQuestionItem=true;
    end
end

function ClearPageCache()
    currPageIndex=nil;
    currChildPageID=nil;--子页签页面ID
    curModule=nil;
    curKey=nil;
    selItemIdx=nil;
end

function Update()
    if timerMgr~=nil then
        timerMgr:Update(Time.deltaTime);
    end
end

function InitShowConfig()
    showConfig={};
    -- 普通
    showConfig[CommodityType.Normal] = {}
    showConfig[CommodityType.Normal][ShopShowType.Normal]="Shop/ShopNormalPage";
    showConfig[CommodityType.Normal][ShopShowType.Package]="Shop/ShopPackagePage";
    showConfig[CommodityType.Normal][ShopShowType.Pay]="Shop/ShopPayCommPage";
    showConfig[CommodityType.Normal][ShopShowType.Skin]="ShopSkinPage/ShopSkinPage";
    showConfig[CommodityType.Normal][ShopShowType.Atlas]="ShopSkinPage/ShopAtlasPage";
    --活动
    showConfig[CommodityType.Normal]["single"]="Shop/ShopSinglePage";
    --默认
    showConfig[CommodityType.Normal]["default"]="Shop/ShopNormalPage";
    -- 随机
    showConfig[CommodityType.Rand] ={}
    showConfig[CommodityType.Rand][ShopShowType.Normal]="Shop/ShopRandPage";
    showConfig[CommodityType.Rand]["default"]="Shop/ShopRandPage";
    -- 推荐
    showConfig[CommodityType.Promote]={}
    showConfig[CommodityType.Promote][ShopShowType.Normal]="ShopPromote/PromoteMain";
    showConfig[CommodityType.Promote]["default"]="ShopPromote/PromoteMain";
end

--将当前商店列表中存在开启时间段的商店全部记录
function RecordPageIDs()
    lastPageIDs={};
    if pageDatas then
        for k,v in ipairs(pageDatas) do
            lastPageIDs[v:GetID()]=true;
        end
    end
end

--记录当前商店列表中的子页签开启状态
function RecordChildPageIDs()
    lastChildPageIDs={};
    local curPage=GetPageData();
    if curPage then
        local childPages=curPage:GetTopTabs(true);
        if childPages==nil then
            do return end
        end
        for k,v in ipairs(childPages) do
            lastChildPageIDs[v.id]=true;
        end
    end
end

function CheckRefresh()
    CheckPageRefresh();
    AutoRefresh();
    CheckShopState();
end

function OnOpenTimeRet()
    local ret=CheckPageRefresh();--检查一次当前界面是否有变化
    if not ret then
        --刷新数据
        if data then
            pageDatas={ShopMgr:GetPageByID(data)};
        else
            pageDatas=ShopMgr:GetAllPages(true);
        end
        --刷新本页签
        Refresh()
    end
end

function CheckShopState()
    local currPage=GetPageData()
    if data and currPage and hasCloseTips==false then --有指定商店ID才做检测
        if TimeUtil:GetTime()>currPage:GetCloseTimeData() and currPage:GetCloseTimeData()~=0 then --商店已关闭
            --提示关闭
            local dialogData={
               content=LanguageMgr:GetTips(24001),
               okCallBack=CloseShopPanels,
            }
            CSAPI.OpenView("Prompt",dialogData);
            hasCloseTips=true;
        end
    end
end

function CloseShopPanels()
    if closeWindows~=nil then
        for k, v in pairs(closeWindows) do
            if CSAPI.IsViewOpen(v) then
                CSAPI.CloseView(v);
            end
        end
    end
    OnClickBack();
end

--商店内部跳转
function OnJumpRefresh(eventData)
    if eventData then
        local index=1;
        for k,v in ipairs(pageDatas) do
            if eventData and v:GetID()==eventData.pageID then
                index=k;
                break;
            end
        end
        currPageIndex=index;
        currChildPageID=eventData.childID or nil;
        Refresh(true);
    end
end

--购买返回 上传日志
function OnBuyRet(proto)
    local isDisRefresh=false;
    if proto then
        local currPageData=GetPageData();
        local currChildPage=GetChildPageData();
        local comm=ShopMgr:GetFixedCommodity(proto.id);
        local priceInfo=comm:GetRealPrice();
        local isPay=false;
        local price=0;
        if priceInfo and priceInfo[1].id==-1  then
            isPay=true;
            price=priceInfo[1].num;
        elseif priceInfo~=nil then
            price=priceInfo[1].num;
        end
        if not isPay then --非充值则上传订单信息
            local gets=comm:GetCommodityList();
            local currNum=1;
            local currPrice=price;
            if proto.gets then
                for k,v in ipairs(proto.gets) do
                    if v.id==gets[1].cid then
                        currNum=math.modf(v.num/gets[1].num);
                        currPrice=math.modf(currNum*price);
                        break;
                    end
                end
            else
                currPrice=price;
            end
            --数数记录购买
            local record={
                store_type=tostring(currPageData:GetID()),
                goods_id=tostring(comm:GetID()),
                goods_name=comm:GetName(),
                goods_num=currNum,
                cost_type=priceInfo~=nil and tostring(priceInfo[1].id) or "免费",
                cost_num=currPrice,
            }
            if CSAPI.IsADV()==false then
                BuryingPointMgr:TrackEvents("store_buy",record )
            end
        end
        --判断该页签是否为空
        if currPageData~=nil then
            local showType=currPageData:GetShowType()
            if showType==ShopShowType.Skin or showType==ShopShowType.Atlas then --皮肤和图册商店做特殊刷新
                selItemIdx=comm:GetID()
                isDisRefresh=true;
                if curModule and curModule.RefreshCurr~=nil then
                    curModule.RefreshCurr();
                end
            end
        end
        if currPageData~=nil and currChildPage~=nil then
           local currList=currPageData:GetCommodityInfos(true,currChildPage.id);
           if currList==nil or (currList and #currList==0) then --子页签数据为空时隐藏
                currChildPageID=nil;
                currChildPage=nil;
           end
        end
    end
    if isDisRefresh~=true then
        Refresh();
    end
end

--兑换返回 上传日志
function OnExchangeRet(proto)
    if proto then
        local currPageData=GetPageData();
        local currChildPage=GetChildPageData();
        local randData=ShopMgr:GetExchangeItem(proto.cfgid,proto.id);
        local comm=RandCommodityData.New();
        comm:SetData(randData,randData.index);
        local priceInfo=comm:GetRealPrice();
        if priceInfo[1].id~=-1 then --非充值则上传订单信息
            local gets=comm:GetCommodityList();
            local currNum=1;
            local currPrice=1;
            if proto.gets then
                for k,v in ipairs(proto.gets) do
                    if v.id==gets[1].cid then
                        currNum=math.modf(v.num/gets[1].num);
                        currPrice=math.modf(currNum*priceInfo[1].num);
                        break;
                    end
                end
            else
                currPrice=priceInfo[1].num;
            end
            --数数记录购买
            local record={
                store_type=tostring(currPageData:GetID()),
                goods_id=tostring(comm:GetID()),
                goods_name=comm:GetName(),
                goods_num=currNum,
                cost_type=priceInfo~=nil and tostring(priceInfo[1].id) or "免费",
                cost_num=currPrice,
            }
            if CSAPI.IsADV()==false then
                BuryingPointMgr:TrackEvents("store_buy",record )
            end
        end
    end
    Refresh();
end

function GetAutoRefreshScopeKey(pageData, childPageID)
    if pageData==nil then
        return nil;
    end
    local pageID=pageData:GetID();
    if childPageID~=nil then
        return tostring(pageID).."_"..tostring(childPageID);
    end
    return tostring(pageID);
end

function CheckPendingResetTimeout()
    if pendingResetRequest==nil or autoRefreshGuard==nil then
        return false;
    end
    local _,state,reason=autoRefreshGuard:CanRequest(pendingResetRequest.scopeKey);
    if reason=="timeout" or (state and state.lastFailReason=="timeout" and state.isPending~=true) then
        pendingResetRequest=nil;
        return true;
    end
    return false;
end

function OnResetAutoRefreshSuccess()
    if pendingResetRequest and autoRefreshGuard then
        local scopeKey=pendingResetRequest.scopeKey;
        local oldResetKey=pendingResetRequest.resetKey;
        local pageID=pendingResetRequest.pageID;
        local childPageID=pendingResetRequest.childPageID;
        autoRefreshGuard:ClearPending(scopeKey);
        local pageData=ShopMgr:GetPageByID(pageID);
        if pageData~=nil then
            local checkList=pageData:GetRefreshInfos(childPageID);
            local nowTime=TimeUtil:GetTime();
            local isReset,_,newResetKey=ShopCommFunc.IsRefreshCommodityInfos(checkList,nowTime);
            if isReset~=true or newResetKey~=oldResetKey then
                autoRefreshGuard:ResolveTriggerKey(scopeKey,oldResetKey);
            end
        end
        pendingResetRequest=nil;
    end
end

--检查页面刷新
function CheckPageRefresh()
    if data ~= nil then return end --活动页签无视
    
    local openList = ShopMgr:GetAllPages(true)
    if not openList then return false  end
    local curPageData=GetPageData()
    if curPageData==nil then
        return false;
    end
    RebuildMap(openMap,openList, function(v) return v:GetID() end)

    -- 检测一级页签是否有变化
     if IsPageChanged(lastPageIDs, openMap, curPageData:GetID()) then
        OnShopTagRefresh()
        return true
    end
    
    if currChildPageID==nil then
        return false;
    end
    local tempList=curPageData:GetTopTabs(true);
    if tempList==nil then
        return false;
    end
    RebuildMap(openMap2,tempList, function(v) return v.id end)
    if IsPageChanged(lastChildPageIDs, openMap2, currChildPageID) then
        OnShopTagRefresh()
        return true;
    end
end

function RebuildMap(map, list, getIdFunc)
    if map then
        for k in pairs(map) do
            map[k] = nil
        end
    end

    if not list then return end

    for _, v in ipairs(list) do
        map[getIdFunc(v)] = true
    end
end

--检测当指定页面的开启关闭状态是否变化
function IsPageChanged(oldMap, newMap, targetID)
    -- 新增检测
    if newMap then
        for id in pairs(newMap) do
            if (not oldMap or not oldMap[id]) and id == targetID then
                return true
            end
        end
    end
    -- 删除检测
    if oldMap then
        for id in pairs(oldMap) do
            if (not newMap or not newMap[id]) and id == targetID then
                return true
            end
        end
    end
    return false
end

--自动刷新时间
function AutoRefresh()
    local currPageData=GetPageData();
    if currPageData~=nil and currPageData:GetCommodityType()==CommodityType.Normal then--检测固定道具商店的重置时间和折扣时间
		local nowTime=TimeUtil:GetTime();
		local checkList=currPageData:GetRefreshInfos(currChildPageID);
		local isReset,isRefresh,c_resetKey,c_refreshKey=ShopCommFunc.IsRefreshCommodityInfos(checkList,nowTime);
        -- LogError("isReset:"..tostring(isReset).."\t isRefresh:"..tostring(isRefresh))
		if isReset then --列表刷新
            if CheckPendingResetTimeout() then
                return;
            end
            local scopeKey=GetAutoRefreshScopeKey(currPageData,currChildPageID);
            if scopeKey==nil or autoRefreshGuard==nil then
                return;
            end
            if pendingResetRequest~=nil and pendingResetRequest.scopeKey~=scopeKey then
                return;
            end
            local canRequest=nil;
            canRequest=autoRefreshGuard:CanRequest(scopeKey);
            -- LogError("是否可以请求1:"..tostring(scopeKey).."\t"..tostring(canRequest))
            if canRequest~=true then
                return;
            end
            canRequest=autoRefreshGuard:RecordTriggerKey(scopeKey,c_resetKey);
            -- LogError("是否可以请求2:"..tostring(scopeKey).."\t"..tostring(canRequest))
            if canRequest~=true then
                return;
            end
            autoRefreshGuard:BeginRequest(scopeKey);
            pendingResetRequest={
                scopeKey=scopeKey,
                resetKey=c_resetKey,
                pageID=currPageData:GetID(),
                childPageID=currChildPageID,
                sendTime=nowTime
            };
            ShopMgr:CheckCommReset();
            ShopProto:GetShopCommodity(currPageData:GetID());
            -- LogError("发送请求------------>")
			return
        elseif isRefresh then --道具购买期限刷新    
            ShopMgr:CheckCommReset();
            local isDonReset=true;
            if currPageData:GetShowType()==ShopShowType.Skin then
                isDonReset=false;
            end
            isTween=isDonReset;
            Refresh();
        end
	end
end

-- 快速检测是否有新 ID 出现
function HasNewPage(currentMap, recordMap)
    for id, _ in pairs(currentMap) do
        if not recordMap[id] then return true end
    end
    return false
end

--页签刷新
function OnShopTagRefresh()
    Init(nil,true);
    SetCurrPage(currPageIndex,true)
    Refresh()
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(15120));
    end,nil,100)
end

function AddTimer(key,func,isLoop,_delay)
    if timerMgr~=nil and func then 
        if timerInfos[key]~=nil then
            RemoveTimer(key)
        end
        local id=timerMgr:AddTimer(_delay or 1, func, isLoop) 
        timerInfos[key]=id;
    end
end

function RemoveTimer(key)
    if timerMgr~=nil and key and timerInfos[key]~=nil then
        timerMgr:RemoveTimer( timerInfos[key]);
        timerInfos[key]=nil;
    end
end

function OnTimerAdd(eventData)
    if eventData then
        AddTimer(eventData.key,eventData.func,eventData.isLoop);
    end
end

function OnTimerRemove(eventData)
    if eventData then
        RemoveTimer(eventData);
    end
end

--初始化选中的页签和子页签信息
function Init(_jumpInfo)
    --获取新的page页信息
    pageDatas=nil;
    lastPageIDs=nil;
    currPageIndex=nil;
    currChildPageID=nil;
    lastChildPageIDs=nil;
    if CSAPI.IsViewOpen("ShopPayView") then
        CSAPI.CloseView("ShopPayView");
    end
    if data then
        pageDatas={ShopMgr:GetPageByID(data)};
    else
        pageDatas=ShopMgr:GetAllPages(true);
    end
    if pageDatas==nil or next(pageDatas)==nil then
        --不存在页签则关闭页面
        --弹提示
        Tips.ShowTips(LanguageMgr:GetTips(15121));
        OnClickBack()
        do return end
    end
    RecordPageIDs();
    --刷新商店页面
    local index=1;
    for k,v in ipairs(pageDatas) do
        if _jumpInfo then
            if v:GetID()==_jumpInfo[1] then
                index=k
                break;
            end
        else
            if v:IsDefaultOpen() then
                index=k;
                break;
            elseif k==1 then
                index=k;
                break;
            end
        end
    end
    local tempCID=_jumpInfo and _jumpInfo[2] or nil;
    if currPageIndex==index and currChildPageID==tempCID and isFirst~=true then
        do return end;
    end
    currPageIndex=index;
    currChildPageID=tempCID;
    selItemIdx=_jumpInfo and _jumpInfo[3] or nil;
end

function OnViewOpened(viewKey)
    if viewKey then
        closeWindows=closeWindows or {};
        closeWindows[viewKey]=viewKey;
    end
end

function ReleaseCSComRefs()
    gameObject=nil;
    transform=nil;
    this=nil;  
    bg=nil;
    childNode=nil;
    leftsv=nil;
    top=nil;
    showConfig=nil;
    moduleViews=nil;
    timerInfos={};
    selItemIdx=nil;
    singleMode=false;
    autoRefreshGuard=nil;
    pendingResetRequest=nil;
    curLoadingInfo=nil;
    if childNodes then
        for k, v in ipairs(childNodes) do
            CSAPI.RemoveGO(v);
        end
    end
    childNodes={};
end
