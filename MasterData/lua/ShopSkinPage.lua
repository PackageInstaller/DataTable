--皮肤商店
local eventMgr=nil;
local currComm=nil;--当前的皮肤商品
local pageData=nil;
local childPageID=nil;
local layout=nil;
local curDatas=nil;
local targetSID=nil;
local currSkin=nil;--皮肤信息类
local layoutTween=nil;
local isShowImg=false;
local l2dOn=true;
local roleItem=nil;
local changeInfo=nil;
local lastTime=0;
local timerKey=nil
local rSkinInfo=nil
local card=nil;
local curModelCfg=nil;
local currIdx=1;
local hasL2d=false;
local sr=nil;
local sortId=29;
local lastSortData=nil;
local noneItem=nil;
local spTags={};
local isTween=false;
local isAll=true
local totalWidth=0; --sv可视区域的宽度
local width=178;--单个的宽度
local lineWidth=15;--间隔宽度
local maxShowNum=0;--折算的最大显示数量
local moveX=0;--移动位置
local svMoveTween=nil  --移动动画脚本       
local tagList={};
local isFirst=true;

function Awake()
    layout=ComUtil.GetCom(sv,"UISV");
    sr=ComUtil.GetComInChildren(sv,"ScrollRect");
    layout:Init("UIs/ShopSkinPage/SkinCommodityItem",LayoutCallBack,true)
    layoutTween=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.CustomTween,{funcName="PlayEntry",delay=48});
    svMoveTween=ComUtil.GetCom(svTween,"ActionUIMoveTo")
    local size=CSAPI.GetRealRTSize(sv);
    totalWidth=size[0];
    maxShowNum=math.floor((totalWidth-18)/(width+lineWidth))
    roleItem = RoleTool.AddRole(cNode, nil, nil, false)		
    eventMgr = ViewEvent.New();
    SetOffset(AdaptiveConfiguration.GetOrientation());
     CSAPI.SetSwapleftandright(txtRmb,1)
end

function OnEnable()
    eventMgr:AddListener(EventType.Card_Update, OnCardUpdate)
    eventMgr:AddListener(EventType.Screen_Rotation_Occurs,OnScreenRotation)
end

function OnDisable()
    eventMgr:ClearListener();
    CleanCache();
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

function OnCardUpdate()
    Tips.ShowTips(LanguageMgr:GetByID(18072));
    InitContent();
end

function OnDestroy()
    eventMgr=nil;
    --缓存L2D按钮状态
    RoleSkinMgr:SetL2DState(l2dOn);
    SortMgr:ClearData(sortId)
end

function SetPlayTween(_isTween)
    isTween=_isTween
end

function GetIsTween()
    return isTween;
end

function Refresh(_pageData, _topTabID,_selID)
    pageData=_pageData;
    childPageID=nil;
    targetSID=_selID and tonumber(_selID) or nil;
    if pageData==nil then
        do return end
    end
    timerKey=tostring(pageData:GetID())
    curDatas=pageData:GetCommodityInfos(true,childPageID);
    local commNum=curDatas and #curDatas or 0;
    curDatas=SortMgr:Sort(sortId,curDatas);
    if isTween then
        layout:AnimAgain()
        if IsNil(roleItem)~=true then
            CSAPI.SetGOAlpha(roleItem.gameObject,1);
        end
        EventMgr.Dispatch(EventType.Shop_Tween_Mask,true)
    else
        EventMgr.Dispatch(EventType.Shop_Tween_Mask,false)
    end
    CSAPI.SetGOActive(clickMask,isTween)
    InitList();
    SetNone(commNum==0);
    CSAPI.SetGOActive(root,commNum>0)
end

