--购买勘探
local eventMgr=nil;
local curData=nil;
local exList={};
local plusList={};
local layout=nil;
local normalDatas=nil;
local firstGrid=nil;
local firstCanvas=nil;
local exDescList={};
local normalDescList={};
local exDailyList={};
local plusDailyList={};
local firstList={};

function Awake()
    UIUtil:AddTop2("ExplorationBuy",gameObject,OnClickReturn,OnClickHome)
    eventMgr = ViewEvent.New();
    -- eventMgr:AddListener(EventType.Exploration_Click_Open,OnClickBuy)
    eventMgr:AddListener(EventType.Exploration_Open_Ret,OnOpenRet);
    eventMgr:AddListener(EventType.SDK_Pay_Result,OnSDKPayResult)
    eventMgr:AddListener(EventType.SDK_QRPay_Over,OnQROver)
    -- layout = ComUtil.GetCom(hsv, "UISV")
    firstCanvas=ComUtil.GetCom(fixedReward,"CanvasGroup");
    -- layout:Init("UIs/Exploration/ExplorationRewardItem",LayoutCallBack,true);

    CSAPI.SetSwapleftandright(txt_normalPriceType,1)
    CSAPI.SetSwapleftandright(txt_plusPriceType,1)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnClickReturn()
    view:Close();
end

function OnClickHome()
    UIUtil:ToHome()
end

function OnOpen()
    Refresh();
end

function OnSDKPayResult(data)
    -- LogError("OnPayResult")
    CSAPI.SetGOActive(mask,false);
end

function OnQROver()
    CSAPI.SetGOActive(mask,false);
end

