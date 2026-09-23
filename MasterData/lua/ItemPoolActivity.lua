--道具池主界面
local pool=nil;
local endTime=0;
local fixedTime=60;
local upTime=0;
local overTime=0;
local eventMgr=nil;
local hasOther=false;
function Awake()
    Top=UIUtil:AddTop2("ItemPoolActivity",gameObject, OnClickReturn,OnClickHomeFunc)
    InitListener()
end

function OnDestroy()
    eventMgr:ClearListener();
end

function InitListener()
	eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.ItemPool_Date_Update, OnpoolUpdate);
    eventMgr:AddListener(EventType.ItemPool_Draw_Ret,OnDrawRet)
end

function OnClickReturn()
    view:Close();
end

function OnClickHomeFunc()
    UIUtil:ToHome()
end

--data={id=xxx,overTime=xxx}
function OnOpen()
    if data then
        Refresh(data.id,data.overTime);
    end
end

function Refresh(poolId,_overTime)
    if poolId then
        pool=ItemPoolActivityMgr:GetPoolInfo(poolId);
        if pool==nil then
            LogError("无法获取道具池："..tostring(poolId));
            do return end;
        end
        -- LogError(pool:GetRound())
        --刷新开始关闭时间
        if  pool:GetPropType()==ItemPoolPropType.TimeLimit then
            CSAPI.SetGOActive(txt_time,true);
            overTime=TimeUtil:GetTimeStampBySplit(pool:GetCloseTime())
            endTime=overTime-TimeUtil:GetTime();
            RefreshDownTime();
        elseif pool:GetPropType()==ItemPoolPropType.Regression then
            CSAPI.SetGOActive(txt_time,true);
            overTime=_overTime;
            endTime=overTime-TimeUtil:GetTime();
            RefreshDownTime();
        else
            CSAPI.SetGOActive(txt_time,false);
        end
        --判断是否显示下一轮补给
        local canNext,_h=pool:CanNext();
        hasOther=_h;
        local isAdd = pool:CanGet();
        UIUtil:SetRedPoint(btnGet, isAdd, 110, 35, 0)
        CSAPI.SetGOActive(btnNext,canNext);
    end
end

function Update()
    if endTime and endTime>0 then
        upTime=upTime+Time.deltaTime;
        if upTime>=fixedTime then
            endTime=endTime-fixedTime;
            RefreshDownTime();
            upTime=0;
        end
    end
end

function RefreshDownTime()
    -- local t=TimeUtil:GetTimeStampBySplit(pool:GetCloseTime());s
    local count=TimeUtil:GetDiffHMS(overTime,TimeUtil.GetTime());
    if count.day>0 or count.hour>0 or count.minute>0 or count.second>60 then
        CSAPI.SetText(txt_time,string.format("%s%s",LanguageMgr:GetByID(60102),LanguageMgr:GetByID(34039,count.day,count.hour,count.minute)));
    else
        CSAPI.SetText(txt_time,string.format("%s%s",LanguageMgr:GetByID(60102),LanguageMgr:GetByID(1062,count.second)));
    end
    if endTime<=0 then--回到主界面并提示
        HandlerOver();
    end
end

--活动结束
function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(24001));
    end,nil,100);      
end

function OnClickGet()
    --打开抽取界面
    local itemInfo=pool:GetCostGoods();
    local count=BagMgr:GetCount(itemInfo:GetID());
    if count==0 then
        Tips.ShowTips(LanguageMgr:GetByID(60116));
        do return end
    elseif pool:IsOver() then
        Tips.ShowTips(LanguageMgr:GetTips(38006));
        do return end
    end
    CSAPI.OpenView("ItemPoolDraw",pool);
end

function OnClickNext()
    --点击下一轮
    if hasOther then
        local dialogpool = {
			content = LanguageMgr:GetByID(60110),
			okCallBack = function()
                RegressionProto:ItemPoolInfo(pool:GetID(),true);
			end,
		}
		CSAPI.OpenView("Dialog", dialogpool);
    else
        RegressionProto:ItemPoolInfo(pool:GetID(),true);
    end
end

function OnClickPreview()
    --点击预览界面
    CSAPI.OpenView("ItemPoolRewardActivity",pool);
end

function OnClickDetails()
    --点击详情界面
    CSAPI.OpenView("ItemPoolPreview",pool);
end

function OnpoolUpdate()
    Tips.ShowTips(LanguageMgr:GetTips(38001));
    Refresh(pool:GetID(),overTime);
end

function OnDrawRet(proto)
    if proto then
        if proto.info and proto.info.round>pool:GetRound()  then
            Tips.ShowTips(LanguageMgr:GetTips(38001));
        end 
        Refresh(pool:GetID(),overTime);
    end
end