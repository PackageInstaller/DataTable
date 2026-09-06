-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderStarView.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderStarView", package.seeall)

local HolyWaterOrderStarView = class("HolyWaterOrderStarView", ViewComponent)

function HolyWaterOrderStarView:ctor()
	HolyWaterOrderStarView.super.ctor(self)
end

function HolyWaterOrderStarView:buildUI()
	HolyWaterOrderStarView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtPass = self:getTxt("info/txtPass")
	self._txtStar = self:getTxt("info/txtStar")
	self._txtHistoryMax = self:getTxt("info/txtHistoryMax")
	self.tableviewGo = self:getGo("tableview")
	self.tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.tableviewGo, self.tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function HolyWaterOrderStarView:bindEvents()
	HolyWaterOrderStarView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function HolyWaterOrderStarView:unbindEvents()
	HolyWaterOrderStarView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function HolyWaterOrderStarView:onEnter()
	HolyWaterOrderStarView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._cfgStages = HolyWaterOrderConfig.instance:getStageCfgList(self._activityId)
	self._maxStageNum = #self._cfgStages
	self._passStageNum = HolyWaterOrderModel.instance:getPassStageNum()
	self._curStageNum = Mathf.Clamp(self._passStageNum + 1, 1, self._maxStageNum)

	self:_updatePassTextInfo()
	self:_updatePassStageList()
end

function HolyWaterOrderStarView:onExit()
	HolyWaterOrderStarView.super.onExit(self)
	self._scrollList:dispose()
end

function HolyWaterOrderStarView:_updateCell(view, cell, data, tag)
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local bg = goutil.findChild(cell, "bg")
	local img = goutil.findChild(cell, "img")
	local starList = {}

	for i = 1, 5 do
		starList[i] = goutil.findChild(cell, "star" .. i .. "/img")
	end

	goutil.setActive(bg, data.stageId % 2 == 0)
	goutil.setActive(img, data.stageId == self._curStageNum)

	local stageNum = data.stageId
	local starNum = HolyWaterOrderModel.instance:getStarNum(data.stageId)

	txtLevel.text = string.format("第 %d 关", stageNum)

	for i, v in ipairs(starList) do
		goutil.setActive(v, i <= starNum)
	end
end

function HolyWaterOrderStarView:_clearCell(cell)
	return
end

function HolyWaterOrderStarView:_updatePassTextInfo()
	local passNum = HolyWaterOrderModel.instance:getPassStageNum()
	local totalStarNum = HolyWaterOrderModel.instance:getTotalStarNum()
	local historyMaxStars = HolyWaterOrderModel.instance:getHistoryMaxStars()

	historyMaxStars = totalStarNum <= historyMaxStars and historyMaxStars or totalStarNum

	local maxStarNum = self._maxStageNum * 5

	self._txtPass.text = string.format("当前已通关：<color=#08AB29>%d</color>/%d", passNum, self._maxStageNum)
	self._txtStar.text = string.format("累计获得：<color=#08AB29>%d</color>/%d", totalStarNum, maxStarNum)
	self._txtHistoryMax.text = string.format("历史最高：<color=#08AB29>%d</color>/%d", historyMaxStars, maxStarNum)
end

function HolyWaterOrderStarView:_updatePassStageList()
	self._scrollList:reloadData(self._cfgStages)
end

return HolyWaterOrderStarView
