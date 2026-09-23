--伤害面板
function OnInit()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.TeamBoss_Room_Update, RoomeUpdate)
	eventMgr:AddListener(EventType.TeamBoss_Over, function()
		view:Close()
	end)
end

function OnDestroy()
	eventMgr:ClearListener()
	ReleaseCSComRefs()
end

function OnOpen()
	RefreshPanel()
end

function RoomeUpdate(room)
	if(data and data.id == room.id) then
		RefreshPanel()
	end
end

function RefreshPanel()
	local roles = data:GetRoles()
	table.sort(roles, function(a, b)
		return a.hurtCnt < b.hurtCnt
	end)
	items = items or {}
	ItemUtil.AddItems("TeamBoss/TeamBossDamageItem", items, roles, grid)
end 
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
Text=nil;
Text=nil;
Text=nil;
grid=nil;
view=nil;
end
----#End#----