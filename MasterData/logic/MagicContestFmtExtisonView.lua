-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/view/MagicContestFmtExtisonView.lua

module("logic.extensions.magiccontest.view.MagicContestFmtExtisonView", package.seeall)

local MagicContestFmtExtisonView = class("MagicContestFmtExtisonView", ViewComponent)

function MagicContestFmtExtisonView:buildUI()
	MagicContestFmtExtisonView.super.buildUI(self)

	local buffScrCell = self:getGo("buffCol/scrCell")
	local buffScrView = self:getGo("buffCol/scrView")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function MagicContestFmtExtisonView:bindEvents()
	MagicContestFmtExtisonView.super.bindEvents(self)
end

function MagicContestFmtExtisonView:unbindEvents()
	MagicContestFmtExtisonView.super.unbindEvents(self)
end

function MagicContestFmtExtisonView:onEnter()
	MagicContestFmtExtisonView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()
	self._batType = self._customFmtMo:getBatType()
	self._subMo = MagicContestController.instance:getSubMo(self._activityId)
	self._myCampId = self._subMo:getCampId()

	self.addGEvent(self, GlobalNotify.HandlePM_MagicContestSelectBuffRes, self._onUpdate, self)
	self:_onUpdate()

	if self._subMo:isContinueWinStreak(self._batType) then
		UIStateManager.instance:push(ViewName.MagicContestBuffView, self._activityId, self._batType)
	end
end

function MagicContestFmtExtisonView:onExit()
	MagicContestFmtExtisonView.super.onExit(self)
	self:_onClearBuffCol()
end

function MagicContestFmtExtisonView:_onUpdate()
	self:_onUpdateBuffColUI()
end

function MagicContestFmtExtisonView:_onUpdateBuffColUI()
	local cfg = MagicSchoolConfig.instance:getBuffCfgsByCampId(self._activityId, self._myCampId)

	self._buffScrollerList:reloadData(cfg)
end

function MagicContestFmtExtisonView:_onClearBuffCol()
	self._buffScrollerList:dispose()
end

function MagicContestFmtExtisonView:_updateBuffCell(view, cell, data, tag)
	local buffId = data.buffId
	local isSelect = self._subMo:isBuffSelected(self._batType, buffId)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "buff/icon")
	local grayMask = goutil.findChild(mainGo, "buff/grayMask")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.name

	GameUtil.SetActive(grayMask, not isSelect)

	local iconUrl = string.format("ui/icon/%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconUrl)
	GameUtil.addClickHandler(mainGo, function()
		if not self._subMo:isContinueWinStreak(self._batType) then
			FloatWordMgr.instance:show("上一场未获胜，无法选择buff")

			return
		end

		UIStateManager.instance:push(ViewName.MagicContestBuffView, self._activityId, self._batType)
	end)
end

function MagicContestFmtExtisonView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "buff/icon")

	GameUtil.SetGray(icon, false)
	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(mainGo)
end

return MagicContestFmtExtisonView
