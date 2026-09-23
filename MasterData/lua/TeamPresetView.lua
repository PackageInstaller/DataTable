--编成预设面板
local itemList = nil;
local layout=nil;
local eventMgr=nil;
local stateList={};
local changeList={};
local isHideUse = false --隐藏使用按钮
function Awake()
	layout = ComUtil.GetCom(vsv, "UISV")
	layout:Init("UIs/FormatPreset/TeamPresetItem",LayoutCallBack,true)
	-- UIUtil:AddTop(gameObject, OnReturn)
	eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Team_Preset_Open, OnOpenPreset);
	eventMgr:AddListener(EventType.Team_Preset_Buy, OnPresetBuyRet);
	eventMgr:AddListener(EventType.Team_PresetName_Change, OnItemNameChange);
end

function SetCloseCB(_cb)
	cb = _cb
end

function SetButtonState(_isHideUse)
	isHideUse = _isHideUse
	layout:IEShowList(#curDatas)
end

function OnEnable()
	CSAPI.ApplyAction(gameObject, "Fade_In_200");
	InitView();
end

function OnDestroy()
	eventMgr:ClearListener();
	ReleaseCSComRefs();
end

function InitView()
	curDatas={};
	stateList={};
	for i = 1, g_FormationMaxNum do
		table.insert(curDatas,i);
		table.insert(stateList,false);
	end
	layout:IEShowList(#curDatas)
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local elseData={
		isLock=_data>TeamMgr:GetPresetNum();
		team=TeamMgr:GetTeamData(eTeamType.Preset + _data),
		index=index,
		isClick=stateList[index]==true,
	}
	local item=layout:GetItemLua(index);
	item.Refresh(_data,elseData);
	item.SetClickCB(OnClickItem);
	CSAPI.SetGOActive(item.btnUse,not isHideUse)
end

function OnClickItem(lua,isOn)
	stateList[lua.GetIndex()]=isOn;
end

function OnClickReturn()
	--保存数据到服务器
	if changeList then
		local list={};
		for k,v in pairs(changeList) do
			table.insert(list,TeamMgr:GetTeamData(k));
		end
		if list~=nil and #list>0 then
			PlayerProto:SaveTeamList(list);
		end
	end
	CSAPI.ApplyAction(gameObject, "Fade_Out_100",function()
		if cb then
			cb()
		end
		CSAPI.SetGOActive(gameObject, false);
	end);
end

function OnOpenPreset()
	OnClickReturn();
end

function OnPresetBuyRet()
	layout:UpdateList();
end

function OnItemNameChange(eventData)
	if eventData and eventData.idx then
		if eventData.isChange then
			changeList[eventData.idx]=true
		elseif changeList[eventData.idx] then
			changeList[eventData.idx]=nil;
		end
	end
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
panelNode=nil;
vsv=nil;
view=nil;
end
----#End#----