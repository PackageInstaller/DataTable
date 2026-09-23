local eventMgr=nil;
local layout=nil;
local curDatas=nil;
local sortView=nil;
local sortID=2;
local data=nil;
local scroll=nil;
function Awake()
    scroll=ComUtil.GetCom(sr,"ScrollRect");
	layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/RoleLittleCard/RoleLittleCard",LayoutCallBack,true,1)
    eventMgr = ViewEvent.New();
end

function OnDestroy()
    eventMgr:ClearListener();
end

function SetData(_data)
    data=_data;
    Refresh();
end

function Refresh()
    SetSortObj();
    SetSVList();
end

function SetSVList()
    --加载所持有的卡牌
    local arr = {}
    arr = RoleMgr:GetArr();
	--剔除不符合需求的卡牌
	if arr then
		local a1={};
		for i, v in ipairs(arr) do
			local haloInfo=v:GetHaloInfo();
			if haloInfo~=nil and haloInfo:GetMaxLv()>1 then
				table.insert(a1,v)
			end
		end
		arr=a1;
	end
    curDatas=SortMgr:Sort(sortID,arr)
    CSAPI.SetGOActive(SortNone,#curDatas<=0);
    layout:IEShowList(#curDatas, nil)
end

function LayoutCallBack(index)
    local _data = curDatas[index]
	local key="TeamFormation"
	local _elseData={
        isSelect=data and _data:GetID()==data:GetID() or false,
		key=key,
		canClick=true,
		sortId=sortID,
    };
	local grid=layout:GetItemLua(index);
	grid.SetIndex(index);
	grid.Refresh(_data,_elseData);
	grid.SetClickCB(OnClickCard);
end

function OnClickCard(tab)
    if data and data:GetID()~=tab.cardData:GetID() then
        EventMgr.Dispatch(EventType.Halo_RoleSelected_Change,tab.cardData:GetID())
    end
end

function SetSortObj()
	--判断筛选ID
	if sortView==nil and isLoadSortView~=true then
		isLoadSortView=true
		ResUtil:CreateUIGOAsync("Sort/SortTop",btnTool,function(go)
			CSAPI.SetScale(go,1,1,1);
			sortView=ComUtil.GetLuaTable(go);
			sortView.Init(sortID,function()
				SetSVList()
			end);
			CSAPI.SetAnchor(go,-55,15);
		end);
	elseif sortView~=nil then
		sortView.Init(sortID,function()
			SetSVList()
		end);
	end
end