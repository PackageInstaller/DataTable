local commodity = nil;
local commodityType = nil;
local iconObj = nil;
local iconObj2 = nil;
local isDorm = false;
local data = nil;
local getData=nil;
local eventMgr=nil;
local selGoods1,selGoods2=nil,nil --选中的物品数据1和2
local curIdx=0;--当前选中的索引
function Awake()
    eventMgr = ViewEvent.New();
end

function OnEnable()
    eventMgr:AddListener(EventType.Shop_Pay_SwitchListSubmit,OnSelect);
end

function OnDisable()
    eventMgr:ClearListener();
end

function Refresh(_data)
    data = _data;
    commodity = data.commodity;
    if commodity ~= nil then
        commodityType = ShopMgr:GetCommodityTypeByData(commodity)
        local getList = commodity:GetCommodityList();
        if getList then
            getData = getList[1];
        end
    end
    SetIcons();
end

function SetIcons()
    --判定是单选还是双选
    local showNum=0;
    if commodity:GetType()==CommodityItemType.SingleSelection then
        showNum=1;
        local list = commodity:GetCommodityList2("grid1")
		if list and list[1] and list[1].data then
			local goodData = list[1].data
			LoadIcon1(goodData)
            SetQuality(goodData,quality);
		end
        if selGoods2 then
            showNum=showNum+1
            LoadIcon2(selGoods2)
            SetQuality(selGoods2,quality2);
        end
    elseif commodity:GetType()==CommodityItemType.DoubleSelection then
        --判定当前选中了几个
        if selGoods1 then
            showNum=showNum+1
            LoadIcon1(selGoods1)
            SetQuality(selGoods1,quality);
        end
        if selGoods2 then
            showNum=showNum+1
            LoadIcon2(selGoods2)
            SetQuality(selGoods2,quality2);
        end
    end
    CSAPI.SetGOActive(iconItem1,showNum>=1)
    CSAPI.SetGOActive(selectItem2,showNum<2)
    CSAPI.SetGOActive(iconItem2,showNum==2)
    CSAPI.SetGOActive(selectItem1,showNum==0)
end

function OnSelect(eventData)
    curIdx=0;
    --{selGridIdx=lua.index,selIdx=lua.index==1 and curIdx1 or curIdx2,isShowList=true}
    if eventData then
        local listKey=eventData.selGridIdx==1 and "grid1" or "grid2"
        local list = commodity:GetCommodityList2(listKey)
        if list and list[eventData.selIdx] then
           local goods = GridUtil.RandRewardConvertToGridObjectData({
                id = list[eventData.selIdx].cid,
                num = list[eventData.selIdx].num,
                type = list[eventData.selIdx].type
            });
            if eventData.selGridIdx==1 then
                selGoods1=goods
            elseif eventData.selGridIdx==2 then
                selGoods2=goods
            end
        end
    end
    SetIcons();
end

function SetQuality(goods,qualityItem)
    local q=1;
    if goods then
        --读取物品表中的数据
        q=goods:GetQuality();
    end
    LoadBorderFrame(q, qualityItem)
end

local qulityFrames={"","img9_06_05","img9_06_04","img9_06_03","img9_06_02","img9_06_01"}

function LoadBorderFrame(lvQuality, border)
    local lvQuality=lvQuality or 1
    if qulityFrames[lvQuality] and qulityFrames[lvQuality]~="" then
        CSAPI.SetGOActive(border,true);
        CSAPI.LoadImg(border, string.format("UIs/ShopComm/"..qulityFrames[lvQuality]..".png", lvQuality or 1), false,nil,true);
    else
        CSAPI.SetGOActive(border,false);
    end
end


function LoadIcon1(goods)
    if iconObj == nil then
        local go = ResUtil:CreateUIGO("ShopComm/CommodityIcon", iconNode.transform)
        iconObj = ComUtil.GetLuaTable(go)
    end
    if goods then
        iconObj.LoadGoodsIcon(goods)
    end
end

function LoadIcon2(goods)
    if iconObj2 == nil then
        local go = ResUtil:CreateUIGO("ShopComm/CommodityIcon", iconNode2.transform)
        iconObj2 = ComUtil.GetLuaTable(go)
    end
    if goods then
        iconObj2.LoadGoodsIcon(goods)
    end
end

function OnClickSelect1()
    SetCurIdx(1)
end

function OnClickSelect2()
    SetCurIdx(2)
end

function SetCurIdx(idx)
    curIdx=idx;
    EventMgr.Dispatch(EventType.Shop_Pay_ShowSwitchList,{isShowList=true,selGridIdx=curIdx,selIdx=0})
end