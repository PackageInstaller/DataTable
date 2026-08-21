-- module(..., package.seeall);

---@class UICommonUtils
local UICommonUtils = {}
local cjson = require "cjson"

--local TradeSetting = Require "TradeSetting"
---@class LocalStrEnum:string

function UICommonUtils.RegEvent()
	GameMsgMgr:regEvent(GameMsgType.Kick, nil, UICommonUtils.DealKick)
	GameMsgMgr:regEvent(GameMsgType.None18Overtime, nil, UICommonUtils.DealNone18Overtime)
	GameMsgMgr:regEvent(GameMsgType.GameVersionNeedUpdate, nil, UICommonUtils.GameVersionNeedUpdate)
end

function UICommonUtils.DealKick(data)
	LuaLogger.ds("deal kick", tablex.dump(data))
	GameNetHandler.IsKicked = true
	GameNetHandler:ClearLoader()
	if EngineUtil.IsWebGL() then
		GameNetHandler:LuaDisconnect()
	end
	local txt = LocalStrEnum.UI_Kick_OtherUserLoginAccount
	if data then
		if data.reason == GE.KickReasonCode.otherLogin then
			txt = LocalStrEnum.UI_kick_Login
		elseif data.reason == GE.KickReasonCode.serverKick then
			txt = LocalStrEnum.UI_kick_Server_Maintenance
		elseif data.reason == GE.KickReasonCode.serverClose then
			txt = LocalStrEnum.UI_kick_serverClose
		elseif data.reason == GE.KickReasonCode.switchGateway then
			txt = LocalStrEnum.UI_kick_switchGateway
		elseif data.reason == GE.KickReasonCode.protocolDuplicate then
			txt = LocalStrEnum.UI_kick_protocolDuplicate
		end
	end
	UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, txt, function ()
		UIMgr:clearAllUI()
		StateMgr:ChangeToState(GameFlowState.LoginState)
	end)
end

function UICommonUtils.DealNone18Overtime(data)
	LuaLogger.ds("None18Overtime")
	GlobalInfo.None18EnterGameFailed = true

	-- local str
	-- -- if data.enterCode == GE.EnterGameCode.CantEnterOvertime18 then
	-- -- 	local AddictionPrevention = require "AddictionPrevention"
	-- -- 	str = string.format(LocalStrEnum.None18OnlineOvertimeHour, tostring(AddictionPrevention.MaxHoursToday()))
	-- -- else
	-- -- 	str = LocalStrEnum.None18Forbidden228
	-- -- end

	-- -- 目前只有这种可能，就不判断了
	-- -- if data.enterCode == GE.EnterGameCode.CanOnlyEnterByNewPolicy1 then
	-- local AddictionPrevention = require "AddictionPrevention"
	-- str = LocalStrEnum.None18NewPolicy1OnlineOvertime--string.format(LocalStrEnum.None18NewPolicy1OnlineOvertime, tostring(AddictionPrevention.MaxHoursToday()))
	-- -- else

	-- UICommonUtils.PopOkBox(LocalStrEnum.FangChenMiPromptTitle, str, function ()
	-- 	StateMgr:ChangeToState(GameFlowState.LoginState)
	-- end)
	UIMgr:popUICover("Adult")
end

function UICommonUtils.GameVersionNeedUpdate()
	UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, LocalStrEnum.GameNeedRestartUpdate, function ()
		if EngineUtil.IsWebGL() then
			g_GameMain:RestartApp()
		else
			Application.Quit()
		end
	end)
end

function UICommonUtils.RefreshLayoutGroup(group)
	-- 立即设不起作用
	DLuaTimer:DoAfter(0.001, function ()
		UnityEngine.UI.LayoutRebuilder.MarkLayoutForRebuild(group:GetComponent(typeof(UnityEngine.RectTransform)))
	end)
end

function UICommonUtils.ReplaceContentBySex(str, obj)
	if stringx.isNilOrEmpty(str) then
		return str
	end
	
	local sex = obj.sex
	local job = obj.job
	
	local key1 = "{sex:(%d*)}"
	for sexIdxStr,v in str:gmatch(key1) do
		local sexId
		if sex == SexType.Male then
			sexId = 1
		else
			sexId = 2
		end

		local strKey = string.format("CallSex%s_%d", sexIdxStr, sexId)
		local toReplace = LocalStrEnum[strKey]
		if not toReplace then
			toReplace = "小家伙"
		end

		str = str:gsub(string.format("{sex:%s}", sexIdxStr), toReplace)
	end

	key1 = "{job:(%d*)}"
	for jobIdxStr,v in str:gmatch(key1) do
		local strKey = string.format("CallJob%s_%03d", jobIdxStr, job)
		local toReplace = LocalStrEnum[strKey]
		if not toReplace then
			toReplace = "小家伙"
		end

		str = str:gsub(string.format("{job:%s}", jobIdxStr), toReplace)
	end

	return str
end

local _firebaseCodeStr = {
	[GE.FireBaseCode.InvalidEmail] = LocalStrEnum.InvalidEmail,-- InvalidEmail
	[GE.FireBaseCode.WrongPassword] = LocalStrEnum.PasswordNotCorrectStr,-- WrongPassword
	[GE.FireBaseCode.TooManyRequests] = LocalStrEnum.TooManyRequestsTryLater,-- TooManyRequests
	[GE.FireBaseCode.MissingEmail] = LocalStrEnum.PleaseEnterEmail,-- MissingEmail
	[GE.FireBaseCode.UserNotFound] = LocalStrEnum.AccountNotExistStr,-- UserNotFound
	[GE.FireBaseCode.WeakPassword] = LocalStrEnum.PasswordTooShortText,-- MissingEmail
	[GE.FireBaseCode.EmailAlreadyInUse] = LocalStrEnum.EmailAlreadyInUse,-- EmailAlreadyInUse
	[GE.FireBaseCode.Cancelled] = LocalStrEnum.AlreadyCancelled,-- Cancelled
	[GE.FireBaseCode.UnverifiedEmail] = LocalStrEnum.EmailNeedVerify,-- UnverifiedEmail

	--[1] = LocalStrEnum.InvalidEmail,--InvalidEmail
	
}

-- maintainOnly表示只处理维护的情况
function UICommonUtils.DealSDKError(response, title, maintainOnly, callback)
	--LuaLogger.ws(title, tablex.dump(response))
	if not UICommonUtils.PassportErrorCodeMap then
		UICommonUtils.PassportErrorCodeMap = DLuaUtil.GetReverseTable(GE.PassportErrorCode)
	end
	
	if not response.error and not response.Code then -- Code是Firebase的Firebase.Auth.AuthError
		LuaLogger.ws("no error in DealSDKError")
		return
	end
	--GE.PassportErrorCode

	local errorCode = response.error
	--维护
	if errorCode == GE.PassportErrorCode.Maintaining then
		-- local callback2 = function ()
		-- 	if callback then
		-- 		callback()
		-- 	end
		-- 	UIMgr:popUICover("NoticePanel", {index = GE.NoticePage.System})
		-- end
		-- UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, response.announce or LocalStrEnum.MaintainingStr, callback2, nil, callback2)
		UIMgr:popUICover("NoticePanel", {index = GE.NoticePage.System})
	elseif errorCode == GE.PassportErrorCode.MaintenanceError then
		UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, LocalStrEnum.NetworkConnectionNotSmooth, callback)
	elseif not maintainOnly then
		local content
		if response.Code then
			content = _firebaseCodeStr[response.Code] or response.Message
			--content = response.CodeString
			LuaLogger.ds(response.Message)
		else
			local errorCodeKey = UICommonUtils.PassportErrorCodeMap[errorCode]
			if errorCodeKey then
				content = LocalStrEnum[errorCodeKey] or ""
			else
				content = ""
			end
		end
		
		UICommonUtils.PopOkBox(title, content, callback)
	else
		return false
	end
	
	return true
end

function UICommonUtils.GetSignNumStr(num)
	local str = ""
	if num > 0 then
		str = "+"
	end

	return str .. num
end

function UICommonUtils.PressToChange(go, func)
	local repeater
	local step = 1
	local seconds = 0
	local delta = 0.1

	EventTriggerListener.Get(go).onDown = function ()
		seconds = 0
		repeater = DLuaTimer:DoRepeatForever(delta, function ()
			seconds = seconds + delta
			if seconds < 4 then
				step = 1
			elseif seconds < 6 then
				step = 5
			elseif seconds < 8 then
				step = 10
			elseif seconds < 10 then
				step = 20
			end

			if seconds > 1 then
				func(step)
			end
		end)
	end

	EventTriggerListener.Get(go).onUp = function ()
		repeater:Stop()
		func(1)
	end
end

function UICommonUtils.ResetToggleListener(mono, toggle, func)
	local toggleEvent = toggle.onValueChanged
	toggleEvent:RemoveAllListeners()
	local audioPath = "Audio/UI/click_tab.mp3"
	toggleEvent:AddListener(function(...)
		mono:play2DSound(audioPath, 1, 1)
		func(...)
	end)
end

function UICommonUtils.ResetButtonListener(mono, button, func, audioPath)
	button.onClick:RemoveAllListeners()
	if func then
		if audioPath ~= false then
			audioPath = audioPath or "Audio/UI/click.mp3"
		end
		
		button.onClick:AddListener(function(...)
			if audioPath ~= false then
				mono:play2DSound(audioPath)
			end
			func(...)
		end)
	end
end

--公用点击音效
---@param id GE.ClickSoundType
function UICommonUtils.PlayClickSound(id)
-- function UICommonUtils.PlayClickSound(mono, id)
	local soundInfo = Config.GetTapSoundInfo(id)
	if soundInfo then
		local audioPath = string.format(Config.AudioPath.SE, soundInfo.resource)
		LuaMain:play2DSound(audioPath)
		-- mono:play2DSound(audioPath)
	end
end

--local oriEnableInput = UIMgr.EnableInput
--function UIMgr.EnableInput(b)
--	LuaLogger.ws(b)
--	oriEnableInput(b)
--end

