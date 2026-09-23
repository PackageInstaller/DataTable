local maxLen = 10

function Awake()
	layout = ComUtil.GetComInChildren(gameObject, "UIInfinite")
	layout:Init("UIs/Menu/MenuMessageItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
	local lua = layout:GetItemLua(index)
	if(lua) then
		lua.Refresh(datas[index])
	end
end

function OnEnable()
	-- eventMgr = ViewEvent.New()
	-- eventMgr:AddListener(EventType.Chat_UpdateInfo_Menu, AddMessage)
	Refresh()
end

function OnDisable()
	-- eventMgr:ClearListener()
end

function Refresh()
	--获取10条最新数据 todo
	datas = {}
	--Test()
	layout:IEShowList(#datas, function()
	end, #datas)  --滑到最低，显示最新一条
end

--添加单条消息
function AddMessage(_data)
	table.insert(datas, _data)
	if(#datas > maxLen) then
		table.remove(datas, 1)
	end
	layout:IEShowList(#datas, nil, #datas)
end

--测试 
function Test()
	local str = "很长的字符串，未了测试过长是否正确"
	for i = 1, 20 do
		table.insert(datas, string.format("%s:%s", "测试者" .. i, StringUtil:SetStringByChats(str, i + 5)))
	end
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
btnMessage=nil;
vsvMessage=nil;
view=nil;
end
----#End#----