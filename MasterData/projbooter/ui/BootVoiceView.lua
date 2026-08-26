-- chunkname: @projbooter/ui/BootVoiceView.lua

module("projbooter.ui.BootVoiceView", package.seeall)

local BootVoiceView = class("BootVoiceView")
local StateKey = "BootVoiceViewState"
local CacheKey = "BootVoiceDownloadChoice"
local Downloading, DownloadDone = "1", "2"
local TextComp = typeof(UnityEngine.UI.Text)
local AnimatorComp = typeof(UnityEngine.Animator)
local FindChildComponent = SLFramework.GameObjectHelper.FindChildComponent
local setActive = SLFramework.GameObjectHelper.SetActive

function BootVoiceView:getDownloadChoices()
	self._choiceStr = self._choiceStr or UnityEngine.PlayerPrefs.GetString(CacheKey, "")

	if not string.nilorempty(self._choiceStr) then
		return string.split(self._choiceStr, "#")
	end

	return {}
end

function BootVoiceView:setDownloadChoices(choicesTb)
	self._choiceStr = table.concat(choicesTb, "#")
end

function BootVoiceView:saveDownloadChoices()
	UnityEngine.PlayerPrefs.SetString(CacheKey, self._choiceStr)
	UnityEngine.PlayerPrefs.Save()
end

function BootVoiceView:isNeverOpen()
	return UnityEngine.PlayerPrefs.GetString(StateKey, "0") == "0"
end

function BootVoiceView:isDownloading()
	return UnityEngine.PlayerPrefs.GetString(StateKey, "0") == Downloading
end

function BootVoiceView:isFirstDownloadDone()
	return UnityEngine.PlayerPrefs.GetString(StateKey, "0") == DownloadDone
end

function BootVoiceView:setDownloading()
	if not self:isDownloading() then
		UnityEngine.PlayerPrefs.SetString(StateKey, Downloading)
		UnityEngine.PlayerPrefs.Save()
	end
end

function BootVoiceView:setFirstDownloadDone()
	if not self:isFirstDownloadDone() then
		UnityEngine.PlayerPrefs.SetString(StateKey, DownloadDone)
		UnityEngine.PlayerPrefs.Save()
	end
end

function BootVoiceView:showChoose(callback, callbackObj)
	self._hasGetHotupdateInfo = false
	self._chooseCallback = callback
	self._chooseCallbackObj = callbackObj
	self._go = BootResMgr.instance:getVoiceViewGo()

	self._go.transform:SetAsLastSibling()
	self._go:SetActive(true)

	self._rootTr = self._go.transform

	self:_initView()
	self:_setState(true)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_UI_manager)
end

function BootVoiceView:showDownloadSize(hotupdateSize, callback, callbackObj)
	self._hasGetHotupdateInfo = true
	self._hotupdateSize = hotupdateSize
	self._downloadSizeCallback = callback
	self._downloadSizeCallbackObj = callbackObj
	self._go = BootResMgr.instance:getVoiceViewGo()

	self._go.transform:SetAsLastSibling()
	self._go:SetActive(true)

	self._rootTr = self._go.transform

	self:_initView()

	if self._firstClickNextTime then
		UpdateBeat:Add(self._onFrame, self)
	else
		self:_setState(false)
		self:_initDownloadSize()
		self:_playAnim("go_seconcheck")
	end
end

function BootVoiceView:isShow()
	return self._go and self._go.activeInHierarchy
end

function BootVoiceView:hide()
	if self._go then
		self._go:SetActive(false)
	end
end

function BootVoiceView:_onFrame()
	local now = Time.time

	if now - self._firstClickNextTime < 0.5 then
		return
	end

	if not self._playDownloadSizeTime then
		self._playDownloadSizeTime = Time.time

		self:_playAnim("go_getinformation")
	elseif now - self._playDownloadSizeTime > 0.1667 then
		self:_setState(false)
		self:_initDownloadSize()
		UpdateBeat:Remove(self._onFrame, self)
	end
