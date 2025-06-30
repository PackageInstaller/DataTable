-- chunkname: @IQIGame\\Module\\GmList\\GmListModule.lua

GmListModule = {
	Key_InspectorCanvas = "key_InspectorCanvas",
	Key_Gesture = "Key_Gesture",
	init = false,
	DEFAULT_CUSTOM_TYPE = 999,
	Key_GM = "Key_GM",
	Key_SkipBattle = "Key_SkipBattle",
	Key_Simulate_Notch = "Key_Simulate_Notch",
	Key_OpenAnim = "Key_OpenAnim",
	Key_Change_To_Spe_Test_Pack = "Key_Change_To_Spe_Test_Pack",
	Key_Debugger = "Key_Debugger",
	Key_ErrorLog = "Key_ErrorLog",
	isDraggingGmBtn = false,
	Key_Guide = "Key_Guide",
	Key_Change_To_Test_Pack = "Key_Change_To_Test_Pack",
	KEY_MAZE_CLOUD_SAVE_DATA = "KEY_MAZE_CLOUD_SAVE_DATA"
}

function GmListModule.Initialize()
	if GmListModule.init then
		return
	end

	GmListModule.init = true
	GmListModule.debugger = UnityEngine.GameObject.Find("/Game Framework/Builtin/Debugger"):GetComponent("DebuggerComponent")
	GmListModule.inspectorCanvas = UnityEngine.GameObject.Find("/Inspector").transform:Find("InspectorCanvas").gameObject

	local gmBtnTrans = UnityEngine.GameObject.Find("/Game Framework/Customs/Overlay").transform:Find("Gm")

	GmListModule.btnGm = gmBtnTrans:GetComponent("Button")

	local GUIDTrans = UnityEngine.GameObject.Find("/Game Framework/Customs/Overlay").transform:Find("GUID")

	if GUIDTrans then
		GUIDTrans.gameObject:SetActive(false)
	end

	local uiDrag = gmBtnTrans:GetComponent("UIDrag")

	uiDrag.onBeginDrag = GmListModule.OnGmBtnBeginDrag
	uiDrag.onEndDrag = GmListModule.OnGmBtnEndDrag

	local config = GmListModule.GetDebugConfig()

	if config == nil then
		config = {}
	end

	if config[GmListModule.Key_OpenAnim] == nil then
		config[GmListModule.Key_OpenAnim] = true
	end

	if config[GmListModule.Key_Guide] == nil then
		config[GmListModule.Key_Guide] = true
	end

	if config[GmListModule.Key_GM] == nil then
		config[GmListModule.Key_GM] = false
	end

	if config[GmListModule.Key_SkipBattle] == nil then
		config[GmListModule.Key_SkipBattle] = false
	end

	if config[GmListModule.Key_Gesture] == nil then
		config[GmListModule.Key_Gesture] = false
	end

	if config[GmListModule.KEY_MAZE_CLOUD_SAVE_DATA] == nil then
		config[GmListModule.KEY_MAZE_CLOUD_SAVE_DATA] = false
	end

	if config[GmListModule.Key_Change_To_Test_Pack] == nil then
		config[GmListModule.Key_Change_To_Test_Pack] = false
	end

	if config[GmListModule.Key_Change_To_Spe_Test_Pack] == nil then
		config[GmListModule.Key_Change_To_Spe_Test_Pack] = false
	end

	GmListModule.SaveDebugConfig(config)
	GmListModule.SetGmEntryVisible(GmListModule.EnableGM())
	GmListModule.SetDebuggerVisible(GmListModule.EnableDebug())
	GmListModule.SetInspectorCanvasVisible(GmListModule.EnableInspectorCanvas())
	GmListModule.SetErrorLogEnable(GmListModule.EnableErrorLog())
	GmListModule.SetSimulateNotchEnable(GmListModule.EnableSimulateNotch())
end

function GmListModule.AddCustomCmdData(cmdTxt)
	if cmdTxt == nil or cmdTxt == "" then
		NoticeModule.ShowNoticeByType(1, "命令无效")

		return
	end

	local lower = string.lower(cmdTxt)

	if not string.find(lower, "/cmd") then
		NoticeModule.ShowNoticeByType(1, "命令无效")

		return
	end

	local cfgCustomData = {
		TypeName = "历史指令",
		Name = "",
		Cmd = cmdTxt,
		Type = GmListModule.DEFAULT_CUSTOM_TYPE
	}
	local tab = GmListModule.GetCustomGmDatum()

	table.insert(tab, 1, cfgCustomData)
	table.remove(tab, 11)
	PlayerPrefsUtil.SetLuaTable("GM", Constant.PlayerPrefsConst.gmCustom, tab)
end

function GmListModule.GetCustomGmDatum()
	local tab = PlayerPrefsUtil.GetLuaTable("GM", Constant.PlayerPrefsConst.gmCustom)

	if tab == nil then
		tab = {}
	end

	local temp = {}

	for i, v in pairs(tab) do
		table.insert(temp, i)
	end

	table.sort(temp, function(a, b)
		return a < b
	end)

	local ret = {}

	for i, v in ipairs(temp) do
		ret[#ret + 1] = tab[v]
	end

	return ret
end

function GmListModule.SendCmd(cmdTxt, type)
	GmListModule.lastCmdType = type
	GmListModule.lastSendCmdTxt = cmdTxt

	if PlayerModule.InMaze then
		if LoginModule.ServerTestMode then
			MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_CHAT, {
				Content = cmdTxt
			})
		end

		GmListModule.OnSendCmdResult()

		return
	end

	local CChatPOD = {}

	CChatPOD.type = 1
	CChatPOD.target = ""
	CChatPOD.content = cmdTxt
	CChatPOD.channel = ChatModule.CHANNEL_WORLD

	ChatModule.SendMsg(CChatPOD, nil, true)
