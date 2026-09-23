local itemPath = "UIs/Archive2/RoleArchiveCard"
local curIndex = 0
local teamDatas = {}
curIndex1, curIndex2 = 1,1
local top=nil;

--定时刷新
local currShowTime = 0
local showTime = 0
local showTimer = 0
local timeInfos = nil

function Awake()	
	layout = ComUtil.GetCom(sv1, "UIInfinite")
	--layout:AddBarAnim(0.4, false)
	layout:Init(itemPath, LayoutCallBack, true)
	animLua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Diagonal)
end

function LayoutCallBack(index)	
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.SetIndex(index)
		--lua.SetClickCB(OnItemClickCB)
		lua.Refresh(_data, elseData)
	end
end

-- function OnItemClickCB()
-- end
function OnInit()
	top=UIUtil:AddTop2("ArchiveRoleListView", gameObject, function()
		view:Close()
	end, nil, "")
end

function Update()
	if showTime > 0 and showTimer < Time.time then
		showTime = currShowTime - TimeUtil:GetTime()
		showTimer = Time.time + 1
		if showTime <= 0 then
			if elseData == ArchiveType.Role then
				SetRoleDatas()
			else
				SetEnemyDatas()
			end
			SetShowTime()
			RefreshPanel()
		end
	end
end

function OnOpen()
	elseData = data or ArchiveType.Role
	CSAPI.PlayUISound("ui_popup_open")		
	curIndex = 0
	if elseData == ArchiveType.Role then
		SetRoleDatas()
	else
		SetEnemyDatas()
	end
	SetShowTime()
	-- SetTeamDatas()
	-- SetDatas()
	InitLeftPanel()
	RefreshPanel()
end

--角色数据
function SetRoleDatas()
	teamCfgs = Cfgs.CfgTeamEnum:GetAll()
	datas = {}
	local _datas = CRoleMgr:GetCfgDatas()
	--去除不可在图鉴显示的
	for i, v in ipairs(_datas) do
		if (v.bShowInAltas) then			
			if v.sShowTime then --有显示时间
				if CheckShowTime(v.sShowTime) then
					table.insert(datas, v)
				end
			else
				table.insert(datas, v)
			end
		end
	end
	--排序
	table.sort(datas, function(a, b)
		local dataA = CRoleMgr:GetData(a.id)
		local dataB = CRoleMgr:GetData(b.id)
		if((dataA and dataB) or(dataA == nil and dataB == nil)) then
			return a.number < b.number
		else
			return dataA ~= nil
		end
	end)
	
	teamDatas = {}
	for i, v in ipairs(datas) do --分组
		teamDatas[v.sTeam] = teamDatas[v.sTeam] or {}
		table.insert(teamDatas[v.sTeam], v)
	end	
	
	local cfgDatas = {}
	for i, v in ipairs(teamCfgs) do --剔除组内没有角色的选项
		if teamDatas[v.id] and #teamDatas[v.id] > 0 then
			table.insert(cfgDatas, v)
		end
	end
	teamCfgs = cfgDatas
end

--敌兵数据
function SetEnemyDatas()
	teamCfgs = Cfgs.CfgMonsterEnum:GetAll()
	datas = {}
	local cfgs = Cfgs.CfgArchiveMonster:GetAll()
	for i, v in pairs(cfgs) do
		if(v.bShowInAltas) then
			table.insert(datas, v)
		end
	end
	
	--排序
	table.sort(datas, function(a, b)
		if a.unlock_type == b.unlock_type then
			if a.unlock_type == 1 then
				local lockA = GetLock(a.unlock_id)
				local lockB = GetLock(b.unlock_id)
				if(lockA and lockB) or(not lockA and not lockB) then
					return a.index < b.index
				else
					return not lockA
				end
			end
		end		
	end)	
	
	for i, v in ipairs(datas) do --分组
		teamDatas[v.type] = teamDatas[v.type] or {}
		table.insert(teamDatas[v.type], v)
	end	
	
	local cfgDatas = {}
	for i, v in ipairs(teamCfgs) do --剔除组内没有角色的选项
		if teamDatas[v.id] and #teamDatas[v.id] > 0 then
			table.insert(cfgDatas, v)
		end
	end
	teamCfgs = cfgDatas
