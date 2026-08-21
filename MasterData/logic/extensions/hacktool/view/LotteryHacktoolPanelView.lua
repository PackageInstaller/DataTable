-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/LotteryHacktoolPanelView.lua

module("logic.extensions.hacktool.view.LotteryHacktoolPanelView", package.seeall)

local M = class("LotteryHacktoolPanelView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._lotteryGo1 = goutil.findChild(self._mainGo, "summoncardPanel1")
	self._lotteryGo2 = goutil.findChild(self._mainGo, "summoncardPanel2")
	self._summoncardPanel1Go = goutil.findChild(self._mainGo, "summoncardPanel1")
	self._summoncardPanel1View = Astral.LuaComponentContainer.Add(self._summoncardPanel1Go, LotteryHacktoolDView)
	self._btnClose2 = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "summoncardPanel2/btnClose"))
	self._btnCleanUp = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "summoncardPanel2/btnCleanUp"))
	self._btnOne = goutil.findChildComponent(self._mainGo, "summoncardPanel2/toggleGroup/btnOne", UIComponentType.SpaceXToggle)
	self._btnTwo = goutil.findChildComponent(self._mainGo, "summoncardPanel2/toggleGroup/btnTwo", UIComponentType.SpaceXToggle)
	self._btnThree = goutil.findChildComponent(self._mainGo, "summoncardPanel2/toggleGroup/btnThree", UIComponentType.SpaceXToggle)
	self._panelOneGo = goutil.findChild(self._mainGo, "summoncardPanel2/panel/one_panel")
	self._panelTwoGo = goutil.findChild(self._mainGo, "summoncardPanel2/panel/two_panel")
	self._panelThreeGo = goutil.findChild(self._mainGo, "summoncardPanel2/panel/three_panel")
	self._panelOneView = Astral.LuaComponentContainer.Add(self._panelOneGo, LotteryHacktoolAView)
	self._panelTwoView = Astral.LuaComponentContainer.Add(self._panelTwoGo, LotteryHacktoolBView)
	self._panelThreeView = Astral.LuaComponentContainer.Add(self._panelThreeGo, LotteryHacktoolCView)
end

function M:bindEvents()
	self._btnClose2:AddClickListener(self._onClickClose2, self)
	self._btnCleanUp:AddClickListener(self._onClickClearUp, self)
	self._btnOne:AddListener(self._onClickPanelOne, self)
	self._btnTwo:AddListener(self._onClickPanelTwo, self)
	self._btnThree:AddListener(self._onClickPanelThree, self)
end

function M:unbindEvents()
	self._btnClose2:RemoveClickListener()
	self._btnCleanUp:RemoveClickListener()
	self._btnOne:RemoveListener()
	self._btnTwo:RemoveListener()
	self._btnThree:RemoveListener()
end

function M:onEnter()
	self:bindEvents()
	self:_onClickPanelOne()

	self._btnOne.IsOn = true
end

function M:onExit()
	self:unbindEvents()
	self._summoncardPanel1View:onExit()
	self._panelOneView:onExit()
	self._panelTwoView:onExit()
	self._panelThreeView:onExit()
end

function M:openPanel1()
	goutil.setActive(self._lotteryGo1, true)
	goutil.setActive(self._lotteryGo2, false)
	self._summoncardPanel1View:onEnter()
end

function M:openPanel2()
	goutil.setActive(self._lotteryGo1, false)
	goutil.setActive(self._lotteryGo2, true)
	self._summoncardPanel1View:onExit()
end

function M:_onClickPanelOne()
	goutil.setActive(self._panelOneGo, true)
	goutil.setActive(self._panelTwoGo, false)
	goutil.setActive(self._panelThreeGo, false)
	self._panelOneView:onEnter()
	self._panelTwoView:onExit()
	self._panelThreeView:onExit()
end

function M:_onClickPanelTwo()
	goutil.setActive(self._panelOneGo, false)
	goutil.setActive(self._panelTwoGo, true)
	goutil.setActive(self._panelThreeGo, false)
	self._panelOneView:onExit()
	self._panelTwoView:onEnter()
	self._panelThreeView:onExit()
end

function M:_onClickPanelThree()
	goutil.setActive(self._panelOneGo, false)
	goutil.setActive(self._panelTwoGo, false)
	goutil.setActive(self._panelThreeGo, true)
	self._panelOneView:onExit()
	self._panelTwoView:onExit()
	self._panelThreeView:onEnter()
end

function M:_onClickClose2()
	goutil.setActive(self._lotteryGo1, false)
	goutil.setActive(self._lotteryGo2, false)
end

function M:_onClickClearUp()
	local data = HackToolUtil.cleanlotteryLog()

	HackToolAgent.instance:sendGmRequest(data)
	self._panelOneView:clearResultList()
	self._panelTwoView:clearResultList()
	self._panelThreeView:clearResultList()
end

return M
