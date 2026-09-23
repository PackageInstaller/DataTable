local data = nil
local shopData = nil
local skillDatas = {}
local itemDatas = {}
local suitDatas = {}
local items1,items2,items3 = nil,nil,nil
local currX,lastX = 0,1
local len,svLen = 0,0
local isLoadSuccess = false
local timer = 0

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Shop_RecordInfos_Refresh,OnShopInfosRefresh)
    eventMgr:AddListener(EventType.Shop_View_Refresh,OnShopInfosRefresh)
    eventMgr:AddListener(EventType.Shop_Buy_Ret,OnShopInfosRefresh)
    eventMgr:AddListener(EventType.Bag_Update,OnShopInfosRefresh)
end

function OnShopInfosRefresh()
    SetDatas()
    SetItems()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    UpdateArrow()
    if timer < Time.time then
        timer = Time.time + 1
        AutoRefresh()
    end
end

function Refresh(_data)
    data = _data
    if data then
        if data:GetShopId() then
            shopData = ShopMgr:GetPageByID(data:GetShopId())
            if shopData then
                SetDatas()
                SetItems()
            end
        end
    end
end

function SetDatas()
    skillDatas = {}
    itemDatas = {}
    suitDatas = {}
    local _datas = shopData:GetCommodityInfos(true)
    if _datas and #_datas > 0 then
        for i, v in ipairs(_datas) do
            if v:GetType() == 3 then
                table.insert(skillDatas,v)
            elseif v:GetType() == 2 then
                table.insert(suitDatas,v)
            else
                table.insert(itemDatas,v)
            end
        end
    end
    if #itemDatas > 0 then
        table.sort(itemDatas,function (a,b)
            return a:GetSort()<b:GetSort()
        end)
    end
end

function SetItems()
    items1 = items1 or {}
    ItemUtil.AddItems("LovePlusShop/LovePlusShopItem",items1,skillDatas,itemParent1,nil,1,skillDatas)
    items3 = items3 or {}
    ItemUtil.AddItems("LovePlusShop/LovePlusShopItem3",items3,suitDatas,itemParent1,nil,1,shopData)
    items2 = items2 or {}
    ItemUtil.AddItems("LovePlusShop/LovePlusShopItem2",items2,itemDatas,itemParent2,nil,1,shopData,OnLoadSuccess)
end

function OnLoadSuccess()
    FuncUtil:Call(SetArrow,this,50)
end

function SetArrow()
    CSAPI.SetGOActive(arrowL,false)
    CSAPI.SetGOActive(arrowR,false)

    len = CSAPI.GetRTSize(content)[0]
    svLen = CSAPI.GetRTSize(sv)[0]
    lastX = 1
    currX = 0
end 

---------------------------------------------Update---------------------------------------------

function UpdateArrow()
    if len > svLen then
        currX = CSAPI.GetAnchor(content)
        if math.abs(currX - lastX) > 0.01 then
            CSAPI.SetGOActive(arrowL,currX < -0.1)
            CSAPI.SetGOActive(arrowR,currX >= -(len - svLen))    
            lastX = currX
        end
    end
end


--检测自动刷新时间
function AutoRefresh()
	if shopData~=nil and shopData:GetCommodityType()==CommodityType.Normal then--检测固定道具商店的重置时间和折扣时间
		local nowTime=TimeUtil:GetTime();
		local checkList=shopData:GetRefreshInfos();
		local isReset,isRefresh=ShopCommFunc.IsRefreshCommodityInfos(checkList,nowTime);
		if isReset then --列表刷新
            ShopMgr:CheckCommReset();
            ShopProto:GetShopCommodity(shopData:GetID());
			return
        elseif isRefresh then --道具购买期限刷新
            ShopMgr:CheckCommReset();
            SetDatas()
            SetItems()
        end
	end
end