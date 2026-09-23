local inpName = nil;
local tab = nil
local oldStr = "";
local bigMonth = {1, 3, 5, 7, 8, 10, 12}
local smallMonth = {2}
local currMonth = 1;
local currDay = 1
local currSex = 1;
local playerName = "";
local dayGos = {}
local isBirthday = false
local eMonthStrs = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
local monthStr = ""
local dayStr = ""
local monthNum = 0

--anim
local animMask = nil
local btnFade1 = nil
local btnFade2 = nil
local canvasGroup = nil
---国内超时1.5秒， 国外2.5秒
local TimeOutCount=1500;
--正则
local regex = nil
local regex2 = nil --特殊控制字符
function Awake()
	if CSAPI.IsADV() then
		TimeOutCount=2500;
	else
		TimeOutCount=1500;
	end
	canvasGroup = ComUtil.GetCom(node,"CanvasGroup")

	inpName = ComUtil.GetCom(inp_name, "InputField");
	CSAPI.AddInputFieldChange(inp_name, InputChange)
	-- if CSAPI.RegionalCode() == 3 or CSAPI.RegionalCode() == 5 then
	-- 	CSAPI.SetGOActive(sexTab,false)
	-- 	CSAPI.SetGOActive(sexObj,false)
	-- else
	tab = ComUtil.GetCom(sexTab, "CTab")
	tab:AddSelChangedCallBack(OnTabChanged)	
	-- end
	--sex
	for k, v in ipairs(g_SexInitCardIds) do --读取男女主立绘
		local img = k == 1 and mRoleImg or wRoleImg
		LoadImg(img, v, 0.85);
	end
	SetSex()
	--birthday
	monthStr = LanguageMgr:GetByID(16049)
	dayStr = LanguageMgr:GetByID(16050)
	CSAPI.SetText(txtBirthday, string.format("%s%s%s%s", currMonth, monthStr, currDay, dayStr))	
	for i = 1, 31 do
		table.insert(dayGos, this[i .. ""].gameObject)
	end
	CSAPI.SetGOActive(confirmNode, false)
	CSAPI.SetAnchor(mRoleImg, - 296, - 379)
	CSAPI.SetAnchor(wRoleImg, - 367, - 418)
	
	animMask = CSAPI.GetGlobalGO("UIClickMask")
end

function OnTabChanged(index)
	if currSex ~= index then
		if not roleFade then
			roleFade = ComUtil.GetCom(roleObj, "ActionFade")
		end
		if not roleTextFade then
			roleTextFade = ComUtil.GetCom(nameObj, "ActionFade")
		end
		if not iconMoveFade then
			iconMoveFade = ComUtil.GetCom(iconMove, "ActionFade")
		end
		PlayAnim(nil, 500)
		local x, y = CSAPI.GetAnchor(iconMove)
		roleFade.delayValue = 1
		roleTextFade.delayValue = 1
		iconMoveFade.delayValue = 1
		roleTextFade:Play(1, 0, 150)
		iconMoveFade:Play(1, 0, 150)
		roleFade:Play(1, 0, 150)
		CSAPI.MoveTo(iconMove, "UI_Local_Move", x + 150, y, 0, function()
			currSex = index
			-- CSAPI.SetGOActive(img9_5, index == 1)
			-- CSAPI.SetGOActive(img9_6, index == 2)
			SetSex()
			
			CSAPI.SetLocalPos(iconMove, x - 150, y, 0)
			CSAPI.MoveTo(iconMove, "UI_Local_Move", x, y, 0, nil, 0.2)
			roleFade.delayValue = 0
			roleTextFade.delayValue = 0
			iconMoveFade.delayValue = 0
			roleFade:Play(0, 1, 150)
			roleTextFade:Play(0, 1, 150)
			iconMoveFade:Play(0, 1, 150)
		end, 0.2)
	end	
end

function OnEnable()
	eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClose);  
	eventMgr:AddListener(EventType.View_Lua_Opened,OnViewOpen);    
end

function OnViewClose(viewKey)
	if viewKey == "Plot" then
		CSAPI.SetGOActive(enterAction,true)
		--startAnim
		PlayAnim(nil, 550)
	end
end

function OnViewOpen(viewKey)
	if viewKey == "Plot" then
		CSAPI.SetGOActive(enterAction,false)
		canvasGroup = 0
	end
end

function OnDisable()
	eventMgr:ClearListener()
end

function OnOpen()
	CSAPI.PlayBGM("Sys_Login", 1);
	closeFunc = data.closeFunc;

	CSAPI.SetGOActive(enterAction,true)
	--startAnim
	PlayAnim(nil, 550)
end

