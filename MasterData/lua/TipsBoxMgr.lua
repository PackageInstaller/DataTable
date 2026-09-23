--TipsPanel
local tipsMaxCount = 1;--飘字最大显示个数
local tipsPadding = 80;--间距
local inviteTipsPadding = 120;--间距

function Awake()
	eventMgr = ViewEvent.New();
	--eventMgr:AddListener(EventType.View_Lua_Opened, CleanTips)
	eventMgr:AddListener(EventType.View_Lua_Closed, CleanTips)
end

function OnOpen()
	_G.Tips = this;
end

function OnDestroy()
	Log("Tips父物体被销毁！！");
	_G.Tips = nil;
	eventMgr:ClearListener();
end

--显示飘字
function ShowTips(content)
	if content == nil then
		LogError("飘字信息不能为空！！");
		return;
	end
	-- tipsQueue = tipsQueue or {};
	-- if #tipsQueue >= tipsMaxCount then
	-- 	--关闭最早显示的飘字
	-- 	for i = tipsMaxCount, #tipsQueue do
	-- 		tipsQueue[i].Close(false);
	-- 		table.remove(tipsQueue, i);
	-- 	end
	-- end
	-- --重新设置位置
	-- for i = 1, #tipsQueue do
	-- 	local item = tipsQueue[i];
	-- 	CSAPI.SetLocalPos(item.gameObject, 0, i * tipsPadding, 0);
	-- end
	local _isTween = false
	if(not item) then
		local go = ResUtil:CreateUIGO("Tips/TipsBox", transform);
		item = ComUtil.GetLuaTable(go);	
		_isTween = true
	else
		item.ResetTime()
		CSAPI.SetLocalPos(item.gameObject, 0, 0, 0);
	end
	
	item.Show({
		content = content,
		isTween = _isTween,
		closeCallBack = function()
			-- for i = 1, #tipsQueue do
			-- 	if tipsQueue[i] == item then
			-- 		table.remove(tipsQueue, i);
			-- 	end
			-- end
			item = nil
		end
	});
	-- table.insert(tipsQueue, 1, item);
end

--清空飘字
function CleanTips(viewName)
	-- if tipsQueue then
	-- 	for i = 1, #tipsQueue do
	-- 		tipsQueue[i].Close(false);
	-- 		table.remove(tipsQueue, i);
	-- 	end
	-- end
	local cfgView = Cfgs.view:GetByKey(viewName)
	if cfgView and cfgView.is_window then
		return
	end
	
	if(item) then
		item.Close(false);
		item = nil
	end
end

--------------------------------邀请tips--------------------------------------
--pvp  ArmyProto:BeInvite	uid	is_cancel	team  rank  invite_time
--teamBoss 
function ShowInviteTips(proto, inviteTypes)
	inviteTypes = inviteTypes == nil and InviteTypes.pvp or inviteTypes
	inviteTipsCount = inviteTipsCount and(inviteTipsCount + 1) or 1
	inviteTipsQueue = inviteTipsQueue or {}
	if #inviteTipsQueue >= tipsMaxCount then
		local _data = inviteTipsQueue[1]
		table.remove(inviteTipsQueue, 1)
		_data.ForceClose(function()
			AddInviteTips(proto, inviteTypes)
		end)
		return
	end
	AddInviteTips(proto, inviteTypes)
end

function AddInviteTips(proto, inviteTypes)
	ResUtil:CreateUIGOAsync(inviteTypes, gameObject, function(go)
		local item = ComUtil.GetLuaTable(go)
		item.Refresh(inviteTipsCount, proto, CheckTips)
		table.insert(inviteTipsQueue, item)	
		CSAPI.SetAnchor(go,-764,-108)
		-- --重新设置位置
		-- for i = 1, #inviteTipsQueue do
		-- 	CSAPI.SetAnchor(inviteTipsQueue[i].gameObject, 0, -(i - 1) * inviteTipsPadding, 0);
		-- end
	end)
end

--某个点取消，重新检测队列
function CheckTips(_inviteTipsCount)
	if(inviteTipsQueue) then
		for i, v in ipairs(inviteTipsQueue) do
			if(v.GetIndex() == _inviteTipsCount) then
				table.remove(inviteTipsQueue, i)
			end
		end
		-- --重新设置位置
		-- for i = 1, #inviteTipsQueue do
		-- 	inviteTipsQueue[i].SetMoveUp(-(i - 1) * inviteTipsPadding)
		-- end
	end
end

function CleanInviteTips()
	if(inviteTipsQueue) then
		for i, v in ipairs(inviteTipsQueue) do
			v.ForceClose()
		end
	end
	inviteTipsQueue = nil
end

--------------------------------任务tips--------------------------------------
function ShowMisionTips()
	local arr = MissionMgr:GetChangeDatas()
	if #arr < 1 then
		arr = AchievementMgr:GetChangeDatas()
	end
	if #arr < 1 then
		arr = BadgeMgr:GetChangeDatas()
	end
	if(#arr > 0) then
		if(not missionTips) then
			local go = ResUtil:CreateUIGO("Tips/MissionTips", transform)
			CSAPI.SetAnchor(go, 0, 0, 0)
			missionTips = ComUtil.GetLuaTable(go)
		end
		missionTips.Refresh(arr)
	end
end

function ClearMisionTips()
	if(missionTips) then
		missionTips.ClearAll()
	end
end

--------------------------------任务tips--------------------------------------
function ShowEquipExpTips(goodsInfo)
	if(goodsInfo) then
		local go = ResUtil:CreateUIGO("Tips/EquipExpTips", transform)
		CSAPI.SetAnchor(go, 0, 0, 0)
		local equipExpTips = ComUtil.GetLuaTable(go)
		equipExpTips.Refresh(goodsInfo)
	end
end

--------------------------------点击特效--------------------------------------
local Input = CS.UnityEngine.Input
local TouchPhase = CS.UnityEngine.TouchPhase;
local GetMouseButtonDown = CS.UnityEngine.Input.GetMouseButtonDown
local isEnableClickEffect = true
local clickTimer = 0
local deviceType = CSAPI.GetDeviceType()

function Update()
	--是否启用特效
	if(not isEnableClickEffect) then
		return
	end
	local pos = nil
	if(deviceType == 3) then
		--电脑
		if(GetMouseButtonDown(0)) then
			if(Time.time < clickTimer) then
				return
			end
			clickTimer = Time.time + 0.1
			pos = Input.mousePosition
		end
	else       
		if(Input.touchCount == 1 and Input.GetTouch(0).phase == TouchPhase.Began) then			
			if(Time.time < clickTimer) then
			    return
		    end
		    clickTimer = Time.time + 0.1

            pos = Input.GetTouch(0).position
		end
	end
	if(pos ~= nil) then
        CSAPI.PlayUISound("ui_generic_click")
		ResUtil:CreateUIGOAsync("Click/ClickItem", gameObject, function(go)
			CSAPI.SetToMousePosition(transform, go.transform, pos.x, pos.y, pos.z)
			CSAPI.RemoveGO(go, 1.5)
		end)
	end
end

--==============================--
--desc: 启用或关闭点击特效
--time:2021-09-07 04:58:42
--@return 
--==============================--
function SetClickEffect(b)
	isEnableClickEffect = b
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	view = nil;
end
----#End#----
