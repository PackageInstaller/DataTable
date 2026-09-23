--聊天界面
local itemPath = "Chat/ChatItem"
local itemPath2 = "UIs/Chat/ChatTextItem"
local itemPath3 = "UIs/Chat/ChatFaceItem"
local items = nil
local datas = nil
local isSelect = false
local faceCfgs = nil
local textCfgs = nil
local textDatas = {}
local faceDatas = {}
local textLayout = nil
local faceLayout = nil
local textCommonDatas = {}
local faceCommonDatas = {}
local curType = 0
local curStr = ""
local curTextItem = nil
local friendUids = {}
local currUid = 0
local currItem = nil
local blackDatas

local textType = {
	"textCommon",
	"textDefault",
}

local faceType = {
	"faceCommon",
	"faceDefault",
}

-- local layout = nil
function Awake()
	tab = ComUtil.GetCom(topTab, "CTab")
	tab:AddSelChangedCallBack(OnTabChanged)
	
	-- layout = ComUtil.GetCom(centerSV, "UIInfinite")
	-- layout:Init(itemPath, LayoutCallBack, true)	
	textLayout = ComUtil.GetCom(textSv, "UIInfinite")
	textLayout:Init(itemPath2, TextLayoutCallBack, true)
	
	faceLayout = ComUtil.GetCom(faceSv, "UIInfinite")
	faceLayout:Init(itemPath3, FaceLayoutCallBack, true)
end

-- function LayoutCallBack(index)
-- 	local lua = layout:GetItemLua(index)
-- 	if(lua) then
-- 		local _data = datas[index]
-- 		lua.SetIndex(index)
-- 		lua.SetClickCB(OnItemClickCB)
-- 		lua.Refresh(_data, curType)
-- 	end
-- end
function OnTabChanged(index)
	curType = index
	ChatMgr:GetInfo(index)
end

function TextLayoutCallBack(index)
	local lua = textLayout:GetItemLua(index)
	if(lua) then
		local _data = textDatas[index]
		lua.SetIndex(index)
		lua.SetClickCB(OnTextItemClickCB)
		lua.Refresh(_data)
	end
end

function OnTextItemClickCB(item)	
	local str = item.GetStr()
	curTextItem = item
	CSAPI.SetText(txtComWorld, str)
	curStr = str
	SelectObj()
end

function FaceLayoutCallBack(index)
	local lua = faceLayout:GetItemLua(index)
	if(lua) then
		local _data = faceDatas[index]
		lua.SetIndex(index)
		lua.SetClickCB(OnFaceItemClickCB)
		lua.Refresh(_data)
	end
end

function OnFaceItemClickCB(item)	
	local name = item.GetName()
	if name ~= "" then
		local _uids = {}
		if curType == ChatType.Friend then
			if currUid > 0 then
				_uids = {currUid}
			else
				return
			end
			local friendData = FriendMgr:GetData(currUid)
			if not friendData:IsOnLine() then --下线
				Tips.ShowTips("对方已下线，无法发送消息！")
				return
			end
			if not IsShowChat(currUid) then --拉黑
				Tips.ShowTips("对方已被你拉黑，无法发送消息！")
				return
			end
		end
		name = "/" .. name
		local info = {
			uids = _uids,
			type = curType,
			content = name
		}
		ChatMgr:SendMsg(info)
	end
	SelectObj()
	
	for i, v in ipairs(faceCommonDatas) do
		if v == item then
			return
		end
	end
	table.insert(faceCommonDatas, 1, item.GetName())
	if #faceCommonDatas > 20 then
		table.remove(faceCommonDatas, #faceCommonDatas)
	end
end

function OnEnable()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.Chat_UpdateInfos, OnInfosUpdate)
end

function OnInfosUpdate(_datas)
	-- LogError("收到消息")
	datas = _datas
	RemoveBlackChat()
	RefreshPanel()	
end

function OnDisable()
	eventMgr:ClearListener()
end

function OnOpen()
	InitPanel()
end

-- data{
-- 	type,
-- 	uid,
-- }
function InitPanel()
	if(data) then
		if data.uid then			
			ChatMgr:SetCurrUid(0)
			ChatMgr:AddFriendUid(data.uid)
		end
		tab.selIndex = data.type		
	else
		tab.selIndex = 1
	end
	
	faceCfgs = Cfgs.CfgChatFace:GetAll()
	textcfgs = Cfgs.CfgChatText:GetAll()
	
	SetCommonWords()
	SetFace()
	SelectObj()
	CSAPI.SetGOActive(friendObj, false)
end

