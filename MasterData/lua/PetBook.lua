--宠物图鉴
local layout1=nil;
local layout2=nil;
local curDatas={}
local curDatas2={}
local curIdx=nil;
local currState=1;--1.物品列表 2.物品详情 3.奖励列表
local unLockNum=0;
local eventMgr=nil;
local progress=nil;
local pageMaxNum=16

function Awake()
    progress=ComUtil.GetCom(progressBar,"Image");
    layout1=ComUtil.GetCom(hpage,"UISlideshow");
    layout1:Init("UIs/Pet/PetBookGrid",LayoutCallBack,true,1)
    layout2=ComUtil.GetCom(hpage2,"UISlideshow");
    layout2:Init("UIs/Pet/PetReviceItem",LayoutCallBack2,true,1)
    SetList();
    eventMgr = ViewEvent.New();
    -- eventMgr:AddListener(EventType.PetActivity_Tab_Click, OnUnLockRet);
    eventMgr:AddListener(EventType.PetActivity_Bestiary_Ret,Refresh);
    eventMgr:AddListener(EventType.PetActivity_BestiaryReward_Ret,OnRewardRet)
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
    eventMgr:AddListener(EventType.PetActivity_Click_BookItem,OnClickReviceGrid)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function SetList()
    curDatas=PetActivityMgr:GetArchiveInfo();
    curDatas2=PetActivityMgr:GetArchiveRewardInfo();
end

function Init()
    CleanCache();
    SetRedInfo();
    Refresh();
end

