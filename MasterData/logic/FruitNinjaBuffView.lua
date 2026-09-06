-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/view/FruitNinjaBuffView.lua

module("logic.extensions.fruitninja.view.FruitNinjaBuffView", package.seeall)

local FruitNinjaBuffView = class("FruitNinjaBuffView", ViewComponent)

function FruitNinjaBuffView:buildUI()
	FruitNinjaBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local descScrView = goutil.findChild(self.mainGO, "descScrView")
	local descScrCell = goutil.findChild(self.mainGO, "descScrCell")

	self._descScrollerList = ScrollerList.create(descScrView, descScrCell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
	self._customInput = UICustomInput.Get(self.mainGO)
end

function FruitNinjaBuffView:bindEvents()
	FruitNinjaBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	self._customInput:AddListener(function(self, hover)
		if not hover then
			self:close()
		end
	end, self)
end

function FruitNinjaBuffView:unbindEvents()
	FruitNinjaBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	self._customInput:RemoveListener()
end

function FruitNinjaBuffView:onEnter()
	FruitNinjaBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = FruitNinjaController.instance:getActivityType()

	local isInTime = FruitNinjaController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._fruitNinjaMo = FruitNinjaController.instance:getFruitNinjaMo(self._activityId)
	self._maxScore = 0
	self._curCriId = 0

	self.addGEvent(self, GlobalNotify.HandlePM_FruitNinjaGetInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function FruitNinjaBuffView:onExit()
	FruitNinjaBuffView.super.onExit(self)
	self._descScrollerList:dispose()
end

function FruitNinjaBuffView:_onUpdate()
	self._maxScore = self._fruitNinjaMo:getHistoryMaxScore(FruitNinjaEnum.GameMode_Ext)

	local cfg = FruitNinjaConfig.instance:getCriticalCfg(self._activityId) or {}

	self._descScrollerList:reloadData(cfg)

	local data = FruitNinjaConfig.instance:getCriticalDataByScore(self._activityId, self._maxScore)

	if data then
		if not data.criId then
			local index = 1

			if data then
				self._curCriId = data.criId or 0
			end

			self._descScrollerList:MoveCellToCenter(index - 1)
		end
	end
end

function FruitNinjaBuffView:_updateDescCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local bg = goutil.findChild(mainGo, "bg")
	local activeTag = goutil.findChild(mainGo, "activeTag")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	GameUtil.SetActive(activeTag, self._curCriId == data.criId)

	txtName.text = data.score
	txtDesc.text = string.format("所有模式下，每次切水果暴击提升至<color=#eb4624>%s</color>%%", data.rate * 100)
end

function FruitNinjaBuffView:_clearDescCell(cell)
	return
end

return FruitNinjaBuffView
