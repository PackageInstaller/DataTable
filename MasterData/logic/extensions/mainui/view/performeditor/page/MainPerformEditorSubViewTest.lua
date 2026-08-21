-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/page/MainPerformEditorSubViewTest.lua

module("logic.extensions.mainui.view.performeditor.page.MainPerformEditorSubViewTest", package.seeall)

local M = class("MainPerformEditorSubViewTest")

M._testBtnData = {
	{
		btnName = "黑底详情"
	},
	{
		btnName = "外挂关闭黑底"
	},
	{
		btnName = "配音切换"
	},
	{
		btnName = "播放配音"
	},
	{
		btnName = "看板娘切换特效"
	},
	{
		btnName = "主界面流记录"
	},
	{
		btnName = "界面堆栈打印"
	},
	{
		btnName = "功能开启弹框"
	},
	{
		btnName = "角色突破"
	}
}
M.lanuageMap = {
	"zh",
	"en"
}
M.lanuageIndex = 1

function M:ctor(mainGo)
	self.mainGO = mainGo
end

function M:init(viewRegistry)
	self._viewRegistry = viewRegistry

	self:buildUI()
	self:bindEvents()

	self._isInit = true
end

function M:Awake()
	return
end

function M:OnEnable()
	return
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._viewRegistry
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._inputParam = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "ViewPort/Content/gadget/inputParam").gameObject)
	self._goPanelScrollTest = registry:findUIElement("main_perform_editor_view_1741590135")

	local rectBtnTestGroup = registry:findUIElement("main_perform_editor_view_1010441564", UIComponentType.RectTransform)
	local goBtnTestTemplate = rectBtnTestGroup:GetChild(0).gameObject

	self._testBtnGroup = {}

	for index, value in ipairs(self._testBtnData) do
		local _btnGo = goutil.cloneAndSetParent(goBtnTestTemplate, rectBtnTestGroup, string.format("btn_%s", index))
		local _txtName = goutil.findChildTextComponent(_btnGo, "Text")

		_txtName.text = value.btnName
		self._testBtnGroup[index] = UIComponentType.ButtonAdapter(_btnGo)

		goutil.setActive(_btnGo, true)
	end

	goutil.setActive(goBtnTestTemplate, false)
end

function M:destroyUI()
	self:setHandler(nil)

	self.mainGO = nil
	self._viewRegistry = nil
	self._testBtnGroup = nil
end

function M:bindEvents()
	for index, _btn in pairs(self._testBtnGroup or {}) do
		_btn:AddClickListener(function()
			self:onClickTestBtn(index)
		end, self)
	end
end

function M:unbindEvents()
	for index, _btn in pairs(self._testBtnGroup or {}) do
		_btn:RemoveClickListener()
	end
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:getActiveSubPageDirty()
	return false
end

function M:onClickTestBtn(index)
	local strParam = self._inputParam:GetText()

	printWarn(string.format("onClickTest:%s, strParam:%s", index, strParam))

	if index == 1 then
		FloatWordMgr.instance:show(ViewBlackFadeController.instance:printStatus())
	elseif index == 2 then
		ViewBlackFadeController.instance:hideGadget(0.4, 0, "外挂关闭黑底")
	elseif index == 3 then
		local curLan = self.lanuageMap[self.lanuageIndex]

		print("当前配音:", curLan)
		CriwareUtil.SetLocalize(curLan)

		if self.lanuageIndex < #self.lanuageMap then
			self.lanuageIndex = self.lanuageIndex + 1
		else
			self.lanuageIndex = 1
		end
	elseif index == 4 then
		CriwareAudioFacade.instance:playVoiceById(CriwareAudioEnum.speech_100011_dazhaohu)
	elseif index == 5 then
		local viewPageMo = HeroDepotModel.instance:getViewPageMo()
		local heroId = viewPageMo and viewPageMo.hero:getId() or -1

		if heroId > 0 then
			GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_CHANGE_EFF, heroId)
		end
	elseif index == 6 then
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_VIEW_STATUS_PRINT)
	elseif index == 7 then
		MainScenePerformUtil.printViewBackStack("界面堆栈打印")
	elseif index == 8 then
		if not string.nilorempty(strParam) then
			local code = tonumber(strParam)

			if code and code > 0 then
				SystemOpenModel.instance:addSystemOpenHint(code)
				ToolTipsMgr.showOpenFunctionsHintTips(code, true)
			end
		end
	elseif index == 9 then
		if string.nilorempty(strParam) then
			return
		end

		local curLv = tonumber(strParam)
		local viewPageMo = HeroDepotModel.instance:getViewPageMo()
		local heroId = viewPageMo and viewPageMo.hero:getId() or -1
		local skinId

		if heroId > 0 then
			ToolTipsMgr.showCharacterHeartAnchorBreakResultTips(heroId, skinId, curLv)
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_EDITOR_HIDE, true)
end

return M
