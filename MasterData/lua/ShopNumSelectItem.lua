local currNum=0;
local maxNum=0;
local limitNum=nil;
local priceItem=nil;
local curPriceInfo=nil;
local priceInfo=nil;
local voucher=nil;
local func=nil;
local sdkPInfo=nil;
function Awake()
    local go=ResUtil:CreateUIGO("ShopComm/ShopPriceItem5",priceNode.transform);
    priceItem=ComUtil.GetLuaTable(go)
end

--priceInfo:单次购买价格  _voucherDiscount:折扣券抵扣的价格 _maxNum:如果有_limitNum不得超过_limitNum
function Refresh(_cNum,_maxNum,_limitNum,_priceInfo,_voucherDiscount,_sdkPInfo)
    currNum=_cNum;
    if _maxNum<1 and _maxNum~=-1  then
        maxNum=1
    else
        maxNum=_maxNum;
    end
    if _limitNum~=nil and maxNum>_limitNum then
        maxNum=_limitNum;
    end
    limitNum=_limitNum;
    priceInfo=_priceInfo;
    voucher=_voucherDiscount;
    sdkPInfo=sdkPInfo;
    SetContent()
end

function SetChangeFunc(_func)
    func=_func
end

function SetContent()
    CSAPI.SetText(txt_num,tostring(currNum));
    if limitNum and limitNum>0 then
        CSAPI.SetText(txt_maxTips,LanguageMgr:GetByID("18034")..tostring(limitNum-currNum));
    else
        CSAPI.SetText(txt_maxTips,"");
    end
    if priceInfo then
       CountPrice();
    end
end

--计算价格
function CountPrice()
    curPriceInfo=table.copy(priceInfo)
    if voucher and voucher>0 then
        curPriceInfo.num=voucher
    else
        curPriceInfo.num=currNum*priceInfo.num
    end
    priceItem.Refresh({curPriceInfo},sdkPInfo);
end

function GetNum()
    return currNum;
end

function GetPrice()
    return curPriceInfo;
end

function OnClickMax()
    if currNum==maxNum then
		Tips.ShowTips(LanguageMgr:GetByID(24025));
		do return end	
	end
    currNum=maxNum;
    SetContent();
    if func then
        func();
    end
end

function OnClickMin()
    if currNum==1 then
		Tips.ShowTips(LanguageMgr:GetByID(24026));	
		do return end	
	end
    if limitNum then
        currNum=limitNum>=1 and 1 or 1
    else
        currNum=1;
    end
    SetContent();
    if func then
        func();
    end
end

function OnClickRemove()
    if limitNum and limitNum<1 then
        currNum=1;
        do return end
    end
    if currNum > 1 then
        currNum = currNum - 1;
        SetContent();
    else
        Tips.ShowTips(LanguageMgr:GetByID(24026));	
		do return end	
    end
    if func then
        func();
    end
end

function OnClickAdd()
    if limitNum and limitNum<1 then
        currNum=1;
        do return end
    end
    if currNum < maxNum then
        currNum=currNum+1
        SetContent();
	else
		Tips.ShowTips(LanguageMgr:GetByID(24025));	
		do return end	
	end
    if func then
        func();
    end
end