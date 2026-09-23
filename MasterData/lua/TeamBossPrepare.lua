local isStart = false --开始倒计时,必定开始，无法中止
local startTime = 0
local timer = 0

local isNeedAutoPrepare = false  --需要自动准备
local prePareTime = 0  --自动等待的时间
local prePareTime2 = 0

function Awake()
	CSAPI.SetGOActive(btnZS, false)
	CSAPI.SetGOActive(timePanel, false)
	CSAPI.SetGOActive(bossInfo, false)
end
function OnInit()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.TeamBoss_Room_Update, RoomeUpdate)
	eventMgr:AddListener(EventType.TeamBoss_Room_Leave, RoomLevel)
	eventMgr:AddListener(EventType.TeamBoss_Room_Start, RoomStart)
	eventMgr:AddListener(EventType.TeamBoss_Over, function()
		view:Close()
	end)
	eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end	

function OnDestroy()
	eventMgr:ClearListener()
	ReleaseCSComRefs()
end

function Update()
	--自动准备的相关逻辑 
	if(isNeedAutoPrepare) then
		AutoPrepare()
	end
	--倒计时逻辑
	if(isStart) then
		if(Time.time >= timer) then
			timer = timer + 0.1
			local t =(startTime - TimeUtil:GetTime()) <= 0 and 0 or(startTime - TimeUtil:GetTime())
			CSAPI.SetText(txtTime, tostring(math.floor(t)))
			if(t <= 0) then
				isStart = false
				CSAPI.SetText(txtTime, "模拟战斗中")
			end
		end
	end
end

function OnOpen()
	RefreshPanel()
end

function RoomeUpdate(room)
	if(roomInfo and roomInfo:GetId() == room.id) then
		RefreshPanel()
	end
end

function RefreshPanel()
	roomInfo = TeamBossMgr:GetData(data)
	if(roomInfo == nil) then
		view:Close()
		Log("房间数据已清除")
		return
	end
	if(roomInfo:GetState() == TeamBossRoomState.Win or roomInfo:GetState() == TeamBossRoomState.Lost) then
		Log("组队boss战斗已结束")
		view:Close()
		return
	end
	--preparetime
	SetPrepareTime()
	--other
	SetOther()
	--self
	SetSelf()
	--boss
	SetBosss()
	--btn
	SetBtns()
	--boss信息
	SetBossInfo()
end

