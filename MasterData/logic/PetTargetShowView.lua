-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/PetTargetShowView.lua

module("logic.extensions.powerland.view.PetTargetShowView", package.seeall)

local PetTargetShowView = class("PetTargetShowView", ViewComponent)

function PetTargetShowView:ctor()
	PetTargetShowView.super.ctor(self)
end

function PetTargetShowView:buildUI()
	PetTargetShowView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._targetScrollerview = goutil.findChild(self.mainGO, "topCol/targetCol/targetScrollerview")
	self._targetScrollercell = goutil.findChild(self.mainGO, "topCol/targetCol/targetScrollercell")
	self._targetCol = goutil.findChild(self.mainGO, "topCol/targetCol")
	self._txtEmptyGo = goutil.findChild(self.mainGO, "topCol/txtEmpty")
	self._petScrollerview = goutil.findChild(self.mainGO, "petCol/petScrollerview")
	self._petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")
	self._petScrollList = ScrollerList.create(self._petScrollerview, self._petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._targetScrollList = ScrollerList.create(self._targetScrollerview, self._targetScrollercell, GameUtil.handler(self._updateTargetCell, self), GameUtil.handler(self._clearTargetCell, self))

	GameUtil.SetActive(self._petScrollercell, false)
	GameUtil.SetActive(self._targetScrollercell, false)
	GameUtil.SetActive(self._targetCol, false)
	GameUtil.SetActive(self._txtEmptyGo, true)
end

function PetTargetShowView:bindEvents()
	PetTargetShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PetTargetShowView:unbindEvents()
	PetTargetShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PetTargetShowView:destroyUI()
	PetTargetShowView.super.destroyUI(self)
end

function PetTargetShowView:onEnter()
	PetTargetShowView.super.onEnter(self)

	self._activityId = PowerLandModel.instance:getCurActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PowerLand, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内( activityId = %d )", self._activityId)
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandRefreshPetRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function PetTargetShowView:onExit()
	PetTargetShowView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandRefreshPetRes, self._onUpdate, self)
	self._targetScrollList:dispose()
	self._petScrollList:dispose()
end

function PetTargetShowView:_onSetUI()
	return
end

function PetTargetShowView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PetTargetShowView:_onUpdateData()
	self:_onUpdateTargetColData()
	self:_onUpdatePetColData()
end

function PetTargetShowView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTargetColUI()
	self:_onUpdatePetScrollerList()
end

function PetTargetShowView:_onUpdatePlaneUI()
	return
end

function PetTargetShowView:_onUpdateTargetColData()
	self._targetColDataList = {}

	local fmtTargetInfo = PowerLandModel.instance:getFmtTargetInfo()
	local moList = fmtTargetInfo:getTargetMoList()

	for _, mo in ipairs(moList) do
		if mo.count == 0 then
			break
		end

		local data = PowerLandConfig.instance:getRealPlTargetData(mo.targetId, mo.level)

		table.insert(self._targetColDataList, data)
	end
end

function PetTargetShowView:_onUpdateTargetColUI()
	local isColNil = #self._targetColDataList <= 0

	GameUtil.SetActive(self._targetCol, not isColNil)
	GameUtil.SetActive(self._txtEmptyGo, isColNil)
	self:_onUpdateTargetScrollerList()
end

function PetTargetShowView:_onUpdateTargetScrollerList()
	self._targetScrollList:reloadData(self._targetColDataList)
end

function PetTargetShowView:_updateTargetCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "icon")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local path = data.iconPath
	local bgGo = iconGo

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/expevents/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	local fmtTargetInfo = PowerLandModel.instance:getFmtTargetInfo()
	local count = fmtTargetInfo:getTargetCount(data.targetId)

	txtCount.text = string.format("x %d", count)
end

function PetTargetShowView:_clearTargetCell(cell)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(iconGo)
end

function PetTargetShowView:_onUpdatePetColData()
	self._petColPetDataList = {}

	local petIdList = PowerLandModel.instance:getCanFormPetIds()

	for _, petId in ipairs(petIdList) do
		local petData = PowerLandConfig.instance:getPlPetDataByActId(self._activityId, petId)

		table.insert(self._petColPetDataList, petData)
	end
end

function PetTargetShowView:_onUpdatePetScrollerList()
	self._petScrollList:reloadData(self._petColPetDataList)

	local isMotion = true

	self._petScrollList:MoveCellInView(0, isMotion)
end

function PetTargetShowView:_updatePetCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local petIcon = goutil.findChild(mainGo, "petIcon")
	local targetCol = goutil.findChild(mainGo, "targetCol")

	for i = 1, targetCol.transform.childCount do
		local trans = targetCol.transform:GetChild(i - 1)

		GameUtil.SetActive(trans.gameObject, i <= #data.targetIds)
	end

	for idx, targetId in ipairs(data.targetIds) do
		local targetIcon = goutil.findChild(targetCol, string.format("target_%s/icon", idx))
		local txtTargetName = goutil.findChildTextComponent(targetCol, string.format("target_%s/txtName", idx))
		local targetData
		local fmtTargetInfo = PowerLandModel.instance:getFmtTargetInfo()
		local level = fmtTargetInfo:getTargetLevel(targetId)
		local targetData = PowerLandConfig.instance:getRealPlTargetData(targetId, level)

		if targetIcon then
			local path = targetData.iconPath
			local bgGo = targetIcon

			if not string.nilorempty(path) and bgGo then
				local spriteType = uGuiUtil.SpriteType.BigBg
				local spriteName = string.format("ui/icon/expevents/%s.png", path)

				local function func()
					return
				end

				uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
			end
		else
			printError(string.format("助战精灵id%d,对应印记的数据无法寻到.( idx=%d )", data.creepsId, idx))
		end

		if txtTargetName then
			txtTargetName.text = targetData.targetName
		end
	end

	local skinId = checknumber(data.faceId)

	if skinId == 0 then
		skinId = data.raceId
	end

	MaterialMgr.setIcon(petIcon, MatType.Pet, skinId, nil, nil)

	local function handler()
		CommonTipsMgr.instance:showMaxLvlPetTips(data.raceId, data.lv, data.awakenLv, data.faceId)
	end

	GameUtil.addClickHandler(petIcon, handler)
end

function PetTargetShowView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local petIcon = goutil.findChild(mainGo, "petIcon")

	MaterialMgr.resetAll(petIcon)
	GameUtil.rmClickHandler(mainGo, handler)
end

return PetTargetShowView
