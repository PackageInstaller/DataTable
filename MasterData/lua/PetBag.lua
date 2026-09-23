--宠物背包
local headList={};
local headsData=nil
local currTab=1;
local eventMgr=nil;
local currIdx=1;--当前选中的格子下标
local currCType=nil;
local currNum=1;
local layout=nil;
local curDatas={};
local grid=nil;
local state=1;
local viewKey="PetBag"
local pageMaxNum=12;
local isShow=true;
local currItem=nil;

function Awake()
    layout=ComUtil.GetCom(hpage,"UISlideshow");
    layout:Init("UIs/Pet/PetGridItem",LayoutCallBack,true,1)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.PetActivity_Head_Click, OnTabClick);
    -- eventMgr:AddListener(EventType.Bag_Update, Refresh);
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
    curDatas=PetActivityMgr:GetPetItemDataByType(currCType);
    if currIdx~=1 and currIdx>#curDatas then
        currIdx=1;
    end
    if curDatas and currIdx<=#curDatas  then
        currItem=curDatas[currIdx];
        if currItem:GetCfg()~=nil then
            EventMgr.Dispatch(EventType.PetActivity_BagSelect_Change,{item=currItem,num=currNum})
        else
            EventMgr.Dispatch(EventType.PetActivity_BagSelect_Change)
        end
    else
        currItem=nil;
        EventMgr.Dispatch(EventType.PetActivity_BagSelect_Change)
    end
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
        grid.Refresh(_data:GetGoods(),{state=state,isSelect=idx==currIdx});
        grid.SetClickCB(OnClickGrid);
    else
        grid.InitNull();
        grid.SetClickCB(nil);
    end
    grid.SetIndex(idx);
end

-- function OnClickBigGrid()
--     if currIdx and curDatas and curDatas[currIdx] then
--         if currNum+1<=curDatas[currIdx]:GetCount() then
--             currNum=currNum+1;
--         end
--         currItem:SetCfgByGoodsID(curDatas[currIdx]:GetID());
--         if currItem:GetCfg()~=nil then
--             EventMgr.Dispatch(EventType.PetActivity_BagSelect_Change,{item=currItem,num=currNum})
--         end
--         --刷新信息简介
--         SetContent();
--     end
-- end

--显示描述内容
function SetContent()
    if currItem then
        local d=currItem:GetGoods() or nil;
        if d then
            CSAPI.SetText(txtTitle,d:GetName());
            CSAPI.SetText(txtDesc,d:GetDesc());
            if grid then
                grid.Refresh(d,{state=state,currNum=currNum});
            else
                ResUtil:CreateUIGOAsync("Pet/PetBigGridItem",girdNode,function(go)
                    grid=ComUtil.GetLuaTable(go)
                    grid.Refresh(d,{state=state,currNum=currNum});
                    grid.SetClickCB(OnClickBigGrid,OnClickRemove);
                end)
            end
        else
            SetContentNull();
        end
    else
        SetContentNull();
    end
end

function SetContentNull()
    if grid then
        grid.SetNull();
    else
        ResUtil:CreateUIGOAsync("Pet/PetBigGridItem",girdNode,function(go)
            grid=ComUtil.GetLuaTable(go)
            grid.SetNull();
            grid.SetClickCB(nil,OnClickRemove);
        end)
    end
    CSAPI.SetText(txtTitle,LanguageMgr:GetByID(62039));
    CSAPI.SetText(txtDesc,LanguageMgr:GetByID(62040));
end

--显示页签
function SetTab()
    ItemUtil.AddItems("Pet/PetHeadTab",headList,headsData,headNode,nil,1,{idx=currTab,key=viewKey});
end

function OnTabClick(_d)
    if _d and _d.data.id~=currTab and _d.key==viewKey then
        currIdx=1;
        currCType=_d.data.type;
        currTab=_d.data.id;
        Refresh();
    end
end

function OnClickRemove(_num)
    currNum=_num;
    if currItem and currItem:GetCfg()~=nil then
        EventMgr.Dispatch(EventType.PetActivity_BagSelect_Change,{item=currItem,num=currNum})
    end
