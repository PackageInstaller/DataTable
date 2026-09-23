local state = nil
local currItem = nil
local canvasGroup = nil
local supportDatas = nil --当前助战数据
local currSupportDatas = nil --最新助战数据
local currBtnType = 1

function Awake()
	canvasGroup = ComUtil.GetCom(clickNode, "CanvasGroup")
end

function SetIndex(_index)
	index = _index
end

function SetClickCB(_cb)
	cb = _cb
end

function OnEnable()
	supportDatas = nil
end

function Refresh(_data, _sign)
	data = _data
	sign = _sign
	if data then
		-- LogError(data)
		--state
		state = data:GetState()
		--icon
		local iconId = data:GetIconId()
		-- if(iconName) then
		-- 	ResUtil.RoleCard:Load(icon, iconName, false)
		-- 	CSAPI.SetRectSize(icon,148,148)
		-- end
		local frame = data:GetFrameId()
		UIUtil:AddHeadByID(frameParent,0.65,frame,iconId, data:GetSex())
		-- CSAPI.SetGOActive(icon, iconId ~= nil)
		-- UIUtil:AddCardIconByID(3,iconCardParent,1,data:GetIconCardId())
		--lvdata:GetIconCardId()
		CSAPI.SetText(txtLv2, data:GetLv() .. "")
		--name
		CSAPI.SetText(txtName, data:GetName())
		--id
		-- CSAPI.SetText(txtID, "ID:" .. data:GetUid() .. "")
		CSAPI.SetText(txtID,LanguageMgr:GetByID(8028) .. data:GetUid())
		--title
		UIUtil:AddTitleByID(titleParent,0.6,data:GetTitle())
		--online
		local onlineStr = data:IsOnLine() and 12015 or 12016
		onlineStr = LanguageMgr:GetByID(onlineStr)
		if sign ~= 2 then
			onlineStr = data:GetOnLine()
		end
		-- CSAPI.SetText(txtOnline, "[" .. LanguageMgr:GetByID(onlineStr) .. "]")
		CSAPI.SetText(txtOnline, onlineStr)
		local code = data:IsOnLine() and "ffc146" or "7B7B7B"
		CSAPI.SetTextColorByCode(txtOnline, code)
		CSAPI.SetGOActive(online, data:IsOnLine())
		--new 
		SetNew(data:IsNew())
		
		supportDatas = {}
		if data.assit_team then
			supportDatas = data.assit_team.data or {}
		end
		SetSupport()
		SetType()
	end
end

--设置助战
function SetSupport()
	supportList = supportList or {};
	for i = 1, 3 do	
		if(supportList[i]) then
			supportList[i].Refresh(supportDatas[i])
			supportList[i].SetClickCB(OnSupportClickCB)
			supportList[i].SetIndex(i)
		else		
			ResUtil:CreateUIGOAsync("Friend/FriendSupportItem", supportNode, function(go)
				local lua = ComUtil.GetLuaTable(go)
				lua.Refresh(supportDatas[i])
				lua.SetClickCB(OnSupportClickCB)		
				lua.SetIndex(i)	
				supportList[i] = lua;
			end)
		end
	end	
end

--助战点击回调
function OnSupportClickCB(item)
	currItem = item
	local ix = sign == 2 and FriendIxType.FriendSreach or FriendIxType.FriendList
	if item.GetCid() then
		FriendProto:GetFriendCard(data:GetUid(), {item.GetCid()}, ix, OnCardInfoCallBack)
	end
	--FriendProto:GetAssitInfo(data:GetUid(), OnCardInfoCallBack)
end

--获取助战卡牌数据回调
function OnCardInfoCallBack(proto)
	local _cards = proto.cards
	-- if not CheckSupportIsNew(_cards) then --数据不一致则刷新助战
	-- 	supportDatas = SetSupportInfo(_cards)
	-- 	FriendMgr:FriendSupportUpdate(data:GetUid(), supportDatas, sign)
	-- 	SetSupport()
	-- end
	if _cards then	
		local _card = CharacterCardsData(_cards[1])	
		--CSAPI.OpenView("RoleInfo", _card, RoleInfoOpenType.LookOther)
		CSAPI.OpenView("RoleInfo", _card)
	end
end

