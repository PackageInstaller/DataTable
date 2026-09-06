-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleShipDescView.lua

module("logic.extensions.freescuffle.view.FreeScuffleShipDescView", package.seeall)

local FreeScuffleShipDescView = class("FreeScuffleShipDescView", ViewComponent)

function FreeScuffleShipDescView:buildUI()
	FreeScuffleShipDescView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local shipScrView = self:getGo("shipCol/scrView")
	local shipScrCell = self:getGo("shipCol/scrCell")

	self._shipScrollerList = ScrollerList.create(shipScrView, shipScrCell, GameUtil.handler(self._updateShipCell, self), GameUtil.handler(self._clearShipCell, self))
end

function FreeScuffleShipDescView:bindEvents()
	FreeScuffleShipDescView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FreeScuffleShipDescView:unbindEvents()
	FreeScuffleShipDescView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FreeScuffleShipDescView:onEnter()
	FreeScuffleShipDescView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleScheduleRes, self._onUpdate, self)
	self:_onUpdate()
end

function FreeScuffleShipDescView:onExit()
	FreeScuffleShipDescView.super.onExit(self)
	self:_onClearShipCol()
end

function FreeScuffleShipDescView:_onUpdate()
	self:_onUpdateShipColUI()
end

function FreeScuffleShipDescView:_onUpdateShipColUI()
	local list = {}
	local cfg = FreeScuffleConfig.instance:getShipCfg(self._activityId) or {}

	GameUtil.SetActive(self._shipCol, #list > 0)
	self._shipScrollerList:reloadData(cfg)
end

function FreeScuffleShipDescView:_onClearShipCol()
	self._shipScrollerList:dispose()
end

function FreeScuffleShipDescView:_updateShipCell(view, cell, data, tag)
	local isActive = self._subMo:isActiveShip(data.relationshipId)

	if not data.petIds then
		local mainGo = cell.gameObject
		local petView = goutil.findChild(mainGo, "petView/Viewport/content")
		local petCell = goutil.findChild(mainGo, "petCell")
		local txtName = goutil.findChildTextComponent(mainGo, "txtName")
		local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

		txtName.text = data.name
		txtDesc.text = data.desc

		GameUtil.updateCellsList(petView, petCell, data.petIds, function(go, raceId, i)
			local isStart = i == 1
			local petData = FreeScuffleConfig.instance:getPetData(self._activityId, raceId)
			local isWorking = self._subMo:isWorkingPet(raceId)
			local con = goutil.findChild(go, "mask/con")
			local tag = goutil.findChild(go, "tag")
			local tagActive = goutil.findChild(go, "tagActive")

			GameUtil.setUIImageSpriteIdx(go, petData.quality - 1)

			local headPath = GameUrl.getCharacterIconUrl(string.format("icon_%s", petData.lihui))

			uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, headPath)
			GameUtil.SetActive(tag, not isStart)
			GameUtil.SetActive(tagActive, isWorking)
		end)
	end
end

function FreeScuffleShipDescView:_clearShipCell(cell)
	local mainGo = cell.gameObject
	local petView = goutil.findChild(mainGo, "petView/Viewport/content")

	GameUtil.clearCells(petView, function(go, i)
		local con = goutil.findChild(go, "mask/con")

		uGuiUtil.clearImage(con)
	end, nil, false)
end

return FreeScuffleShipDescView
