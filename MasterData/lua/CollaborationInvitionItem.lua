local state = nil
local currItem = nil
local canvasGroup = nil
local supportDatas = nil --当前助战数据
local currSupportDatas = nil --最新助战数据
local currBtnType = 1
local isInvite=true;
local data=nil;
local code=nil;

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

function Refresh(_data,_isInvite)
	data = _data
    isInvite=_isInvite==true
	if data then
		state = data:GetState()
		local iconId = data:GetIconId()
		local frame = data:GetFrameId()
		local sex=data:GetSex();
		UIUtil:AddHeadByID(frameParent,0.78,frame,iconId,sex)
		--lv
		CSAPI.SetText(txtLv2, data:GetLv() .. "")
		--name
		CSAPI.SetText(txtName, data:GetName())

		CSAPI.SetText(txtID,LanguageMgr:GetByID(8028)..data:GetUid())
		--online
		local onlineName =	data:IsOnLine()	and "online" or "offline"
		CSAPI.LoadImg(lineImg, "UIs/Friend/" .. onlineName .. ".png", true, nil, true)
		local onlineStr = data:IsOnLine() and 12015 or 12016
		onlineStr = LanguageMgr:GetByID(onlineStr)
		CSAPI.SetText(txtOnline, "[" .. onlineStr .. "]")
		local color = data:IsOnLine() and {255, 193, 70, 255} or {150, 150, 146, 255}
		CSAPI.SetTextColor(txtOnline, color[1], color[2], color[3], color[4])
		CSAPI.SetGOActive(online, data:IsOnLine())
		CSAPI.SetGOActive(offline, not data:IsOnLine())

		--new 
		SetNew(data:IsNew())
		
		supportDatas = {}
		if data.assit_team then
			supportDatas = data.assit_team.data or {}
		end
		SetSupport()
        CSAPI.SetGOActive(search, isInvite)
        CSAPI.SetGOActive(apply, not isInvite)
        if isInvite then
            --判定是否已经邀请过
            local invited=CollaborationMgr:IsIniviteMember(data:GetUid());
            CSAPI.SetGOActive(txtState,invited);
            CSAPI.SetGOActive(btnInvite,not invited);
        end
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
			ResUtil:CreateUIGOAsync("Collaboration/CollaborationGrid", supportNode, function(go)
				local lua = ComUtil.GetLuaTable(go)
				lua.Refresh(supportDatas[i])
				lua.SetClickCB(OnSupportClickCB)		
				lua.SetIndex(i)	
                lua.SetScale(0.65);
				supportList[i] = lua;
			end)
		end
	end	
end

--助战点击回调
function OnSupportClickCB(item)
	currItem = item
	if item.GetCid() then
		FriendProto:GetFriendCard(data:GetUid(), {item.GetCid()}, FriendIxType.FriendSreach, OnCardInfoCallBack)
	end
end

--获取助战卡牌数据回调
function OnCardInfoCallBack(proto)
	local _cards = proto.cards
	if _cards then	
		local _card = CharacterCardsData(_cards[1])	
		--CSAPI.OpenView("RoleInfo", _card, RoleInfoOpenType.LookOther)
		CSAPI.OpenView("RoleInfo", _card)
	end
end

function SetNew(b)
	b = data:IsOnLine() and b or false
	CSAPI.SetGOActive(newObj, b)	
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

--接受
function OnClickAccept()
    -- local code=nil;
    -- RegressionProto:PlrBindInvite();
	if data==nil or data=="" then
		do return end
	end
	local curr=CollaborationMgr:GetCurrInfo();
	if curr==nil then
		do return end
	elseif curr:IsBindOver() then
		Tips.ShowTips(LanguageMgr:GetTips(40002));
		do return end
	-- elseif curr:GetApplyCnt()>=g_PlrBindListOnceCnt then
	-- 	Tips.ShowTips(LanguageMgr:GetTips(40004));
	-- 	do return end
	end
	RegressionProto:PlrBindBeInviteRet(true,data:GetUid())
end

--拒绝
function OnClickRefuse()
	if data==nil or data=="" then
		do return end
	end
	RegressionProto:PlrBindBeInviteRet(false,data:GetUid())
end

--邀请
function OnClickInvite()
	if data==nil or data=="" then
		do return end
	end
	local currActivity=CollaborationMgr:GetCurrInfo();
	if currActivity==nil or (currActivity and currActivity:GetApplyCnt()>=currActivity:GetApplyLimit()) then
		LanguageMgr:ShowTips(40004)
		do return end
	end
	RegressionProto:PlrBindInvite(nil,data:GetUid())
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