function CheckSupportIsNew(_datas)
	if #_datas ~= #supportDatas then
		return false
	else
		for i, v in ipairs(_datas) do		
			if v.cid ~= supportDatas[i].cid then
				return false
			end
		end
	end
	return true
end

--重新封装数据
function SetSupportInfo(_datas)
	local sDatas = {}
	if _datas and #_datas > 0 then
		for i, v in ipairs(_datas) do
			local supportData = {
				card_info = {
					name = v.name,
					cfgid = v.cfgid,
					equip_ids = v.equip_ids,
					level = v.level,
					cid = v.cid
				},
				cid = v.cid
			}
			table.insert(sDatas, supportData)
		end
	end
	return sDatas
end

--设置好友类型
--sign = 1-选项，2-搜索，3-申请，4-黑名单
function SetType()
	if(sign == nil or sign < 1 or sign > 4) then
		return
	end	
	
	CSAPI.SetGOActive(option, sign == 1)
	CSAPI.SetGOActive(search, sign == 2)
	CSAPI.SetGOActive(apply, sign == 3)
	CSAPI.SetGOActive(black, sign == 4)
	local x = 398
	if(sign == 1) then
		--SetOptionPlane()
	elseif(sign == 2) then
		x = 335
		SetSearchPlane()
	elseif(sign == 3) then
		x = 94
		SetApplyPlane()
	elseif(sign == 4) then
		--SetBlackPlane()
		x = 335
	end

	CSAPI.SetAnchor(supportObj,x,61)
end

--选项
-- function SetOptionPlane()
-- end
--宿舍
function OnClickDorm()
	currBtnType = 1
	EventMgr.Dispatch(EventType.Friend_Other, {item = this, isDorm = true})
	-- Tips.ShowTips("该功能暂不开放！")
end

--聊天
function OnClickTalk()
	-- Tips.ShowTips("该功能暂不开放！")
	-- EventMgr.Dispatch(EventType.Friend_Talk, this)
	-- if(data.is_online) then
	-- 	data:IsNewInfo(false)
	-- 	CSAPI.SetGOActive(newObj, false)
	-- 	CSAPI.OpenView("Chat", {type = ChatType.Friend, uid = data:GetUid()})
	-- else
	-- 	Tips.ShowTips("无法和离线好友进行聊天！")
	-- end
end

function SetNew(b)
	b = data:IsOnLine() and b or false
	CSAPI.SetGOActive(newObj, b)	
end

--其他
function OnClickOther()
	currBtnType = 2
	EventMgr.Dispatch(EventType.Friend_Other, {item = this, isDorm = false})
end

--删除
function OnClickDetele()
	local len = FriendMgr:GetDelCnt()
	local max = Cfgs.CfgFriendConst:GetByID(eFriendConst.DailyDelLimit).nVal
	local dialogdata = {}
	dialogdata.content = len < max and LanguageMgr:GetTips(6000) or LanguageMgr:GetTips(6001)
	if(len < max) then
		dialogdata.okCallBack = function()
			local tabs = {{uid = data:GetUid(), state = eFriendState.Delete}}
			FriendMgr:Op(tabs)
		end
	end
	CSAPI.OpenView("Dialog", dialogdata)
end

--拉黑
function OnClickBlock()
	local dialogdata = {}
	dialogdata.content = LanguageMgr:GetTips(6002)
	dialogdata.okCallBack = function()
		local tabs = {{uid = data:GetUid(), state = eFriendState.Black}}
		FriendMgr:Op(tabs)
	end
	CSAPI.OpenView("Dialog", dialogdata)
end