function UICommonUtils.EnableInput()
	UIMgr.EnableInput(true)
end

function UICommonUtils.DisableInput()
	UIMgr.EnableInput(false)
end

function UICommonUtils.PanelMoveIn(panel, time)
	-- panel.transform.gameObject:FadeIn(time, nil)
	
    local rectTrans = panel.gameObject:GetComponent(TypeInfo.RectTransform)
    local height = rectTrans.rect.height
    rectTrans.anchoredPosition = Vector2.New(rectTrans.anchoredPosition.x, height)
    panel.transform:DoMoveToY(0, time, true)
end

function UICommonUtils.PanelMoveOut(panel, time)
	-- panel.transform.gameObject:FadeOut(time, nil)

    local rectTrans = panel.gameObject:GetComponent(TypeInfo.RectTransform)
    local height = rectTrans.rect.height
    panel.transform:DoMoveToY(height, time, true)
end

function UICommonUtils.PanelMoveRightIn(panel, time)
	panel.transform.gameObject:FadeIn(time, nil)
	
    local rectTrans = panel.gameObject:GetComponent(TypeInfo.RectTransform)
    local width = rectTrans.rect.width
    rectTrans.anchoredPosition = Vector2.New(-width, rectTrans.anchoredPosition.y)
    panel.transform:DoMoveToX(0, time, true)
end

function UICommonUtils.PanelMoveLeftOut(panel, time)
	panel.transform.gameObject:FadeOut(time, nil)
	
    local rectTrans = panel.gameObject:GetComponent(TypeInfo.RectTransform)
    local width = rectTrans.rect.width
    rectTrans.anchoredPosition = Vector2.New(0, rectTrans.anchoredPosition.y)
    panel.transform:DoMoveToX(-width, time, true)
end

function UICommonUtils.PopOkCancelBox(title, content, okCallback, cancelCallback)
	UIMgr:popUI("MsgBox", { title = title, 
        content = content,
        type = MsgBoxType.OKCancel,
        okCallback = okCallback,
        cancelCallback = cancelCallback,
    })
end

function UICommonUtils.PopPromptOkCancelBox(content, okCallback, cancelCallback)
	local title = LocalStrEnum and LocalStrEnum.PromptTitle
	UICommonUtils.PopOkCancelBox(title, content, okCallback, cancelCallback)
end

function UICommonUtils.PopPromptBox(content, callback)
	local title = LocalStrEnum and LocalStrEnum.PromptTitle
	UICommonUtils.PopOkBox(title or "", content, callback)
end

function UICommonUtils.PopOkBox(title, content, okCallback, data, cancelCallback)
	UIMgr:popUICover("MsgBox", {
		title = title, 
        content = content,
        type = MsgBoxType.OK,
        okCallback = okCallback,
		cancelCallback = cancelCallback,
        data = data,
    })
end

function UICommonUtils.PopMsgBox(title, content, type, okCallback, cancelCallback, okStr, cancleStr)
	local data = {}
	data.title = title
	data.content = content
	data.type = type
	data.okStr = okStr
	data.okCallback = okCallback
	data.cancleStr = cancleStr
	data.cancelCallback = cancelCallback
	UIMgr:popUI("MsgBox", data)
end

local _reasonToastMap = {
	--[ActionFailReason.WorkOrderTitleTooShort] = LocalStrEnum
}

function UICommonUtils.MsgBoxLogicError(ok, res)
	if not ok then
		local str = _reasonToastMap[res]
		if not str then
			str = Config.GetFailReasonStr(res)
		end

		if not str then
			str = Config.GetFailReasonStr(ActionFailReason.UnknowError)
		end

		UICommonUtils.PopPromptBox(str)
	end

	return not ok
end

function UICommonUtils.ToastLogicError(ok, res)
	if not ok then
		local str = _reasonToastMap[res]
		if not str then
			str = Config.GetFailReasonStr(res)
		end

		if not str then
			str = Config.GetFailReasonStr(ActionFailReason.UnknowError)
		end

		UICommonUtils.PopToast(str)
	end
	
	return not ok
end

---弹出提示文本（滚动到屏幕中央的文本条）
---@param content string|LocalStrEnum
function UICommonUtils.PopToast(content)
	UIMgr:popUI("Toast", content)
	-- ChatUtil.AddErrorMsg(content)
end

function UICommonUtils.PopFailReason(reason)
	if reason and reason ~= ActionFailReason.None then
		UICommonUtils.PopToast(Config.GetFailReasonStr(reason))
	end
end

function UICommonUtils.SecondsToHourMinuteStr(second, up)
	local hour, min = DLuaUtil.SecondsToHourMinute(second, up)
	if hour > 0 then
		return string.format("%d%s%d%s", hour, LocalStrEnum.UI_Hour2, min, LocalStrEnum.UI_Minutes2)
	else
		return string.format("%d%s", min, LocalStrEnum.UI_Minutes2)
	end
end

-- local _panelTypeMap = {
-- 	["SelectUserPanel"] = GE.PanelType.SelectUser,
-- 	["CreateUserPanel"] = GE.PanelType.CreateChar,
-- 	["MainPanel"] = GE.PanelType.Main,
-- 	["ItemPanel"] = GE.PanelType.Bag,
-- 	["HeroesPanel"] = GE.PanelType.Heroes,
-- 	["StorePanel"] = GE.PanelType.Store,
-- 	["MailPanel"] = GE.PanelType.Mail,
-- 	["ChapterPanel"] = GE.PanelType.Chapter,
-- 	["AccountPanel"] = GE.PanelType.Account,
-- 	["RoomPanel"] = GE.PanelType.Room,
-- 	["LevelInfoPanel"] = GE.PanelType.LevelInfo,
-- }

function UICommonUtils.SendOpenEvent(panelName, source)
	local panelType = GE.PanelType[panelName]
	if panelType and (Me and Me.uid) then
		-- print("UICommonUtils.SendOpenEvent", panelName, source)
		-- GameNetHandler:SendMessage("user.OpenPanelReq", {panelName = panelName, source = source}, function (data)
		-- 	if data and data.ret ~= 0 then
		-- 		LuaLogger.es("OpenPanelReq failed", panelName, data.ret)
		-- 	end
		-- end)
		local data = {
			user_name = Me:getUserName(),
			user_aid = Me.aid,
			user_uid = Me.uid,
			panel_name = panelName,
			source = source,
			distinct_id = SDKMgr:getDistinctId(),
			server_id = GV.GlobalConfig.LogServerId
		}
		ThinkingAnalytics:track("panel_use", data)
	end
end

function UICommonUtils.WrapUIEvent()
	UIMgr:AddOpenFunc(function (wnd, tbData)
		-- local panelType = _panelTypeMap[tbData.id]
		-- local panelType = GE.PanelType[tbData.id]
		-- UICommonUtils.SendOpenEvent(tbData.id, tbData.source or "")
		if wnd.msgEventHandler then
			for i,v in ipairs(wnd.msgEventHandler) do
				GameMsgMgr:regEvent(v[1], wnd, v[2])
			end
		end
	end)

	UIMgr:AddCloseFunc(function (wnd)
		if wnd.msgEventHandler then
			for i,v in ipairs(wnd.msgEventHandler) do
				GameMsgMgr:unRegEvent(v[1], wnd, v[2])
			end
		end
		
		wnd:AutoReleaseAssets()
		wnd:AutoReleaseTimers()
	end)

	UIMgr:AddHideFunc(function (wnd)
		if wnd.msgEventHandler then
			for i,v in ipairs(wnd.msgEventHandler) do
				GameMsgMgr:unRegEvent(v[1], wnd, v[2])
			end
		end
		wnd:AutoReleaseTimers()
	end)

	UIMgr:AddShowFunc(function (wnd)
		if wnd.msgEventHandler then
			for i,v in ipairs(wnd.msgEventHandler) do
				GameMsgMgr:unRegEvent(v[1], wnd, v[2])
				GameMsgMgr:regEvent(v[1], wnd, v[2])
			end
		end
	end)
end

-- 定义虽然有错误但是仍然需要回调的协议
local passProto = {
	["user.UserInfoResp"] = true,
	["user.ItemUseResp"] = true,
	["user.BattleFinishResp"] = true,
	["user.payValidateResp"] = true,
	["user.payResultResp"] = true,
	["user.TavernTenReq"] = true,
	["user.RegisterUserResp"] = true,
	["login.LoginAuthResp"] = true,
	["user.BattleResultResp"] = true,
	["user.BattleStartResp"] = true,
}

local loginGateFailMsg = {"错误请求", "请重新登录", "index过期", "验证错误", "服务端错误"} -- 最后一个未实现

-- 可能是ErrorReason，也可能是协议内包含res
function UICommonUtils.IsRetOk(proto, name)
	local res = proto
	if not res.ret then
		res = res.res
		if not res then
			-- LuaLogger.w("No ErrorReason info")
			return true
		end
	end

	if res.ret == ActionFailReason.None 
		or res.ret == ActionFailReason.SUCCEES then
		res.ret = ActionFailReason.None
		return true
	else
		local msg
		local pass
		if name:startswith("login.") then
			LuaLogger.ds(res.ret)
			if name ~= "login.LoginAuthResp" then
				msg = Config.LoginFailedStr[res.ret]
				pass = true
			end
		elseif name == "user.LoginGateResp" then
			msg = loginGateFailMsg[res.ret]
			pass = true
			GameNetHandler:FailInLoginGateFlow()
		else
			msg = CommonLogic.GetResInfo(res)
		end
		if msg and string.len(msg) > 0 then
			UICommonUtils.PopToast(msg)
			LuaLogger.ws(msg)
		end
		LuaLogger.ds(name, passProto[name], pass, res.ret)
		return passProto[name] or pass
	end
end