function SetPrepareTime()
	--已开始的房间没有自动准备
	if(roomInfo:GetState() == TeamBossRoomState.Fighting) then
		isNeedAutoPrepare = false
		return
	end
	--已准备
	if(roomInfo:GetMyInfo().state == TeamBossTeamState.Prepare) then
		isNeedAutoPrepare = false
		return
	end
	--一个人时
	local roles = roomInfo:GetRoles()
	if(#roles <= 1) then
		isNeedAutoPrepare = false
		return
	end
	local uid = PlayerClient:GetID()
	if(roomInfo:GetCreateId() == uid) then
		--我是房主
		prePareTime2 = g_TeamBossPrepareTime1
		for i, v in ipairs(roles) do
			if(v.uid ~= uid) then
				if(v.state == TeamBossTeamState.Join) then
					prePareTime2 = g_TeamBossPrepareTime2
					break
				end
			end
		end
	else
		--我是房客
		prePareTime2 = g_TeamBossPrepareTime3
	end
	prePareTime = Time.time + prePareTime2
	isNeedAutoPrepare = true
end

function SetOther()
	local roles = roomInfo:GetRoles()
	local elseDatas = {}
	local uid = PlayerClient:GetID()
	for i, v in ipairs(roles) do
		if(v.uid ~= uid) then
			table.insert(elseDatas, v)
		end
	end
	local fzID = roomInfo:GetCreateId()
	items = items or {}
	for i = #elseDatas + 1, #items do
		CSAPI.SetGOActive(items[i].gameObject, false)
	end
	for i = 1, 4 do
		if(#items >= i) then
			CSAPI.SetGOActive(items[i].gameObject, true)
			items[i].Refresh(elseDatas[i], fzID)		
		else
			ResUtil:CreateUIGOAsync("TeamBoss/TeamBossPrepareItem", this["else" .. i], function(go)
				local item = ComUtil.GetLuaTable(go)
				if(item.SetIndex) then
					item.SetIndex(i)
				end
				item.Refresh(elseDatas[i], fzID)
				table.insert(items, item)
			end)
		end
	end
end

--自己的数据
function SetSelf()
	local roles = roomInfo:GetRoles()
	myData = nil
	local uid = PlayerClient:GetID()
	for i, v in ipairs(roles) do
		if(v.uid == uid) then
			myData = v
		end
	end
	--总指挥
	CSAPI.SetGOActive(fz, myData.uid == PlayerClient:GetID())
	--队伍
	SetItems(myData.team.data)
	--战力
	CSAPI.SetText(txtFighting, "战斗力：" .. myData.team.performance)
end

function SetItems(teamData)
	--封装数据
	local lNewDatas = {}
	local cardDatas = {}
	if(teamData) then
		for i, v in ipairs(teamData) do
			local _card = CharacterCardsData(v.card_info)
			table.insert(cardDatas, _card)
		end
	end	
	for i = 1, 5 do
		if(i <= #cardDatas) then
			table.insert(lNewDatas, cardDatas[i])
		else
			table.insert(lNewDatas, {})
		end
	end	
	
	lTeamGrids = lTeamGrids or {}
	ItemUtil.AddItems("RoleLittleCard/RoleLittleCard", lTeamGrids, lNewDatas, grid)
end

function SetBosss()
	--boss名称
	CSAPI.SetText(txtBossName, string.format("%s   %s", roomInfo:GetCfg().name, roomInfo:GetCfg().hard))
	--lv
	local lvStr = LanguageMgr:GetByID(1033) or "LV."
	CSAPI.SetText(txtBossLv, string.format("%s%s", lvStr,roomInfo:GetCfg().rLv))
	--推荐等级
	CSAPI.SetText(txtLv, string.format("推荐等级：%s级", roomInfo:GetCfg().rLv))
	--hp
	if(hp_bar == nil) then
		hp_bar = ComUtil.GetCom(bar, "BarBase")
	end
	local curHP, maxHP = roomInfo:GetHP()
	hp_bar:SetFullProgress(curHP, maxHP, true)
end

function SetBtns()
	--邀请好友
	local b2 = roomInfo:GetCreateId() == PlayerClient:GetID()
	CSAPI.SetGOActive(btnInvite, b2)
	--进入战斗
	SetWaitBtn()
end

function SetWaitBtn()
	local str = "准备"
	if(roomInfo:GetState() == TeamBossRoomState.Fighting) then
		str = "进入战斗"  --加入了已开始的房间
	elseif(myData.state == TeamBossTeamState.Prepare) then
		str = "解除准备"
	end
	CSAPI.SetText(txtStart, str)
end

--自动准备
function AutoPrepare()
	if(CS.UnityEngine.Input.GetMouseButton(0)) then
		prePareTime = Time.time + prePareTime2
	end
	if(Time.time > prePareTime) then
		isNeedAutoPrepare = false
		OnClickStart() --去准备
	end
end

--离开房间
function RoomLevel(proto)
	local _roomInfo = TeamBossMgr:GetData(proto.id)
	if(_roomInfo == nil or proto.uid == PlayerClient:GetID()) then
		view:Close()
		return
	end
	RefreshPanel()
end


--倒计时开始
function RoomStart(proto)
	isNeedAutoPrepare = false
	
	--关闭好友邀请面板
	CSAPI.CloseView("TeamBossInvite")
	
	startTime = proto.time
	timer = Time.time
	CSAPI.SetGOActive(timePanel, true)
	isStart = true
end

function SetBossInfo()
	--boss名称
	CSAPI.SetText(txtBossName2, string.format("%s   %s", roomInfo:GetCfg().name, roomInfo:GetCfg().hard))
	--lv
	local lvStr = LanguageMgr:GetByID(1033) or "LV."
	CSAPI.SetText(txtBossLv2, string.format("%s%s", lvStr,roomInfo:GetCfg().rLv))
	--hp
	if(hp_bar2 == nil) then
		hp_bar2 = ComUtil.GetCom(bar2, "BarBase")
	end
	local curHP, maxHP = roomInfo:GetHP()
	hp_bar2:SetFullProgress(curHP, maxHP, true)
	--desc
	CSAPI.SetText(txtDesc, roomInfo:GetCfg().desc)
end
--详细
function OnClickDetail()
	SetBossInfo()
	CSAPI.SetGOActive(bossInfo, not bossInfo.activeSelf)
end
function OnClickClose()
	CSAPI.SetGOActive(bossInfo, false)
end

--邀请
function OnClickInvite()
	CSAPI.OpenView("TeamBossInvite", roomInfo)
end
--准备/解除准备/开始
function OnClickStart()
	if(roomInfo:GetState() == TeamBossRoomState.Fighting) then
		-- "进入战斗"  --加入了已开始的房间
		CSAPI.SetText(txtTime, "模拟战斗中")
		CSAPI.SetGOActive(timePanel, true)
		TeamBoss:Start(roomInfo:GetId(), function()
			--进入战斗失败,刷新房间
			CSAPI.SetGOActive(timePanel, false)
			RefreshPanel()
		end)
	elseif(myData.state == TeamBossTeamState.Prepare) then
		-- "解除准备"
		TeamBoss:Prepare(roomInfo:GetId(), 1)
	else
		--准备
		TeamBoss:Prepare(roomInfo:GetId(), 2)
	end
end

--退出
function OnClickBack()
	if(not isStart) then
		local dialogdata = {}
		local str = "是否退出房间？"
		if(roomInfo:GetCreateId() == PlayerClient:GetID()) then
			if(roomInfo:GetRolesCount() > 1) then
				str = string.format("当前房间还有其他玩家，是否关闭房间？若关闭则需要等待%s分钟才能重新加入或开启房间", roomInfo:GetForceDelCd())
			else
				str = "是否关闭当前房间"
			end
		end
		dialogdata.content = str
		dialogdata.okCallBack = function()
			TeamBoss:LeaveRoom(roomInfo:GetId())
		end
		CSAPI.OpenView("Dialog", dialogdata)
	end
end
       
--编成
function OnClickBC()
	if(not isStart) then
		CSAPI.OpenView("TeamView", {currentIndex = eTeamType.TeamBoss, canEmpty = false, is2D = true}, TeamOpenSetting.PVP)
	end
end
function OnViewClosed(viewKey)
	if(viewKey == "TeamView") then
		SetSelf()
	end
end 
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
txtBossName=nil;
txtBossLv=nil;
txtLv=nil;
bar=nil;
txtHP=nil;
else1=nil;
else2=nil;
else3=nil;
else4=nil;
btnTalk=nil;
btnInvite=nil;
btnDetail=nil;
btnStart=nil;
txtStart=nil;
btnBack=nil;
down=nil;
Text=nil;
txtFighting=nil;
grid=nil;
fz=nil;
btnZS=nil;
btnBC=nil;
timePanel=nil;
txtTime=nil;
bossInfo=nil;
icon=nil;
txtBossName2=nil;
txtBossLv2=nil;
txtDesc=nil;
bar2=nil;
txtHP2=nil;
btnClose=nil;
view=nil;
end
----#End#----