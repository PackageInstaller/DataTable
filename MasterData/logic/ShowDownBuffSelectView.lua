-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownBuffSelectView.lua

module("logic.extensions.showdown.view.ShowDownBuffSelectView", package.seeall)

local ShowDownBuffSelectView = class("ShowDownBuffSelectView", ViewComponent)

function ShowDownBuffSelectView:ctor()
	ShowDownBuffSelectView.super.ctor(self)
end

function ShowDownBuffSelectView:buildUI()
	ShowDownBuffSelectView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")

	local buffScrView = goutil.findChild(self.mainGO, "buffScrView")
	local buffScrCell = goutil.findChild(self.mainGO, "buffScrCell")

	self._buffScrollList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function ShowDownBuffSelectView:bindEvents()
	ShowDownBuffSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function ShowDownBuffSelectView:unbindEvents()
	ShowDownBuffSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function ShowDownBuffSelectView:onEnter()
	ShowDownBuffSelectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()
	self._roundId = self._customFmtMo:getRoundId()
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._usingBuffId = self:_getCurBuffId()
	self._selectedBuffId = self._usingBuffId

	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self.close, self)
	self:_onUpdateBuffColUI()
end

function ShowDownBuffSelectView:onExit()
	ShowDownBuffSelectView.super.onExit(self)

	self._customFmtMo = nil

	self:_onClearBuffColUI()
end

function ShowDownBuffSelectView:_getCurBuffId()
	return self._customFmtMo:getCurBuffId()
end

function ShowDownBuffSelectView:_setCurBuffId(value)
	self._customFmtMo:setCurBuffId(value)
end

function ShowDownBuffSelectView:_onUpdateBuffColUI()
	local cfg = ShowDownConfig.instance:getBuffCfg(self._activityId, self._roundId)

	cfg = cfg or {}

	self._buffScrollList:reloadData(cfg)

	local index = 1
	local curBuffId = self._selectedBuffId

	if curBuffId > 0 then
		for idx, data in ipairs(cfg) do
			if data.buffId == curBuffId then
				index = idx

				break
			end
		end
	end

	self._buffScrollList:MoveCellInView(index - 1, true)
end

function ShowDownBuffSelectView:_onClearBuffColUI()
	self._buffScrollList:dispose()
end

function ShowDownBuffSelectView:_updateBuffCell(view, cell, data, tag)
	local buffId = data.buffId
	local isSelected = self._selectedBuffId == buffId
	local isUsing = self._usingBuffId == buffId
	local mainGo = cell.gameObject
	local btn = goutil.findChild(mainGo, "btn")
	local icon = goutil.findChild(mainGo, "btn/icon")
	local txtName = goutil.findChildTextComponent(mainGo, "btn/txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "btn/txtDesc")
	local imgSelected = goutil.findChild(mainGo, "btn/imgSelected")
	local imgUsing = goutil.findChild(mainGo, "btn/imgUsing")

	GameUtil.SetActive(imgSelected, isSelected)
	GameUtil.SetActive(imgUsing, isUsing)

	local path = ShowDownController.instance:getBuffIconPath(self._activityId, self._roundId, buffId)
	local bgGo = icon

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, path, func)
	else
		uGuiUtil.clearImage(bgGo)
	end

	txtName.text = data.name
	txtDesc.text = data.desc

	GameUtil.addClickHandler(btn, function()
		self._selectedBuffId = self._selectedBuffId == buffId and 0 or buffId

		self:_onUpdateBuffColUI()
	end, self)
end

function ShowDownBuffSelectView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local btn = goutil.findChild(mainGo, "btn")
	local icon = goutil.findChild(mainGo, "btn/icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(btn)
end

function ShowDownBuffSelectView:_onClickBtnSure()
	self:_setCurBuffId(self._selectedBuffId)
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.ShowDownFormationBuffUpdate)
end

return ShowDownBuffSelectView
