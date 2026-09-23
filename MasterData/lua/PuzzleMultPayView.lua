--商城购买界
local eventMgr=nil;
local onceMax=0;
local tab=nil;
local costIdx=1;
local costs=nil;
local goods=nil;
local rmbIcon=nil;
local currNum=1;
local comm=nil

-- local slider=nil;
function Awake()
    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)
	-- SetText();
	InitListener();
end

function OnTabChanged(_index)
	costIdx=_index==0 and 1 or 2;
    RefreshPanel()
end

function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Puzzle_Buy_Ret,OnBuyRet)
end

function OnDestroy()
    eventMgr:ClearListener();
	ReleaseCSComRefs();
end

function OnOpen()
	UIUtil:ShowAction(childNode,nil,UIUtil.active2);
    tab.selIndex = 0
    if data then
        comm=data.commodity;
        costs=comm:GetCosts();
    end
    SetImgTabs();
	RefreshPanel();
end

function SetImgTabs()
    if costs then
        if costs[1].id~=-1 then
            local _cfg1 = Cfgs.ItemInfo:GetByID(costs[1].id)
            ResUtil.IconGoods:Load(imtTab1, _cfg1.icon .. "_1");
            LanguageMgr:SetText(txtItem1, 18111, _cfg1.name)
        else
            CSAPI.SetText(txtItem2,LanguageMgr:GetByID(18124));
        end
        if costs[2].id~=-1 then
            local _cfg1 = Cfgs.ItemInfo:GetByID(costs[2].id)
            ResUtil.IconGoods:Load(imtTab2, _cfg1.icon .. "_1");
            LanguageMgr:SetText(txtItem2, 18111, _cfg1.name)
        else
            CSAPI.SetText(txtItem2,LanguageMgr:GetByID(18124));
        end
    end
end

function RefreshPanel()
	-- 根据当前物品数量进行初始化
	if comm then
        rmbIcon=""
        goods=comm:GetGoods();
		CSAPI.SetText(txt_name,goods:GetName());
		CSAPI.SetText(txt_desc,goods:GetDesc());
        goods:GetIconLoader():Load(icon,goods:GetIcon());
        ShopCommFunc.LoadBorderFrame(goods:GetQuality(),border);
		--当前剩余数量
		currNum=comm:GetNum();
        local bagNum=BagMgr:GetCount(goods:GetID());
		CSAPI.SetText(txt_hasNum, bagNum .. "")
        CSAPI.SetText(txt_contentName,goods:GetName());
        CSAPI.SetText(txt_contentNum,"X"..tostring(currNum));
		if currNum~=-1 then
			CSAPI.SetText(txt_limit,LanguageMgr:GetByID(38005,currNum))
		else
			CSAPI.SetText(txt_limit,LanguageMgr:GetByID(38009))
		end
		RefreshPrice();
        -- CSAPI.SetRectSize(black,777.8,type==1 and 569 or 634);
	end
end

--刷新价格
function RefreshPrice()
	if costs==nil then
		do return end;
	end
	local normalPrice=costs[costIdx];
	if normalPrice==nil or (normalPrice and normalPrice.num==0) then --免费
		CSAPI.SetGOActive(txt_free,true);
		CSAPI.SetGOActive(nPriceObj,false);
		CSAPI.SetGOActive(hPrice,false);
	else
		CSAPI.SetGOActive(txt_free,false);
		CSAPI.SetGOActive(nPriceObj,true);
		SetPrice(normalPrice.id,normalPrice.num*currNum,priceIcon,txt_price,txt_rmb2);
        SetPrice(normalPrice.id,normalPrice.num*currNum,nPriceIcon,txt_nPrice,txt_rmb);
        CSAPI.SetGOActive(hPrice,false)
	end
end

function SetPrice(id, num,pIcon,pText,pRmbIcon)
	if id==-1 then --SDK支付
		CSAPI.SetText(pRmbIcon, rmbIcon);
		CSAPI.SetText(pText, tostring(num));
		CSAPI.SetGOActive(pIcon,false);
		CSAPI.SetGOActive(pRmbIcon,true);
		return;
	else
		CSAPI.SetGOActive(pIcon,true);
		CSAPI.SetGOActive(pRmbIcon,false);
	end
	if id == ITEM_ID.GOLD then --金币
		ResUtil.IconGoods:Load(pIcon, tostring(ITEM_ID.GOLD).."_1");
		CSAPI.SetImgColorByCode(pIcon,"ffffff")
	elseif id == ITEM_ID.DIAMOND then --钻石
		ResUtil.IconGoods:Load(pIcon, tostring(ITEM_ID.DIAMOND).."_1");
		CSAPI.SetImgColorByCode(pIcon,"ffc146")
	else
		local cfg = Cfgs.ItemInfo:GetByID(id);
		if cfg and cfg.icon then
			ResUtil.IconGoods:Load(pIcon, cfg.icon.."_1");
		end
		CSAPI.SetImgColorByCode(pIcon,"ffffff")
	end
	CSAPI.SetText(pText, tostring(math.floor(num+0.5)));
end

function OnClickDetails()
    if goods then
        CSAPI.OpenView("GoodsFullInfo",{comm=goods});
    end
end

--购买成功
function Close()
	UIUtil:HideAction(childNode, function()
		if view and view.Close then
			view:Close();
		end
	end, UIUtil.active4);
end

function OnClickAnyWay()
	Close();
end

--点击购买
function OnClickPay()
    if comm and data and data.activityId then
        local cost = costs[costIdx];
        if cost then
            local goodsInfo = BagMgr:GetFakeData(cost.id);
            local dialogData = {}
            dialogData.content = LanguageMgr:GetByID(74021, goodsInfo:GetName(), cost.num)
            dialogData.okCallBack = function()
                ActivePuzzleProto:BuyPuzzle(data.activityId, comm:GetID(), costIdx);
            end
            CSAPI.OpenView("Dialog", dialogData)
        end
    end
end

function OnBuyRet()
    view:Close();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
childNode=nil;
bg=nil;
gridNode=nil;
border=nil;
icon=nil;
txt_name=nil;
normalLayout=nil;
txt_desc=nil;
hasNumObj=nil;
txt_hasNumTips=nil;
txt_hasNum=nil;
numTips=nil;
txt_num=nil;
btn_remove=nil;
removeImg=nil;
btn_add=nil;
addImg=nil;
line=nil;
btn_pay=nil;
priceObj=nil;
priceIcon=nil;
txt_price=nil;
btn_min=nil;
btn_max=nil;
nPrice=nil;
nPriceIcon=nil;
txt_nPrice=nil;
hPrice=nil;
txt_hPrice=nil;
hPriceIcon=nil;
view=nil;
end
----#End#----