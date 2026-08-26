-- chunkname: @projbooter/ui/BootLoadingView.lua

module("projbooter.ui.BootLoadingView", package.seeall)

local BootLoadingView = class("BootLoadingView")

BootLoadingView.AutoChangeBgTime = 10
BootLoadingView.ClickChangeBgTime = 3
BootLoadingView.SwitchAnimTime = 0.667

function BootLoadingView:init()
	self._go = BootResMgr.instance:getLoadingViewGo()
	self._rootTr = self._go.transform
	self._ani = self._go:GetComponent(typeof(UnityEngine.Animator))
	self._progressBar = SLFramework.UGUI.SliderWrap.GetWithPath(self._go, "progressBar")

	self:setPercent(0)

	local txtType = typeof(UnityEngine.UI.Text)

	self._txtPercent = self._rootTr:Find("bottom_text/#txt_percent"):GetComponent(txtType)
	self._txtWarn = self._rootTr:Find("bottom_text/#txt_actualnum"):GetComponent(txtType)
	self._bottomText = self._rootTr:Find("bottom_text")
	self._goDescribe = self._rootTr:Find("describe_text")
	self._aniTxt = self._goDescribe:GetComponent(typeof(UnityEngine.Animator))
	self._txtDescribe1 = self._rootTr:Find("describe_text/#txt_describe1"):GetComponent(txtType)
	self._txtTitle1 = self._rootTr:Find("describe_text/#txt_describe1/title/#txt_title"):GetComponent(txtType)
	self._txtTitleEn1 = self._rootTr:Find("describe_text/#txt_describe1/title/#txt_title_en"):GetComponent(txtType)
	self._txtDescribe2 = self._rootTr:Find("describe_text/#txt_describe2"):GetComponent(txtType)
	self._txtTitle2 = self._rootTr:Find("describe_text/#txt_describe2/title/#txt_title"):GetComponent(txtType)
	self._txtTitleEn2 = self._rootTr:Find("describe_text/#txt_describe2/title/#txt_title_en"):GetComponent(txtType)
	self._txtFix = self._rootTr:Find("#btn_fix/txt_fix"):GetComponent(txtType)
	self._btnFix = SLFramework.UGUI.ButtonWrap.GetWithPath(self._go, "#btn_fix")
	self._goBg = UnityEngine.GameObject.Find("UIRoot/OriginBg")
	self._btnClickBg = SLFramework.UGUI.UIClickListener.Get(self._goBg)
	self._clickBgEnable = false

	self:_setLoadingItem()
	self._btnFix:AddClickListener(self._onClickFix, self)
	self._btnClickBg:AddClickListener(self._onClickBg, self)
	self._btnFix.gameObject:SetActive(false)

	self._updateHandle = UpdateBeat:CreateListener(self._onFrameUpdate, self)

	UpdateBeat:AddListener(self._updateHandle)

	self.hasClickFix = nil
end

function BootLoadingView:_onClickBg()
	if not self._clickBgEnable then
		return
	end

	self:_setLoadingItem()
end

function BootLoadingView:_onClickFix()
	if BootMsgBox.instance:isShow() and BootMsgBox.instance.args and BootMsgBox.instance.args.leftCbObj == self then
		return
	end

	local args = {}

	args.title = booterLang("fixed_content")
	args.content = booterLang("fixed_content_tips") or ""
	args.leftMsg = booterLang("cancel")
	args.leftMsgEn = "CANCEL"

	if BootMsgBox.instance:isShow() then
		local preMsgBoxArgs = BootMsgBox.instance.args

		if preMsgBoxArgs then
			self._preMsgBoxArgs = {}

			for key, value in pairs(preMsgBoxArgs) do
				self._preMsgBoxArgs[key] = value
			end

			args.leftCb = self._cancelFixReturnPrevMsgBox
		end
	else
		args.leftCb = nil
	end

	args.leftCbObj = self
	args.rightMsg = booterLang("sure")
	args.rightMsgEn = "CONFIRM"
	args.rightCb = self.reallyFix
	args.rightCbObj = self

	if string.nilorempty(args.content) then
		args.titleAnchorY = 10
	end

	BootMsgBox.instance:show(args)
end

function BootLoadingView:_cancelFixReturnPrevMsgBox()
	if self._preMsgBoxArgs then
		local args = self._preMsgBoxArgs

		self._preMsgBoxArgs = nil

		BootMsgBox.instance:show(args)
	end
end