function Refresh()
    curData=ExplorationMgr:GetCurrData();
    SetContents(ExplorationState.Ex,txt_normalTitle,txt_normalPrice,txt_normalPriceType,txt_normalOver,btn_normalBuy);
    SetContents(ExplorationState.Plus,txt_plusTitle,txt_plusPrice,txt_plusPriceType,txt_plusOver,btn_plusBuy);
    if curData:GetState()>=ExplorationState.Ex and firstReward~=nil then --大于高级勘探则是已领取
        firstCanvas.alpha=0.5;
        CSAPI.SetGOActive(txt_overFixed,true);
    else
        firstCanvas.alpha=1;
        CSAPI.SetGOActive(txt_overFixed,false);
    end
    if curData and curData:GetBaseMailReward()~=nil and curData:GetDailyRewardID()==nil then
        CSAPI.SetGOActive(normalRewards2,true);
        CSAPI.SetGOActive(normalRewards,false);
        CSAPI.SetGOActive(plusStageRewards,false);
        CSAPI.SetGOActive(plusRewards,false);
        CSAPI.SetGOActive(plusStageRewards2,true);
        local firstRewards=curData:GetBuyRewardShows() or {};
        if firstRewards then
            local fCurList=GetFakeList(firstRewards);
            CreateRewards(firstList,fCurList,normalGrids2);
        end
        local curList2=curData:GetExBuyRewardShows() or {};
        local tempCurList2=GetFakeList(curList2);
        CreateRewards(plusList,tempCurList2,plusGrids2);
    else
        CSAPI.SetGOActive(normalRewards,true);
        CSAPI.SetGOActive(normalRewards2,false);
        CSAPI.SetGOActive(plusStageRewards,true);
        CSAPI.SetGOActive(plusRewards,true);
        CSAPI.SetGOActive(plusStageRewards2,false);
        local firstReward=curData:GetFirstRewardInfo();
        if firstReward then
            local rewards=firstReward:GetRewardData();
            local fakeReward=GridFakeData(rewards[1]);
            if firstGrid==nil then
                ResUtil:CreateUIGOAsync("Exploration/ExplorationRewardItem",fixedNode,function(go)
                    firstGrid=ComUtil.GetLuaTable(go);
                    firstGrid.Refresh(fakeReward);
                    firstGrid.SetClickCB(GridClickFunc.OpenInfoSmiple);
                end)
            else
                firstGrid.Refresh(fakeReward);
            end
        end
        --高级勘探每日获得奖励
        local list={curData:GetDailyReward()} or {};
        curList3=GetFakeList(list);
        CreateRewards(exDailyList,curList3,normalGrids);
        --机密测绘
        local curList2=curData:GetPlusRewardCfgs() or {};
        local tempCurList2=GetFakeList(curList2);
        CreateRewards(plusList,tempCurList2,plusStageGrids);
        --机密勘探每日获得奖励
        local curList4={curData:GetPlusDailyReward()} or {};
        local tempCurList3=GetFakeList(curList4);
        CreateRewards(plusDailyList,tempCurList3,plusGrids);
    end
    -- CreateRewards(exList,curList1,normalGrids);
    --高级测绘阶段性奖励
    local curList1=curData:GetExRewardCfgs() or {};
    normalDatas=GetFakeList(curList1);
    CreateRewards(exList,normalDatas,normalStageGrids);
    -- layout:IEShowList(#curList3);
    --创建描述内容
    CreateDescItems(exDescList,{LanguageMgr:GetByID(34032),LanguageMgr:GetByID(34033)},normalDescObj);
    CreateDescItems(normalDescList,{LanguageMgr:GetByID(34035),LanguageMgr:GetByID(34036)},plusDescObj);
end

function LayoutCallBack(index)
	-- local _data = normalDatas[index]
    local _data=curList3[index]
	local grid=layout:GetItemLua(index);
	grid.SetIndex(index);
	grid.Refresh(_data);
	grid.SetClickCB(GridClickFunc.OpenInfoSmiple);
end

function SetContents(type,txt_title,txt_price,txt_priceType,txt_over,btn_buy)
    -- local isShowTips=false;
    local plusPrice=curData and curData:GetTargetPrice(type);
    local displayPrice=nil;
    local Price=nil;
    local amountPrice=0;
    if CSAPI.IsADV() then
         amountPrice=curData and curData:GetTargetPrice(type);
        local TwdData=curData:GetTWDDataPrice(type);
        if TwdData and TwdData["data"]["displayCurrency"]~=nil then
            Price=TwdData["data"]["displayCurrency"];--描述字符
        end
        if TwdData and TwdData["data"]["displayPrice"]~=nil then
            displayPrice=TwdData["data"]["displayPrice"];--显示价格
            amountPrice=TwdData["cfg"]["amount"];
            amountPrice=math.floor(amountPrice/100);
        end
        if displayPrice~=nil then plusPrice=displayPrice; end
    end


    if type==ExplorationState.Ex then
        -- CSAPI.LoadImg(bg,"UIs/ExplorationCard/img_15_1.png",true,nil,true);
        CSAPI.SetText(txt_title,LanguageMgr:GetByID(18042));
        CSAPI.SetText(txt_price,tostring(plusPrice));
        if CSAPI.IsADV() then CSAPI.SetText(normal_VoucherPrice,tostring(amountPrice)); end
        -- isShowTips=true;
    elseif type==ExplorationState.Plus then
        -- CSAPI.LoadImg(bg,"UIs/ExplorationCard/img_15_2.png",true,nil,true);
        CSAPI.SetText(txt_title,LanguageMgr:GetByID(18040));
        CSAPI.SetText(txt_price,tostring(plusPrice));
        if CSAPI.IsADV()  then CSAPI.SetText(plus_VoucherPrice,tostring(amountPrice)); end
        -- isShowTips=false;
    end
    CSAPI.SetText(txt_priceType,LanguageMgr:GetByID(18013));
    if (CSAPI.IsADV()) and Price~=nil then
        CSAPI.SetText(txt_priceType,Price);
        txt_priceType.transform.localPosition=UnityEngine.Vector3(-47,0,0);
    end
    local isOver=false;
    local curList=nil;
    if curData then
        local curState=curData:GetState()
        if type==ExplorationState.Ex then
            if curState>=ExplorationState.Ex then
                isOver=true;
            end
        else
            if curState==ExplorationState.Plus then
                isOver=true;
            end
        end
    end
    CSAPI.SetGOActive(txt_over,isOver);
    CSAPI.SetGOActive(btn_buy,not isOver);
end

function GetFakeList(curList)
    local list={};
    local l={};
    for k, v in ipairs(curList) do
        local spRewards=v:GetSPReward();
        if spRewards then
            for _, val in pairs(spRewards) do
                if l[val.id]~=nil then
					l[val.id].num=l[val.id].num+val.num;
				else	
					l[val.id]=val;
				end
            end
        end
    end
    if l~=nil then
        for _,val in pairs(l) do
            local info,_=GridFakeData(val);
            table.insert(list,info);
        end
        table.sort(list,function(a,b)
            if a:GetQuality() and b:GetQuality() and a:GetQuality()~=b:GetQuality() then
                return a:GetQuality()>b:GetQuality()
            end
            return a:GetID()<b:GetID()
        end);
    end
    return list;
end

function CreateRewards(itemList,curList,parent)
    ItemUtil.AddItems("Exploration/ExplorationRewardItem", itemList, curList, parent, GridClickFunc.OpenInfoSmiple, 1);
end

function CreateDescItems(itemList,curList,parent)
    ItemUtil.AddItems("Exploration/ExplorationDescItem", itemList, curList, parent);
end

function OnClickPlus()
    OnClickBuy(ExplorationState.Plus);
end

function OnClickNormal()
    OnClickBuy(ExplorationState.Ex);
end

function OnClickPlusVoucher()
    ---抵扣卷打开按钮逻辑注释2026-1-22 需求变更
end

function OnClickBuy(type)
    --获取真实价格
    curData=ExplorationMgr:GetCurrData();
    -- if CSAPI.IsChannel() then
    -- if CSAPI.IsPCPlatform()~=true then
        --调用SDK支付
         if curData~=nil then
            if (curData:GetMaxLv()-curData:GetCurrLv())<10 and type==ExplorationState.Plus then
                local dialogdata = {
                    content = LanguageMgr:GetByID(34037),
                    okCallBack = function()
                        local commInfo=curData:GetTargetCommInfo(type);
                        if commInfo~=nil then
                            ShopCommFunc.HandlePayLogic(commInfo,1);
                        else
                            Tips.ShowTips(LanguageMgr:GetTips(9006));
                        end
                    end
                }
                CSAPI.OpenView("Dialog",dialogdata)
            else
                local commInfo=curData:GetTargetCommInfo(type);
                if commInfo~=nil then
                    ShopCommFunc.HandlePayLogic(commInfo,1);
                else
                    Tips.ShowTips(LanguageMgr:GetTips(9006));
                end
            end
        end
    -- else
    --     Log("PC平台无法调用支付！");
    -- else --临时用
        -- if curData~=nil then
        --     if (curData:GetMaxLv()-curData:GetCurrLv())<10 and type==ExplorationState.Plus then
        --         local dialogdata = {
        --             content = LanguageMgr:GetByID(34037),
        --             okCallBack = function()
        --                 ExplorationProto:Open(curData:GetCfgID(),type)--临时用
        --             end
        --         }
        --         CSAPI.OpenView("Dialog",dialogdata)
        --     else
        --         ExplorationProto:Open(curData:GetCfgID(),type)--临时用
        --     end
        -- end
    -- end
end

function OnOpenRet()
    CSAPI.SetGOActive(mask,false);
    --开通回调
    Refresh();
end