--搜寻
function SetSearchPlane()
	local str = ""
	local isShowBtn = true
	local isShowImg = true
	local isAlpha = true
	local isWaiting = false
	local color = {255, 255, 255, 255}
	CSAPI.SetGOActive(txt_apply, false)
	if(state == eFriendState.Pass) then --已是好友
		str = LanguageMgr:GetByID(12029)
		color = {255, 193, 64, 255}
		isShowBtn = false --隐藏按钮
	elseif(state == eFriendState.Black) then --已拉黑
		str = LanguageMgr:GetByID(12030)
		isShowBtn = false
	elseif(state == eFriendState.Apply) then --已申请
		str = LanguageMgr:GetByID(12031)
		isShowImg = false --只显示按钮底框
		color = {15, 15, 25, 125}
		isAlpha = false --半透明
	elseif(state == eFriendState.Waiting) then --被申请
		str = LanguageMgr:GetByID(12032)
		isShowBtn = false
		isWaiting = true
	end
	CSAPI.SetTextColor(txtState, color[1], color[2], color[3], color[4])
	CSAPI.SetGOActive(btnAdd, isShowBtn)
	CSAPI.SetGOActive(imgAdd, isShowImg)
	CSAPI.SetGOActive(txt_add, isShowImg)
	CSAPI.SetGOActive(txt_apply, isWaiting)
	if(not addCanvasGroup)then
		addCanvasGroup = ComUtil.GetCom(btnAdd,"CanvasGroup")
	end
	addCanvasGroup.alpha = isAlpha and 1 or 0.5
	CSAPI.SetText(txtState, str)
end

function SetRemoveTween()
	if not fade then
		fade = ComUtil.GetCom(clickNode, "ActionFade")
	end
	local x, y = CSAPI.GetLocalPos(clickNode)
	CSAPI.SetUIScaleTo(clickNode, nil, 0.8, 0.8, 1, nil, 0.15, 0.05)
	CSAPI.MoveTo(clickNode, "UI_Local_Move", x + 746, y, 0, nil, 0.45, 0.27)
	fade.delayValue = 1
	fade:Play(1, 0, 270, 450, function()
		CSAPI.SetScale(clickNode, 1, 1, 1)
		CSAPI.SetAnchor(clickNode, 0, 0, 0)
		canvasGroup.alpha = 1
		CSAPI.SetGOActive(gameObject, false)
	end)
	EventMgr.Dispatch(EventType.Friend_UI_Remove)
end

--添加
function OnClickAdd()
	EventMgr.Dispatch(EventType.Friend_Apply_Panel, this)
end

--申请
function SetApplyPlane()
	-- CSAPI.SetText(txtSign, data.apply_msg)
	CSAPI.SetText(txtSign, "")
end

--接受
function OnClickAccept()
	if(FriendMgr:CanAdd()) then
		-- EventMgr.Dispatch(Friend_Wait_Accept, this)
		local datas = {{uid = data:GetUid(), state = eFriendState.Pass}}	
		FriendMgr:Op(datas)
	else
		LanguageMgr:ShowTips(6015)
		-- Tips.ShowTips("好友已达到上限，无法继续添加!")
	end
end

--拒绝
function OnClickRefuse()
	local datas = {{uid = data:GetUid(), state = eFriendState.Deny}}	
	FriendMgr:Op(datas)
end

--拉黑
-- function SetBlackPlane()
-- end
function OnClickRelieve()
	local datas = {{uid = data:GetUid(), state = eFriendState.DelBlack}}	
	FriendMgr:Op(datas)
end

function GetUid()
	return data and data:GetUid()
end

--更多按钮位置
function GetBtnPos()
	local go = currBtnType == 1 and dorm or other
	local x, y = CSAPI.GetLocalPos(go)
	return x, y
end

function GetIndex()
	return index
end

function GetSupports()
	return data and data.assit_team and data.assit_team.data
end

function GetIconName()
	return data and data:GetIconName()
end

function OnClick()
	if(cb) then
		cb(this)
	end
end

function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	clickNode = nil;
	lineImg = nil;
	icon = nil;
	txtLv1 = nil;
	txtLv2 = nil;
	txtName = nil;
	txtID = nil;
	txtSign = nil;
	onlineObj = nil;
	txtOnline = nil;
	online = nil;
	offline = nil;
	supportNode = nil;
	option = nil;
	dorm = nil;
	txt_dorm = nil;
	talk = nil;
	txt_talk = nil;
	newObj = nil;
	other = nil;
	txt_other = nil;
	search = nil;
	btnAdd = nil;
	imgAdd = nil;
	txt_add = nil;
	txtState = nil;
	apply = nil;
	btnAccept = nil;
	txt_accept = nil;
	btnRefuse = nil;
	txt_refuse = nil;
	black = nil;
	btnRelieve = nil;
	txt_relieve = nil;
	view = nil;
end
----#End#----
