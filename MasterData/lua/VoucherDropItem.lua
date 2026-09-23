--折扣券物体
local options={};
local opDatas=nil;
local drop=nil;
local data=nil;
local dropVal=nil;
local isChoosie=true;
local lockVID=nil;
local hasVID=false;
local currNum=0;
local isMax=false;
local shopPriceKey=ShopPriceKey.jCosts;
local descItems={};

function Awake()
    --设置mask大小
    -- local arr = CSAPI.GetMainCanvasSize()
    CSAPI.SetRectSize(mask,100000,100000);
    local x,y=CSAPI.GetAnchor(gameObject.transform.parent.gameObject);
    -- CSAPI.SetAnchor(mask,-x,-y);
end

--data=CommodityDat
function Init(_d,_num,_isMax,_shopPriceKey)
    data=_d;
    currNum=_num or 1;
    lockVID=ShopMgr:GetJumpVoucherID();
    shopPriceKey=_shopPriceKey;
    isMax=_isMax;
    opDatas=GetVoucherOptions();
    Refresh();
    local cData=GetChooiseList();
    if cData then
        EventMgr.Dispatch(EventType.Shop_PayVoucher_Change,cData)
    end
end

function Refresh()
    if data==nil then
        do return end
    end
    SetChoosieState(isChoosie);
    if lockVID==nil  then
        CSAPI.SetGOActive(useNode,true);
        CSAPI.SetGOActive(unUseNode,false);
        CSAPI.SetGOActive(rightObj,#opDatas>0);
        if dropVal==nil then
            dropVal=1;
        end
        ItemUtil.AddItems(isMax and "ShopComm/VoucherDownListItem2" or "ShopComm/VoucherDownListItem",options,opDatas,Content,OnDropChange,1,dropVal);
    else
        if #opDatas==0 then
            CSAPI.SetGOActive(useNode,false);
            CSAPI.SetGOActive(unUseNode,true);
            CSAPI.SetGOActive(rightObj,false);
            hasVID=false;
        else
            local isShowUse=false;
            if hasVID and dropVal~=nil then
                isShowUse=true;
            end
            CSAPI.SetGOActive(useNode,isShowUse);
            CSAPI.SetGOActive(unUseNode,isShowUse~=true);
            CSAPI.SetGOActive(rightObj,true);
            ItemUtil.AddItems(isMax and "ShopComm/VoucherDownListItem2" or "ShopComm/VoucherDownListItem",options,opDatas,Content,OnDropChange,1,dropVal);
        end
    end
    SetDropInfo();
end

function OnDropChange(lua)
    if lua and lua.GetIndex()~=dropVal then
        options[dropVal].SetSelect(false);
        lua.SetSelect(true);
        dropVal=lua.GetIndex();
    end
    SetDropInfo();
    SetDownList(false)
    EventMgr.Dispatch(EventType.Shop_PayVoucher_Change,GetChooiseList())
end

function SetDropInfo()
    if opDatas and dropVal and opDatas[dropVal] then
        CSAPI.SetText(txtName,opDatas[dropVal].txt);
        CSAPI.SetText(txtTime,opDatas[dropVal].txt2);
        local isShow=(opDatas[dropVal].txt2~=nil and opDatas[dropVal].txt2~="")
        CSAPI.SetGOActive(txtTime,isShow)
        CSAPI.SetText(txtVoucher,"-"..opDatas[dropVal].discount);
        if IsNil(nameLayout2)~=true then
            CSAPI.SetText(txtName2,opDatas[dropVal].txt);
            CSAPI.SetText(txtVoucher2,"-"..opDatas[dropVal].discount);
            if opDatas[dropVal].txt2==nil or opDatas[dropVal].txt2=="" then
                CSAPI.SetGOActive(nameLayout2,true);
                CSAPI.SetGOActive(nameLayout,false);
            else
                CSAPI.SetGOActive(nameLayout,true);
                CSAPI.SetGOActive(nameLayout2,false);
            end
        end
    end
end

function GetChooiseList()
    if isChoosie and opDatas and opDatas[dropVal] then
        return {{id=opDatas[dropVal].id,num=1}};
    end
    return nil;
end

function SetDownList(isShow)
    CSAPI.SetGOActive(mask,isShow==true);
    CSAPI.SetGOActive(downListObj,isShow==true);
    CSAPI.SetRectAngle(arrow,0,0,isShow and 180 or 0);
end

function OnClickAnyway()
    SetDownList(false)
    CloseQuestion();
end

--显示下拉框
function OnClickDrop()
    if not IsNil(downListObj) and downListObj.activeSelf==true then
        OnClickAnyway()
        do return end;
    end
    CSAPI.SetGOActive(useNode,true);
    CSAPI.SetGOActive(unUseNode,false);
    if dropVal==nil and #opDatas>0 then
        dropVal=1;
        options[dropVal].SetSelect(true);
        SetDropInfo();
        EventMgr.Dispatch(EventType.Shop_PayVoucher_Change,GetChooiseList())
    end
    SetDownList(true)
     --计算显示范围
     local num=4;
     if isMax then
         num=5;
     end
     local maxNum=#opDatas;
     local height=maxNum>num and num*60+(num-1)*8+30 or maxNum*60+(maxNum-1)*8+30
     local size=CSAPI.GetRTSize(downListObj);
     CSAPI.SetRTSize(downListView,size[0],height);
end

function SetChoosieState(_isChoosie)
    CSAPI.SetGOActive(onObj,_isChoosie==true);
end

function OnClickChoosie()
    isChoosie=not isChoosie;
    SetChoosieState(isChoosie)
    CSAPI.SetGOActive(txtTime,isChoosie);
    CSAPI.SetGOActive(txtVoucher,isChoosie);
    CSAPI.SetGOActive(txtVoucher2,isChoosie);
    CSAPI.SetGOActive(rightObj,isChoosie);
    if isChoosie then
        SetDropInfo()
    else
        CSAPI.SetText(txtName,LanguageMgr:GetByID(18501))
        CSAPI.SetText(txtVoucher,"-"..opDatas[dropVal].discount);
        if not IsNil(nameLayout2) then
            CSAPI.SetText(txtName2,LanguageMgr:GetByID(18501))
            CSAPI.SetText(txtVoucher2,"-"..opDatas[dropVal].discount);
        end
    end
    EventMgr.Dispatch(EventType.Shop_PayVoucher_Change,GetChooiseList())
end

function OnClickQuestion()
    --显示当前锁定折扣券信息
    if lockVID and data then
        local goodInfo=BagMgr:GetFakeData(lockVID);
        if goodInfo then
            CSAPI.SetText(txtTitle,goodInfo:GetName());
            local str="";
            local descList={};
            local voucherInfo=VoucherInfo.New();
            voucherInfo:SetCfg(goodInfo:GetDyVal1());
            if data:CanUseVoucher(voucherInfo:GetType())~=true then
                table.insert(descList,LanguageMgr:GetByID(63001))
            end
            if voucherInfo:GetMinLevel()>PlayerClient:GetLv() then
                table.insert(descList,LanguageMgr:GetByID(63004,voucherInfo:GetMinLevel()))
            else
                table.insert(descList,LanguageMgr:GetByID(63004,voucherInfo:GetMinLevel()))
            end
            local priceInfos=data:GetRealPrice(shopPriceKey);
            local price=priceInfos and priceInfos[1] or nil;
            if price then
                local realNum=currNum*price.num;
                if realNum<voucherInfo:GetMinCost() then
                    str=LanguageMgr:GetByID(63003,voucherInfo:GetMinCost());
                else
                    str=LanguageMgr:GetByID(63003,voucherInfo:GetMinCost());
                end
                local good2=BagMgr:GetFakeData(price.id);
                if price.id~=voucherInfo:GetReduceId() then
                    table.insert(descList,LanguageMgr:GetByID(63005))
                end
            end
            CSAPI.SetText(txtQuestion,str);
            ItemUtil.AddItems("ShopComm/VQuestionTips", descItems, descList, qLayout, nil, 1)
        end
    end
    --显示说明面板
    CSAPI.SetGOActive(questionObj,true);
    --生成描述物体
    CSAPI.SetGOActive(mask,true);
end

function CloseQuestion()
    CSAPI.SetGOActive(questionObj,false);
    CSAPI.SetGOActive(mask,false);
end

function GetOptionsLength()
    return opDatas and #opDatas or 0;
end

function GetVoucherOptions()
    local list = {};
    if data then -- 查找可用的折扣券并添加列表
        local ls = ShopCommFunc.MatchVouchers(data, currNum,shopPriceKey);
        -- 排序
        if ls and #ls > 0 then
            table.sort(ls, function(a, b)
                local time1 = 0;
                local time2 = 0;
                local id1 = 0;
                local id2 = 0;
                if a.good then
                    time1 = a.good:GetExpiry() or 2 ^ 53; -- 2^53是最大整数值
                    id1 = a.good:GetID();
                end
                if b.good then
                    time2 = b.good:GetExpiry() or 2 ^ 53;
                    id2 = b.good:GetID();
                end
                if time1 == time2 then
                    local info1 = a.info;
                    local info2 = b.info;
                    if info1 and info2 then
                        if info1:GetType() == info2:GetType() then
                            if info1:GetReduceNum() == info2:GetReduceNum() then
                                if info1:GetMinCost() == info2:GetMinCost() then
                                    return id1 < id2;
                                else
                                    return info1:GetReduceNum() < info2:GetReduceNum()
                                end
                            else
                                return info1:GetReduceNum() > info2:GetReduceNum()
                            end
                        else
                            return info1:GetType() > info2:GetType()
                        end
                    else
                        return id1 < id2;
                    end
                else
                    return time1 < time2;
                end
            end);
            for k, v in ipairs(ls) do
                if v.good and v.info then
                    table.insert(list, {
                        id = v.good:GetID(),
                        txt = v.good:GetName(),
                        txt2 = GetTxt2(v.good),
                        discount=v.info:GetReduceNum(),
                    });
                    if lockVID and v.good:GetID()==lockVID and hasVID~=true then
                        hasVID=true;
                        dropVal=k;
                    end
                end
            end
        end
    end
    return list;
end

function GetTxt2(good)
    if good==nil then
        return ""
    end
    local time=good:GetExpiry();
	if time then
       local str= os.date("%Y-%m-%d %H:%M", time)
       return LanguageMgr:GetByID(63000,str);
	end
    return "";
end