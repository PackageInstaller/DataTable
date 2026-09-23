local curIdx=0;
local curListIdx=0;
local data=nil;
local layout=nil;
local curDatas={};
local commodity=nil;
function Awake()
    layout = ComUtil.GetCom(vsv, "UISV")
	layout:Init("UIs/ShopComm/ShopPayChoosieItem",LayoutCallBack,true)
end

function Refresh(_data,_elseData)
    data=_data
    curIdx=_elseData and _elseData[1] or 0
    curListIdx=_elseData and _elseData[2] or 0
    commodity=data and data.commodity or nil
    --初始化列表
    if commodity then
        curDatas={};
        local listKey = curIdx == 1 and "grid1" or "grid2"
        local list = commodity:GetCommodityList2(listKey)
        for i, v in ipairs(list) do
            local itemData=GridUtil.RandRewardConvertToGridObjectData({id=v.cid,num = v.num,type=v.type})
            table.insert(curDatas,{itemData = itemData})
        end
        layout:IEShowList(#curDatas);
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
	local item=layout:GetItemLua(index);
    item.SetIndex(index)
    item.SetClickCB(OnItemClickCB)
	item.Refresh(_data.itemData,index==curListIdx);
end

function OnItemClickCB(lua)
    curListIdx=lua.index
    EventMgr.Dispatch(EventType.Shop_Pay_SwitchListSubmit,{selGridIdx=curIdx,selIdx=curListIdx});
end