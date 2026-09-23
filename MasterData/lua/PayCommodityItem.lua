local eventMgr=nil;
local data=nil;
local priceItem=nil;
local animator=nil;
function Awake()
    animator = ComUtil.GetCom(node, "Animator");
    eventMgr = ViewEvent.New();
end

function OnDestroy()
    eventMgr:ClearListener();
end

function Refresh(_d)
    data=_d;
    if data==nil then
        do return end
    end
    priceItem=ShopCommFunc.InitPriceItem(data,priceNode,priceItem);
    local isDouble=false;
    local exList=data:GetExCommodityList();
    local buyNum=data:GetBuyCount();
    local tNum=string.match(data:GetName(),"%d+")
    local ss=StringUtil:split(data:GetName(), "%d+")
    CSAPI.SetText(text_name1,tostring(tNum))
    CSAPI.SetText(text_name2,tostring(ss[1]))
    ResUtil.Commodity:Load(bg,data:GetIcon())
    if buyNum==0 and data:GetExCommodityList()~=nil then --首次赠送
        CSAPI.SetGOActive(altNameItem,true)
        local goods=BagMgr:GetFakeData(exList[1].cid);
        goods:GetIconLoader():Load(img_altNum,goods:GetIcon().."_2",false);
        CSAPI.SetText(text_altName,LanguageMgr:GetByID(18030));
        CSAPI.SetText(text_altNum,tostring(exList[1].num));
        CSAPI.SetGOActive(doubleTag,true)
    elseif buyNum>0 and data:GetExCommodityList()~=nil and exList[1].num>0 then--本次赠送
        CSAPI.SetGOActive(altNameItem,true)
        local goods=BagMgr:GetFakeData(exList[1].cid);
        goods:GetIconLoader():Load(img_altNum,goods:GetIcon().."_2",false);
        CSAPI.SetText(text_altName,LanguageMgr:GetByID(18031));
        CSAPI.SetText(text_altNum,tostring(exList[1].num));
        CSAPI.SetGOActive(doubleTag,false)
    else
        CSAPI.SetGOActive(altNameItem,false)
        CSAPI.SetGOActive(doubleTag,false)
    end
end

function OnClickSelf()
    ShopCommFunc.OpenPayView(data);
end

function PlayEntry(delayTime)
    ShopCommFunc.PlayAnimation(animator,"Payitem_entry",delayTime);
end

function SetIndex(_i)
    this.index=_i;
    gameObject.name=tostring(_i)
end

function GetIndex()
    return this.index;
end