function BootLoadingView:reallyFix()
	self.hasClickFix = true

	self._btnFix.gameObject:SetActive(false)
	HotUpdateMgr.instance:stop()
	HotUpdateVoiceMgr.instance:stop()
	SLFramework.GameLuaEventDispatcher.Instance:ClearAllEvent()
	require("tolua.reflection")
	tolua.loadassembly("SL_AS")

	local type = tolua.findtype("SLFramework.GameUpdate.MassHotUpdate")
	local baseType = type.BaseType
	local instance = tolua.getproperty(baseType, "Instance")
	local method = tolua.gettypemethod(type, "_Stop", 36)

	method:Call(instance:Get(nil, nil))

	if BootNativeUtil.isIOS() then
		SDKMgr.instance:stopAllDownload()
	end

	UnityEngine.PlayerPrefs.DeleteAll()
	SLFramework.GameUpdate.HotUpdateInfoMgr.RemoveLocalVersionFile()
	SLFramework.GameUpdate.OptionalUpdate.Instance:RemoveLocalVersionFile()
	UpdateBeat:Add(self._onFrame, self)

	self._startTime = Time.time
	self._hotupdateEvent = SLFramework.GameUpdate.HotUpdateEvent.Instance
	self._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate.Instance

	self:_logThreadState()
end

local ThreadStateDescDict = {
	[0] = "Running",
	"StopRequested",
	"SuspendRequested",
	nil,
	"Background",
	nil,
	nil,
	nil,
	"Unstarted",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"Stopped",
	[32] = "WaitSleepJoin",
	[128] = "AbortRequested",
	[64] = "Suspended",
	[256] = "Aborted"
}
local ThreadStopped = {
	[8] = true,
	[64] = true,
	[16] = true,
	[256] = true
}

function BootLoadingView:_hasStop(state)
	if state == -1 then
		return true
	end

	for mask, _ in pairs(ThreadStopped) do
		if bit.band(state, mask) ~= 0 then
			return true
		end
	end
end

function BootLoadingView:_getThreadStateDesc(state)
	if state == -1 then
		return "null"
	end

	if state == 0 then
		return ThreadStateDescDict[state]
	end

	local stateDescTb = {}

	for mask, desc in pairs(ThreadStateDescDict) do
		if bit.band(state, mask) ~= 0 then
			table.insert(stateDescTb, desc)
		end
	end

	return table.concat(stateDescTb, "|")
end

function BootLoadingView:_onFrame()
	local cost = Time.time - self._startTime

	if self._startTime and cost > 60 then
		logNormal("修复程序等待线程退出超时了")
		UpdateBeat:Remove(self._onFrame, self)
		self:_deleteCache()

		return
	end

	local state1 = self._hotupdateEvent.DownloadThreadState
	local state2 = self._hotupdateEvent.UnzipThreadState
	local state3 = self._optionalUpdate.DownloadThreadState
	local state4 = self._optionalUpdate.UnzipThreadState

	if self:_hasStop(state1) and self:_hasStop(state2) and self:_hasStop(state3) and self:_hasStop(state4) then
		logNormal(string.format("修复程序等待线程退出完成，耗时%.2fs", cost))
		UpdateBeat:Remove(self._onFrame, self)

		local timer = Timer.New(function()
			self:_deleteCache()
		end, 0.5)

		timer:Start()
	end

	self:_logThreadState()
end

function BootLoadingView:_logThreadState()
	local state1 = self._hotupdateEvent.DownloadThreadState
	local state2 = self._hotupdateEvent.UnzipThreadState
	local state3 = self._optionalUpdate.DownloadThreadState
	local state4 = self._optionalUpdate.UnzipThreadState
	local desc1 = self:_getThreadStateDesc(state1)
	local desc2 = self:_getThreadStateDesc(state2)
	local desc3 = self:_getThreadStateDesc(state3)
	local desc4 = self:_getThreadStateDesc(state4)

	logNormal(string.format("修复程序线程状态 热更下载%d_%s 热更解压%d_%s 语音下载%d_%s 语音解压%d_%s", state1, desc1, state2, desc2, state3, desc3, state4, desc4))
end

function BootLoadingView:_deleteCache()
	self:_deleteAllCache()

	local args = {}

	args.title = booterLang("fixed_res_finish")
	args.content = ""
	args.leftMsg = nil
	args.leftCb = nil
	args.leftCbObj = self
	args.rightMsg = booterLang("sure")
	args.rightMsgEn = "CONFIRM"
	args.rightCb = self.quitGame
	args.rightCbObj = self
	args.titleAnchorY = 10

	BootMsgBox.instance:show(args)
end

function BootLoadingView:quitGame()
	self:_deleteAllCache()
	ProjBooter.instance:quitGame()
end

function BootLoadingView:_deleteAllCache()
	SLFramework.GameUpdate.HotUpdateInfoMgr.RemoveLocalVersionFile()
	SLFramework.GameUpdate.OptionalUpdate.Instance:RemoveLocalVersionFile()
	SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResTempDir1)
	SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResTempDir2)
	ZProj.GameHelper.DeleteAllCache()
