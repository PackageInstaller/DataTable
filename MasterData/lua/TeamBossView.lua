local curIndex = 0
local calTime = false --是否计算时间
local timer = 0       --计时，没0.1s执行一次
local rTime = 0       --剩余秒数

function Awake()
	tab = ComUtil.GetCom(tabs, "CTab")
	tab:AddSelChangedCallBack(OnTabChanged)
	
	CSAPI.SetGOActive(mask2, false)
end

function OnInit()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.TeamBoss_List, RefreshPanel)
	eventMgr:AddListener(EventType.TeamBoss_Over, function()
		view:Close()
	end)
	layout = ComUtil.GetCom(vsv, "UIInfinite")
	layout:Init("UIs/TeamBoss/TeamBossItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.SetClickCB(OnClickInFunc)
		lua.Refresh(_data)
	end
end

function OnDestroy()
	eventMgr:ClearListener()
	ReleaseCSComRefs()
end

function Update()
	if(calTime and Time.time > timer) then
		timer = timer + 0.1
		SetTime()
	end
end

function OnOpen()
	tab.selIndex = 0
	
	--CSAPI.OpenView("TeamBossPrepare", 1)
end

function OnTabChanged(_index)
	curIndex = _index
	local b = curIndex == 0
	TeamBoss:Rooms(b)
end

function RefreshPanel()
	ud = TeamBossMgr:GetOrderType()
	SetDatas()
	SetUDAngle()
	InitTime()
end
function SetDatas()
	curDatas = TeamBossMgr:GetSortArr(curIndex == 0)
	layout:IEShowList(#curDatas)
end

function SetUDAngle()
	local angle = ud == 1 and 0 or 180
	CSAPI.SetAngle(objSort, 0, 0, angle)
end

function InitTime()
	timer = Time.time
	calTime = TeamBossMgr.createLimitTime > TimeUtil:GetTime()
	if(not calTime) then
		CSAPI.SetText(txtTime, "")
	end
end

function SetTime()
	rTime = TeamBossMgr.createLimitTime - TimeUtil:GetTime()
	calTime = rTime >= 0
	if(not calTime) then
		CSAPI.SetText(txtTime, "")
	else	
		CSAPI.SetText(txtTime, rTime > 0 and string.format("剩余时间：%s", TimeUtil:GetTimeStr(rTime)) or "")
	end
end
function OnClickInFunc(item)
	if(item.isEnd or item.isEnd_s) then
		CSAPI.OpenView("TeamBossSort", item.data)
	else
		CSAPI.SetGOActive(mask2, true) --锁屏
		TeamBoss:JoinRoom(item.data:GetId(), function(b, id)
			CSAPI.SetGOActive(mask2, false)
			if(not b) then	
				--加入失败，重新拉列表
				TeamBoss:Rooms(curIndex == 0)
			end
		end)
	end
end

function OnClickCreate()
	CSAPI.OpenView("TeamBossCreate")
end

function OnClickTips()
	CSAPI.OpenView("TeamBossTips")
end

function OnClickRefresh()
	TeamBoss:Rooms(curIndex == 0)
end

function OnClickMask()
	view:Close()
end

--上下
function OnClickUD()
	ud = ud == 1 and 2 or 1
	TeamBossMgr:GetOrderType(ud)
	RefreshPanel()
end

--筛选
function OnClickFiltrate()
	local mData = {}
	--需要单选的列表
	mData.single = {["Sort"] = 1} --1无意义
	--由上到下排序
	mData.list = {"Sort", "Difficulty", "StateType"}
	--标题名(与list一一对应)
	mData.titles = {"排序方式", "难度", "状态"}
	--当前数据
	mData.info = TeamBossMgr:GetSortType()
	--源数据
	local _root = {}
	_root.Sort = {{id = 1, sName = "创建时间"}, {id = 2, sName = "难度"}}
	_root.Difficulty = {{id = 1, sName = "简单"}, {id = 2, sName = "普通"}, {id = 3, sName = "困难"}}
	_root.StateType = {{id = 1, sName = "准备中"}, {id = 2, sName = "战斗中"}}
	mData.root = _root
	--回调
	mData.cb = SortCB
	
	CSAPI.OpenView("SortView", mData)
end
function SortCB(newInfo)
	TeamBossMgr:GetSortType(newInfo)
	RefreshPanel()
end




----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
btnCreate=nil;
tabs=nil;
item1=nil;
txtNormal1=nil;
txtSel1=nil;
item2=nil;
txtNormal2=nil;
txtSel2=nil;
btnTips=nil;
txtTime=nil;
btnRefresh=nil;
btnFiltrate=nil;
txtFiltrate=nil;
btnUD=nil;
objSort=nil;
txtUD=nil;
vsv=nil;
mask2=nil;
view=nil;
end
----#End#----