--刷新当前选中的商品
function RefreshCurr()
    if curDatas~=nil and currIdx and #curDatas>currIdx then
        layout:UpdateOne(currIdx);
        InitContent();
    end    
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
    currIdx = 1;
    for k, v in ipairs(curDatas) do
        if (targetSID ~= nil and v:GetID() == targetSID) then
            currIdx = k;
            break
        end
    end
    if curDatas and #curDatas > 0 then
        currComm = curDatas[currIdx] or curDatas[1];
    end
    InitContent();
    layout:IEShowList(#curDatas, function()
        isTween = false;
        EventMgr.Dispatch(EventType.Shop_Tween_Mask,false)
        CSAPI.SetGOActive(clickMask, false)
    end, currIdx)
    CSAPI.SetGOActive(svNoneObj,#curDatas==0);
end


function InitContent()
    if currComm==nil then
        do return end
    end
    currSkin=ShopCommFunc.GetSkinInfo(currComm);
    curModelCfg=currSkin:GetModelCfg();
    rSkinInfo=RoleSkinMgr:GetRoleSkinInfo(curModelCfg.role_id,curModelCfg.id);
    local useL2d=false;
    hasL2d=currSkin:HasL2D();
    isShowImg=false;
    local isShowAction=false;
    if g_FHXOpenSkin ~= true then
        useL2d = l2dOn;
        if currComm and currComm:IsShowImg() and rSkinInfo and rSkinInfo:CheckCanUse() ~= true then
            useL2d = false;
            isShowImg = true;
            CSAPI.SetGOActive(btnAction, false);
        else
            isShowAction=hasL2d;
            CSAPI.SetGOActive(btnAction, hasL2d);
        end
    else
        l2dOn = false;
        CSAPI.SetGOActive(btnAction, false);
    end
    -- 初始化立绘
    roleItem.Refresh(curModelCfg.id, LoadImgType.SkinFull, nil, useL2d, isShowImg)
    -- 初始化L2D按钮状态
    SetL2DState(useL2d);
    --设置皮肤名,上架时间,系列信息，价格，皮肤标签
    local cfg = currSkin:GetSetCfg();
    CSAPI.SetText(txtRName,currSkin:GetSkinName());
    CSAPI.SetText(txtSName,currSkin:GetRoleName());
    local cards=RoleMgr:GetCardsByCfgID(curModelCfg.role_id);
    if cards then
        card=cards[1];
    else
        card=nil;
    end
    ResUtil.SkinSetIcon:Load(setIcon,cfg.icon.."_w");
    changeInfo=currSkin:GetChangeInfo();
    SetChangeInfo();
    local icons,lIds=currSkin:GetTagIcons();
    SetSPTag(icons);
    CSAPI.SetGOActive(voiceObj,currSkin:UnlockVoice()~=nil);
    CSAPI.SetAnchor(voiceObj,-187,isShowAction and 558 or 495)
    --倒计时
    if currComm and (currComm:IsOver() or (rSkinInfo and rSkinInfo:CheckCanUse() == true )) then
        lastTime=0;
        EventMgr.Dispatch(EventType.Shop_Timer_Remove, timerKey)
    else
        lastTime=currComm:GetEndBuyTime();
        if lastTime>0 then
            SetTime();
            EventMgr.Dispatch(EventType.Shop_Timer_Add,{key=timerKey,func=SetTimeUpdate,isLoop=true}) 
        elseif lastTime==0 then
            CSAPI.SetText(txtTime,LanguageMgr:GetByID(18195));
            EventMgr.Dispatch(EventType.Shop_Timer_Remove,timerKey)
        end
    end
    SetPriceNode();
    local posY=-325;
    if changeInfo~=nil then
        posY=-505;
    end
    CSAPI.SetAnchor(tagNode2,50,posY);
    SetTags(isTween)
end

function SetTags(playTween)
    local list =currComm and currComm:GetTagsData(true) or {}; 
    ItemUtil.AddItems("ShopComm/CommodityTag", tagList, list, tagNode2, nil, 1,playTween);
end

function SetSPTag(list)
   ItemUtil.AddItems("ShopComm/SkinTag", spTags, list or {}, tagNode, nil, 1, {
    count=list and #list or 0,skinInfo=currSkin
   });
end

function SetPriceNode()
    if currSkin==nil then
        CSAPI.SetGOActive(payNode3,false);
        CSAPI.SetGOActive(payNode2,false);
        CSAPI.SetGOActive(payNode1,false);
        return;
    end
    local getType,getTips=currSkin:GetWayInfo();
    local has=false;
    if rSkinInfo and rSkinInfo:CheckCanUse() and rSkinInfo:IsLimitSkin()~=true then
        has=true;
    end
    if has then
        if card then
            --判断当前是否穿戴着该皮肤
            local isSuit=card:GetSkinID()==currSkin:GetModelID();
            CSAPI.SetGOActive(payNode2,false);
            CSAPI.SetGOActive(payNode1,false);
            CSAPI.SetGOActive(payNode3,true);
            CSAPI.SetGOActive(btnSuit,not isSuit);
            CSAPI.SetGOActive(btnSuit2,isSuit);
            CSAPI.SetText(txtS1,LanguageMgr:GetByID(isSuit and 18197 or 18061));
            local lid=isSuit and 18064 or 18065;
            CSAPI.SetText(txtSuitTips,LanguageMgr:GetByID(lid));
            CSAPI.SetText(txtTime,LanguageMgr:GetByID(18509));
        else
            CSAPI.SetText(txtTime,LanguageMgr:GetByID(18066)); --仅供预览都显示在倒计时那
            CSAPI.SetGOActive(payNode3,false); 
            CSAPI.SetGOActive(payNode2,false);
            CSAPI.SetGOActive(payNode1,false);
        end
    else 
        if getType==SkinGetType.Store then --初始化价格
            --判断商品是否在购买期限内
            local isBtnShow=false
            if curModelCfg and curModelCfg.shopId and currComm and currComm:GetNowTimeCanBuy() then
                isBtnShow=currComm:IsOver()~=true;
            end
            local costs=currComm:GetRealPrice();
            local rmbIcon=currComm:GetCurrencySymbols();
            local SDKdisplayPrice=currComm:GetSDKdisplayPrice();
            if isBtnShow and currComm and currComm:HasOtherPrice(ShopPriceKey.jCosts1) then
                local costs2=currComm:GetRealPrice(ShopPriceKey.jCosts1);
                CSAPI.SetGOActive(payNode1,false);
                CSAPI.SetGOActive(payNode2,true);
                CSAPI.SetGOActive(payNode3,false);
                SetPrice(txtRmb,pIconObj1,pIcon1,txtPVal1,txtFree2,costs,rmbIcon,SDKdisplayPrice)
                SetPrice(txtRmb2,pIconObj2,pIcon2,txtPVal2,txtFree3,costs2,rmbIcon,SDKdisplayPrice)
            elseif isBtnShow and currComm then
                CSAPI.SetGOActive(payNode1,true);
                CSAPI.SetGOActive(payNode2,false);
                CSAPI.SetGOActive(payNode3,false);
                SetPrice(txtSRmb,pSIconObj,pSIcon,txtSPVal,txtFree1,costs,rmbIcon,SDKdisplayPrice)
            else
                CSAPI.SetGOActive(payNode1,false);
                CSAPI.SetGOActive(payNode2,false);
                CSAPI.SetGOActive(payNode3,false);
                CSAPI.SetText(txtSuitTips,LanguageMgr:GetByID(18056));
            end
        end
    end
end


function SetPrice(_txtRmb,_iconObj,_icon,_txtPrice,_txtFree,costs,rmbIcon,SDKdisplayPrice)
    if costs==nil or (#costs==1 and costs[1].num<=0) then
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
        if costs[1].id==-1 then
            ---价格显示，如果没有就不显示
            CSAPI.SetText(_txtRmb,rmbIcon)
            if CSAPI.IsADV() then 
                if SDKdisplayPrice~=nil then 
                    CSAPI.SetText(_txtPrice,tostring(SDKdisplayPrice or costs[1].num)); 
                end 
            else
                CSAPI.SetText(_txtPrice,tostring(costs[1].num)); 
            end
        else
            local extend=nil
            if costs[1].id==ITEM_ID.GOLD then
                extend="_2"
            elseif costs[1].id==ITEM_ID.DIAMOND then
                extend="_3"
            end
            ShopCommFunc.SetPriceIcon(_icon,costs[1],extend);
            CSAPI.SetText(_txtPrice,tostring(costs[1].num))
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
    if Time.unscaledTime -endMoveTime <tweenTime or curDatas==nil or (curDatas and #curDatas==0) then
        do return end
    end
    if Time.unscaledTime - holdDownTime >= holdTime then
        local len = CS.UnityEngine.Input.mousePosition.x - startPosX
        if (math.abs(len) > 100) then
            local lastIndex=currIdx
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
            if index ~= currIdx and index>0 and index<=#curDatas then
                endMoveTime=Time.unscaledTime;
                MoveOffset(len>0,index,function() 
                    -- 更新选中物体并设置移动
                    local item1 = layout:GetItemLua(lastIndex);
                    local item2 = layout:GetItemLua(index);
                    if item1 then
                        item1.SetSelect(false,true);
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

--Sr偏移量移动
function MoveOffset(isRTL,nextIdx,func)
    local indexs = layout:GetIndexs()
    local state=2;
    local len=indexs.Length;
    for i=0,len-1 do
        if indexs[i]==nextIdx then
            -- LogError(i.."\t"..tostring(isRTL).."\t"..tostring(nextIdx))
            -- if indexs[i]>=maxShowNum+1 and indexs[i]<=#curDatas-maxShowNum and (i==0 or i>=maxShowNum-1) then
            if i==0 or (indexs[i]>=maxShowNum+1 and (i>=maxShowNum-1)) then
                state=3;
            else
                state=1
            end
            break;
        end
    end
    if state>=2 then --需要移动
        --获取当前SR位置
        sr.velocity=UnityEngine.Vector.zero;
        local x1,y1=CSAPI.GetAnchor(srContent)
        local size=CSAPI.GetRTSize(srContent);
        local moveIndex=nextIdx;
        if state==3 then
            -- moveIndex=isRTL and indexs[0] or indexs[0]-1;
            moveIndex=isRTL and indexs[0] or moveIndex-(maxShowNum-1);
            if moveIndex<=1 then
                moveIndex=1
            elseif moveIndex>#curDatas then
                moveIndex=#curDatas;
            end
        end
        local x2=moveIndex>1 and (moveIndex-1)*193 or 0
        if not IsNil(sr) then
            local item=layout:GetItemLua(moveIndex)
            -- LogError(tostring(item and item.data:GetName() or "无预制体").."\tnextIndex:"..tostring(nextIdx).."\tmoveIndex:"..tostring(moveIndex).."\twidth:"..tostring(size[0]).."\tx2:"..tostring(x2).."\t"..tostring(x2/size[0]))
            --播放动画
            svMoveTween:SetStartPos(x1,0);
            svMoveTween:SetTargetPos(x2*-1,0);
            svMoveTween:Play(func);
        end
    elseif func~=nil then
       func();
    end
end

-- 播放立绘移动动画 isRTL:是否从右到左
function PlayMoveTween(index,isRTL)
    local x1 = 0
    local x2 = isRTL and 400 or -400
    -- LogError(tostring(isShowImg))
    if(not isShowImg and hasL2d) then 
        UIUtil:SetObjFade(roleItem.gameObject, 1, 0, nil, 1, 300, 1)
    else 
        UIUtil:SetObjFade(roleItem.gameObject, 1, 0, nil, 300, 1, 1)
    end 
    UIUtil:SetPObjMove(roleItem.gameObject, x1, x2, 0, 0, 0, 0, function()
        SetCurrIndex(index);
        if(not isShowImg and hasL2d) then 
            UIUtil:SetObjFade(roleItem.gameObject, 0, 1, nil, 1, 300, 0)
        else 
            UIUtil:SetObjFade(roleItem.gameObject, 0, 1, nil, 300, 1, 0)
        end 
        UIUtil:SetPObjMove(roleItem.gameObject, -x2, x1, 0, 0, 0, 0, nil, 300, 1)
    end, 301, 1)
end

function SetTime()
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
    lastTime=lastTime-1>0 and lastTime-1 or 0;
    SetTime();
    SetTags(isTween);
    --显示时间
    if lastTime<=0 then
        lastTime=0;
        EventMgr.Dispatch(EventType.Shop_Timer_Remove,timerKey)
    end
end

--加载切换信息
function SetChangeInfo()
    if changeInfo then
        local type=changeInfo[1].cfg.skinType;
        local langID=18104;
        if type==3 then--同调
            langID=18105;
        elseif type==4 then --形切
            langID=18106;
        elseif type==5 then --机神
            langID=18104;
        end
        CSAPI.SetText(txt_other,LanguageMgr:GetByID(langID));
        --加载图
        ResUtil.Card:Load(spIcon, changeInfo[1].cfg.List_head);
        CSAPI.SetText(txtSP,LanguageMgr:GetByID(langID));
        CSAPI.SetGOActive(btnSP1,true);
    else
        CSAPI.SetGOActive(btnSP1,false);
    end
end

function SetL2DState(isOn)
    if isOn then
        CSAPI.SetAnchor(onImg,22,-3);
        CSAPI.SetImgColorByCode(onObj,"FFFFFF");
    else
        CSAPI.SetAnchor(onImg,-16,-3);
        CSAPI.SetImgColorByCode(onObj,"767679");
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
    local item=layout:GetItemLua(index);
    local isSel=index==currIdx;
    item.Refresh(_data,isSel);
    item.SetIndex(index)
    item.SetClickCB(OnClickItem);
end

function OnClickItem(tab)
    if tab==nil then
        do return end
    end
    if currIdx~=tab.index then
        local item1=layout:GetItemLua(currIdx);
        local item2=layout:GetItemLua(tab.index);
        if item1 then
            item1.SetSelect(false,true);
        end
        if item2 then
            item2.SetSelect(true,true);
        end
        SetCurrIndex(tab.index)
    end
end

function OnClickRmb()
    if currComm then
       OnClickPay(ShopPriceKey.jCosts)
    end
end

function OnClickPay(shopPriceKey)
    local realPrice=currComm:GetRealPrice(shopPriceKey);
    if realPrice and realPrice[1].id==-1 then
        ShopCommFunc.HandlePayLogic(currComm,1,nil,OnSuccess,shopPriceKey);
    else
        ShopCommFunc.OpenPayView(currComm,nil,nil,shopPriceKey);
    end
end

function OnSuccess(proto)
    if currSkin and proto and next(proto.gets) then
        CSAPI.OpenView("SkinShowView",currSkin)
    end
end


function OnClickBuy2()
    if currComm then
        OnClickPay(ShopPriceKey.jCosts1)
    end
end

function OnClickBuy()
    if currComm then
        OnClickPay(ShopPriceKey.jCosts)
    end
end

--切换动态按钮
function OnClickAction()
    l2dOn=not l2dOn;
    InitContent();
end

--切换皮肤预览按钮
function OnClickSP1()
    if changeInfo then
        local cfg=changeInfo[1].cfg;
        local type=changeInfo[1].type;
        local isShowImg2=isShowImg;
        local tips=nil;
        local desc="";
        if type==5 then
            isShowImg2=false;
        end
        desc=LanguageMgr:GetByID(18102,currSkin:GetRoleName(),cfg.desc);
        if g_FHXOpenSkin ~= true then
            OpenSearchView({cfg.id, type==SkinChangeResourceType.Spine,isShowImg2,desc}, LoadImgType.Main)
        else
            --和谐更改
            OpenSearchView({cfg.id, type==SkinChangeResourceType.Image,isShowImg2,desc}, LoadImgType.Main)
        end
    end
end

function OpenSearchView(data,loadImgType)
    if data~=nil then
        CSAPI.OpenView("RoleInfoAmplification", data,loadImgType)
    end
end

--图鉴
function OnClickDetails()
    local id=nil
    if currSkin then
        local cfg=currSkin:GetSetCfg();
        if cfg then
            id=cfg.id
        end
    end
    CSAPI.OpenView("SkinSetView",id)
end

function OnClickSuit()
    if card and currSkin then
        local skin_a = RoleTool.GetBDSkin_a(card:GetCfgID(), currSkin:GetModelID())
        RoleSkinMgr:UseSkin(card:GetID(), currSkin:GetModelID(), skin_a,l2dOn,l2dOn)
    end
end

--搜索
function OnClickSearch()
    -- currIdx=1;
    CSAPI.OpenView("ShopSearch",{func=OnInputChange,func2=OnSearchClose});
end

--筛选
function OnClickFilter()
    CSAPI.OpenView("SkinFilter", {id=sortId,func=OnSort})
end

function OnSort(filterData)
    currIdx=1;
    currComm=nil;
    curDatas=pageData:GetCommodityInfos(true,childPageID);
    local sData = SortMgr:GetData(sortId)
    sData.Filter=filterData
    local list=SortMgr:Sort(sortId,curDatas);
    if #list<=0 then 
        Tips.ShowTips(LanguageMgr:GetByID(18196))
        if lastSortData~=nil then
            sData.Filter=lastSortData --不存在则使用上次的记录
        else
            for k, v in pairs(filterData) do
                filterData[k]={0}
            end
            sData.Filter=filterData
        end
        curDatas=SortMgr:Sort(sortId,curDatas);
    else
        curDatas=list;
        lastSortData=table.copy(filterData)
    end
    InitList();
end

--搜索框输入变更 tab:控件 txt:输入内容
function OnInputChange(tab,txt)
    if txt==nil or txt=="" then
        return
    end
    local list=SearchCurrList(txt);
    if tab then
        tab.SetDownList(list)
    end
end

--搜索框选中 info是SearchCurrList中设置进去的table
function OnSearchClose(info)
    --跳转到对应ID
    if info~=nil then
        currComm=nil;
    end
    if info and info.index and curDatas and curDatas[info.index] then
        if currIdx~=info.index then
            local item=layout:GetItemLua(currIdx);
            if item then
                item.SetSelect(false,true);
            end
        end
        currIdx=info.index
        currComm=curDatas[currIdx]
        InitContent();
        layout:MoveToIndex(info.index)
        layout:UpdateOne(info.index)
    end
end

--搜索当前显示的列表
function SearchCurrList(txt)
    local list=nil
    if txt~=nil and curDatas~=nil then
        for i, v in ipairs(curDatas) do
            local skinInfo=ShopCommFunc.GetSkinInfo(v);
            if string.match(v:GetName(), txt) or string.match(skinInfo:GetRoleName(), txt) then
                list=list or {}
                table.insert(list,{txt=string.format("%s-%s",skinInfo:GetRoleName(),v:GetName()),index=i,comm=v});
            end
        end
    end
    return list;
end

function OnClickVoice()
    CSAPI.OpenView("ShopVoiceTips",currComm)
end

function CleanCache()
    currComm=nil;--当前的皮肤商品
    pageData=nil;
    childPageID=nil;
    curDatas=nil;
    targetSID=nil;
    currSkin=nil;--皮肤信息类
    isShowImg=false;
    l2dOn=true;
    changeInfo=nil;
    lastTime=0;
    timerKey=nil
    rSkinInfo=nil
    card=nil;
    curModelCfg=nil;
    currIdx=1;
    hasL2d=false;
    -- sr=nil;
    sortId=29;
    lastSortData=nil;
    -- spTags={};
    -- isAll=true;
    isFirst=true;
end