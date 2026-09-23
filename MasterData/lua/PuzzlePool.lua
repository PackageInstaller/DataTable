--拼图奖池
local layout=nil;
local curDatas=nil;
local selectItem=nil;
local moneyItem=nil;
local datas=nil;
local loopTime=0;
local fixedTime=1;
local totalTime=0;
local buyCfg=nil;

function Awake()
	layout = ComUtil.GetCom(vsv, "UISV")
    layout:Init("UIs/PuzzleActivity/PuzzleGoods",LayoutCallBack,true)
    local go = ResUtil:CreateUIGO("PuzzleActivity/PuzzlePoolMoneyItem", moneyNode.transform)
    moneyItem = ComUtil.GetLuaTable(go)
    local viewCfg = Cfgs.view:GetByKey("PuzzlePool")
    datas=viewCfg.Show_CurrencyType or nil;
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Puzzle_Selected_Goods, OnSelected);
    eventMgr:AddListener(EventType.Puzzle_Buy_Ret,OnBuyRet)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnOpen()
    Refresh()
end

function Refresh()
      --初始化奖励池信息
      if data then
        local tagID=74019;
        curDatas={};
        if data:GetFragmentsWay()==PuzzleEnum.GetWayType.Draw then
            tagID=74018;
            local cfg=data:GetDrawCfg();
            if cfg and cfg.item then
                CSAPI.SetText(txtHas,BagMgr:GetCount(cfg.item[1].id));
                for k,v in ipairs(cfg.item) do
                    table.insert(curDatas,v);
                end
            end
            CSAPI.SetGOActive(moneyNode,false);
            CSAPI.SetGOActive(btnSubmit,true);
        elseif data:GetFragmentsWay()==PuzzleEnum.GetWayType.Buy then
            curDatas=data:GetBuyComms();
            if datas and moneyItem then
                CSAPI.SetGOActive(moneyNode,true);
                moneyItem.SetMoney(datas)
            else
                CSAPI.SetGOActive(moneyNode,false);
            end
            CSAPI.SetGOActive(btnSubmit,false);
            local buyCfg=data:GetBuyCfg();
            if buyCfg and buyCfg.endTime then
                local endTime=TimeUtil:GetTimeStampBySplit(buyCfg.endTime);
                local currTime = TimeUtil:GetTime()
                totalTime=endTime-currTime;
            end
        end 
        if curDatas then
            layout:IEShowList(#curDatas);
        else
            layout:IEShowList(0);
        end
        CSAPI.SetGOActive(hasObj,data:GetFragmentsWay()==PuzzleEnum.GetWayType.Draw);
        CSAPI.SetGOActive(btnDesc,data:GetFragmentsWay()==PuzzleEnum.GetWayType.Draw);
        CSAPI.SetText(txtBuy,LanguageMgr:GetByID(tagID));
        local lID=data:GetFragmentsWay()==PuzzleEnum.GetWayType.Buy and 74019 or 74017;
        CSAPI.SetText(txtS1,LanguageMgr:GetByID(lID));
        CheckIsOver();
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
	local grid=layout:GetItemLua(index);
    local isSelect=false;
    if selectItem then
        isSelect=selectItem.GetID()==_data:GetID()
    end
	grid.Refresh(_data,data:GetFragmentsWay(),isSelect);
end

function OnSelected(eventData)   
    if eventData and eventData.tab then
        CSAPI.OpenView("ShopPayView",{
            commodity=eventData.tab.GetData(),
            payFunc=OnClickPay,
            spType=3
        })
    end
end

function OnClickPay(payInfo)
    if payInfo~=nil then
        local costs=payInfo.comm:GetCosts();
        local costIdx=payInfo.shopPriceKey==ShopPriceKey.jCosts and 1 or 2
        local cost = costs[costIdx];
        if cost then
            local goodsInfo = BagMgr:GetFakeData(cost.id);
            local dialogData = {}
            dialogData.content = LanguageMgr:GetByID(74021, goodsInfo:GetName(), cost.num)
            dialogData.okCallBack = function()
                ActivePuzzleProto:BuyPuzzle(data:GetID(), payInfo.comm:GetID(), costIdx);
            end
            CSAPI.OpenView("Dialog", dialogData)
        end
    end
end

function Update()
    loopTime=loopTime+Time.deltaTime;
    if totalTime and totalTime>0 and (loopTime>=fixedTime) then
        totalTime=totalTime-fixedTime;
        if totalTime<=0 then
            view:Close();
        end
        loopTime=0;
    end
end

function OnClickClose()
    view:Close()
end

function OnClickSubmit()
    if data then
        if data:GetFragmentsWay()==PuzzleEnum.GetWayType.Draw then
            local cost=data:GetDrawCost();
            local goodsInfo=BagMgr:GetFakeData(cost[1][1]);
            local dialogData= {}
            dialogData.content = LanguageMgr:GetByID(74011,goodsInfo:GetName(),cost[1][2])
            dialogData.okCallBack = function()
                ActivePuzzleProto:DrawPuzzle(data:GetID());
            end
            CSAPI.OpenView("Dialog",dialogData)
        -- elseif data:GetFragmentsWay()==PuzzleEnum.GetWayType.Buy then
        --     if selectItem then
        --         --购买
        --         CSAPI.OpenView("PuzzleMultPayView",{comm=selectItem.GetData(),activityId=data:GetID()})
        --     else
        --         Tips.ShowTips(LanguageMgr:GetByID(74022));
        --     end
        end
    end
end

function OnClickDesc()
    if data then
        local cfg=data:GetDrawCfg();
        if cfg then
            CSAPI.OpenView("PackGetInfo",cfg)
        end
    end
end

function OnBuyRet()
    if CSAPI.IsViewOpen("ShopPayView") then --购买返回，关闭购买界面
        CSAPI.CloseView("ShopPayView");
    end
    selectItem=nil;
    if data then
        data=PuzzleMgr:GetData(data:GetID());
    end
    --记录新增的
    Refresh()
end

function CheckIsOver()
    if data then
        if data:GetType()==ePuzzleType.Type1 then
            --计算剩余
            local grids=data:GetFragments(true);
            if grids ==nil or (#grids==0) then
                CSAPI.SetGOActive(txtOver,true);
            elseif grids then
                local costInfos={};
                for k, v in ipairs(grids) do
                    for _, val in ipairs(v:GetCost()) do
                        costInfos[val[1]]=costInfos[val[1]] and costInfos[val[1]]+costInfos[2] or costInfos[2]
                    end
                end
                local isOver=true;
                for k, v in pairs(costInfos) do
                    if BagMgr:GetCount(k)<=v then --道具解锁数量不够
                        isOver=false;
                        break;
                    end
                end
                CSAPI.SetGOActive(txtOver,isOver);
            else
                CSAPI.SetGOActive(txtOver,false);
            end
        else
            if data:HasOverReward() then
                CSAPI.SetGOActive(txtOver,true);
            else
                CSAPI.SetGOActive(txtOver,false);
            end
        end
    else
        CSAPI.SetGOActive(txtOver,true);
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