function OnClickOK()
	isBirthday = false
	playerName = inpName.text
	if CSAPI.IsADV() then
		local Len1 = GLogicCheck:GetStringLen(playerName)
		playerName = playerName:gsub("^%s*(.-)%s*$", "%1")
		local Len2 = GLogicCheck:GetStringLen(playerName)
		if Len1 ~= Len2 then
			local dialogData = {}
			dialogData.content = LanguageMgr:GetTips(9011)
			dialogData.okCallBack = OnNameCheck
			CSAPI.OpenView("Dialog",dialogData)
		else
			OnNameCheck()
		end
	else
		OnNameCheck()
	end
end

function OnNameCheck()
	if playerName == nil or playerName == "" then
		Tips.ShowTips(LanguageMgr:GetByID(16005));
		return
	end
	if CSAPI.IsADV()==false then
		if IsEmoji(playerName) then
			Tips.ShowTips(LanguageMgr:GetByID(16064));
			return
		end
	end
	if currSex == nil then
		Tips.ShowTips(LanguageMgr:GetByID(16007));
		return
	end
	if currMonth == nil or currDay == nil then
		Tips.ShowTips(LanguageMgr:GetByID(16006));
		return
	end
	local b = MsgParser:CheckContain(playerName)

	-- if not b then
	-- 	b = StringUtil:CheckPassStr(playerName)
	-- end
	
	if(b) then
		LanguageMgr:ShowTips(9003)
		return
	end
	EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="name_check",time=TimeOutCount,
	timeOutCallBack=function ()
		-- Tips.ShowTips("检查姓名超时,请点击重试！")
		LanguageMgr:ShowTips(6016)
	end});

	PlayerProto:PlrNameCheckUse({name = playerName},function(proto)
		EventMgr.Dispatch(EventType.Net_Msg_Getted,"name_check");
		if proto and proto.isUse ~= nil then
			if proto.isUse == false then
				SetConfirm(true);
			else
				Tips.ShowTips(LanguageMgr:GetByID(16076));
			end
		end
	end)
	BuryingPointMgr:BuryingPoint("after_login",20031)
end

--匹配中英文数字(中文符号没有去除),符合返回true，否则返回false
-- function MatchName(inputstr)
-- 	local isTrue = true;
-- 	local i = 1
-- 	while i <= #inputstr do
-- 		local curByte = string.byte(inputstr, i)
-- 		local byteCount = 1
-- 		if curByte > 239 then
-- 			byteCount = 4  -- 4字节字符
-- 		elseif curByte > 223 then
-- 			byteCount = 3  -- 汉字
-- 		elseif curByte > 128 then
-- 			byteCount = 2  -- 双字节字符
-- 		else
-- 			byteCount = 1  -- 单字节字符
-- 		end
-- 		local char = string.sub(inputstr, i, i + byteCount - 1)
-- 		if nil == string.find(char, "[0-9A-Za-z\194-\244\128-\132\134-\164\166-\191]") then
-- 			isTrue = false;
-- 			break;
-- 		end
-- 		i = i + byteCount
-- 	end
-- 	return isTrue;
-- end

function MatchName(inputstr)
	local isTrue = true
	local i = 1
	while i <= #inputstr do
		local curByte = string.byte(inputstr, i)
		local byteCount = 1
		if curByte > 239 then
			byteCount = 4  -- 4字节字符
		elseif curByte > 223 then
			byteCount = 3  -- 汉字
		elseif curByte > 128 then
			byteCount = 2  -- 双字节字符
		else
			byteCount = 1  -- 单字节字符
		end
		local char = string.sub(inputstr, i, i + byteCount - 1)
		if nil == string.find(char, "[^0-9A-Za-z]") then
			isTrue = false
			break
		end
		i = i + byteCount
	end
	return isTrue
end

function IsEmoji(_str)
	local len = StringUtil:Utf8Len(_str)
	-- local len = string.utf8len(_str) --utf8解码长度
	for i = 1, len do
		local str = StringUtil:Utf8Sub(_str, i, i)
		-- local str = string.utf8sub(_str, i, i)
		local byteLen = string.len(str)--编码占多少字节
		if byteLen > 3 then--超过三个字节的必须是emoji字符啊
			return true
		end
		
		if byteLen == 3 then
			if string.find(str, "[\226][\132-\173]") or string.find(str, "[\227][\128\138]") then
				return true--过滤部分三个字节表示的emoji字符，可能是早期的符号，用的还是三字节，坑。。。这里不保证完全正确，可能会过滤部分中文字。。。
			end
		end
		
		if byteLen == 1 then
			local ox = string.byte(str)
			if(33 <= ox and 47 >= ox) or(58 <= ox and 64 >= ox) or(91 <= ox and 96 >= ox) or(123 <= ox and 126 >= ox) or(str == "　") then
				return true--过滤ASCII字符中的部分标点，这里排除了空格，用编码来过滤有很好的扩展性，如果是标点可以直接用%p匹配。
			end
		end
	end
	return false