end

--商店
function OnClickS1()
    EventMgr.Dispatch(EventType.PetActivity_Tab_Click, 2);
end

--使用
function OnClickS2()
    if  PetActivityMgr:GetDisUse() then
        Tips.ShowTips(LanguageMgr:GetTips(42007));
        do return end;
    end
    local pet=PetActivityMgr:GetCurrPetInfo();
    if pet and (pet:GetCurrAction()==PetTweenType.sport or pet:GetCurrAction()==PetTweenType.walk) then
        local dialogData={
            content = LanguageMgr:GetTips(42006),
            okCallBack =  function()
                UseItem();
            end,
        }
        CSAPI.OpenView("Dialog",dialogData);
        do return end;
    end
    UseItem();
end

function UseItem()
    --检测是否有值溢出或变成0
    local pet=PetActivityMgr:GetCurrPetInfo();
    if currItem and pet then
        --计算数据
        local preH,preW,preF=pet:GetHappy(),pet:GetWash(),pet:GetFood();
        preH=preH+currItem:GetHappyChange()*currNum;
        preW=preW+currItem:GetWashChange()*currNum;
        preF=preF+currItem:GetFoodChange()*currNum;
        local content=nil;
        local isDialog=1;
        if preF>pet:GetFullFood() or preF<0 then
            isDialog=2
            content=preF<0 and LanguageMgr:GetTips(42005,LanguageMgr:GetTips(42010)) or LanguageMgr:GetTips(42009);
        elseif preW>pet:GetFullWash() or preW<0 then
            isDialog=preW<0 and 2 or 3;
            content=preW<0 and LanguageMgr:GetTips(42005,LanguageMgr:GetTips(42011)) or LanguageMgr:GetTips(42008,LanguageMgr:GetTips(42011));
        elseif preH>pet:GetFullHappy() or preH<0 then
            isDialog=preH<0 and 2 or 3;
            content=preH<0 and LanguageMgr:GetTips(42005,LanguageMgr:GetTips(42012)) or LanguageMgr:GetTips(42008,LanguageMgr:GetTips(42012));
        end
        if isDialog==1 then
            PlayerProto:UseItem({id=currItem:GetGoodsID(),cnt=currNum},false,function(proto)
                currNum=1;
                Refresh();
                EventMgr.Dispatch(EventType.PetActivity_UseItem_Ret,proto);
            end);
        elseif isDialog==3 then
            local dialogData = {
                content = content,
                okCallBack = function()
                    if  PetActivityMgr:GetDisUse() then
                        Tips.ShowTips(LanguageMgr:GetTips(42007));
                        do return end;
                    end
                    PlayerProto:UseItem({id=currItem:GetGoodsID(),cnt=currNum},false,function(proto)
                        currNum=1;
                        Refresh();
                        EventMgr.Dispatch(EventType.PetActivity_UseItem_Ret,proto);
                    end);
                end
            }
            CSAPI.OpenView("Dialog", dialogData);
        elseif isDialog==2 then
            Tips.ShowTips(content);
        end
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
    --     if currNum+1<=lua.data:GetCount() then
    --         currNum=currNum+1;
    --     end
    end
    currItem=curDatas[currIdx];
    if currItem:GetCfg()~=nil then
        EventMgr.Dispatch(EventType.PetActivity_BagSelect_Change,{item=currItem,num=currNum})
    end
    --刷新信息简介
    SetContent();
end

function CleanCache()
    currIdx=1;--当前选中的格子下标
    currTab=1;
    currNum=1;
    currCType=nil;
end

function Show()
    if IsNil(gameObject) then
        do return end
    end
    isShow=true
    CSAPI.SetAnchor(gameObject,0,0);
    CSAPI.SetGOActive(enterTween,true);
end

function Hide()
    if isShow then
        EventMgr.Dispatch(EventType.PetActivity_BagSelect_Change)
    end
    currItem=nil;
    isShow=false;
    if IsNil(gameObject) then
        do return end
    end
    CSAPI.SetAnchor(gameObject,10000,10000);
    CSAPI.SetGOActive(enterTween,false);
end