function UICommonUtils.SendOperatelInfoReq(req,sendData)
	if Me and Me:isEnterGame() then
		--LuaLogger.es("   SendOperatelInfoReq  ",req ,EngineUtil.TableToStr(sendData))
		--GameNetHandler:SendMessage(req, sendData, function(data)
		--	if data then
		--		if data.ret ~=0 then
		--			LuaLogger.es("   SendOperatelInfoReq  ",req,sendData, data.ret)
		--		end
		--		--LuaLogger.es("   SendOperatelInfoResp  ",req ,data.ret,EngineUtil.TableToStr(sendData))
		--	end
		--end)
	end
end

---根据AssetPath来获取UI prefab的路径
---@param AssetPath string
---@return string
function UICommonUtils.GetUIPath(AssetPath)
	--body
	local len = string.len(AssetPath)
	local path1 = string.sub(AssetPath, 0 , len - 7)
	local index = string.find(path1, "/[^/]*$")
	local path2 = string.sub(path1, index+1 , string.len(path1))
	local extention = string.sub(AssetPath, len - 6 , len)
	if EngineUtil.IsWebGL() then
		return string.format("Web%s/%s_%s%s", path1, path2, LocalizationLanguage, extention)
	else
		return string.format("%s/%s_%s%s", path1, path2, LocalizationLanguage, extention)
	end
end

function UICommonUtils.GetMaskUIPath(AssetPath)
	if EngineUtil.IsWebGL() then
		AssetPath = string.format("Web%s", AssetPath)
	end
	return AssetPath
end

function UICommonUtils.convertToChineseNum(num, hasOneStr, needZero, layer)
    if not layer then
        layer = 1
    end
	local mapping = {
		{num = 100000000, str = LocalStrEnum.Logic_Num_Yi, bCarry = true},
		{num = 10000, str = LocalStrEnum.Logic_Num_Wan , bCarry = true},
		{num = 1000, str = LocalStrEnum.Logic_Num_Thousand , bCarry = true},
		{num = 100, str = LocalStrEnum.Logic_Num_Hundred , bCarry = true},
		{num = 10, str = LocalStrEnum.Logic_Num_Ten, hasOneStr = false , bCarry = true},
		{num = 1, str = LocalStrEnum.Logic_Num_One},
		{num = 2, str = LocalStrEnum.Logic_Num_Two},
		{num = 3, str = LocalStrEnum.Logic_Num_Three},
		{num = 4, str = LocalStrEnum.Logic_Num_Four},
		{num = 5, str = LocalStrEnum.Logic_Num_Five},
		{num = 6, str = LocalStrEnum.Logic_Num_Six},
		{num = 7, str = LocalStrEnum.Logic_Num_Seven},
		{num = 8, str = LocalStrEnum.Logic_Num_Eight},
		{num = 9, str = LocalStrEnum.Logic_Num_Nine},
		{num = 0, str = LocalStrEnum.Logic_Num_Zero},
	}
	local currNum = num
	local numStr = ""
	local hasStr = false
	for i, v in ipairs(mapping) do
		if v.bCarry then
			local n = math.floor(currNum/v.num)
			if n > 0 then
				local str, b = UICommonUtils.convertToChineseNum(n, v.hasOneStr, needZero, layer + 1)
				if b then
					numStr = numStr .. str .. v.str
					hasStr = true
				end
				currNum = currNum - n*v.num
			end
		else
			if currNum == v.num then
				if v.num == 0 then
					needZero = true
				else
					if needZero == true then
						numStr = numStr .. LocalStrEnum.Logic_Num_Zero
					end
					if v.num == 1 and hasOneStr == false then
						hasStr = true
					else
						numStr = numStr .. v.str
						hasStr = true
					end
				end
			end
		end
	end
    if layer == 1 and string.len(numStr) == 0 then
        numStr = LocalStrEnum.Logic_Num_Zero
    end
	return numStr, hasStr
end


function UICommonUtils.getItemColorName(id)
	local str = string.format("<color=#%s>%s</color>", Config.QualityColor[Config.GetItemInfo(id).Quality]:ToHexStr(), Config.GetItemInfo(id).name)
	return str
end


function UICommonUtils.getCommonSortFunc(name, type, isAscending)
	local SortFunc = nil
	if name == "CatListSort" then--猫排序
		if type == "lvSort" then--按等级
			if isAscending then
				SortFunc = function(a, b)
					local res = a.catData.level > b.catData.level
					if a.catData.level == b.catData.level then
						res = a.catData.rarity > b.catData.rarity
						if a.catData.rarity == b.catData.rarity then
							res = a.catData.id > b.catData.id
						end
					end
					return res
				end
			else
				SortFunc = function(a, b)
					local res = a.catData.level < b.catData.level
					if a.catData.level == b.catData.level then
						res = a.catData.rarity > b.catData.rarity
						if a.catData.rarity == b.catData.rarity then
							res = a.catData.id > b.catData.id
						end
					end
					return res
				end
			end
		end
		if type == "raritySort" then--按稀有度
			if isAscending then
				SortFunc = function(a, b)
					local res = a.catData.rarity > b.catData.rarity
					if a.catData.rarity == b.catData.rarity then
						res = a.catData.level > b.catData.level
						if a.catData.level == b.catData.level then
							res = a.catData.id > b.catData.id
						end
					end
					return res
				end
			else
				SortFunc = function(a, b)
					local res = a.catData.rarity < b.catData.rarity
					if a.catData.rarity == b.catData.rarity then
						res = a.catData.level > b.catData.level
						if a.catData.level == b.catData.level then
							res = a.catData.id > b.catData.id
						end
					end
					return res
				end
			end
		end
		if type == "timeSort" then--按获取时间
			if isAscending then
				SortFunc = function(a, b)
					local res = a.catData.id > b.catData.id
					if a.catData.id == b.catData.id then
						res = a.catData.level > b.catData.level
						if a.catData.level == b.catData.level then
							res = a.catData.rarity > b.catData.rarity
						end
					end
					return res
				end
			else
				SortFunc = function(a, b)
					local res = a.catData.id < b.catData.id
					if a.catData.id == b.catData.id then
						res = a.catData.level > b.catData.level
						if a.catData.level == b.catData.level then
							res = a.catData.rarity > b.catData.rarity
						end
					end
					return res
				end
			end
		end
	end
	if SortFunc then
		return SortFunc
	else
		LuaLogger.es("——————未添加的排序方法——————")
	end
end

--判断object是否为空
function UICommonUtils.Checkobj(obj)
	if obj and not DUtil.IsNull(obj) and tostring(obj) ~= nil and tostring(obj) ~= "null" and not obj:Equals(nil) then
		return true
	else
		return false
	end
end

--判断剧情文件是否存在，不存在则新建
function UICommonUtils.CheckOrCreatStoryFileById(storyId)
	local name = "story_pv01.lua"--string.format("story_%s.lua", storyId)
    local path = string.format(Config.StoryLuaPath, name)
    local file = io.open(path,"r")
    if file then
        file:close()
		return true
    else
        local file = io.open(path,"w")
        io.output(file)
        tablex.dumpSetting.ShowIndex = false
        local storyData = {
            storyName = "待修改",
	        setting = {},
            storyScript = {
                {
                    type = "DoTalk",
                    params = {
                        rightSpine = "",
                        title = "",
                        content = "",
                        showSpine = "",
                        leftSpine = "",
                    },
                },
            },
        }
        io.write("local screenPlay =  "..tablex.dump(storyData).."\nreturn screenPlay")
        io.close(file)
		return false
    end
end

--处理界面顶部资源类型数字显示形式
function UICommonUtils.SetResourceFormatByType(resourceType, num)
	local resNum
	if resourceType == GE.ResourceType.Gold then
		resNum = Me:getItemNumById(resourceType)
	elseif resourceType == GE.ResourceType.Strength then
		resNum = Me:getTicketData().num
	elseif resourceType == GE.ResourceType.FreeDiamond then
		resNum = Me:getItemNumById(resourceType)
	end
	return UICommonUtils.FormatNumber(resNum)
end

--- 格式化数字为K或M
--- @param num number 要格式化的数字
--- @return string 格式化后的字符串
function UICommonUtils.FormatNumber(num)
    if num >= 1000000 then
        local millions = math.floor((num / 1000000) * 10) / 10
        -- Remove decimal point when integer part >= 3 digits
        if millions >= 100 or millions % 1 == 0 then
            return string.format("%d M", millions)
        else
            return string.format("%.1f M", millions)
        end
    elseif num >= 1000 then
        local thousands = math.floor((num / 1000) * 10) / 10
        -- Remove decimal point when integer part >= 3 digits
        if thousands >= 100 or thousands % 1 == 0 then
            return string.format("%d K", thousands)
        else
            return string.format("%.1f K", thousands)
        end
    else
        return tostring(num)
    end
end