end

function InputChange(_str)
	_str = StringUtil:FilterChar(_str)
	local str = StringUtil:SetStringByLen(_str, 7,"")
	inpName.text = str
end

function SetSex()
	local isMan = currSex == 1 and true or false
	CSAPI.SetGOActive(mRoleImg, isMan)
	CSAPI.SetGOActive(wRoleImg, not isMan)
	-- local str = string.format("%s%s", LanguageMgr:GetByID(isMan and 16046 or 16047), LanguageMgr:GetByID(16060))
	-- CSAPI.SetText(txtName, str)
end

function OnClickYes()
	CSAPI.SetGOActive(sound, false)
	currItem = selItem
	SetVoiceName()
end

function OnClickNo()
	CSAPI.SetGOActive(sound, false)
end

function LoadImg(go, id, _scale)
	local cfg = Cfgs.CardData:GetByID(id);
	local pos, scale, imgName = RoleTool.GetImgPosScale(cfg.model,  LoadImgType.Main);
	if(pos) then
		ResUtil.ImgCharacter:Load(go, imgName);
		-- ResUtil.ImgCharacter:SetPos(go, pos);
		ResUtil.ImgCharacter:SetScale(go, _scale);
	end
end

function SetConfirm(isShow)
	if isShow then
		CSAPI.SetGOActive(confirmNode, true);
		CSAPI.SetGOActive(confirmObj, not isBirthday)
		CSAPI.SetGOActive(birthdayObj, isBirthday)
		--UIUtil:ShowAction(confirmNode, nil, UIUtil.active2);
		if isBirthday then	
			monthNum = currMonth				
			RefreshBirthdayPanel()
			SetSelectDay(currDay)
			CSAPI.SetGOActive(btnLeft, currMonth ~= 1)
			CSAPI.SetGOActive(btnRight, currMonth ~= 12)		
		else
			CSAPI.SetText(txt_cName, tostring(playerName));
			if CSAPI.RegionalCode() == 6 then
				CSAPI.SetText(txt_cBirthday, string.format("%s.%s",(currDay < 10 and "0" .. currDay or currDay),(currMonth < 10 and "0" .. currMonth or currMonth)))
			else
				CSAPI.SetText(txt_cBirthday, string.format("%s%s%s%s", currMonth, monthStr, currDay, dayStr))
			end
			
			LanguageMgr:SetText(txt_cSex, 16061, LanguageMgr:GetByID(currSex == 1 and 16046 or 16047))
			
			local cfgId = Cfgs.CardData:GetByID(g_SexInitCardIds[currSex]).model
			local cfgCharacter = Cfgs.character:GetByID(cfgId)
			ResUtil.RoleCard:Load(icon, cfgCharacter.icon, true)
		end		
	else
		--UIUtil:HideAction(confirmNode, function()
		CSAPI.SetGOActive(confirmNode, false);
		--end, UIUtil.active4);
	end
end

function OnClickCancel()
	SetConfirm(false);
end

function OnClickConfirm()
	EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="name_set",time=TimeOutCount,
	timeOutCallBack=function ()
		LanguageMgr:ShowTips(1014)
		-- Tips.ShowTips("网络连接超时，即将返回重新登录")
		SceneMgr:SetLoginLoaded(false);
		if CSAPI.IsADV() then
			ADVBackToLogin()
		else
			BackToLogin()
		end
	end});

	PlayerProto:SetPlrName({name = playerName, index = currSex, month = currMonth, day = currDay,
	use_vid = 1}, function()
		PlayerClient:SetSex(currSex);
		PlayerClient:SetName(playerName);
		EventMgr.Dispatch(EventType.Player_EditName);
		EventMgr.Dispatch(EventType.Login_Create_Role, {name = playerName, uid = PlayerClient:GetUid()}, true)
		EventMgr.Dispatch(EventType.Net_Msg_Getted,"name_set");
		if CSAPI.IsADV() or CSAPI.IsDomestic() then
			ShiryuSDK.OnRoleInfoUpdate();
			BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_ROLE_CONFIRM,{image = tostring(currSex)})
		end		
		if CSAPI.IsADV()==false then
			-- 国内、中台国内需要走数数
			-- 数数接入
			ThinkingAnalyticsMgr:SetUser({ADID = CSAPI.GetADID()},TAUserType.Once)
			BuryingPointMgr:TrackEvents("register", {gender = currSex == 1 and "男" or "女",createTime = TimeUtil:GetTime() .. ""})
		end
		if closeFunc then
			closeFunc();
		else
			view:Close();
		end
	end);
	BuryingPointMgr:BuryingPoint("after_login",20032)