function Refresh()
    if IsNil(gameObject) then
        do return end
    end
    CSAPI.SetGOActive(listObj,currState==1);
    CSAPI.SetGOActive(infoObj,currState==2);
    CSAPI.SetGOActive(rewardObj,currState==3);
    CSAPI.SetGOActive(btnS1,currState~=1);
    unLockNum=PetActivityMgr:GetUnLockNum();
    CSAPI.SetText(txtProgressVal,unLockNum.."/"..#curDatas);
    progress.fillAmount=unLockNum/#curDatas;
    if currState==1 then
        EventMgr.Dispatch(EventType.PetActivity_SetLine_State,{state=true,pos={-9.24,-412}});
        local num=12; 
        if #curDatas%pageMaxNum==0 and #curDatas~=0 then
            num=#curDatas;
        else
            num=(pageMaxNum-#curDatas%pageMaxNum)+#curDatas;
        end
        table.sort(curDatas,function(a,b)
            return a:GetNO()<b:GetNO();
        end)
        layout1:IEShowList(num);
    elseif currState==2 then 
        EventMgr.Dispatch(EventType.PetActivity_SetLine_State,{state=false});
        SetInfos();
    elseif currState==3 then
        EventMgr.Dispatch(EventType.PetActivity_SetLine_State,{state=false});
        layout2:IEShowList(#curDatas2);
    end
end

function LayoutCallBack(idx)
    local _data = curDatas[idx]
    local grid=layout1:GetItemLua(idx);
    if _data then
        grid.Refresh(_data,{isPre=_data:IsLock()});
        grid.SetClickCB(OnClickGrid);
    else
        grid.InitNull();
        grid.SetClickCB(nil);
    end
    grid.SetIndex(idx);
end

function LayoutCallBack2(idx)
    local _data = curDatas2[idx]
    local item=layout2:GetItemLua(idx);
    item.Refresh(_data);
end

function OnClickGrid(_d)
    if _d and _d.GetIndex()~=curIdx then
        curIdx=_d.GetIndex();
        currState=2;
        Refresh();
    end
end

function SetInfos()
    if IsNil(gameObject) or curIdx==nil then
        do return end
    end
    local curItem=curDatas[curIdx];
    if curItem==nil then
        do return end
    end
    if curIdx then
        CSAPI.SetGOActive(btnDown,curIdx<#curDatas);
        CSAPI.SetGOActive(btnUp,curIdx>1);
    else
        CSAPI.SetGOActive(btnDown,#curDatas>0);
        CSAPI.SetGOActive(btnUp,false);
    end
    local isLock=curItem:IsLock();
    CSAPI.SetText(txtNo,tostring(curItem:GetNONumb()));
    CSAPI.SetGOActive(getInfoObj,isLock);
    CSAPI.SetGOActive(detialsObj,isLock~=true);
    CSAPI.SetText(txt_get,curItem:GetDesc());
    local goods=curItem:GetGoods();
    if goods then
        CSAPI.SetText(txtName,goods:GetName());
    end
    if isLock then
        CSAPI.LoadImg(icon,"UIs/Pet/img_04_31.png",true,nil,true);
    else
        ResUtil.IconGoods:Load(icon,curItem:GetIcon());
    end
    local num=curItem:GetQuality();
    for i=1,3 do
        CSAPI.SetGOActive(this["star"..i],num>=i);
    end
end

function OnUnLockRet()
    Refresh();
end

function OnClickRevice()
    currState=3;
    Refresh();
end

function OnClickDown()
    if curIdx==nil or curDatas==nil or curIdx>=#curDatas then
        do return end
    end
    -- curIdx=curIdx+1;
    PlayTween(curIdx+1);
    -- Refresh();
end

function OnClickUp()
    if curIdx==nil or curIdx<=1 then
        do return end
    end
    PlayTween(curIdx-1);
    -- curIdx=curIdx-1;
    -- Refresh();
end

function OnClickReviceGrid(eventData)
    --查找对应index并显示
    if curDatas and eventData then
        for k,v in ipairs(curDatas) do
            if v:GetID()==eventData then
                curIdx=k;
                break;
            end
        end
        currState=2;
        Refresh();
    end
end

function OnClickS1()
    curIdx=nil;
    currState=1;
    Refresh();
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
    currState=1;
    curIdx=nil;
end

function OnRewardRet(proto)--刷新一下列表
    if layout2 then
        layout2:UpdateList();
    end
end

function SetRedInfo()
	local redInfo=RedPointMgr:GetData(RedPointType.ActiveEntry16);
	local isRed=redInfo and redInfo.hasBook==true or false;
    CSAPI.SetGOActive(redObj,isRed);
	-- UIUtil:SetRedPoint(topObj,isRed,310,40);
end

local holdDownTime = 0
local holdTime = 0.1
local startPosX = 0

function OnPressDown(isDrag, clickTime)
    holdDownTime = Time.unscaledTime
    startPosX = CS.UnityEngine.Input.mousePosition.x
    CSAPI.SetGOActive(pressTween,true);
    CSAPI.SetGOActive(pressUpTween,false);
    CSAPI.SetGOActive(dragTween,false);
    CSAPI.SetGOActive(dragTween2,false);
end

function OnPressUp(isDrag, clickTime)
    if Time.unscaledTime - holdDownTime >= holdTime then
        local len = CS.UnityEngine.Input.mousePosition.x - startPosX
        if (math.abs(len) > 115) then
            local index=curIdx
            if (len > 0) then
                 --图片左移
                 index=curIdx-1<=0 and 0 or curIdx-1;
            else
                --图片右移
                index=curIdx+1>=#curDatas and #curDatas or curIdx+1;
            end
            --移动动画
            PlayTween(index);
        end
    end
    CSAPI.SetGOActive(pressTween,false);
    CSAPI.SetGOActive(pressUpTween,true);
end

function PlayTween(index)
    CSAPI.SetGOActive(dragTween,false);
    CSAPI.SetGOActive(dragTween2,false);
    if curDatas and  index>0 and index<=#curDatas then
        CSAPI.SetGOActive(dragTween,curIdx<index);
        CSAPI.SetGOActive(dragTween2,curIdx>index);
        curIdx=index;
        CSAPI.SetGOActive(mask,true);
        FuncUtil:Call(SetInfos,nil,200);
        FuncUtil:Call(function()
            CSAPI.SetGOActive(mask,false);
        end,nil,400);
    end
end