function RefreshPanel()
	CSAPI.SetText(txtEmpty, "")
	blackDatas = FriendMgr:GetDatasByState(eFriendState.Black)
	--friend
	CSAPI.SetGOActive(friendObj, curType == ChatType.Friend)
	local svHeight = curType ~= ChatType.Friend and 825 or 750
	CSAPI.SetRTSize(centerSV, 800, svHeight)
	if curType == ChatType.Friend then
		friendUids = ChatMgr:GetFriendUids()
		currUid = ChatMgr:GetCurrUid()
		if friendUids and #friendUids > 0 then
			if currUid <= 0 then --如果没有正在聊天数据则推送好友数据组第一个
				ChatMgr:PushFriendUid(friendUids[1])
				currUid = ChatMgr:GetCurrUid()
				friendUids = ChatMgr:GetFriendUids()
			end
			SetFriendGrid(friendUids)			
		end
		if currUid > 0 then
			datas = ChatMgr:GetTypeData(ChatType.Friend .. currUid)
			RemoveBlackChat()
			local friendData = FriendMgr:GetData(currUid)
			CSAPI.SetText(txtFriendName, friendData:GetOldName())
			
		else
			SetEmpty()
		end
	elseif curType == ChatType.Team then
		SetEmpty()
	end	
	
	if datas and #datas > 0 then		
		local infos = {}
		for i = #datas, 1, - 1 do
			table.insert(infos, datas[i])
		end
		datas = infos
	end
	
	items = items or {}
	ItemUtil.AddItems(itemPath, items, datas, content, OnItemClickCB, 1, curType)
	-- layout:IEShowList(#datas)
end

function RemoveBlackChat()
	if datas and #datas > 0 then		
		local infos = {}
		for i = 1, #datas do
			if IsShowChat(datas[i].data.uid) then
				table.insert(infos, datas[i])
			end
		end
		datas = infos
	end
end

function IsShowChat(_uid) --是否显示聊天信息
	if blackDatas and #blackDatas > 0 then	
		for i, v in ipairs(blackDatas) do
			if v.uid == _uid then
				return false
			end
		end
	end
	return true
end

function SetFriendGrid(_uids)
	for i = 1, 3 do	
		CSAPI.SetGOActive(this["friendItem" .. i].gameObject, false)
	end
	if #_uids > 0 then
		local uids = {}
		for i, v in ipairs(_uids) do
			if IsShowChat(v) then
				table.insert(uids, v)
			end
		end
		_uids = uids
		for i = 1, #_uids do
			CSAPI.SetGOActive(this["friendItem" .. i].gameObject, true)
			local friendData = FriendMgr:GetData(_uids[i])
			CSAPI.SetText(this["txtName" .. i].gameObject, friendData:GetOldName())
		end
	end
end

function SetEmpty()
	CSAPI.SetGOActive(friendObj, false)
	local str = ""
	if curType == ChatType.Friend then
		str = "当前没有最近聊天的好友"
	elseif curType == ChatType.Team then
		str = "敬请期待"
	end
	CSAPI.SetText(txtEmpty, str)
end

--点击弹出多选项框
function OnItemClickCB(item)
	if curType == ChatType.Notice then
		return
	end
	
	currItem = item
	SelectObj(4)
	
	--自适应位置
	local itemX, itemY = CSAPI.GetLocalPos(item.gameObject) --item相对sv的位置
	local svX, svY = CSAPI.GetLocalPos(centerSV.gameObject) --grid相对sv的位置
	local worldY = svY + itemY --画布坐标
	local offsetX = 189
	local offsetY = - 39
	CSAPI.SetLocalPos(moreObj.gameObject, svX + offsetX, worldY + offsetY)	
end

--选择物体状态 --1.常用语 2.表情 3.好友 4.多选项
function SelectObj(idx)
	if not textCanvas then
		textCanvas = ComUtil.GetCom(textObj, "CanvasGroup")
	end
	if not faceCanvas then
		faceCanvas = ComUtil.GetCom(faceObj, "CanvasGroup")
	end
	isSelect = true
	if idx == 1 then
		textCanvas.alpha = 1
		textCanvas.blocksRaycasts = true
	elseif idx == 2 then
		faceCanvas.alpha = 1
		faceCanvas.blocksRaycasts = true
	elseif idx == 3 then
		CSAPI.SetGOActive(friendGrid, true)
	elseif idx == 4 then
		CSAPI.SetGOActive(moreObj, true)
	else
		textCanvas.alpha = 0
		faceCanvas.alpha = 0
		textCanvas.blocksRaycasts = false
		faceCanvas.blocksRaycasts = false
		CSAPI.SetGOActive(friendGrid, false)
		CSAPI.SetGOActive(moreObj, false)
		isSelect = false
	end
	CSAPI.SetGOActive(btnBack, isSelect)	
end

--常用语
function SetCommonWords(_type)
	if textcfgs then
		local _datas = {}
		local type = _type or 2
		if type == 1 then
			textDatas = textCommonDatas
		else
			for i, v in ipairs(textcfgs) do
				if((type - 1) == v.type) then
					table.insert(_datas, v.text)
				end
			end
			textDatas = _datas	
		end
		textLayout:IEShowList(#textDatas)
	end
end

--表情
function SetFace(_type)	
	if faceCfgs then
		local type = _type or 2
		if type == 1 then
			faceDatas = faceCommonDatas
		else
			local _datas = {}
			for i, v in ipairs(faceCfgs) do
				if((type - 1) == v.type) then
					table.insert(_datas, v.name)
				end
			end
			faceDatas = _datas	
		end
		faceLayout:IEShowList(#faceDatas)
	end
end

function OnClickSend()
	-- LogError("发送消息")
	if curStr == nil or curStr == "" then --无消息
		return
	end
	
	local _uids = {}
	if curType == ChatType.Friend then
		if currUid > 0 then
			_uids = {currUid}
		else --无ID
			return
		end
		local friendData = FriendMgr:GetData(currUid)
		if not friendData:IsOnLine() then --下线
			Tips.ShowTips("对方已下线，无法发送消息！")
			return
		end
		if not IsShowChat(currUid) then
			Tips.ShowTips("对方已被你拉黑，无法发送消息！")
			return
		end
	end
	local info = {
		uids = _uids,
		type = curType,
		content = curStr
	}
	ChatMgr:SendMsg(info)
	
	for i, v in ipairs(textCommonDatas) do
		if v == curTextItem then
			return
		end
	end
	table.insert(textCommonDatas, 1, curTextItem.GetStr())
	if #textCommonDatas > 20 then
		table.remove(textCommonDatas, #textCommonDatas)
	end
end

function OnClickText()
	SelectObj(1)
end

function OnClickFace()
	SelectObj(2)
end

function OnClickTextType(go)
	for i, v in ipairs(textType) do
		if go.name == v then
			SetCommonWords(i)			
		end
	end
end

function OnClickFaceType(go)
	for i, v in ipairs(faceType) do
		if go.name == v then
			SetFace(i)			
		end
	end
end

-------------------------------------好友--------------------------------------
function SelectFriendState(state)
	isSelectFriend = state
	CSAPI.SetGOActive(friendGrid, isSelectFriend)
end

function OnClickFriendGrid()
	SelectFriendState(not isSelectFriend)
end

function OnClickFriend(go)
	for i = 1, 3 do
		if go.name ==("friendItem" .. i) then
			ChatMgr:PushFriendUid(friendUids[i])
			if currUid then
				ChatMgr:AddFriendUid(currUid)
			end
			RefreshPanel()
			break
		end
	end
	SelectFriendState(false)
end

-------------------------------------------------------------------------------
--玩家信息
function OnClickInfo()	
	CSAPI.OpenView("PlayerInfoView", currItem.GetUid())
end

--添加
function OnClickAdd()
	local dialogData = {}
	dialogData.content = string.format("是否向%s玩家发送好友申请？", currItem.GetName())
	dialogData.okCallBack = function()		
		FriendMgr:Op({{uid = currItem.GetUid(), state = eFriendState.Apply, apply_msg = ""}})
	end
	CSAPI.OpenView("Dialog", dialogData)
end

--拉黑
function OnClickBlack()
	local dialogData = {}
	--LogError(currItem.GetUid())
	dialogData.content = string.format("是否拉黑%s玩家？", currItem.GetName())
	dialogData.okCallBack = function()		
		FriendMgr:Op({{uid = currItem.GetUid(), state = eFriendState.Black}})
		RefreshPanel()
		OnClickBack()
	end
	CSAPI.OpenView("Dialog", dialogData)
end

function OnClickBack()
	if isSelect then
		SelectObj()
		return
	end
	
	if currUid > 0 then
		ChatMgr:AddFriendUid(currUid)
		ChatMgr:SetCurrUid(0)
	end
	view:Close()
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
topTab=nil;
btnWorld=nil;
txtWorld=nil;
btnSystem=nil;
txtSystem=nil;
btnGuild=nil;
txtGuild=nil;
btnTeam=nil;
txtTeam=nil;
btnFriend=nil;
txtFriend=nil;
centerSV=nil;
content=nil;
friendObj=nil;
friendTop=nil;
txtFriendName=nil;
btnFriend=nil;
bottomObj=nil;
btnFace=nil;
txtComWorld=nil;
btnSend=nil;
btnBack=nil;
textObj=nil;
textCommon=nil;
textDefault=nil;
textSv=nil;
textGrid=nil;
faceObj=nil;
faceCommon=nil;
faceDefault=nil;
faceSv=nil;
faceGrid=nil;
friendGrid=nil;
friendItem1=nil;
txtName1=nil;
friendItem2=nil;
txtName2=nil;
friendItem3=nil;
txtName3=nil;
emptyObj=nil;
txtEmpty=nil;
moreObj=nil;
view=nil;
end
----#End#----