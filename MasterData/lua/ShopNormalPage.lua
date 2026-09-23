--通用商店页（万物贸易所）
local bottomItem=nil;
local curDatas={};
local layout=nil;
local data=nil;
local isTween=false;
local layoutTween=nil;
local topItem=nil;
local shopID=nil;
local eventMgr=nil;
local topTabID=nil
local noneItem=nil;
local isJump=false;
function Awake()
    layout = ComUtil.GetCom(sv, "UISV")
    layout:Init("UIs/Shop/CommodityItem",LayoutCallBack,true)
    layoutTween=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.CustomTween,{funcName="PlayEntry",delay=80});
    eventMgr = ViewEvent.New();
end

function OnEnable()
    eventMgr:AddListener(EventType.Shop_ResetTime_Ret,OnResetTimeRet)
end

function OnDisable()
    eventMgr:ClearListener();
end

function OnDestroy()
    EventMgr.Dispatch(EventType.Shop_QuestionItem_Active,false)
    eventMgr=nil;
    ReleaseCSComRefs()
end

function Refresh(pageData, _topTabID)
    data=pageData;
    topTabID=_topTabID;
    if pageData then
        curDatas=pageData:GetCommodityInfos(true,_topTabID);
        table.sort(curDatas,ShopCommFunc.SortComm)
        bottomItem=ShopCommFunc.AddBottomPage(data,topTabID,bottomItem,bottomNode,nil,SetBottom);
        topItem=ShopCommFunc.AddHeadPage(data,topTabID,isJump,topItem,topBar,"Shop/ShopHeadPage");
        if curDatas==nil or (curDatas and #curDatas==0) then
            CSAPI.SetGOActive(sv,false)
            CSAPI.SetGOActive(noneNode,true)
            SetNone(true)
            EventMgr.Dispatch(EventType.Shop_Tween_Mask,false)
        else
            CSAPI.SetGOActive(sv,true)
            CSAPI.SetGOActive(noneNode,false)
            if isTween then
                EventMgr.Dispatch(EventType.Shop_Tween_Mask,true)
                layout:AnimAgain();--再次播放
            end
            layout:IEShowList(#curDatas,function()
                EventMgr.Dispatch(EventType.Shop_Tween_Mask,false)
                isTween=false;
            end);
        end
    end
    isJump=false;
end

function OnResetTimeRet()
    if data then
        bottomItem=ShopCommFunc.AddBottomPage(data,topTabID,bottomItem,bottomNode,nil,SetBottom);
    end
end

function SetNone(isNone)
    if noneItem then
        noneItem.Refresh(data,isNone);
    else
        ResUtil:CreateUIGOAsync("ShopComm/ShopNonePage",noneNode,function(go)
            noneItem=ComUtil.GetLuaTable(go)
            noneItem.Refresh(data,isNone);
        end)
    end
end

function SetIsJump(_j)
    isJump=_j;
end

function SetBottom(_item)
    bottomItem=_item or bottomItem
    if bottomItem~=nil then
        bottomItem.SetTime(data,topTabID,nil);
        local isFragment=data:ShowExchange();
        local os=nil;
        if topTabID then --优先显示子页面的碎片兑换
            local currChildPage=data:GetChildPageData(topTabID,true);
            isFragment=currChildPage.fragmentExchange~=nil;
            os=currChildPage.fragmentExchange;
        else
            os=data:GetFragmentExchange();
        end
        bottomItem.SetRoleExchange(isFragment,os,OnClickExchange);
    end
end

--点击兑换
function OnClickExchange()
    local list=BagMgr:GetCardElems(true);
    --剔除未持有卡牌的星源数据
    local lt={};
    for k,v in ipairs(list) do
        local c=v:GetCfg();
        if c.id==107101 then--总队长
            table.insert(lt,v);
        elseif c and c.dy_arr then
            local cards=RoleMgr:GetCardsByCfgID(c.dy_arr[1]) 
            if cards and #cards>=1 then--持有的卡牌才列入计算
                table.insert(lt,v);
            end
        end
    end
    local os=nil
    if topTabID then --优先显示子页面的碎片兑换
        local currChildPage=data:GetChildPageData(topTabID,true)
        os=currChildPage.fragmentExchange;
    else
        os=data:GetFragmentExchange();
    end
    if lt and #lt>0 then
        CSAPI.OpenView("RoleExchangeView",lt,os);
    else
        Tips.ShowTips(LanguageMgr:GetTips(15105));
    end
end

function SetPlayTween(_isTween)
    isTween=_isTween;
end

function GetIsTween()
    return isTween;
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item=layout:GetItemLua(index);
    item.Refresh(_data,{commodityType=data:GetCommodityType()});
    item.SetClickCB(OnClickGrid);
end

function OnClickGrid(lua)  
    --判断是否是选择类型
    if lua.data:GetType()==CommodityItemType.ChoiceCard and lua.data:GetCommodityList()==nil then
        local cfg=lua.data:GetCfg();
        CSAPI.OpenView("CreateSelectRolePanel",cfg.ChoicePoolId) --卡池自选界面
        do return end;
    end
    ShopCommFunc.OpenPayView(lua.data);
end

function ReleaseCSComRefs()
    bottomItem=nil;
    layout=nil;
    layoutTween=nil;
    eventMgr=nil;
end