end

function BootVoiceView:_initView()
	setActive(self._go, true)

	local btnBack = self._rootTr:Find("view/btn/#btn_back").gameObject
	local btnNext = self._rootTr:Find("view/btn/#btn_next").gameObject
	local btnDownload = self._rootTr:Find("view/btn/#btn_downloadall").gameObject
	local btnLock = self._rootTr:Find("view/btn/#btn_lock").gameObject

	self._btnBack = SLFramework.UGUI.ButtonWrap.Get(btnBack)
	self._btnNext = SLFramework.UGUI.ButtonWrap.Get(btnNext)
	self._btnDownload = SLFramework.UGUI.ButtonWrap.Get(btnDownload)
	self._btnLock = SLFramework.UGUI.ButtonWrap.Get(btnLock)

	self._btnBack:AddClickListener(self._onClickBack, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnDownload:AddClickListener(self._onClickDownload, self)

	self._firstChooseGO = self._rootTr:Find("view/#go_firstchoose").gameObject
	self._secondCheckGO = self._rootTr:Find("view/#go_secondcheck").gameObject
	self._firstSelectGO = self._rootTr:Find("view/bg/#go_Title/first/icon1").gameObject
	self._firstUnselectGO = self._rootTr:Find("view/bg/#go_Title/first/icon2").gameObject
	self._secondSelectGO = self._rootTr:Find("view/bg/#go_Title/second/light").gameObject
	self._secondUnselectGO = self._rootTr:Find("view/bg/#go_Title/second/dark").gameObject
	self._lineDarkGO = self._rootTr:Find("view/bg/#go_Title/line_dark").gameObject
	self._lineLightGO = self._rootTr:Find("view/bg/#go_Title/line_light").gameObject
	self._animator = self._go:GetComponent(AnimatorComp)

	local txtFirst = FindChildComponent(self._go, "view/bg/#go_Title/first", TextComp)
	local txtSecondLight = FindChildComponent(self._go, "view/bg/#go_Title/second/light", TextComp)
	local txtSecondDark = FindChildComponent(self._go, "view/bg/#go_Title/second/dark", TextComp)
	local txtDefaultDownloadLangTips = FindChildComponent(self._go, "view/#go_firstchoose/#txt_desc", TextComp)

	txtFirst.text = booterLang("select_lang")
	txtSecondLight.text = booterLang("check_update")
	txtSecondDark.text = booterLang("check_update")

	local defaultLang = GameConfig:GetDefaultLangShortcut()

	txtDefaultDownloadLangTips.text = booterLang("default_download_lang_tips_" .. defaultLang)

	local txtNext = FindChildComponent(self._go, "view/btn/#btn_next/Text", TextComp)
	local txtBack = FindChildComponent(self._go, "view/btn/#btn_back/Text", TextComp)
	local txtDownload1 = FindChildComponent(self._go, "view/btn/#btn_downloadall/Text", TextComp)
	local txtDownload2 = FindChildComponent(self._go, "view/btn/#btn_lock/Text", TextComp)

	txtNext.text = booterLang("next_step")
	txtBack.text = booterLang("back_step")
	txtDownload1.text = booterLang("download")
	txtDownload2.text = booterLang("download")

	self:_initChoose()
end

function BootVoiceView:_initChoose()
	self._selectGOList = {}
	self._selectClickList = {}

	local contentTr = self._rootTr:Find("view/#go_firstchoose/#scroll_content/viewport/content")
	local itemTr = contentTr:Find("item")

	self._supportLangList = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

	table.insert(self._supportLangList, "res-HD")

	local defaultLang = GameConfig:GetDefaultVoiceShortcut()

	for i = 1, #self._supportLangList do
		local lang = self._supportLangList[i]
		local item = i == 1 and itemTr or SLFramework.GameObjectHelper.FindChild(contentTr.gameObject, "item" .. i)

		item = item or SLFramework.GameObjectHelper.CloneInPlace(itemTr.gameObject, "item" .. i)

		local itemGO = item.gameObject
		local selectGO = SLFramework.GameObjectHelper.FindChild(itemGO, "#go_select")
		local selectIconGO = SLFramework.GameObjectHelper.FindChild(selectGO, "icon")

		table.insert(self._selectGOList, selectGO)

		local tipsGO = SLFramework.GameObjectHelper.FindChild(itemGO, "#go_tips")

		if HotUpdateVoiceMgr.ForceSelect[lang] or lang == defaultLang then
			setActive(selectGO, true)
			setActive(tipsGO, true)
			setActive(selectIconGO, false)

			FindChildComponent(tipsGO, "dec", TextComp).text = booterLang("default_download")
		else
			local choices = self:getDownloadChoices()
			local hasChoose = tabletool.indexOf(choices, lang) ~= nil

			setActive(selectGO, hasChoose)
			setActive(tipsGO, false)
			setActive(selectIconGO, true)

			local click = SLFramework.UGUI.UIClickListener.Get(itemGO)

			click:AddClickListener(self._onClickItem, self, i)
			table.insert(self._selectClickList, click)
		end

		local txtTitle = FindChildComponent(itemGO, "#txt_title", TextComp)
		local txtDesc = FindChildComponent(itemGO, "#txt_dec", TextComp)
		local size = HotUpdateVoiceMgr.instance:getLangSize(lang)

		if HotUpdateVoiceMgr.IsGuoFu and size == 0 and lang == HotUpdateVoiceMgr.LangEn then
			size = HotUpdateVoiceMgr.instance:getLangSize(HotUpdateVoiceMgr.LangZh)
		end

		txtTitle.text = size > 0 and booterLang(lang .. "_voice") .. string.format(" (%s)", self:_fixSizeStr(size)) or booterLang(lang .. "_voice")
		txtDesc.text = booterLang(lang .. "_voice_desc")
	end
end

function BootVoiceView:_initDownloadSize()
	local voiceSize = HotUpdateVoiceMgr.instance:getNeedDownloadSize()
	local totalSize = voiceSize + (self._hotupdateSize or 0)
	local txtTips = FindChildComponent(self._go, "view/#go_secondcheck/#txt_tips", TextComp)
	local txtWifi = FindChildComponent(self._go, "view/#go_secondcheck/#txt_desc", TextComp)
	local txtDownload = FindChildComponent(self._go, "view/btn/#btn_downloadall/Text", TextComp)

	if totalSize > 0 then
		local sizeStr = string.format("<color=#bb541d>%s</color>", self:_fixSizeStr(totalSize))

		sizeStr = string.format(booterLang("hotupdate_info"), sizeStr)
		txtTips.text = sizeStr
		txtWifi.text = booterLang("recommend_wifi")
		txtDownload.text = booterLang("download")

		setActive(txtWifi.gameObject, true)
	else
		txtTips.text = booterLang("zero_hotupdate_size")
		txtDownload.text = booterLang("sure")

		setActive(txtWifi.gameObject, false)
	end
end

function BootVoiceView:_initGetInfoTips()
	self:updateTips()

	local txtWifi = FindChildComponent(self._go, "view/#go_secondcheck/#txt_desc", TextComp)

	setActive(txtWifi.gameObject, false)
end

function BootVoiceView:updateTips()
	if self._go then
		local txtTips = FindChildComponent(self._go, "view/#go_secondcheck/#txt_tips", TextComp)

		if HotUpdateMgr.instance:getFailAlertCount() > 0 then
			local failCountStr = string.format("(%d)", HotUpdateMgr.instance:getFailAlertCount())

			txtTips.text = booterLang("hotupdate_getinfo") .. failCountStr
		else
			txtTips.text = booterLang("hotupdate_getinfo")
		end
	end
end

function BootVoiceView:_setState(isChooseState)
	setActive(self._firstChooseGO, isChooseState)
	setActive(self._secondCheckGO, not isChooseState)
	setActive(self._firstSelectGO, isChooseState)
	setActive(self._firstUnselectGO, not isChooseState)
	setActive(self._secondSelectGO, not isChooseState)
	setActive(self._secondUnselectGO, isChooseState)
	setActive(self._lineDarkGO, isChooseState)
	setActive(self._lineLightGO, not isChooseState)

	local isDownloading = self:isDownloading()

	setActive(self._btnBack.gameObject, not isChooseState and not isDownloading and self._hasGetHotupdateInfo)
	setActive(self._btnNext.gameObject, isChooseState)
	setActive(self._btnDownload.gameObject, not isChooseState and self._hasGetHotupdateInfo)
	setActive(self._btnLock.gameObject, not isChooseState and not self._hasGetHotupdateInfo)
end

function BootVoiceView:_playAnim(stateName)
	if self._animator then
		self._animator:Play(stateName, 0, 0)
	end
end

function BootVoiceView:_onClickItem(i)
	local selectGO = self._selectGOList[i]

	if selectGO then
		setActive(selectGO, not selectGO.activeSelf)
	end
end

function BootVoiceView:_onClickBack()
	UpdateBeat:Remove(self._onFrame, self)
	self:_initChoose()
	self:_setState(true)
	self:_playAnim("go_firstchoose")
end

function BootVoiceView:_onClickNext()
	local selectLangs = {}

	for i = 1, #self._supportLangList do
		local selectGO = self._selectGOList[i]

		if selectGO and selectGO.activeSelf then
			table.insert(selectLangs, self._supportLangList[i])
		end
	end

	self:setDownloadChoices(selectLangs)
	self:_playAnim("go_seconcheck")

	self._firstClickNextTime = self._firstClickNextTime or Time.time

	if self._chooseCallback then
		self:_setState(false)
		self:_initGetInfoTips()
	else
		self:_initDownloadSize()
		self:_setState(false)
	end
end

function BootVoiceView:_onClickDownload()
	local data = {}

	data.entrance = "first_open"
	data.update_amount = self:_fixSizeMB(HotUpdateVoiceMgr.instance:getNeedDownloadSize())
	data.download_voice_pack_list = self:getDownloadChoices()
	data.current_voice_pack_list = {
		GameConfig:GetCurVoiceShortcut()
	}

	SDKDataTrackMgr.instance:trackVoicePackDownloadConfirm(data)
	UpdateBeat:Remove(self._onFrame, self)
	self:setDownloading()
	self:saveDownloadChoices()
	self._go:SetActive(false)
end

function BootVoiceView:dispose()
	UpdateBeat:Remove(self._onFrame, self)

	if self._go then
		self._btnBack:RemoveClickListener()
		self._btnNext:RemoveClickListener()
		self._btnDownload:RemoveClickListener()
		UnityEngine.GameObject.Destroy(self._go)

		self._go = nil
	end

	if self._selectClickList then
		for i = #self._selectClickList, 1, -1 do
			local click = self._selectClickList[i]

			click:RemoveClickListener()

			self._selectClickList[i] = nil
		end

		self._selectClickList = nil
	end

	for key, value in pairs(self) do
		if type(value) == "userdata" then
			rawset(self, key, nil)
		end
	end
end

function BootVoiceView:_fixSizeStr(size)
	local ret = size / HotUpdateMgr.MB_SIZE
	local units = "MB"

	if ret < 1 then
		ret = size / HotUpdateMgr.KB_SIZE
		units = "KB"

		if size / HotUpdateMgr.KB_SIZE < 0.01 then
			ret = 0.01
		end
	end

	ret = ret - ret % 0.01

	return string.format("%.2f %s", ret, units)
end

function BootVoiceView:_fixSizeMB(size)
	local ret = size / HotUpdateMgr.MB_SIZE

	return ret - ret % 0.01
end

BootVoiceView.instance = BootVoiceView.New()

return BootVoiceView
