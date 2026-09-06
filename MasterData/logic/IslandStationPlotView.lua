-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationPlotView.lua

module("logic.extensions.islandstation.view.IslandStationPlotView", package.seeall)

local IslandStationPlotView = class("IslandStationPlotView", ViewComponent)

function IslandStationPlotView:ctor()
	IslandStationPlotView.super.ctor(self)
end

function IslandStationPlotView:unbindEvents()
	IslandStationPlotView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function IslandStationPlotView:bindEvents()
	IslandStationPlotView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function IslandStationPlotView:buildUI()
	IslandStationPlotView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function IslandStationPlotView:onExit()
	IslandStationPlotView.super.onExit(self)
	self._scrollList:dispose()

	for k, scroll in pairs(self._plotScrollDic) do
		scroll:dispose()
	end
end

function IslandStationPlotView:onEnter()
	IslandStationPlotView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._storyGroupCfg = IslandStationConfig.instance:getStoryGroupCfg(self._activityId)
	self._plotScrollDic = {}

	self._scrollList:reloadData(self._storyGroupCfg)
end

function IslandStationPlotView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtName2 = goutil.findChildTextComponent(cell, "txtName2")
	local tableview = goutil.findChild(cell, "tableview")
	local tablecell = goutil.findChild(cell, "tableview/tablecell")
	local scroller = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updatePlotCell, self), GameUtil.handler(self._clearPlotCell, self))
	local groupCfg = IslandStationConfig.instance:getStoryCfgByGroupId(self._activityId, data.groupId)

	scroller:reloadData(groupCfg)
	scroller:dragNotifyParent()

	self._plotScrollDic[cell] = scroller
	txtName.text = data.groupName
	txtName2.text = data.groupName
end

function IslandStationPlotView:_clearCell(cell)
	if self._plotScrollDic[cell] then
		self._plotScrollDic[cell]:dispose()
	end
end

function IslandStationPlotView:_updatePlotCell(view, cell, data)
	local btnPlay = goutil.findChild(cell, "btnPlay")
	local imgLock = goutil.findChild(cell, "imgLock")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local girlId = checknumber(data.girlId)
	local fetter = 0

	if girlId <= 0 then
		fetter = IslandStationController.instance:getTotalFetter(self._activityId)
	else
		local girlId = IslandStationConfig.instance:getGirlIdByGroupId(self._activityId, data.groupId)

		fetter = IslandStationModel.instance:getGirlFetter(self._activityId, girlId)
	end

	txtName.text = data.storyName

	GameUtil.addClickHandler(btnPlay, function()
		if fetter >= data.unLockFetter then
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, data.storyId, StoryModel.StoryType.SCCopy)
		else
			FloatWordMgr.instance:show("暂未解锁此剧情，继续推进活动进程可解锁哦~")
		end
	end, self)
	GameUtil.SetActive(imgLock, fetter < data.unLockFetter)
end

function IslandStationPlotView:_clearPlotCell(cell)
	local btnPlay = goutil.findChild(cell, "btnPlay")

	GameUtil.rmClickHandler(btnPlay)
end

return IslandStationPlotView
