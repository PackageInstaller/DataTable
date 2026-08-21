-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/view/SurveyHtmlView.lua

module("logic.extensions.survey.view.SurveyHtmlView", package.seeall)

local M = class("SurveyHtmlView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("btnBack")
	self._btnRefresh = self:getBtnByPath("btnRefresh")
	self._contentPanel = self:getGoByPath("content")
	self._tipsGo = self:getGoByPath("charactersystem_top_item")
	self._canvasGroup = self._tipsGo:GetComponent(ComponentType.CanvasGroup)
	self._txtTips = goutil.findChildComponent(self.mainGO, "charactersystem_top_item/Text1", UIComponentType.TextMeshProUGUI)

	goutil.setActive(self._btnRefresh.gameObject, false)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnRefresh:AddClickListener(self._onClickRefresh, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.GET_SURVEY_LIST_EVENT, self._handleGetSurveyList, self)
	self:_handleGetSurveyList(nil, nil, true)
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.GET_SURVEY_LIST_EVENT, self._handleGetSurveyList, self)
	goutil.setActive(self._tipsGo, false)
end

function M:_handleGetSurveyList(e, surveydata, isOnEnter)
	if not isOnEnter and (surveydata == nil or surveydata and #surveydata == 0) then
		self._txtTips.text = lang("tip_survey_done_desc")
		self._canvasGroup.alpha = 0

		goutil.setActive(self._tipsGo, true)
		self._canvasGroup:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
		settimer(1, function()
			goutil.setActive(self._tipsGo, false)
		end, self, false)

		return
	end

	if not self._webViewRect then
		local rect = Astral.GeometryUtil.GetNativePixelRect(self._contentPanel.transform, CameraTargetMgr.instance:getUICameraTarget():getCamera())

		self._webViewRect = {
			x = math.floor(rect.x),
			y = math.floor(rect.y),
			width = math.floor(rect.width),
			height = math.floor(rect.height)
		}
	end

	local x = self._webViewRect.x
	local y = self._webViewRect.y
	local width = self._webViewRect.width
	local height = self._webViewRect.height
	local url = SurveyHtmlUtil.getSurveyData()
	local percent = SceneResolution.Instance.percent
	local isShowWeb = UnityWebBridge.isExistFunc()

	if isShowWeb then
		if percent > 0 then
			width = width / percent
			height = height / percent
		end

		UnityWebBridge.closeWebView()
		UnityWebBridge.openWebView(url, true, x, y, width, height, true)
	else
		SDKManager.getSDKInstacne():showWebBrowser(url, false)
		self:_onClickClose()
		printWarn("当前平台无法打开网址", url)
	end
end

function M:_encodeURL(s)
	s = string.gsub(s, "([^%w%.%- ])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)

	return string.gsub(s, " ", "+")
end

function M:_onClickRefresh()
	SurveyHtmlUtil.requestSurveyData()
end

function M:_onClickClose()
	UnityWebBridge.closeWebView()
	self:close()
	GlobalDispatcher:removeEventListener(EventType.GET_SURVEY_LIST_EVENT, self._handleGetSurveyList, self)
	SurveyHtmlUtil.requestSurveyData()
end

return M