end

function InitLeftPanel()
	if(not leftPanel) then
		local go = ResUtil:CreateUIGO("Common/LeftPanel", left.transform)
		leftPanel = ComUtil.GetLuaTable(go)
	end
	-- local enemyLIds = {29018, 29019, 29020, 29021, 29022, 29023, 29024, 29025, 29026, 29027, 29028, 29029
	-- }
	-- local roleLIds = {29009, 29010, 29011, 29012, 29013, 29014, 29015, 29016}
	-- local ids = elseData == ArchiveType.Role and roleLIds or enemyLIds
	
	local leftDatas = {}
	for i = 0, #teamCfgs do
		local data = {}
		if i == 0 then
			data = {3025, "Archive2/icon"}
		else
			data = {teamCfgs[i].languageID, "Archive2/" .. teamCfgs[i].icon}
		end
		table.insert(leftDatas, data)
	end
	leftPanel.Init(this, leftDatas)
end

function RefreshPanel()
	SetLeft()
	SetRight()
end

function SetLeft()
	leftPanel.Anim()
end

function SetRight()
	curIndex =(curIndex1 - 1)
	SetBottom()
	curDatas = {}
	if(curIndex == 0) then
		curDatas = datas
	else
		curDatas = teamDatas[teamCfgs[curIndex].id]
	end
	AnimStart()
	animLua:AnimAgain()
	layout:IEShowList(#curDatas, AnimEnd)
end

function SetBottom()
	local count = 0
	local max = 0
	if elseData == ArchiveType.Role then
		count, max = ArchiveMgr:GetRoleCount()
	else
		count, max = ArchiveMgr:GetEnemyCount()
	end
	CSAPI.SetText(txtNum, count .. "")
	CSAPI.SetText(txtMaxNum, "/" .. max)
	local percent = math.floor(count / max * 100)
	CSAPI.SetText(txtRate, percent .. "%")
	CSAPI.SetRTSize(line, 1213 *(percent / 100), 9)
end


function GetLock(ids)
	local isLock = true
	for i, v in ipairs(ids) do
		local dData = DungeonMgr:GetDungeonData(v)
		if dData and dData:IsPass() then
			isLock = false
			break
		end
	end
	return isLock
end

function CheckShowTime(str)
	local sTime = TimeUtil:GetTimeStampBySplit(str) 
	if sTime > TimeUtil:GetTime() then
		timeInfos = timeInfos or {}
		timeInfos[sTime] = sTime
		return false 
	end
	return true
end

function SetShowTime()
	if timeInfos then
		local infos = {}
		for k, v in pairs(timeInfos) do
			table.insert(infos,v)
		end
		timeInfos = nil
		if #infos > 0 then
			table.sort(infos,function (a,b)
				return a < b
			end)
			currShowTime = infos[1]
			showTime = currShowTime - TimeUtil:GetTime()
			showTimer = 0
		else
			showTime = 0
			showTimer = 0
		end
	end
end

function AnimStart()
	if not UIMask then
		UIMask = CSAPI.GetGlobalGO("UIClickMask")
	end
	CSAPI.SetGOActive(UIMask, true)
end

function AnimEnd()
	CSAPI.SetGOActive(UIMask, false)
end 
function OnDestroy()    
    ReleaseCSComRefs();
end
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
	---填写退出代码逻辑/接口
	if  top.OnClickBack then
		top.OnClickBack();
		if not UIMask then
			UIMask = CSAPI.GetGlobalGO("UIClickMask")
		end
		CSAPI.SetGOActive(UIMask, false)
	end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
left=nil;
right=nil;
sv1=nil;
txt_collection=nil;
line=nil;
txtRate=nil;
txtNum=nil;
txtMaxNum=nil;
view=nil;
end
----#End#----