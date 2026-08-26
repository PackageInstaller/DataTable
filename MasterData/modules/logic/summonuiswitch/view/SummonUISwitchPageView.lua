-- chunkname: @modules/logic/summonuiswitch/view/SummonUISwitchPageView.lua

module("modules.logic.summonuiswitch.view.SummonUISwitchPageView", package.seeall)

local SummonUISwitchPageView = class("SummonUISwitchPageView", BaseView)

function SummonUISwitchPageView:onInitView()
	self._gobg1 = gohelper.findChild(self.viewGO, "#go_bg1")
	self._gobg2 = gohelper.findChild(self.viewGO, "#go_bg2")
	self._simageFullBG1 = gohelper.findChildSingleImage(self._gobg1, "img")
	self._simageFullBG2 = gohelper.findChildSingleImage(self._gobg2, "img")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonUISwitchPageView:addEvents()
	return
end

function SummonUISwitchPageView:removeEvents()
	return
end

function SummonUISwitchPageView:_editableInitView()
	self._switchTime = CommonConfig.instance:getConstNum(ConstEnum.SceneSwitchPageTime)

	self.addEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.SwitchSceneUI, self._onShowSceneInfo, self)
end

function SummonUISwitchPageView:_onShowSceneInfo(id)
	local showCurScene = id == SummonUISwitchModel.instance:getCurUseUI()

	if showCurScene then
		self:_clearPage()

		return
	end

	self:_initPage(id)
end

function SummonUISwitchPageView:_clearPage()
	self._simageFullBG1:UnLoadImage()
	self._simageFullBG2:UnLoadImage()
	gohelper.setActive(self._simageFullBG1, false)
	gohelper.setActive(self._simageFullBG2, false)
	TaskDispatcher.cancelTask(self._switchPage, self)
	TaskDispatcher.cancelTask(self._switchPageFinish, self)
end

function SummonUISwitchPageView:_initPage(id)
	gohelper.setActive(self._simageFullBG1, true)
	gohelper.setActive(self._simageFullBG2, true)

	if not self._page1 then
		self._page1 = {
			img = self._simageFullBG1,
			pageGo = self._gobg1,
			animator = self._gobg1:GetComponent("Animator")
		}
		self._page2 = {
			img = self._simageFullBG2,
			pageGo = self._gobg2,
			animator = self._gobg2:GetComponent("Animator")
		}
	end

	local sceneConfig = lua_scene_switch.configDict[id]

	self._previews = sceneConfig.previews
	self._pageIndex = 1

	self:_updatePage()
	TaskDispatcher.cancelTask(self._switchPageFinish, self)
	TaskDispatcher.cancelTask(self._switchPage, self)
	TaskDispatcher.runDelay(self._switchPage, self, self._switchTime)
end

function SummonUISwitchPageView:_switchPage()
	TaskDispatcher.runDelay(self._switchPageFinish, self, SummonUISwitchEnum.PageSwitchTime)
	self._page1.animator:Play("close", 0, 0)
	self._page2.animator:Play("open", 0, 0)

	if not self._switchClose then
		local viewNameList = ViewMgr.instance:getOpenViewNameList()
		local topView = viewNameList[#viewNameList]

		if topView ~= ViewName.MainSwitchView then
			return
		end

		AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_glitter)
	end
end

function SummonUISwitchPageView:_switchPageFinish()
	self._page1, self._page2 = self._page2, self._page1
	self._pageIndex = self._pageIndex + 1

	if self._pageIndex > #self._previews then
		self._pageIndex = 1
	end

	self:_updatePage()
	TaskDispatcher.runDelay(self._switchPage, self, self._switchTime)
end

function SummonUISwitchPageView:_updatePage()
	self:_updateOnePage(self._page1.img, self._pageIndex, 0)
	self:_updateOnePage(self._page2.img, self._pageIndex + 1, 0)
	self._page1.animator:Play("open", 0, 0)
	gohelper.setAsFirstSibling(self._page2.pageGo)
	self._page2.animator:Play("open", 0, 0)
end

function SummonUISwitchPageView:_updateOnePage(img, index, x)
	if index > #self._previews then
		index = 1
	end

	local url = ResUrl.getMainSceneSwitchIcon(string.format("mainsceneswitch_randombg%02d", self._previews[index]))

	img:LoadImage(url)
	recthelper.setAnchorX(img.transform.parent, x)
end

function SummonUISwitchPageView:onTabSwitchOpen()
	self._switchClose = false
end

function SummonUISwitchPageView:onTabSwitchClose()
	self._switchClose = true
end

function SummonUISwitchPageView:onDestroyView()
	self:_clearPage()
end

return SummonUISwitchPageView
