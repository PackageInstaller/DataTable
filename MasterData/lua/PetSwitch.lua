--宠物切换
local totalNum=0;
local currNum=0;
local layout=nil;
local curDatas={}
local slider=nil;
local isChoosie=false;
local curIdx=nil;
local hp=nil;
local heath=nil;
local hunger=nil;
local lBar=nil;
local eventMgr=nil;
local redInfo=nil;
function Awake()
    detailsTween=ComUtil.GetCom(detialsObj,"ActionFadeCurve");
    getsTween=ComUtil.GetCom(getInfoObj,"ActionFadeCurve");
    slider=ComUtil.GetCom(progressBar,"Image")
    hp=ComUtil.GetCom(hpSlider,"Image")
    heath=ComUtil.GetCom(heathSlider,"Image")
    hunger=ComUtil.GetCom(hungerSlider,"Image")
    layout=ComUtil.GetCom(hpage,"UISlideshow");
    lBar=ComUtil.GetCom(lifeBar,"Image")
    layout:Init("UIs/Pet/PetInfoGrid",LayoutCallBack,true,1)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo);
end


function OnDestroy()
    eventMgr:ClearListener();
end

function Init()
    CleanCache();
    Refresh();
end

function SetRedInfo()
    redInfo=RedPointMgr:GetData(RedPointType.ActiveEntry16);
    Refresh();
end

function Refresh()
    --设置当前收集数量
    CSAPI.SetGOActive(listObj,not isChoosie);
    CSAPI.SetGOActive(infoObj,isChoosie);
    curDatas=PetActivityMgr:GetAllPets();
    currNum=0;
    for k,v in ipairs(curDatas) do
        if v:IsLock()~=true then
            currNum=currNum+1;
        end
    end
    CSAPI.SetText(txtProgressVal,currNum.."/"..#curDatas);
    slider.fillAmount=currNum/#curDatas;
    if isChoosie then
        EventMgr.Dispatch(EventType.PetActivity_SetLine_State,{state=false});
        --初始化信息
        SetPetInfo();
    else
        EventMgr.Dispatch(EventType.PetActivity_SetLine_State,{state=true,pos={-9.24,-430}});
        layout:IEShowList(#curDatas);
    end
end

function SetPetInfo()
    if curIdx==nil then
        do return end
    end
    local curPet=curDatas[curIdx];
    if curPet==nil then
        do return end
    end
    local isLock=curPet:IsLock();
    CSAPI.SetText(txtNo,tostring(curPet:GetNONumb()));
    local cPet=PetActivityMgr:GetCurrPetInfo()
    if cPet and cPet:GetID()==curPet:GetID() then
        CSAPI.SetGOActive(hasObj,true)
    else
        CSAPI.SetGOActive(hasObj,false)
    end
    CSAPI.SetGOActive(btnUp,curIdx>1);
    CSAPI.SetGOActive(btnDown,curIdx<#curDatas);
    CSAPI.SetText(txtName,curPet:GetName());
    CSAPI.SetGOActive(getInfoObj,isLock);
    CSAPI.SetGOActive(detialsObj,true);
    CSAPI.SetGOActive(btnS1,not isLock);
    if isLock then
        --读取图标
        CSAPI.LoadImg(icon,"UIs/Pet/img_04_24.png",true,nil,true);
        CSAPI.SetGOActive(hasNode,false);
        CSAPI.SetText(txt_get,curPet:GetTxt());
        CSAPI.SetAnchor(btnS2,-40,-329.9);
    else
        PetActivityMgr:AddUnLockPetList(curPet:GetID()); --记录当前的宠物红点数据
        -- CSAPI.LoadImg(icon,"UIs/Pet/img_04_23.png",true,nil,true);
        ResUtil.PetIcon:Load(icon,curPet:GetIcon())
        local _happy=curPet:GetHappyPercent();
        local _wash=curPet:GetWashPercent();
        local _food=curPet:GetFoodPercent();
        hp.fillAmount=_happy;
        heath.fillAmount=_wash;
        hunger.fillAmount=_food;
        CSAPI.SetText(txtHP,tostring(math.floor(100*_happy).."%"));
        CSAPI.SetText(txtHeath,tostring(math.floor(100*_wash).."%"));
        CSAPI.SetText(txtHunger,tostring(math.floor(100*_food).."%"));
        -- LogError(_happy.."\t".._wash.."\t".._food)
        -- LogError(curPet)
        lBar.fillAmount=curPet:GetExpPercent();
        CSAPI.SetText(txtLifeTips,curPet:GetExpPercentDesc());
        CSAPI.SetGOActive(hasNode,true);
        CSAPI.SetAnchor(btnS2,-213.6,-329.9);
    end
end

function LayoutCallBack(idx)
    local _data = curDatas[idx]
    local grid=layout:GetItemLua(idx);
    local isRed=false;
    if redInfo and redInfo.newPets then
        for k,v in ipairs(redInfo.newPets) do
            if v==_data:GetID() then
                isRed=true;
                break;
            end
        end
    end 
    grid.Refresh(_data,isRed);
    grid.SetClickCB(OnClickGrid);
    grid.SetIndex(idx);
end

function OnClickGrid(lua)
    if curIdx~=lua.GetIndex() then
        curIdx=lua.GetIndex();
        isChoosie=true;
        Refresh();
    end
end

function OnClickDown()
    if curIdx==nil or curDatas==nil or curIdx>=#curDatas then
        do return end
    end
    PlayTween(curIdx+1);
    -- curIdx=curIdx+1;
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

function OnClickS1()
    --切换宠物
    if curIdx and curDatas then
        local curPet=curDatas[curIdx];
        local cPet=PetActivityMgr:GetCurrPetInfo()
        if cPet==nil or (cPet and curPet:GetID()~=cPet:GetID()) then
            local dialogdata = {
                content = LanguageMgr:GetTips(42018),
                okCallBack = function()
                    SummerProto:PetSwitch(curPet:GetID())
                end
            }
            CSAPI.OpenView("Dialog", dialogdata);
        else
            Tips.ShowTips(LanguageMgr:GetTips(42019));
        end
    end
end

function OnClickS2()
    curIdx=nil;
    isChoosie=false;
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
    isChoosie=false;
    curIdx=nil;
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
    CSAPI.SetGOActive(getInfoObj,false);
    CSAPI.SetGOActive(detialsObj,false);
    if curDatas and  index>0 and index<=#curDatas then
        CSAPI.SetGOActive(dragTween,curIdx<index);
        CSAPI.SetGOActive(dragTween2,curIdx>index);
        curIdx=index;
        CSAPI.SetGOActive(mask,true);
        FuncUtil:Call(SetPetInfo,nil,200);
        FuncUtil:Call(function()
            CSAPI.SetGOActive(mask,false);
        end,nil,400);
    end
end