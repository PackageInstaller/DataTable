-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionView.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionView", package.seeall)

local ChuangkongunionView = class("ChuangkongunionView", ViewComponent)

function ChuangkongunionView:ctor()
	ChuangkongunionView.super.ctor(self)
end

function ChuangkongunionView:bindEvents()
	ChuangkongunionView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnShop, self._onShop, self)

	for i = 1, 3 do
		GameUtil.addClickHandler(self._btnTab[i], GameUtil.handler(self._onClickTab, self, i))
	end
end

function ChuangkongunionView:unbindEvents()
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShop)

	for i = 1, 3 do
		GameUtil.rmClickHandler(self._btnTab[i])
	end

	ChuangkongunionView.super.unbindEvents(self)
end

function ChuangkongunionView:buildUI()
	ChuangkongunionView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._container = self:getGo("container")
	self._btnShop = self:getGo("btnShop")
	self._selectFlag = {}
	self._btnTab = {}
	self._redPoint = {}
	self._txtName = {}
	self._txtCoin = {}

	for i = 1, 3 do
		self._btnTab[i] = self:getBtn("btnTab" .. i)
		self._selectFlag[i] = self:getGo("btnTab" .. i .. "/selected")
		self._redPoint[i] = self:getGo("btnTab" .. i .. "/imgPoint")
		self._txtName[i] = self:getTxt("btnTab" .. i .. "/txtName")
		self._txtCoin[i] = self:getTxt("btnTab" .. i .. "/txtTop")
	end
end

function ChuangkongunionView:onEnter()
	ChuangkongunionView.super.onEnter(self)
	self:_initTabCfg()
	self:_initTabIndex()
	self:_initTab()
	self:_onClickTab(self._curSelectTab)
end

function ChuangkongunionView:onEnterFinished()
	ChuangkongunionView.super.onEnterFinished(this)
end

function ChuangkongunionView:onExit()
	self._curTabCfgs = nil

	for i = 1, 3 do
		RedPointController.instance:unregRedPoint(self._redPoint[i])
	end

	ChuangkongunionView.super.onExit(this)
end

function ChuangkongunionView:_initTabCfg()
	self._curTabCfgs = ChuangkongunionConfig.instance:getTabCfg()
end

function ChuangkongunionView:_initTabIndex()
	self._curSelectTab = self:_getDefaultOpenTab()

	local firstParam = self:getFirstParam()

	if firstParam ~= nil then
		if type(firstParam) == "number" and self._curTabCfgs[firstParam] ~= nil then
			self._curSelectTab = checknumber(firstParam)
		end

		if type(firstParam) == "string" and not string.nilorempty(firstParam) and not string.nilorempty(firstParam) then
			for i, cfg in ipairs(self._curTabCfgs) do
				if cfg and cfg.viewname == firstParam then
					self._curSelectTab = i
				end
			end
		end
	end
end

function ChuangkongunionView:_initTab()
	for i = 1, 3 do
		data = self._curTabCfgs[i]
		self._txtName[i].text = data.title

		RedPointController.instance:regRedPoint(self._redPoint[i], unpack(string.splitToNumber(data.redpointId or "", "#")))

		self._txtCoin[i].text = data.coin
	end
end

function ChuangkongunionView:_getDefaultOpenTab()
	local lastTabOpen = ChuangkongunionController.instance:getLastTabOpen()

	if lastTabOpen > 0 then
		return lastTabOpen
	end

	return 1
end

function ChuangkongunionView:_updateUI()
	for i = 1, 3 do
		goutil.setActive(self._selectFlag[i], i == self._curSelectTab)
	end
end

function ChuangkongunionView:_onClickTab(i)
	self._curSelectTab = i

	local data = self._curTabCfgs[i]

	ChuangkongunionController.instance:markShowTab(i)
	SurveyController.instance:reportBehavior(data.reportBehavior)
	self:showTabAt(self._container, data.viewname, data.parameter)
	self:_updateUI()
end

function ChuangkongunionView:_onShop()
	ChuangkongunionController.instance:openShop()
end

return ChuangkongunionView
