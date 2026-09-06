-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnExtremeBuffView.lua

module("logic.extensions.originan.view.OriginAnExtremeBuffView", package.seeall)

local OriginAnExtremeBuffView = class("OriginAnExtremeBuffView", ViewComponent)

function OriginAnExtremeBuffView:buildUI()
	OriginAnExtremeBuffView.super.buildUI(self)

	local descScrView = self:getGo("descScrView")
	local descScrCell = self:getGo("descScrCell")

	self._descScrollerList = ScrollerList.create(descScrView, descScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._btnSure = self:getGo("btnSure")
	self._customInput = UICustomInput.Get(self.mainGO)
end

function OriginAnExtremeBuffView:bindEvents()
	OriginAnExtremeBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function OriginAnExtremeBuffView:unbindEvents()
	OriginAnExtremeBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginAnExtremeBuffView:onEnter()
	OriginAnExtremeBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = OriginAnController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_OriginAnInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginAnResetExtremeRes, self._onUpdate, self)
	self:_onUpdate()
end

function OriginAnExtremeBuffView:onExit()
	OriginAnExtremeBuffView.super.onExit(self)
	self._descScrollerList:dispose()
end

function OriginAnExtremeBuffView:_onUpdate()
	local totalTimes = self._subMo:getExtremeTotalBlockHealTimes()
	local data = OriginAnConfig.instance:getExtremeBuffDataByTimes(self._activityId, totalTimes)

	if data then
		self._activeBlockHealTimes = data.blockHealTimes or 0
	end

	local datas = OriginAnConfig.instance:getExtremeBuffDatas(self._activityId) or {}

	self._descScrollerList:reloadData(datas)
end

function OriginAnExtremeBuffView:_updateBuffCell(view, cell, data, tag)
	local isActive = data.blockHealTimes == self._activeBlockHealTimes
	local index = cell.data
	local mainGo = cell.gameObject
	local bg = goutil.findChild(mainGo, "bg")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local tagActive = goutil.findChild(mainGo, "tagActive")

	txtScore.text = data.blockHealTimes
	txtDesc.text = data.buffDesc

	GameUtil.SetActive(tagActive, isActive)
	GameUtil.SetActive(bg, index % 2 == 1)
end

function OriginAnExtremeBuffView:_clearBuffCell(cell)
	return
end

return OriginAnExtremeBuffView
