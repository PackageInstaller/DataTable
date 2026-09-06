-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyabuffView.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyabuffView", package.seeall)

local MiraclenuoyabuffView = class("MiraclenuoyabuffView", ViewComponent)

function MiraclenuoyabuffView:ctor()
	MiraclenuoyabuffView.super.ctor(self)

	self._banRaceIds = {}
end

function MiraclenuoyabuffView:buildUI()
	MiraclenuoyabuffView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")

	local buffScrView = goutil.findChild(self.mainGO, "buffCol/scrView")
	local buffScrCell = goutil.findChild(self.mainGO, "buffCol/scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function MiraclenuoyabuffView:bindEvents()
	MiraclenuoyabuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MiraclenuoyabuffView:unbindEvents()
	MiraclenuoyabuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MiraclenuoyabuffView:onEnter()
	MiraclenuoyabuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.MiracleNuoYaInfoUpdate, self._onUpdate, self)
	MiracleNuoyaController.instance:sendGetInfo(self._activityId)
end

function MiraclenuoyabuffView:onExit()
	MiraclenuoyabuffView.super.onExit(self)
	self:_onClear()
end

function MiraclenuoyabuffView:_onUpdate()
	local info = MiracleNuoyaModel.instance:getInfo(self._activityId) or {}

	if not info.extremeClgInfo then
		local extremeClgInfo = {}

		self._extremeClgSupportPetLeftHpPercent = checknumber(extremeClgInfo.extremeClgSupportPetLeftHpPercent)
		self._fitBuffId = 0
		self._curIndex = 1

		local maxPercent = 0
		local cfg = MiracleNuoyaConfig.instance:getBuffListCfg(self._activityId)

		for index, data in pairs(cfg) do
			local leftHpPercent = data.leftHpPercent

			if leftHpPercent <= self._extremeClgSupportPetLeftHpPercent and maxPercent <= leftHpPercent then
				maxPercent = leftHpPercent
				self._fitBuffId = data.buffId
				self._curIndex = index
			end
		end

		self:_onUpdateBuffColUI()
	end
end

function MiraclenuoyabuffView:_onClear()
	self:_onClearBuffCol()
end

function MiraclenuoyabuffView:_onUpdateBuffColUI()
	local cfg = MiracleNuoyaConfig.instance:getBuffListCfg(self._activityId)

	self._buffScrollerList:reloadData(cfg)
	self._buffScrollerList:MoveCellToCenter(self._curIndex - 1)
end

function MiraclenuoyabuffView:_onClearBuffCol()
	self._buffScrollerList:dispose()
end

function MiraclenuoyabuffView:_updateBuffCell(view, cell, data, tag)
	local isFit = self._fitBuffId == data.buffId
	local mainGo = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local imgPass = goutil.findChild(mainGo, "imgPass")

	txtTitle.text = data.title
	txtDesc.text = data.buffDesc

	GameUtil.SetActive(imgPass, isFit)
end

function MiraclenuoyabuffView:_clearBuffCell(cell)
	return
end

return MiraclenuoyabuffView