--公用跳转
---@param trunToId int 跳转功能id
--@param 
function UICommonUtils.CommonTurnTo(trunToId, curWnd, finishCallback, extraData)
	if not trunToId then
		LuaLogger.es("CommonTurnTo trunToId is nil")
		return
	end
	local trunTo = Config.SkipFuncInfo(trunToId)
	if not trunTo then
		LuaLogger.es("CommonTurnTo trunTo is nil, trunToId: ", trunToId)
		return
	end
	local finishCallbackList = {}
	if finishCallback then
		table.insert(finishCallbackList, 1, finishCallback)
	end
	local function praseData(data)
		local panelName, func, panelData, overRideFunc, overRideFinishCallback, isCover = nil, nil, nil, nil, nil, false
		if data[1] == GE.TurnToType.TechnologyTreePagePanel then
			panelName = "TechnologyTreePagePanel"
		elseif data[1] == GE.TurnToType.TechnologyTreePanel then
			panelName = "TechnologyTreePanel"
			panelData = {pageId = data[2]}
		elseif data[1] == GE.TurnToType.RaffleMainPanel then
			panelName = "RaffleMainPanel"
		elseif data[1] == GE.TurnToType.HomeFuncPanel then
			panelName = "HomeFuncPanel"
			panelData = {homeType = data[2][1], constuctId = data[2][2]}
			func = function ()
				local constructCfg = Config.GetConstructionInfo(data[2][2])
				if constructCfg then
					local focusObjName = constructCfg.camera[1]
					local zOffSet = constructCfg.camera[2]
					local focusObj = GameObject.Find("FocusList/" .. focusObjName).gameObject
					local pos = focusObj.transform.position
					local coveMgr = CoveManager.instance()
					coveMgr:LookAtPos(GE.HomeLandPerspectiveType.HomeFunc, pos)
					coveMgr.homeFuncVcamObj.transform.localPosition = Vector3.New(0, 0, zOffSet)
					coveMgr:ChangeVCam(coveMgr.homeFuncVcamObj, true, true, 0.1)
					coveMgr._buildingMgr:changeBtnState(false)
					-- local mainPanel = UIMgr:GetUI("MainPanel")
					-- if mainPanel then
					-- 	mainPanel:HideAll(true, true)
					-- end
				end
			end
		elseif data[1] == GE.TurnToType.CombatIntelligenctPanel then
			panelName = "CombatIntelligenctPanel"
			func = function ()
				local constructCfg = Config.GetConstructionInfo(GE.CoustructionEnum.Intelligenct)
				if constructCfg then
					CoveManager.instance():SetHomelandShowOrHide(true)
					local focusObjName = constructCfg.camera[1]
					local zOffSet = constructCfg.camera[2]
					local focusObj = GameObject.Find("FocusList/" .. focusObjName).gameObject
					local pos = focusObj.transform.position
					local coveMgr = CoveManager.instance()
					coveMgr:LookAtPos(GE.HomeLandPerspectiveType.HomeFunc, pos)
					coveMgr.homeFuncVcamObj.transform.localPosition = Vector3.New(0, 0, zOffSet)
					coveMgr:ChangeVCam(coveMgr.homeFuncVcamObj, true, true, 0.1)
					coveMgr._buildingMgr:changeBtnState(false)
					-- local mainPanel = UIMgr:GetUI("MainPanel")
					-- if mainPanel then
					-- 	mainPanel:HideAll(true, true)
					-- end
				end
			end
		elseif data[1] == GE.TurnToType.HomeWeaponProPanel then
			panelName = "HomeWeaponProPanel"
			panelData = {itemId = data[2]}
		elseif data[1] == GE.TurnToType.WeaponFusePanel then
			panelName = "WeaponFusePanel"
		elseif data[1] == GE.TurnToType.DispatchMainPanel then
			panelName = "DispatchMainPanel"
			panelData = {page = data[2]}
			func = function()
				CoveManager.instance()._roleMgr:onInit()
			end
		elseif data[1] == GE.TurnToType.SeaMapPanel then
			panelName = "SeaMapPanel"
			panelData = {mode = data[2]}
		elseif data[1] == GE.TurnToType.MaterialLevelPanel then
			panelName = "MaterialLevelPanel"
			panelData = {
				chapterIdList = Config.GetChapterInfoByTypeDeepType(2, data[2]),
            	materialType = data[2],
				selectDeepType = data[3],
				selLevelIndex = data[4],
			}
		elseif data[1] == GE.TurnToType.LevelMapPanel then
			panelName = "LevelMapPanel"
			panelData = {page = data[2]}
			func = function()
				if data[2] then
					ClientData:SetNowSelectChatperId(data[2])
				end
				if data[3] then
					ClientData:SetNowSelectLevelId(data[3])
				end
			end
		elseif data[1] == GE.TurnToType.SimulatedLevelPanel then
			panelName = "SimulatedLevelPanel"

		elseif data[1] == GE.TurnToType.GameShopPanel then
			panelName = "GameShopPanel"
			panelData = data[2]
		elseif data[1] == GE.TurnToType.HomelandShopPanel then
			panelName = "HomelandShopPanel"
			panelData = data[2]
		elseif data[1] == GE.TurnToType.GoodsItemPanel then
			panelName = "GoodsItemPanel"
			panelData = data[2]
		elseif data[1] == GE.TurnToType.MainPanel then
			panelName = "MainPanel"
			-- panelData = {mode = 2}
			overRideFinishCallback = function()
				local mainPanel = UIMgr:GetUI("MainPanel")
				if mainPanel then
					mainPanel:changeNowMode(2)
				end
			end
			table.insert(finishCallbackList, 1, overRideFinishCallback)
		elseif data[1] == GE.TurnToType.DockRolePanel then
			panelName = "DockRolePanel"
		elseif data[1] == GE.TurnToType.WarePanel then
			panelName = "WarePanel"
			panelData = {pageIndex = data[2]}
		elseif data[1] == GE.TurnToType.GiftUsePanel then
			panelName = "GiftUsePanel"
			panelData = {
				itemId = data[2],
				needNum = extraData and extraData.needNum or 0,
				targetId = extraData and extraData.targetId or 0,
			}
			isCover = true
		elseif data[1] == GE.TurnToType.HomeLvUpPanel then
			panelName = "HomeLvUpPanel"
			isCover = true
			panelData = {homeType = data[2][1], constuctId = data[2][2]}
			func = function()
				GameMsgMgr:sendEvent(GameMsgType.ChangeMainPanelMode, 2)
				CoveManager.instance()._buildingMgr:FocusingBuild11(data[2][2])
			end
		elseif data[1] == GE.TurnToType.WeeklyBossMainPanel then
			panelName = "WeeklyBossMainPanel"
		elseif data[1] == GE.TurnToType.GenRoleFragPanel then
			func = function()
				 if CoveManager.instance() then
					CoveManager.instance():SetHomelandShowOrHide(false)
				end
				-- local asyncOperation = UnityEngine.SceneManagement.SceneManager.LoadSceneAsync("GenRoleFrag",UnityEngine.SceneManagement.LoadSceneMode.Additive)
				-- UICommonUtils.loadSceneTimer = DLuaTimer:DoRepeatForever(0.1, function()
				-- 	if (asyncOperation.isDone) then
				-- 		DLuaTimer:RemoveTimer(UICommonUtils.loadSceneTimer)
				-- 		ResMgr:LoadPrefabAsync(Config.PrefabPath.GenRoleFragRoot, function (obj)
				-- 			local battleRoot = Instantiate(obj).gameObject
				-- 			local targetScene = UnityEngine.SceneManagement.SceneManager.GetSceneByName("GenRoleFrag")
				-- 			UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(battleRoot, targetScene)
				-- 			UIMgr:popUI("GenRoleFragPanel", {}, function()
				-- 				LoadingMgr:SetUISwitchOver()
				-- 			end)
				-- 		end)
				-- 	end
				-- end)
				ResMgr:LoadSceneAsyncLua(Config.ScenePath.GenRoleFragScene, true, function(sceneName)
					ResMgr:LoadPrefabAsync(Config.PrefabPath.GenRoleFragRoot, function (obj)
						local battleRoot = Instantiate(obj).gameObject
						local targetScene = UnityEngine.SceneManagement.SceneManager.GetSceneByName("GenRoleFrag")
						UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(battleRoot, targetScene)
						UIMgr:popUI("GenRoleFragPanel", {}, function()
							LoadingMgr:SetUISwitchOver()
						end)
					end)
				end)
			end
		elseif data[1] == GE.TurnToType.ActivityPanel then
			panelName = "ActivityPanel"
			panelData = {activityId = data[2]}
			-- Singleton 关闭后 GetUI 仍能拿到实例(bClose=true)，不能当作已打开而跳过 popUI
			local activityPanelData = UIMgr:getUIData("ActivityPanel")
			if activityPanelData and not activityPanelData.bClose then
				local activityPanel = activityPanelData.ui
				overRideFunc = function()
					if activityPanelData.isHide then
						UIMgr:popUI("ActivityPanel", panelData)
						--activityPanel:OnOpen(panelData, false)
					else
						activityPanel:onSelect(data[2])
					end
				end
			end
		elseif data[1] == GE.TurnToType.ProsperityPanel then
			panelName = "ProsperityPanel"
			isCover = true
		else
			local id = tonumber(data[1])
			for k, v in pairs(GE.TurnToType) do
				if v == id then
					panelName = tostring(k)
					panelData = data[2]
					isCover = data[3] or false
					break
				end
			end
		end
		return panelName, func, panelData, overRideFunc, overRideFinishCallback, isCover
	end
	local panelName1, step1Func, panelData1, overRideFunc1, overRideFinishCallback1, isCover1 = praseData(trunTo.process[1])
	local panelName2, step2Func, panelData2, overRideFunc2, overRideFinishCallback2, isCover2 = nil, nil, nil, nil, nil, false
	if #trunTo.process > 1 then
		panelName2, step2Func, panelData2, overRideFunc2, overRideFinishCallback2, isCover2 = praseData(trunTo.process[2])
	end
	--遍历执行所有callback
	local doFinishCallback = function()
		for k, v in pairs(finishCallbackList) do
			v()
		end
	end
	--特殊处理
	if overRideFunc1 then
		overRideFunc1()
		return
	end
	local function bringPanelToTop(panelName)
		local ui = UIMgr:GetUI(panelName)
		if ui then
			UIMgr:bringUIToTop(ui)
			UIMgr:resetRenderHierarchy()
		end
	end
	local function onTurnToFinish()
		LoadingMgr:SetUISwitchOver()
		doFinishCallback()
	end
	local function popUIFunc(panelName, panelData, isCover, callFunc, endCallBack)
		if isCover then
			UIMgr:popUICover(panelName, panelData, callFunc, nil, nil, endCallBack)
		else
			UIMgr:popUI(panelName, panelData, callFunc, nil, nil, endCallBack)
		end
	end
	local function openStep2()
		if step2Func then
			step2Func()
		end
		if not panelName2 then
			onTurnToFinish()
			return
		end
		popUIFunc(panelName2, panelData2, isCover2, nil, function()
			if isCover2 then
				bringPanelToTop(panelName2)
			end
			onTurnToFinish()
		end)
	end
	local cb = function()
		if curWnd then
			UIMgr:closeUI(curWnd)
		end
		if step1Func then
			step1Func()
		end
		if panelName1 then
			-- step2 放在 step1 的 endCallBack 中，等 MainPanel 完全打开后再盖 cover 面板，避免 WndQueue 时序导致层级错乱
			popUIFunc(panelName1, panelData1, isCover1, nil, openStep2)
		else
			openStep2()
		end
	end

	local curPanel = UIMgr:getCurWndName()
	if curPanel == panelName1 then
		if step1Func then
			step1Func()
		end

		if panelName1 then
			local uiData = UIMgr:getUIData(panelName1)
			if uiData and uiData.isHide then
				UIMgr:showUIImmediately(panelName1, panelData1)
			end
			local uiBase = UIMgr:GetUI(panelName1)
			if uiBase ~= nil then
				uiBase:OnOpen(panelData1, false)
			end
		end
		openStep2()
		return
	end
	-- 单步 cover，或多步且最后一步为 cover（如 MainPanel + HomeLvUpPanel）时跳过转场
	if (isCover1 and #trunTo.process == 1) or (#trunTo.process > 1 and isCover2) or trunTo.specialSkip == 1 then
		cb()
	else
		LoadingMgr:SetUISwitchStart(cb)
	end

end

---@param id number	功能id
---@return number 功能当前状态
---@return string 弹窗提示
---@return number 未开启的情况下的显示类型 GE.FunctionNotOpenDisType
---@return boolean 是否显示new标签
function UICommonUtils.CheckFunctionOpen(id)
	-- LuaLogger.ds("需要检测的功能id:  ", id)
	local FunctionOpenInfo = Config.GetFunctionOpenInfo(id)
	if not FunctionOpenInfo then
		LuaLogger.ds("未找到对应功能id的配置信息:  ", id)
		return 1, "", GE.FunctionNotOpenDisType.Lock
	end
	local tips = FunctionOpenInfo.unlockKey			--提示
	local lockShowType = FunctionOpenInfo.isShow	--未开启的显示类型
	--遍历检测条件是否不满足

	local functionState = Me:getFunctionOpenStateById(id)
	return functionState, tips, lockShowType, FunctionOpenInfo.isNew == 1
	--return 2, tips, lockShowType
end

--- 获取已解锁但未观看过功能解锁动画列表
---@return needWatchList number[] 需要观看解锁动画的功能id列表
---@return watchedList table 已观看过解锁动画的功能id列表，key为功能
function UICommonUtils.GetUnwatchedFunctionList()
	local needWatchList = {}
	local functionOpenInfoList = Config.GetAllConfig("FunctionOpenTable")
	local watchedList = ClientData:GetCustomData(GE.CustomDataKey.FunctionOpenWatched) or {}
	--LuaLogger.ds("功能总表功能id列表:  ", tablex.dump(watchedList))
	for _, cfg in pairs(functionOpenInfoList) do
		if cfg.openPrompt == 1 then
			local state = Me:getFunctionOpenStateById(cfg.id)
			if state == GE.FunctionOpenState.Open and not tablex.contains(watchedList, tostring(cfg.id)) then
				table.insert(needWatchList, cfg.id)
				-- LuaLogger.ds("需要观看解锁动画的功能id:  ", cfg.id)
			end
		end
	end
	--LuaLogger.ds("需要观看解锁动画的功能id列表:  ", tablex.dump(needWatchList))
	--LuaLogger.ds("已观看过解锁动画的功能id列表:  ", tablex.dump(watchedList))
	return needWatchList, watchedList
end

--- 获取已解锁但未观看过关卡解锁动画列表
---@return needWatchList number[] 需要观看解锁动画的功能id列表
---@return watchedList table 已观看过解锁动画的功能id列表，key为功能
function UICommonUtils.GetUnwatchedLevelList()
	local needWatchList = {}
	local ChapterInfoList = Config.GetAllConfig("ChapterTable")
	local watchedList = ClientData:GetCustomData(GE.CustomDataKey.LevelOpenWatched) or {}
	-- LuaLogger.ds("章节总表功能id列表:  ", tablex.dump(watchedList))
	for _, cfg in pairs(ChapterInfoList) do
		--普通
		if cfg.Type == GE.ChapterType.MainStory then
			if Me:canOpenFunctionByCfg(cfg.Condition) and not tablex.contains(watchedList, tostring(cfg.id)) then
				table.insert(needWatchList, cfg.id)
			end
		--困难
		elseif cfg.Type == GE.ChapterType.MainDifficult then
			--困难解锁状态
			local state = Me:getFunctionOpenStateById(1)
			if Me:canOpenFunctionByCfg(cfg.Condition) and state == GE.FunctionOpenState.Open and not tablex.contains(watchedList, tostring(cfg.id)) then
				table.insert(needWatchList, cfg.id)
			end
		end
	end
	--LuaLogger.ds("需要观看解锁动画的章节id列表:  ", tablex.dump(needWatchList))
	--LuaLogger.ds("已观看过解锁动画的章节id列表:  ", tablex.dump(watchedList))
	return needWatchList, watchedList
end

--功能开放显示相关
-- {
-- 	lockObj = obj,
-- 	entryObj = obj,
-- 	lockShowType = GE.FunctionNotOpenDisType	未开放的显示类型
--	isOpen = bool	--是否开放
-- }
---@class FunctionOpenDisData
---@field lockShowType number	GE.FunctionNotOpenDisType	未开放的显示类型
---@field state number	GE.FunctionOpenState	功能状态
---@field lockObj UnityEngine.GameObject	锁定对象
---@field entryObj UnityEngine.GameObject	入口对象
---@field newObj UnityEngine.GameObject	新标签对象
---@field redObj UnityEngine.GameObject	红点对象
---@field showNew boolean	是否显示新标签

---@param data FunctionOpenDisData
function UICommonUtils.FunctionOpenDis(data)
	local lockShowType = data.lockShowType
	local state = data.state
	local lockObj = data.lockObj
	local entryObj = data.entryObj
	local newObj = data.newObj
	local redObj = data.redObj
	local showNew = data.showNew
	entryObj:SetActive(true)
	lockObj:SetActive(false)
	--LuaLogger.ds("FunctionOpenDis",state)
	if lockShowType == GE.FunctionNotOpenDisType.Lock then
		lockObj:SetActive(state == GE.FunctionOpenState.Lock)
	elseif lockShowType == GE.FunctionNotOpenDisType.Hide then
		lockObj:SetActive(state == GE.FunctionOpenState.Lock)
		entryObj:SetActive(state ~= GE.FunctionOpenState.Lock)
	end
	if newObj then
		newObj:SetActive(state == GE.FunctionOpenState.Open and showNew == true)
	end
	if state == GE.FunctionOpenState.Open and showNew == true and redObj ~= nil then
		redObj:SetActive(false)
	end
end


--钻石购买体力通用逻辑
function UICommonUtils.DiamondBuyStrength(isShowTips)
	local todayBuyCount = Me:getTicketData().todayBuyCount
    local changeBuyCount = todayBuyCount + 1
    local nowNeednum = Config.GetConfigInfo("BuyTicketNeedCountList")[changeBuyCount]
	local haveDiamond = Me:getItemNumById(GE.ResourceType.FreeDiamond)
    local dataBuy = {
        type = MsgBoxType.Buy,
        title = LocalStrEnum.TipBuyTickets,
		---@type BuyItemData
        needItemData = {id = GE.ResourceType.FreeDiamond, count = nowNeednum},
		---@type BuyItemData
        buyItemData = {id = GE.ResourceType.Strength, count = Config.GetConfigInfo("BuyTicketOnceCount")},
        commonMsg = string.format(LocalStrEnum.TipResidueDegree, Config.GetConfigInfo("BuyTicketCountLimit") - todayBuyCount, Config.GetConfigInfo("BuyTicketCountLimit")),
        okCallback = function()
			if haveDiamond < nowNeednum then
				UICommonUtils.PopToast(LocalStrEnum.TipDiamondNotEnough)
				return
			end
            UIMgr:closeUI("MsgBox")
            Me:buyNormalTicketReq()
        end,
    }
    local dataTips = {
        type = MsgBoxType.OKCancel,
        title = LocalStrEnum.TipTicketNotEnough,
        content = LocalStrEnum.TipToBuyTickets,
        okCallback = function()
            if todayBuyCount >= Config.GetConfigInfo("BuyTicketCountLimit") then
                UICommonUtils.PopToast(LocalStrEnum.TipBuyLimit)
            else
                UIMgr:popUI("MsgBox", dataBuy)
            end
        end,
    }
	if isShowTips then
		UIMgr:popUI("MsgBox", dataTips)
	else
		if todayBuyCount >= Config.GetConfigInfo("BuyTicketCountLimit") then
			UICommonUtils.PopToast(LocalStrEnum.TipBuyLimit)
		else
			UIMgr:popUI("MsgBox", dataBuy)
		end
	end
end

function UICommonUtils.ScreenToUILocalPos(rectTransform, camera, v2)
	local tempPos = Vector2.zero
    local success, uiLocalPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, v2, camera, tempPos)
    if success then
        if not (uiLocalPos.x == uiLocalPos.x) or not (uiLocalPos.y == uiLocalPos.y) then
            print("Error: uiLocalPos contains NaN values")
            return tempPos
        end
        return uiLocalPos
    else
        print("Error: ScreenPointToLocalPointInRectangle failed")
        return tempPos
    end
