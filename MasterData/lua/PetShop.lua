--宠物商店
local headList={};
local headsData=nil
local currTab=1;
local eventMgr=nil;
local currIdx=1;--当前选中的格子下标
local layout=nil;
local curDatas={};
local grid=nil;
local state=2;
local currNum=1;
local currCType=nil;
local viewKey="PetShop"
local pageMaxNum=12;
local pageData=nil;
function Awake()
    layout=ComUtil.GetCom(hpage,"UISlideshow");
    layout:Init("UIs/Pet/PetGridItem",LayoutCallBack,true,1)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.PetActivity_Head_Click, OnTabClick);
    for i=1,100 do
        table.insert(curDatas,i);
    end
end

function OnDestroy()
    eventMgr:ClearListener();
end

function Init()
    CleanCache();
    headsData=PetActivityMgr:GetHeadsData();
    Refresh();
end

function Refresh()
    SetTab()
    --显示对应页签数据
    SetList()
    SetContent()
end

--显示列表
function SetList()
    curDatas,pageData=PetActivityMgr:GetPetCommodityByType(currCType);
    local num=12; 
    if #curDatas%pageMaxNum==0 and #curDatas~=0 then
        num=#curDatas;
    else
        num=(pageMaxNum-#curDatas%pageMaxNum)+#curDatas;
    end
    layout:IEShowList(num);
end

function LayoutCallBack(idx)
    local _data = curDatas[idx]
    local grid=layout:GetItemLua(idx);
    if _data~=nil then
        local list=_data:GetCommodityList();
        local goods=nil;
        if list then
            goods=list[1].data;
        end
        local price=0;
        local priceInfo=_data:GetRealPrice();
        if priceInfo then
            price=priceInfo[1].num;
        end
        grid.Refresh(goods,{state=state,commodity=_data,isSelect=idx==currIdx,price=price});
        grid.SetClickCB(OnClickGrid);
    else
        grid.InitNull();
        grid.SetClickCB(nil);
    end
    grid.SetIndex(idx);
end

--显示描述内容
function SetContent()
    if curDatas and currIdx then
        local d=curDatas[currIdx];
        if d then
            local list=d:GetCommodityList();
            local goods=nil;
            if list then
                goods=list[1].data;
            end
            local price=0;
            local priceInfo=d:GetRealPrice();
            if priceInfo then
                price=priceInfo[1].num;
            end
            CSAPI.SetText(txtTitle,d:GetName());
            CSAPI.SetText(txtDesc,d:GetDesc());
            if grid then
                grid.Refresh(goods,{state=state,price=price,currNum=currNum});
            else
                ResUtil:CreateUIGOAsync("Pet/PetBigGridItem",girdNode,function(go)
                    grid=ComUtil.GetLuaTable(go)
                    grid.Refresh(goods,{state=state,price=price,currNum=currNum});
                    grid.SetClickCB(nil,OnClickRemove);
                end)
            end
        end
    end
end

--显示页签
function SetTab()
    ItemUtil.AddItems("Pet/PetHeadTab",headList,headsData,headNode,nil,1,{idx=currTab,key=viewKey});
end

function OnTabClick(_d)
    if _d and _d.data.id~=currTab and _d.key==viewKey then
        currIdx=1;
        currTab=_d.data.id;
        currCType=_d.data.type;
        Refresh();
    end
end


--背包
function OnClickS1()
    EventMgr.Dispatch(EventType.PetActivity_Tab_Click,1);
end

--购买
function OnClickS2()
    if currIdx and curDatas and curDatas[currIdx] and currNum>=1 then
        CSAPI.OpenView("ShopPayView", {
            commodity = curDatas[currIdx],
            pageData = pageData,
            callBack = OnBuyRet
        },2);
        -- ShopCommFunc.BuyCommodity(curDatas[currIdx], currNum,function(proto)
        --     currNum=1;
        --     Refresh();
        --     UIUtil:OpenSummerReward({proto.gets})
        -- end);
    end
end

function OnBuyRet(proto)
    if proto then
        currNum=1;
        Refresh();
        UIUtil:OpenSummerReward({proto.gets})
    end
end

function OnClickGrid(lua)
    if lua and lua.GetIndex()~=currIdx then
        if currIdx then
            local l=layout:GetItemLua(currIdx);
            if l then
                l.SetSelect(false);                
            end
        end
        currIdx=lua.GetIndex();
        currNum=1;
        lua.SetSelect(true);
    -- else
    --     local comm=lua.elseData and lua.elseData.commodity or nil;
    --     if comm and (currNum+1<=comm:GetNum() or (comm:GetNum()==-1 and comm:GetOnecBuyLimit()>=currNum+1)) then
    --         currNum=currNum+1;
    --     end
    end
    --刷新信息简介
    SetContent();
end

-- function OnClickBigGrid()
--     if currIdx and curDatas and curDatas[currIdx] then
--         local comm=curDatas[currIdx];
--         if comm and (currNum+1<=comm:GetNum() or (comm:GetNum()==-1 and comm:GetOnecBuyLimit()>=currNum+1)) then
--             currNum=currNum+1;
--         end
--          --刷新信息简介
--         SetContent();
--     end
-- end

function OnClickRemove(_num)
    currNum=_num;
end

function Show()
    if IsNil(gameObject) then
        do return end
    end
    CSAPI.SetAnchor(gameObject,0,0);
    CSAPI.SetGOActive(enterTween,true);
end

function Hide()
    if IsNil(gameObject) then
        do return end
    end
    CSAPI.SetAnchor(gameObject,10000,10000);
    CSAPI.SetGOActive(enterTween,false);
end

function CleanCache()
    currIdx=1;--当前选中的格子下标
    currTab=1;
    currNum=1;
    currCType=nil;
end