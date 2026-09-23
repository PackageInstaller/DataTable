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
local isJump=false;
local noneItem=nil;
function Awake()
    layout = ComUtil.GetCom(sv, "UISV")
    layout:Init("UIs/Shop/CommodityItem",LayoutCallBack,true)
    layoutTween=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.CustomTween,{funcName="PlayEntry",delay=80});
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Shop_RandComm_Refresh,SetCommodityList)
end

function OnDestroy()
    EventMgr.Dispatch(EventType.Shop_QuestionItem_Active,false)
    eventMgr:ClearListener();
    eventMgr=nil;
    ReleaseCSComRefs()
end

function Refresh(pageData, _topTabID)
    data=pageData;
    topTabID=_topTabID;
    if pageData then
        topItem=ShopCommFunc.AddHeadPage(data,topTabID,isJump,topItem,topBar,"Shop/ShopHeadPage");
        if pageData:GetCommodityType()==CommodityType.Rand then
            SetRandCommodity();
        else
            SetCommodityList();
        end
    end
    isJump=false;
end

function SetCommodityList()
    curDatas=data:GetCommodityInfos(true,topTabID);
    table.sort(curDatas,ShopCommFunc.SortComm)
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
end

--获取随机商店数据
function SetRandCommodity(isRefresh,isTimeOut)
    local exchangeCfg=Cfgs.CfgRandCommodity:GetGroup(data:GetID())[1];
    if exchangeCfg then
        shopID = exchangeCfg.id;
    end
    local list=ShopMgr:GetExchangeData(shopID);
    if list==nil or isRefresh or isTimeOut then
        ShopProto:GetExchangeInfo(shopID,isRefresh);
    else
        SetCommodityList();
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
    layout=nil;
    layoutTween=nil;
    eventMgr=nil;
end