end

function UICommonUtils.WorldToScreenPoint(rectTransform, camera, uiCamera, v3)
	local tempPos = Vector2.zero
    local screenPoint = UnityEngine.RectTransformUtility.WorldToScreenPoint(camera, v3)

	local success, v2 = RectTransformUtility.ScreenPointToLocalPointInRectangle(
		rectTransform,
		screenPoint,                     
		uiCamera, tempPos);
	return success, v2
end


--通用显示角色原画或spine
---@param mono LuaMonoBehaviour
---@param showRoot UnityEngine.GameObject 显示根节点
---@param skinId integer 皮肤id
---@param callback function 回调函数，参数为spineObject
function UICommonUtils:ShowRolePicOrSpine(mono, showRoot, skinId, callback)
	local picRoot = showRoot.skinImg
	local spineRoot = showRoot.spineRoot
	local skinConfig = Config.GetCharacterSkinInfo(skinId)
	if not skinConfig then
		picRoot:SetActive(false)
		spineRoot:SetActive(false)
		if callback then
			callback(nil)
		end
		return
	end

    --根据配置信息显示spine或图片
    picRoot:SetActive(false)
    spineRoot:SetActive(false)
	showRoot.canvasGroup.alpha = 0
	local needOffset, needRate
    if skinConfig.spineKey and skinConfig.spineKey ~= "" then
		needOffset = skinConfig.spineOffset
		needRate = skinConfig.spineRate
        local prefabPath = string.format(Config.PrefabPath.RoleSpine, skinConfig.spineKey, skinConfig.spineKey)
        mono:LoadInstantiatePrefab(prefabPath, function (obj)
            local spineObject = obj
            spineObject:SetParent(spineRoot.transform)
			local objSpineAnim = spineObject:GetComponent("SkeletonAnimation")
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Action, "idle_action", true)
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, "idle", true)
			local spineAnimation = spineObject:GetComponent("SetSpineAnimation")
			if spineAnimation:CheckAnimationExist("effect") then
                objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Effect, "effect", true)
            end

			--测试版整体调低物理效果
			local objSpine = spineObject:GetComponent("SkeletonGraphic")
        	objSpine.PhysicsPositionInheritanceFactor = Vector2.New(0.4, 0.4)

			spineRoot:SetActive(true)
			showRoot.canvasGroup:DOFade(1, 0.18)
			--设置图片与spine大小和位置
			showRoot.rectTransform.anchoredPosition = Vector2(needOffset[1], needOffset[2])
			showRoot.rectTransform.localScale = Vector2.New(needRate, needRate)
			if callback then
				callback(spineObject)
			end
        end)
    else
		needOffset = skinConfig.imgOffset
		needRate = skinConfig.imgRate
        local function is_numeric(str)
            return tonumber(str) ~= nil
        end
        local resourceFolder = nil
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end
        mono:LoadSpriteAsync(string.format(Config.SpritePath.PortraitRolePath, resourceFolder, skinConfig.imgKey), function (s)
			picRoot.image.sprite = s
            picRoot.image:SetNativeSize()
            picRoot:SetActive(true)
			showRoot.canvasGroup:DOFade(1, 0.18)
			--设置图片与spine大小和位置
			showRoot.rectTransform.anchoredPosition = Vector2(needOffset[1], needOffset[2])
			showRoot.rectTransform.localScale = Vector2.New(needRate, needRate)
			if callback then
				callback(nil)
			end
        end)
    end
