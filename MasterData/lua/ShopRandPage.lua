--随机商品页面
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
local isJump=false;
local noneItem=nil;
function Awake()
    layout = ComUtil.GetCom(sv, "UISV")
    layout:Init("UIs/Shop/CommodityItem",LayoutCallBack,true)
    layoutTween=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.CustomTween,{funcName="PlayEntry",delay=48});
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Shop_RandComm_Refresh,OnRandCommRefresh)
    eventMgr:AddListener(EventType.Shop_ResetTime_Ret,OnResetTimeRet)
end

function OnDestroy()
    EventMgr.Dispatch(EventType.Shop_QuestionItem_Active,false)
    eventMgr:ClearListener();
    eventMgr=nil;
    ReleaseCSComRefs()
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

function Refresh(pageData, _topTabID)
    data=pageData;
    topTabID=_topTabID;
    if pageData then
        local exchangeCfg=Cfgs.CfgRandCommodity:GetGroup(pageData:GetID())[1];
        if exchangeCfg then
            shopID=exchangeCfg.id;
        end
        local timeOut=ShopMgr:GetExchangeRefreshTime(shopID)
        local isTimeOut=false;
        if timeOut and timeOut<=0 then
            isTimeOut=true;
        end
        SetRandCommodity(false,isTimeOut);
        bottomItem=ShopCommFunc.AddBottomPage(data,topTabID,bottomItem,bottomNode,nil,SetBottom);
        topItem=ShopCommFunc.AddHeadPage(data,topTabID,isJump,topItem,topBar,"Shop/ShopHeadPage");
    end
    isJump=false;
end

function SetRandCommodity(isRefresh,isTimeOut)
    local list=ShopMgr:GetExchangeData(shopID);
    if list==nil or isRefresh or isTimeOut then
        ShopProto:GetExchangeInfo(shopID,isRefresh);
    else
        OnRandCommRefresh();
    end
end

function SetIsJump(_j)
    isJump=_j;
end

function OnRandCommRefresh()
    if data == nil then
        LogError("OnRandCommRefresh------------->data不得为空！")
        layout:IEShowList(0);
        do
            return
        end
    end
    curDatas = data:GetCommodityInfos(true);
    table.sort(curDatas, ShopCommFunc.SortRandComm);
    if curDatas == nil or (curDatas and #curDatas == 0) then
        CSAPI.SetGOActive(sv, false)
        CSAPI.SetGOActive(noneNode, true)
        SetNone(true)
        EventMgr.Dispatch(EventType.Shop_Tween_Mask,false)
    else
        CSAPI.SetGOActive(sv, true)
        CSAPI.SetGOActive(noneNode, false)
        if isTween then
            layout:AnimAgain(); -- 再次播放
            EventMgr.Dispatch(EventType.Shop_Tween_Mask,true)
        end
        layout:IEShowList(#curDatas,function()
            isTween=false;
            EventMgr.Dispatch(EventType.Shop_Tween_Mask,false)
        end);
    end
    SetBottom();
end


function SetBottom(_item)
    bottomItem=_item or bottomItem
    if bottomItem~=nil then
        bottomItem.SetRefreshBtn(true,OnClickRefresh);
        bottomItem.SetTime(data,topTabID,OnTimeOver);
    end
end

--倒计时结束执行一次
function OnTimeOver()
    SetRandCommodity(false,true)
end

function OnClickRefresh()
    local costInfo=ShopMgr:GetExChangeRefreshCost(shopID)
    if costInfo~=nil then
        if costInfo[1]==0 then--免费
            SetRandCommodity(true);
        else
            local cfg=Cfgs.ItemInfo:GetByID(costInfo[1]);
            local count=BagMgr:GetCount(costInfo[1]);
            if count<costInfo[2] then --消耗道具不足
                CSAPI.OpenView("Prompt", {content = string.format( LanguageMgr:GetTips(15000),cfg.name)});
                return;
            end
            local content=string.format( LanguageMgr:GetTips(15005), cfg.name.."X"..costInfo[2]);
            local dialogdata = {}
            dialogdata.content = content
            dialogdata.okCallBack = function()
                if CSAPI.IsADVRegional(3) then
                    CSAPI.ADVJPTitle(costInfo[2],function() SetRandCommodity(true); end)
                else
                    SetRandCommodity(true);
                end
            end
            CSAPI.OpenView("Dialog", dialogdata)
        end
    -- else
    --     SetRandCommodity(false);
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
    ShopCommFunc.OpenPayView(lua.data);
end

function ReleaseCSComRefs()
    bottomItem=nil;
    layout=nil;
    layoutTween=nil;
    eventMgr=nil;
end