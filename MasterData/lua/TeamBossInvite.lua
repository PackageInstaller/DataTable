--好友邀请
function Awake()
	layout = ComUtil.GetCom(vsv, "UIInfinite")
	layout:Init("UIs/TeamBoss/TeamBossInviteItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.Refresh(_data, data)
	end
end

function OnInit()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.TeamBoss_Room_Update, RoomeUpdate)
	eventMgr:AddListener(EventType.Friend_Update, RefreshPanel)
	eventMgr:AddListener(EventType.TeamBoss_Invite_Update, RefreshPanel)
	eventMgr:AddListener(EventType.TeamBoss_Over, function()
		view:Close()
	end)
end

function OnDestroy()
	eventMgr:ClearListener()
	ReleaseCSComRefs()
end


function OnOpen()
	FriendMgr:GetFlush()
end

function RoomeUpdate(room)
	if(data and data.id == room.id) then
		if(layout) then
			layout:UpdateList()
		end
	end
end

function RefreshPanel()
	if(not data) then
		Log("无房间数据")
		view:Close()
		return
	end
	
	--count
	local cur = data:GetRolesCount() - 1
	CSAPI.SetText(txtCount, string.format("可邀请的数量：%s/%s", cur, 4))
	--list
	curDatas = FriendMgr:GetDatasByState()
	layout:IEShowList(#curDatas)
end

function OnClickMask()
	view:Close()
end 
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
txtCount=nil;
vsv=nil;
view=nil;
end
----#End#----