end

--判断是否点击在ui上
function UICommonUtils.isPointerOverUIObject()
	if (not EventSystem.current) then
		return false
	end
	local eventDataCurrentPosition = UnityEngine.EventSystems.PointerEventData(EventSystem.current)
	eventDataCurrentPosition.position = Input.mousePosition
	local results = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	EventSystem.current:RaycastAll(eventDataCurrentPosition, results)
	return results.Count > 0
end

--- 遍历寻找子物体
---@param parent Transform
---@param name string
---@return Transform
function UICommonUtils.FindDeepChild(parent, name)
    -- parent 是 Unity 的 Transform 对象
    -- name 是要查找的子物体名称
    
    -- 遍历所有子物体
    for i = 0, parent.childCount - 1 do
        local child = parent:GetChild(i)
        
        -- 检查当前子物体名称是否匹配
        if child.name == name then
            return child
        end
        
        -- 递归查找子物体的子物体
        local result = UICommonUtils.FindDeepChild(child, name)
        if result ~= nil then
            return result
        end
    end
    
    -- 没找到返回 nil
    return nil
end

--地格提示替换Image
function UICommonUtils.BlockTag_SetBlockIcon(obj, s)
	obj.transform:Find("BattleBlockTag"):GetComponent(TypeInfo.Image).sprite = s
end

--整体显隐
function UICommonUtils.BlockTag_SetActive(obj, bool)
	local image = obj.transform:Find("BattleBlockTag")
	image.gameObject:SetActive(bool)
end

--战斗HPUI相关

--战舰类型图标替换
function UICommonUtils.HP_SetShipTypeIcon(obj, s)
	obj.transform:Find("Image/bg/ShipTypeIcon"):GetComponent(TypeInfo.Image).sprite = s
end

--开关战舰图标
function UICommonUtils.HP_OpenShipTypeIcon(obj, bool)
	obj.transform:Find("Image/bg/ShipTypeIcon").gameObject:SetActive(bool)
end

--克制关系 图标替换
function UICommonUtils.HP_SetSituationIcon(obj, s)
	obj.transform:Find("Image/situationIcon"):GetComponent(TypeInfo.Image).sprite = s
end

--开关克制关系
function UICommonUtils.HP_OpenSituationIcon(obj, bool)
	obj.transform:Find("Image/situationIcon").gameObject:SetActive(bool)
end

--技能图标 图标替换
function UICommonUtils.HP_SetSkillTypeIcon(obj, s)
	obj.transform:Find("icon/skillTypeIcon"):GetComponent(TypeInfo.Image).sprite = s
end

--开关技能图标
function UICommonUtils.HP_OpenSkillTypeIcon(obj, bool)
	obj.transform:Find("icon/skillTypeIcon").gameObject:SetActive(bool)
end

--技能图标偏移量
function UICommonUtils.HP_SetSkillTypeIconOffset(obj, offset)
	local skillTypeIcon = obj.transform:Find("icon")
	skillTypeIcon.localPosition = Vector3(skillTypeIcon.localPosition.x, offset, skillTypeIcon.localPosition.z);
end

--hp偏移量
function UICommonUtils.HP_SetHpOffset(obj, offset)
	local hp = obj.transform:Find("Image")
	hp.localPosition = Vector3(hp.localPosition.x, offset, hp.localPosition.z);
end

--修改血量
function UICommonUtils.HP_ChangeHp(obj, dmg, isRepair, roleCtor)
	local hp = roleCtor:GetHp()
	local maxHp = roleCtor:GetMaxHp()
	if isRepair then
		UICommonUtils.HP_SetHp(obj, hp + dmg, maxHp)
	else
		UICommonUtils.HP_SetHp(obj, hp - dmg, maxHp)
	end
end

function UICommonUtils.Clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    else
        return value
    end
end

--设置血量
function UICommonUtils.HP_SetHp(obj, hp, maxHp)
	local hp = UICommonUtils.Clamp(hp, 0, maxHp)
	local hpSlider = obj.transform:Find("Image/HpSlider"):GetComponent(TypeInfo.Slider)
    hpSlider.value = hp / maxHp
	local hpPreviewFill = obj.transform:Find("Image/HpSlider/HpPreviewImg")
    hpPreviewFill.gameObject:SetActive(false)
	local breaImage = obj.transform:Find("Image/HpSlider/break").gameObject
	breaImage:SetActive(false)
end

--设置预计伤害
function UICommonUtils.HP_SetPreviewHp(obj, dmg, isRepair, roleCtor)
	local hp = roleCtor:GetHp()
	local maxHp = roleCtor:GetMaxHp()
	local repaireColor = Color.New(35/255,1,149/255,1)
	local damageColor = Color.New(1, 0, 0, 1)
	local hpPreviewFill = obj.transform:Find("Image/HpSlider/HpPreviewImg"):GetComponent(TypeInfo.Image)
	local hpSlider = obj.transform:Find("Image/HpSlider"):GetComponent(TypeInfo.Slider)
	local breaImage = obj.transform:Find("Image/HpSlider/break").gameObject

	hpPreviewFill.gameObject:SetActive(true)
    local oldValue = hpSlider.value  -- 当前血条值（0~1）
    local num = isRepair and 1 or -1  -- 治疗 +1，伤害 -1
    local c = isRepair and repaireColor or damageColor  -- 颜色（治疗/伤害）
    
    local newValue = (hp + (num * dmg)) / maxHp  -- 计算新血量比例
    hpPreviewFill.color = c  -- 设置颜色
    hpPreviewFill.fillAmount = math.max(oldValue, newValue)  -- 填充较大值
    hpSlider.value = math.min(oldValue, newValue)  -- 血条取较小值
	if newValue <= 0 then
		breaImage:SetActive(true)
	else
		breaImage:SetActive(false)
	end
end

--关闭预计伤害
function UICommonUtils.HP_CancelPreviewHp(obj, roleCtor)
	local hpPreviewFill = obj.transform:Find("Image/HpSlider/HpPreviewImg")
	local breaImage = obj.transform:Find("Image/HpSlider/break").gameObject

	hpPreviewFill.gameObject:SetActive(false)
	breaImage:SetActive(false)

	local hp = roleCtor:GetHp()
	local maxHp = roleCtor:GetMaxHp()

	local hpSlider = obj.transform:Find("Image/HpSlider"):GetComponent(TypeInfo.Slider)
	hpSlider.value = hp / maxHp
end

--设置血条格式
function UICommonUtils.Hp_SetHpImageByCamp(obj, roleCtor, index)
	local hpFill = obj.transform:Find("Image/HpSlider/Fill Area/Fill"):GetComponent(TypeInfo.Image)
	local s = roleCtor:GetHpImageSpriteByCamp(index)
	hpFill.sprite = s
end

--血条偏移
function UICommonUtils.Hp_SetHpBarOffset(obj, offset)
	local hpBarObj = obj.transform:Find("Image")
	hpBarObj.transform.localPosition = Vector3(-0.1, offset, 0);
end

--整体显隐
function UICommonUtils.Hp_SetUIRootActive(obj, bool)
	LuaLogger.ds(" HP_SetUIRootActive ", bool)
	local image = obj.transform:Find("Image")
	image.gameObject:SetActive(bool)