end

---------------------------------生日-----------------------------------
--刷新日历面板
function RefreshBirthdayPanel()
	SetMonthOptions()
	SetDayOptions()
end

--设置月
function SetMonthOptions()
	LanguageMgr:SetText(txtTitle, 410000 + monthNum)
	-- CSAPI.SetText(txtTitle, string.format("%s%s %s", monthNum, LanguageMgr:GetByID(16049), eMonthStrs[monthNum]))
end

--点击右按钮
function OnClickRight()
	if monthNum == 1 then
		CSAPI.SetGOActive(btnLeft, true)
	elseif monthNum == 11 then
		CSAPI.SetGOActive(btnRight, false)
	end
	monthNum = monthNum + 1
	RefreshBirthdayPanel()
end

--点击左按钮
function OnClickLeft()
	if monthNum == 12 then
		CSAPI.SetGOActive(btnRight, true)
	elseif monthNum == 2 then
		CSAPI.SetGOActive(btnLeft, false)
	end
	monthNum = monthNum - 1
	RefreshBirthdayPanel()
end

--设置天
function SetDayOptions()
	local days = 30;
	local isBigMonth = false;
	for k, v in ipairs(bigMonth) do
		if v == monthNum then
			isBigMonth = true
			break;
		end
	end
	if isBigMonth then
		days = 31
	elseif monthNum == 2 then
		days = 29
	end
	for i = 30, 31 do
		if i <= days then
			CSAPI.SetGOActive(dayGos[i], true)
		else
			CSAPI.SetGOActive(dayGos[i], false)
		end
	end
	
	if not currDayText then
		currDayText = ComUtil.GetCom(txtSel, "Text")
	end
	local _day = tonumber(currDayText.text)
	if (currDay > days) or (_day > days) then
		SetSelectDay(days)
	end
end

--设置日
function SetSelectDay(day)
	local dayGo = dayGos[day]
	CSAPI.SetParent(selImg, dayGo)
	CSAPI.SetAnchor(selImg, 0, - 15)
	CSAPI.SetText(txtSel, dayGo.name)
end

--选中日
function OnClickDay(go)
	SetSelectDay(tonumber(go.name))
end

--打开日历
function OnClickBirthday()
	if not fadeImgT then
		fadeImgT = ComUtil.GetCom(fadeImg, "ActionFadeT")
	end
	fadeImgT:Play()
	isBirthday = true
	SetConfirm(true)
end

--生日确定
function OnClickSure()
	SetConfirm(false)
	if not currDayText then
		currDayText = ComUtil.GetCom(txtSel, "Text")
	end
	currDay = tonumber(currDayText.text)
	currMonth = monthNum
	CSAPI.SetText(txtBirthday, string.format("%s%s%s%s", currMonth, monthStr, currDay, dayStr))	
end

-------------------------动效--------------------
function PlayAnim(_cb, _time)
	AnimStart()
	if _cb then
		_cb()
	end
	FuncUtil:Call(AnimEnd, nil, _time)
end

function AnimStart()
	CSAPI.SetGOActive(animMask, true)
end

function AnimEnd()
	CSAPI.SetGOActive(animMask, false)
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
	node = nil;
	roleObj = nil;
	mRoleImg = nil;
	wRoleImg = nil;
	iconMove = nil;
	img9_5 = nil;
	img9_6 = nil;
	nameObj = nil;
	txt_name1 = nil;
	txtName = nil;
	txt_title1 = nil;
	txt_title2 = nil;
	txt_name2 = nil;
	txt_birthday1 = nil;
	txt1 = nil;
	childNode = nil;
	sexTab = nil;
	txt2 = nil;
	rightNode = nil;
	inp_name = nil;
	Placeholder = nil;
	text_name = nil;
	text_ok = nil;
	text_ok = nil;
	txtBirthday = nil;
	fadeImg = nil;
	confirmNode = nil;
	confirmObj = nil;
	txt3 = nil;
	icon = nil;
	txt_cName = nil;
	txt_cBirthday = nil;
	txt_cSex = nil;
	btn_cancel = nil;
	txt_cancel = nil;
	txt_confirm = nil;
	Text = nil;
	birthdayObj = nil;
	selImg = nil;
	txtSel = nil;
	btnRight = nil;
	btnLeft = nil;
	txt_confirm = nil;
	Text = nil;
	txtTitle = nil;
	gird = nil;
	view = nil;
end
----#End#----
