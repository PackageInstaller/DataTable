--礼包页面
local bottomItem=nil;
local curDatas={};
local layout=nil;
local data=nil;
local isTween=false;
local layoutTween=nil;
local topItem=nil;
local isJump=false;
local eventMgr=nil;
local topTabID=nil;
function Awake()
    layout = ComUtil.GetCom(sv, "UISV")
    layout:Init("UIs/Shop/VCommodityItem",LayoutCallBack,true)
    layoutTween=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.CustomTween,{funcName="PlayEntry",delay=48});
    eventMgr = ViewEvent.New();
end

function OnDisable()
    eventMgr:ClearListener();
end

function OnDestroy()
    eventMgr=nil;
    ReleaseCSComRefs()
    EventMgr.Dispatch(EventType.Shop_QuestionItem_Active,false)
end

function OnEnable()
    if CSAPI.IsADV() then
        EventMgr.Dispatch(EventType.Shop_QuestionItem_Active,true)
    else
        EventMgr.Dispatch(EventType.Shop_QuestionItem_Active,false)
    end
    eventMgr:AddListener(EventType.Shop_ResetTime_Ret,OnResetTimeRet)
end

function Refresh(pageData, _topTabID)
    data=pageData;
    topTabID=_topTabID
    if pageData then
        curDatas=pageData:GetCommodityInfos(true,topTabID);
        table.sort(curDatas,ShopCommFunc.SortComm)
        if isTween then
            layout:AnimAgain();--再次播放
            EventMgr.Dispatch(EventType.Shop_Tween_Mask,true)
        end
        layout:IEShowList(#curDatas,function()
            isTween=false;
            EventMgr.Dispatch(EventType.Shop_Tween_Mask,false)
        end);
        ShopCommFunc.AddBottomPage(data,topTabID,bottomItem,bottomNode,nil,SetBottom);
        topItem=ShopCommFunc.AddHeadPage(data,topTabID,isJump,topItem,topBar,"Shop/ShopHeadPage");
    else
        EventMgr.Dispatch(EventType.Shop_Tween_Mask,false)
    end
    isJump=false;
end

function OnResetTimeRet()
    if data then
        ShopCommFunc.AddBottomPage(data,topTabID,bottomItem,bottomNode,nil,SetBottom);
    end
end

function SetIsJump(_j)
    isJump=_j;
end

function SetBottom(_item)
    -- 日服则加载提示
    bottomItem=bottomItem==nil and _item or bottomItem
    if CSAPI.IsADV() and CSAPI.RegionalCode()==3 and bottomItem~=nil then
        bottomItem.ShowADVJP(true);
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
    item.Refresh(_data);
    item.SetClickCB(OnClickGrid);
end

function OnClickGrid(lua)  
    ShopCommFunc.OpenPayView(lua.data);
end

function ReleaseCSComRefs()
    bottomItem=nil;
    layout=nil;
    layoutTween=nil;
end