end

--设置buff图标
function UICommonUtils.Hp_SetBuffIcon(obj, s, index)
	local buffIcon = obj.transform:Find("Image/BuffGroup/BuffIcon" .. index)
	if buffIcon then
		buffIcon:GetComponent(TypeInfo.Image).sprite = s
	end
end

--开关buff图标
function UICommonUtils.HP_OpenBuffIcon(obj, bool, index)
	local buffIcon = obj.transform:Find("Image/BuffGroup/BuffIcon" .. index)
	if buffIcon then
		buffIcon.gameObject:SetActive(bool)
	end
end

---问卷调查判断是否可开启begin
---遍历所有的内容条件，然后给出结果
function UICommonUtils.QuestionOpenList()
	local questionnaireList = Config.GetAllConfig("QuestionnaireTable")
	local openList = {}
	for k, questionnaireTable in pairs(questionnaireList) do
		local isOpen = true
		if not Me:canOpenFunctionByCfg(questionnaireTable.unlock) then
			isOpen = false
		end
		if Me:canOpenFunctionByCfg(questionnaireTable.endCondition) then
			isOpen = false
		end
		if Me.serverChannel ~= questionnaireTable.Channel then
			isOpen = false
		end

		local m_qnaireServerMap = Me:getQnaireData()
		local qnaireInfo = m_qnaireServerMap[questionnaireTable.Codeid]
		if  qnaireInfo and qnaireInfo.isCompleted == true  and  qnaireInfo.isRewarded == true  then
			isOpen = false
		end
		if isOpen then
			table.insert(openList,questionnaireTable.id)
		end
	end

	return openList
end




--通用跳转功能是否可用
---@param skipId integer 跳转功能id
---@param showTips boolean 是否显示提示
---@return boolean 是否解锁
---@return boolean 是否显示跳转按钮
function UICommonUtils.CanUseSkipJudge(skipId, showTips)
	local skipInfo = Config.SkipFuncInfo(skipId)
	if not skipInfo then
		return false, false
	end
	if skipInfo.specialShow and skipInfo.specialShow == 1 then
		return true, false
	end
	if not skipInfo.unlock or #skipInfo.unlock == 0 then
		return true, true
	end
	if skipInfo.unlock[1] == GE.JumpLockType.ChapterUnLock then
		local cfg = Config.GetChapterInfo(skipInfo.unlock[2])
		if not cfg then
			return true, false
		end
		local resule1 = UICommonUtils.CommonLockJudge(cfg.Condition, showTips)
		local resule2 = UICommonUtils.CommonLockJudge(cfg.chaCondition, showTips and resule1 == true)
		return resule1 and resule2, (resule1 and resule2) or false
	elseif skipInfo.unlock[1] == GE.JumpLockType.LevelUnlock then
		local cfg = Config.GetPveLevelInfo(skipInfo.unlock[2])
		if not cfg then
			return true, false
		end
		local resule = UICommonUtils.CommonLockJudge(cfg.unlock, showTips)
		return resule, resule and true or false
	elseif skipInfo.unlock[1] == GE.JumpLockType.FuncOpen then
		local cfg = Config.GetFunctionOpenInfo(skipInfo.unlock[2])
		if not cfg then
			return true, false
		end
		local resule = UICommonUtils.CommonLockJudge(cfg.unlock, showTips, cfg.unlockKey)
		return resule, resule and true or false
	elseif skipInfo.unlock[1] == GE.JumpLockType.ItemNum then
		local cfg = Config.GetItemInfo(skipInfo.unlock[2])
		if not cfg then
			return true, false
		end
		local haveNum = Me:getItemNumById(skipInfo.unlock[2])
		if haveNum < skipInfo.unlock[3] then
			if showTips then
				UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_ItemNoEnough)
			end
			return false, false
		end
	end
	return true, true
end

--通用解锁判断
---@param condition table 条件{{GE.CommonLockJudgeType, value1}...}
---@param showTips boolean 是否显示提示
---@param tips string 提示内容
---@return boolean 是否解锁
function UICommonUtils.CommonLockJudge(condition, showTips, tips)
	local state = Me:canOpenFunctionByCfg(condition)
	if showTips then
		for _, v in pairs(condition) do
			if v[1] == GE.CommonLockJudgeType.Level then
				local levelData = Me:getLevelDataByid(v[2])
				if not levelData or levelData.state ~= GE.LevelStateType.Finish then
					if tips then
						UICommonUtils.PopToast(tips)
					else
						local levelCfg = Config.GetPveLevelInfo(v[2])
						if levelCfg then
							local tag = ""
							if levelCfg.typemain == GE.LevelTypeMain.Main then
								tag = LocalStrEnum.FunctionOpenUnlock_Main
							elseif levelCfg.typemain == GE.LevelTypeMain.Difficulty then
								tag = LocalStrEnum.FunctionOpenUnlock_Difficulty
							elseif levelCfg.typemain == GE.LevelTypeMain.Simulated then
								tag = LocalStrEnum.FunctionOpenUnlock_Simulated
							elseif levelCfg.typemain == GE.LevelTypeMain.Material then
								tag = LocalStrEnum.FunctionOpenUnlock_Material
							elseif levelCfg.typemain == GE.LevelTypeMain.ExpMaterial then
								tag = LocalStrEnum.FunctionOpenUnlock_ExpMaterial
							elseif levelCfg.typemain == GE.LevelTypeMain.TalentMaterial then
								tag = LocalStrEnum.FunctionOpenUnlock_TalentMaterial
							elseif levelCfg.typemain == GE.LevelTypeMain.TechMaterial then
								tag = LocalStrEnum.FunctionOpenUnlock_TechMaterial
							elseif levelCfg.typemain == GE.LevelTypeMain.EquipMaterial then
								tag = LocalStrEnum.FunctionOpenUnlock_EquipMaterial
							end
							local str = string.format(LocalStrEnum.FunctionOpenUnlock_Common1, tag, levelCfg.nameKey)
							UICommonUtils.PopToast(str)
						end
					end
				end
			elseif v[1] == GE.CommonLockJudgeType.UserLevel then
				local userLevel = Me:getUserLevel()
				if userLevel < v[2] then
					if tips then
						UICommonUtils.PopToast(tips)
					else
						local str = string.format(LocalStrEnum.FunctionOpenUnlock_Common2, v[2])
						UICommonUtils.PopToast(str)
					end
				end
			elseif v[1] == GE.CommonLockJudgeType.BulidLevel then
				local buildData = Me:getConstructionDataById(v[2])
				if buildData ~= nil then
					if buildData.level < v[3] then
						if tips then
							UICommonUtils.PopToast(tips)
						else
							UICommonUtils.PopToast("功能未开放")
						end
					end
				end
			elseif v[1] == GE.CommonLockJudgeType.Time then
				local nowTime = DLuaUtil.GetGreenwichTime()
				if nowTime < v[2] then
					if tips then
						UICommonUtils.PopToast(tips)
					else
						UICommonUtils.PopToast("功能未开放")
					end
				end
			elseif v[1] == GE.CommonLockJudgeType.ProsperityLevel then
				if state == false then
					if tips then
						UICommonUtils.PopToast(tips)
					else
						UICommonUtils.PopToast("功能未开放")
					end
				end
			end
		end
	end
	return state
end

--获取所有可显示的活动id列表
---@param FunctionType number 功能类型 GE.FunctionType
function UICommonUtils.GetActivityShowIdList(FunctionType)
	local activityInfoList = Me:getActivityInfoByFunctionType(FunctionType)
	local showIdList = {}
    --筛选活动列表
    for activityId, activityInfo in pairs(activityInfoList) do
        local isShow = false
        local cfg = Config.GetActivityInfo(activityId)
		--活动开启
        if activityInfo.state == GE.ActivityState.Open then
            --首充特殊处理
            if cfg.Type == GE.ActivityType.FirstCharge then
                local taskgroup = cfg.TaskGroup[1]
                --活动关联任务 与逻辑 没有任务或者有一个任务没在进行中 则不显示活动
                local taskList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.FirstCharge, taskgroup)
                LuaLogger.ds("活动关联任务", tablex.dump(taskList))
                local isOpen = false
                for _, task in pairs(taskList) do
                    local missionData = Me:getMissionListById(task.id)
                    LuaLogger.ds("活动关联任务具体数据", tablex.dump(missionData))
                    isOpen = missionData and missionData.state == GE.MissionState.Progress or 
                        missionData and missionData.state == GE.MissionState.Unclaimed
                    if not isOpen then
                        break
                    end
                end
                isShow = isOpen
			-- --角色自选 活动完成后需要下一天关闭显示
            -- elseif cfg.Type == GE.ActivityType.HeroExchange then
            --     local taskgroup = cfg.TaskGroup[1]
            --     --活动关联任务 或逻辑 任意一个活动任务在进行中或者未领取 则显示活动
            --     local taskList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.HeroExchange, taskgroup)
			-- 	local needTaskList = {}
			-- 	for k, v in pairs(taskList) do
			-- 		if v.type == 2 or v.type == 3 then
			-- 			table.insert(needTaskList, v)
			-- 		end
			-- 	end
            --     -- LuaLogger.ds("活动关联任务", tablex.dump(taskList))
            --     local isOpen = false
            --     for _, task in pairs(needTaskList) do
            --         local missionData = Me:getMissionListById(task.id)
            --         -- LuaLogger.ds("活动关联任务具体数据", tablex.dump(missionData))
            --         isOpen = missionData and missionData.state == GE.MissionState.Progress or 
            --             missionData and missionData.state == GE.MissionState.Unclaimed
            --         if isOpen then
            --             break
            --         end
            --     end
			-- 	isShow = isOpen
			-- 	--如果活动任务都完成了，则判断是否超过24小时
			-- 	if isShow == false then
			-- 		local endTime = ClientData:GetCustomData(GE.CustomDataKey.ActivityEndTime) or {}
			-- 		local activityEndTime = endTime[tostring(activityId)] or 0
			-- 		-- LuaLogger.ds("角色自选活动结束时间", activityEndTime)
			-- 		local nowTime = Me.servertime
			-- 		--没到结束时间则继续显示
			-- 		if nowTime < activityEndTime then
			-- 			isShow = true
			-- 		end
			-- 	end
            else
				--其余活动只读服务器状态来判断
                if cfg then
                    isShow = true
                end
			end
        end
        if isShow then
            table.insert(showIdList, activityId)
        end
    end
    return showIdList