end

function BootLoadingView:_setLoadingItem()
	if not self._goOriginBg then
		self._goOriginBg = BootResMgr.instance:getOriginBgGo()

		self._goOriginBg:SetActive(true)

		self._bgAnim = self._goOriginBg:GetComponent(typeof(UnityEngine.Animator))
		self._imageBg1 = self._goOriginBg.transform:Find("originbg1"):GetComponent(typeof(UnityEngine.UI.Image))
		self._imageBg2 = self._goOriginBg.transform:Find("originbg2"):GetComponent(typeof(UnityEngine.UI.Image))
	end

	self._txtFix.text = booterLang("fixed")
	self._clickBgEnable = false

	if self._setIndex then
		self._setIndex = self._setIndex + 1 or 1
	end

	self._initTime = Time.time

	BootResMgr.instance:getLoadingBg(self._setIndex, self._setSwitch, self)
end

function BootLoadingView:_setSwitch(texture, bgCo)
	if self._imageBg2.sprite then
		self._txtDescribe1.gameObject:SetActive(true)
		self._imageBg1.gameObject:SetActive(true)

		self._imageBg1.sprite = self._imageBg2.sprite
		self._txtDescribe1.text = self._txtDescribe2.text
		self._txtTitle1.text = self._txtTitle2.text
		self._txtTitleEn1.text = self._txtTitleEn2.text
		self._hasSetDec1ForAnim = true
	else
		self:_hideDesc1()
	end

	self._imageBg2.sprite = UnityEngine.Sprite.Create(texture, UnityEngine.Rect.New(0, 0, texture.width, texture.height), Vector2.zero)

	self._aniTxt:Play("switch", 0, 0)
	self._bgAnim:Play("switch", 0, 0)

	self._txtDescribe2.text = bgCo.desc
	self._txtTitle2.text = bgCo.title
	self._txtTitleEn2.text = bgCo.titleen
	self._initTime = Time.time
end

function BootLoadingView:_onFrameUpdate()
	if not self._initTime then
		return
	end

	local now = Time.time

	if self._hasSetDec1ForAnim and now - self._initTime > BootLoadingView.SwitchAnimTime then
		self._hasSetDec1ForAnim = nil

		self:_hideDesc1()
	end

	if now - self._initTime > BootLoadingView.ClickChangeBgTime then
		self:_onEnableClickBg()
	end

	if now - self._initTime > BootLoadingView.AutoChangeBgTime then
		self:_onAutoChangeBg()
	end
end

function BootLoadingView:_hideDesc1()
	self._txtDescribe1.text = ""
	self._txtTitle1.text = ""
	self._txtTitleEn1.text = ""

	self._txtDescribe1.gameObject:SetActive(false)
	self._imageBg1.gameObject:SetActive(false)
end

function BootLoadingView:_onEnableClickBg()
	self._clickBgEnable = self._clickBgEnable or true
end

function BootLoadingView:_onAutoChangeBg()
	self._initTime = Time.time

	self:_setLoadingItem()
end

function BootLoadingView:addEventListeners()
	return
end

function BootLoadingView:show(percent, progressMsg, warnningMsg)
	self:setPercent(percent)
	self:setProgressMsg(progressMsg)
	self:setWarnningMsg(warnningMsg)
	self._go:SetActive(true)
end

function BootLoadingView:showMsg(progressMsg, warnningMsg)
	self:setProgressMsg(progressMsg)
	self:setWarnningMsg(warnningMsg)
	self._go:SetActive(true)
end

function BootLoadingView:showFixBtn()
	self._btnFix.gameObject:SetActive(true)
end

function BootLoadingView:setPercent(percent)
	self._progressBar:SetValue(percent)
end

function BootLoadingView:setProgressMsg(progressMsg)
	self._txtPercent.text = progressMsg and progressMsg or ""
end

function BootLoadingView:setWarnningMsg(warnningMsg)
	self._txtWarn.text = warnningMsg and warnningMsg or ""
end

function BootLoadingView:hide()
	self._go:SetActive(false)
end

function BootLoadingView:playClose()
	if self._ani then
		self._ani:Play("close")
	end
end

function BootLoadingView:dispose()
	self._btnFix:RemoveClickListener()
	self._btnClickBg:RemoveClickListener()

	for key, value in pairs(self) do
		if type(value) == "userdata" then
			rawset(self, key, nil)
		end
	end

	if self._updateHandle then
		UpdateBeat:RemoveListener(self._updateHandle)

		self._updateHandle = nil
	end
end

BootLoadingView.instance = BootLoadingView.New()

return BootLoadingView