end

function GmListModule.OnSendCmdResult()
	if GmListModule.enableGmModule then
		local tab = GmListModule.GetCustomGmDatum()

		for i, v in pairs(tab) do
			if v.Cmd == GmListModule.lastSendCmdTxt then
				return
			end
		end

		GmListModule.AddCustomCmdData(GmListModule.lastSendCmdTxt)
		EventDispatcher.Dispatch(EventID.CmdSendSuccess, GmListModule.lastCmdType)
	end
end

function GmListModule.SetGmEntryVisible(vs)
	GmListModule.btnGm.onClick:RemoveListener(GmListModule.OnClickGm)
	GmListModule.btnGm.gameObject:SetActive(vs)

	if vs then
		GmListModule.btnGm.onClick:AddListener(GmListModule.OnClickGm)
	end
end

function GmListModule.SetDebuggerVisible(vs)
	if vs ~= nil then
		GmListModule.debugger.ActiveWindow = vs
	end
end

function GmListModule.SetInspectorCanvasVisible(vs)
	if vs ~= nil then
		GmListModule.inspectorCanvas:SetActive(vs)
	end
end

function GmListModule.SetErrorLogEnable(enable)
	if enable == nil then
		return
	end

	if enable then
		LuaCodeInterface.SetLogLevel(UnityEngine.LogType.Error)
	else
		LuaCodeInterface.SetLogLevel(UnityEngine.LogType.Log)
	end
end

function GmListModule.SetSimulateNotchEnable(value)
	if value ~= nil then
		UnityEngine.GameObject.Find("PhoneFrame").transform:GetChild(0).gameObject:SetActive(value)
	end
end

function GmListModule.OnClickGm()
	if GmListModule.isDraggingGmBtn then
		return
	end

	if UIModule.HasUI(Constant.UIControllerName.GmListUI) or UIModule.IsLoadingUI(Constant.UIControllerName.GmListUI) then
		UIModule.Close(Constant.UIControllerName.GmListUI)
	else
		UIModule.Open(Constant.UIControllerName.GmListUI, Constant.UILayer.UI)
	end
end

function GmListModule.OnGmBtnBeginDrag(eventData)
	GmListModule.isDraggingGmBtn = true
end

function GmListModule.OnGmBtnEndDrag(eventData)
	GmListModule.isDraggingGmBtn = false
end

function GmListModule.SaveDebugConfig(config)
	GmListModule.config = config

	PlayerPrefsUtil.SetLuaTable("GM", Constant.PlayerPrefsConst.gmDebug, config)
	PlayerPrefsUtil.Save()
end

function GmListModule.GetDebugConfig()
	return PlayerPrefsUtil.GetLuaTable("GM", Constant.PlayerPrefsConst.gmDebug)
end

function GmListModule.GetBool(key)
	if GmListModule.config[key] == nil then
		return false
	end

	return GmListModule.config[key]
end

function GmListModule.EnableOpenAnim()
	return GmListModule.config[GmListModule.Key_OpenAnim]
end

function GmListModule.EnableGuide()
	return GmListModule.config[GmListModule.Key_Guide]
end

function GmListModule.EnableGM()
	return GmListModule.config[GmListModule.Key_GM]
end

function GmListModule.EnableSkipBattle()
	return GmListModule.config[GmListModule.Key_SkipBattle]
end

function GmListModule.EnableDebug()
	return GmListModule.config[GmListModule.Key_Debugger]
end

function GmListModule.EnableMazeCloudSaveData()
	return GmListModule.config[GmListModule.KEY_MAZE_CLOUD_SAVE_DATA]
end

function GmListModule.EnableInspectorCanvas()
	return GmListModule.config[GmListModule.Key_InspectorCanvas]
end

function GmListModule.EnableErrorLog()
	return GmListModule.config[GmListModule.Key_ErrorLog]
end

function GmListModule.EnableSimulateNotch()
	return GmListModule.config[GmListModule.Key_Simulate_Notch]
end

function GmListModule.EnableTestPack()
	return GmListModule.config[GmListModule.Key_Change_To_Test_Pack]
end

function GmListModule.IsSpeTestFunctionEnabled()
	return GmListModule.config[GmListModule.Key_Change_To_Spe_Test_Pack]
end

function GmListModule.ShowPlayerGUI()
	local GUITransform = UnityEngine.GameObject.Find("/Game Framework/Customs/Overlay").transform:Find("GUID")

	if GUITransform then
		GUITransform.gameObject:SetActive(true)
	end

	local GUIDText = UnityEngine.GameObject.Find("/Game Framework/Customs/Overlay").transform:Find("GUID/Text")

	if GUIDText then
		GUIDText.gameObject:GetComponent("Text").text = string.format("UID:%s", PlayerModule.PlayerInfo.baseInfo.guid)
	end
end