end

--记录已看过的活动
---@param activityId integer 活动id
function UICommonUtils.RecordWatchedActivity(activityId)
	--记录已看过的活动
    local watchedList = MyPrefs:GetString(GE.LocalCustomDataKey.WatchedActivityList, "")
    local data = {}
    if watchedList ~= "" then
        data = cjson.decode(watchedList)
    end
	if not data[tostring(activityId)] then
		data[tostring(activityId)] = true
		local str = cjson.encode(data)
		MyPrefs:SetString(GE.LocalCustomDataKey.WatchedActivityList, str)
		RedPointMgr:Refresh("ActivityPanelRedPoint")
	end
end

---根据礼包id获取最终价格，考虑渠道折扣
---@param GiftId 氪金商品id
function UICommonUtils.GetGiftPriceById(GiftId)
	local data = Config.GetGiftInfo(GiftId)
	if not data then
		LuaLogger.es("GetGiftPriceById not find GiftId:", GiftId)
		return 0
	end
	local cost = data.Cost
    local RechargeDiscountCost = data.RechargeDiscountCost or {}
    local channel = SDKMgr:getChannel()
    -- LuaLogger.ds("GetRechargeItemList channel:", channel)
    local costChannel = Config.PayDiscountChannelSetting[channel]
    -- LuaLogger.ds("PayDiscountChannelSetting", tablex.dump(Config.PayDiscountChannelSetting))
    if costChannel then
        --查找渠道对应的折扣价格
        for _,v in ipairs(RechargeDiscountCost) do
            if tostring(v[1]) == tostring(costChannel) then
                cost = v[2]
                break
            end
        end
    end
	return cost
end

---问卷调查判断是否可开启end


---计算当前宽度下loopGridView 显示的最大行数(or 列数)
---@param loop SuperScrollView.LoopGridView
---@return int? columnCount 一行显示的数量
function UICommonUtils.CalculateColumnCount(loop)
	if IsNull(loop) then
		return
	end
	local scrollRect = loop.ScrollRect
	if scrollRect == nil then
		scrollRect = loop.gameObject:GetComponent(TypeInfo.ScrollRect)
	end
	if IsNull(scrollRect) then
		return
	end
	local columnCount = 0
	if scrollRect.vertical then
		local view = scrollRect.viewport
		local availableWidth = view.rect.width - loop.Padding.left - loop.Padding.right
		local itemWidth = loop.ItemSize.x + loop.ItemPadding.x
		if itemWidth <= 0 then
			return
		end
		columnCount = math.floor((availableWidth + loop.ItemPadding.x) / itemWidth)
		loop:SetGridrColumnCount(columnCount)
	elseif scrollRect.horizontal then
		local view = scrollRect.viewport
		local availableHeight = view.rect.height - loop.Padding.top - loop.Padding.bottom
		local itemHeight = loop.ItemSize.y + loop.ItemPadding.y
		if itemHeight <= 0 then
			return
		end
		columnCount = math.floor((availableHeight + loop.ItemPadding.y) / itemHeight)
		loop:SetGridrColumnCount(columnCount)
	end
	return columnCount
end

--根据角色所选语种播放语音(角色语音相关音频都要使用此方法)
---@param roleId integer 角色id
---@param configPath string 资源配置表路径
---@param callBack function 播放完成回调
---@param monoObj? UnityEngine.GameObject Mono对象，用于资源卸载
function UICommonUtils.Play2DVoiceByLanguage(roleId, configPath, callBack, monoObj)
	local roleData = Me.name and Me:getPlayerHero(roleId) or nil
	local voiceType = Me.name and Me:getUserData().CharInitVoice or GE.RoleLanguage.CHS
	if roleData then
		voiceType = roleData.voiceType
	end
	local voicePath
	if voiceType == GE.RoleLanguage.CHS then
		voicePath = string.format(Config.AudioPath.CharacterVoice, configPath)
	elseif voiceType == GE.RoleLanguage.JP then
		voicePath = string.format(Config.AudioPath.CharacterVoiceJP, configPath)
	end
	if not monoObj then
		monoObj = ResMgr:GetResCarrier()
	end
	--LuaLogger.ds(">>>>>Play2DVoiceByLanguage", roleId, configPath, voicePath)
	local ret = AudioMgr:play2DVoice(voicePath, monoObj, nil, nil, callBack, nil, nil, nil)
	return ret
end

function UICommonUtils.ClearAllListeners(rootTransform)

	if not UICommonUtils.Checkobj(rootTransform) then
		return
	end

	local buttons = rootTransform:GetComponentsInChildren(TypeInfo.Button, true)
    for i = 1, buttons.Length do
        buttons[i - 1].onClick:RemoveAllListeners()
    end

    local scaleButtons = rootTransform:GetComponentsInChildren(TypeInfo.ScaleButton, true)
    for i = 1, scaleButtons.Length do
        scaleButtons[i - 1].onClick:RemoveAllListeners()
    end

    local toggles = rootTransform:GetComponentsInChildren(TypeInfo.Toggle, true)
    for i = 1, toggles.Length do
        toggles[i - 1].onValueChanged:RemoveAllListeners()
    end

    local sliders = rootTransform:GetComponentsInChildren(TypeInfo.Slider, true)
    for i = 1, sliders.Length do
        sliders[i - 1].onValueChanged:RemoveAllListeners()
    end

	local dragListener = rootTransform:GetComponentsInChildren(TypeInfo.DragListener, true)
	for i = 1, dragListener.Length do
		dragListener[i - 1]:RemoveAllEvent()
	end

	local pointerListener = rootTransform:GetComponentsInChildren(TypeInfo.PointerListener, true)
	for i = 1, pointerListener.Length do
		pointerListener[i - 1]:RemoveAllEvent()
	end

	local inputFields = rootTransform:GetComponentsInChildren(TypeInfo.InputField, true)
	for i = 1, inputFields.Length do
		inputFields[i - 1].onEndEdit:RemoveAllListeners()
	end
	
    local luaMonos = rootTransform:GetComponentsInChildren(TypeInfo.LuaMono, true)
    for i = 1, luaMonos.Length do

		if luaMonos[i - 1].transform ~= rootTransform then
			luaMonos[i - 1]:LogicDestory()
		end
    end
end

---处理生存配置表属性
---@param baseAttr table 基础属性 配置为A..枚举
---@return table 处理后的属性
function UICommonUtils.ProcessSurvivalCfgAttr(cfgAttr)
	local realAttr = {}
	for k, v in pairs(cfgAttr) do
		local attrId = tonumber(string.sub(k, 2))  -- 去掉首字母，转数字
		if attrId then
			realAttr[attrId] = v
		end
	end
	return realAttr
end



function UICommonUtils.selectPayType(callBack)

	local pay_channels, platform, pay_sdk = Me:getPlatform_(nil)
	if GV.GlobalConfig.IsAuditingRelease() then
		return
	end
	if tablex.size(pay_channels) == 1 then
		local pay_channel = pay_channels[1]
		if pay_channel == GE.PayChannel.UnionPayWeb then

			UIMgr:popUI("MsgBox", {
				title = "请选择支付方式", 
				type = MsgBoxType.SelectPay,
				okCallback = function(select_pay_channel)
					callBack(pay_channel, select_pay_channel)
				end,
			})

			--test 测试支付
			--22  local select_pay_channel = GE.PayChannel.Alipay
			
			-- UIMgr:popUI("SelectPayPanel", function(select_pay_channel)
			-- 	callBack(pay_channel, select_pay_channel)
			-- end)
		else
			callBack(pay_channel)
		end
	else
		for _, v in pairs(pay_channels) do
			if v == GE.PayChannel.TestPay then
				UICommonUtils.PopMsgBox(LocalStrEnum.UI_PromptTitle, "是否使用测试支付？", MsgBoxType.OKCancel, function ()
					callBack(GE.PayChannel.TestPay)
				end, function ()
					--test 测试支付
					callBack(pay_channel)

					UIMgr:popUI("MsgBox", {
						title = "请选择支付方式", 
						type = MsgBoxType.SelectPay,
						okCallback = function(select_pay_channel)
							callBack(select_pay_channel)
						end,
					})

					-- UIMgr:popUI("SelectPayPanel", function(pay_channel)
					-- 	callBack(pay_channel)
					-- end)
				end)
				return
			end
		end

		UIMgr:popUI("MsgBox", {
			title = "请选择支付方式", 
			type = MsgBoxType.SelectPay,
			okCallback = function(select_pay_channel)
				callBack(select_pay_channel)
			end,
		})


		-- UIMgr:popUI("SelectPayPanel", function(pay_channel)
		-- 	callBack(pay_channel)
		-- end)
		--test 测试支付
		-- local pay_channel = GE.PayChannel.Alipay
		-- callBack(pay_channel)
	end
end


function UICommonUtils.Pay(id, SuccessCB)
	UICommonUtils.PopToast("暂未开放")
	-- return
	-- UICommonUtils.selectPayType(function(pay_channel, extra)
	-- 	LuaLogger.ds("UICommonUtils:Pay pay_channel:", pay_channel)
	-- 	LuaLogger.ds("UICommonUtils:Pay id:", id)
	-- 	Me:payReq(id, pay_channel, extra, function(success, data)
	-- 		if success then
	-- 			PayMgr:Pay(id, pay_channel)
	-- 		end
	-- 	end,SuccessCB)
	-- end)
end


return UICommonUtils