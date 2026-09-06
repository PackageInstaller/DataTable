-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/view/PsychicImproveHudView.lua

module("logic.extensions.psychicimprove.view.PsychicImproveHudView", package.seeall)

local PsychicImproveHudView = class("PsychicImproveHudView", ViewComponent)

function PsychicImproveHudView:buildUI()
	PsychicImproveHudView.super.buildUI(self)

	self._btnClose = self:getGo("topleft/btnClose")
	self._container = self:getGo("container")
	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PsychicImproveHudView:bindEvents()
	PsychicImproveHudView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function PsychicImproveHudView:unbindEvents()
	PsychicImproveHudView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PsychicImproveHudView:onEnter()
	PsychicImproveHudView.super.onEnter(self)
	self:refreshViewByCfg()
end

function PsychicImproveHudView:onExit()
	PsychicImproveHudView.super.onExit(self)

	if self._curShowData then
		PsychicImproveModel.instance:setLastOpenId(self._curShowData.id)
	end

	self._curShowData = nil

	self._tableview:dispose()
end

function PsychicImproveHudView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtName.text = data.name

	goutil.setActive(cell.select, data == self._curShowData)

	if string.nilorempty(data.tag) then
		goutil.setActive(cell.tag, false)
	else
		goutil.setActive(cell.tag, true)

		cell.txtTag.text = data.tag
	end

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickTab, self, data.id))

	if not string.nilorempty(data.redpointId) then
		RedPointController.instance:regRedPoint(cell.redpoint, unpack(string.split(data.redpointId, "#")))
	end
end

function PsychicImproveHudView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.select = goutil.findChild(cell.go, "select")

	GameUtil.rmClickHandler(cell.go)

	cell.redpoint = goutil.findChild(cell.go, "redpoint")
	cell.tag = goutil.findChild(cell.go, "tag")
	cell.txtTag = goutil.findChildTextComponent(cell.tag, "Text")

	goutil.setActive(cell.redpoint, false)
	RedPointController.instance:unregRedPoint(cell.redpoint)

	return cell
end

function PsychicImproveHudView:_onClickTab(id)
	local tryOpenData

	for i, v in ipairs(self._tagDataList) do
		if v.id == checkint(id) then
			tryOpenData = v
		end
	end

	tryOpenData = tryOpenData or self._tagDataList[1]

	if tryOpenData ~= self._curShowData then
		self._curShowData = tryOpenData

		self:showTabAt(self._container)
		self:showTabAt(self._container, self._curShowData.viewname, self._curShowData)
		self._tableview:reloadData(self._tagDataList)
		SurveyController.instance:reportBehavior(self._curShowData.reportBehavior)
	end
end

function PsychicImproveHudView:_onClickClose()
	self._curShowData = nil

	PsychicImproveModel.instance:setLastOpenId(0)
	self:close()
end

function PsychicImproveHudView:refreshViewByCfg()
	self._hudCfgs = PsychicImproveConfig.instance:getHudCfgs()
	self._curShowData = nil

	local curShowId = checkint(self:getFirstParam())

	if curShowId <= 0 then
		curShowId = PsychicImproveModel.instance:getLastOpenId()
	end

	self._tagDataList = {}

	for k, v in ipairs(self._hudCfgs) do
		if v.id > 0 then
			table.insert(self._tagDataList, v)
		end
	end

	table.sort(self._tagDataList, function(a, b)
		return a.sort < b.sort
	end)
	self:_onClickTab(curShowId)
end

return PsychicImproveHudView
