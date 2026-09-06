-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/FulllevelmissionView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.FulllevelmissionView", package.seeall)

local FulllevelmissionView = class("FulllevelmissionView", ViewComponent)

function FulllevelmissionView:ctor()
	FulllevelmissionView.super.ctor(self)
end

function FulllevelmissionView:unbindEvents()
	FulllevelmissionView.super.unbindEvents(self)

	for i = 1, #self._infoList do
		GameUtil.rmClickHandler(self._infoList[i].btnGoto)
	end

	for i = 1, #self._infoList do
		GameUtil.rmClickHandler(self._infoList[i].btnInfo)
	end

	for i = 1, #self.filterList do
		GameUtil.rmClickHandler(self.filterList[i].go)
	end
end

function FulllevelmissionView:bindEvents()
	FulllevelmissionView.super.bindEvents(self)

	for i = 1, #self._infoList do
		GameUtil.addClickHandler(self._infoList[i].btnGoto, function()
			self:_onClickGoto(self._cfgs[i])
		end, self)
	end

	for i = 1, #self._infoList do
		GameUtil.addClickHandler(self._infoList[i].btnInfo, function()
			self:_onClickInfo(self._cfgs[i].showRaceId)
		end, self)
	end

	for i = 1, #self.filterList do
		GameUtil.addClickHandler(self.filterList[i].go, function()
			self:_refreshPetCfg(i)
		end, self)
	end
end

function FulllevelmissionView:buildUI()
	FulllevelmissionView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._infoList = {}

	for i = 1, 6 do
		local goInfo = {}

		goInfo.go = self:getGo("info/cell_" .. i)
		goInfo.pet = goutil.findChild(goInfo.go, "pet")
		goInfo.txtTitle = goutil.findChildTextComponent(goInfo.go, "txtTitle")
		goInfo.openTime = goutil.findChild(goInfo.go, "openTime")
		goInfo.openDesc = goutil.findChildTextComponent(goInfo.openTime, "txtTime")
		goInfo.time = goutil.findChild(goInfo.go, "time")
		goInfo.timeDesc = goutil.findChildTextComponent(goInfo.time, "txtTime")
		goInfo.over = goutil.findChild(goInfo.go, "over")
		goInfo.btnGoto = goutil.findChildButtonComponent(goInfo.go, "btnGoto")
		goInfo.btnInfo = goutil.findChildButtonComponent(goInfo.go, "btnInfo")
		self._infoList[i] = goInfo
	end

	self._petPos = {}

	for i = 1, 9 do
		local petPosCell = {}

		petPosCell.go = self:getGo("formation/cell_" .. i)
		petPosCell.con = goutil.findChild(petPosCell.go, "con")
		self._petPos[i] = petPosCell
	end

	self.filterList = {}

	for i = 1, 4 do
		local filterCell = {}

		filterCell.go = self:getGo("btnFilter/btn_" .. i)
		filterCell.select = goutil.findChild(filterCell.go, "select")
		filterCell.headcell = goutil.findChild(filterCell.go, "headcell")
		self.filterList[i] = filterCell
	end

	self._goFilter = self:getGo("btnFilter")
end

function FulllevelmissionView:onExit()
	FulllevelmissionView.super.onExit(self)
	uGuiUtil.clearImage(self._bg)

	for i, v in ipairs(self._infoList) do
		uGuiUtil.clearImage(goutil.findChild(self._infoList[i].go, "pet"))
	end

	for i = 1, #self._petPos do
		uGuiUtil.clearImage(self._petPos[i].con)
	end

	for i = 1, #self.filterList do
		MaterialMgr.clearIcon(self.filterList[i].headcell)
	end

	self._curShowId = nil
end

function FulllevelmissionView:onEnter()
	FulllevelmissionView.super.onEnter(self)

	local params = self:getFirstParam().parameter

	self._params = string.splitToNumber(params, "#")

	if #self._params <= 1 then
		self._cfgs = XiaonuoBirthConfig.instance:getFullMissionCfgById(checkint(params))

		self:_refreshUI()
		goutil.setActive(self._goFilter, false)
	else
		goutil.setActive(self._goFilter, true)

		for k, v in ipairs(self.filterList) do
			local raceId = self._params[k]

			if raceId and raceId > 0 then
				goutil.setActive(v.go, true)
				MaterialMgr.setIcon(v.headcell, MatType.Pet, raceId)
			else
				goutil.setActive(v.go, false)
			end
		end

		self:_refreshPetCfg(1)
	end
end

function FulllevelmissionView:_refreshPetCfg(showId)
	if self._curShowId ~= showId then
		self._curShowId = showId

		uGuiUtil.clearImage(self._bg)

		for i, v in ipairs(self._infoList) do
			uGuiUtil.clearImage(goutil.findChild(self._infoList[i].go, "pet"))
		end

		self:_petPosReset()

		self._cfgs = XiaonuoBirthConfig.instance:getFullMissionCfgById(self._params[self._curShowId])

		self:_refreshUI()

		for k, v in ipairs(self.filterList) do
			goutil.setActive(v.select, k == self._curShowId)
		end
	end
end

function FulllevelmissionView:_petPosReset()
	for i = 1, #self._petPos do
		GameUtil.SetActive(self._petPos[i].go, false)
		uGuiUtil.clearImage(self._petPos[i].con)
	end
end

function FulllevelmissionView:_refreshUI()
	self:_petPosReset()

	local bgUrl = self._cfgs[1].bgName

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.BigBg, GameUrl.getBonusIconUrl(bgUrl))

	for i, v in ipairs(self._cfgs) do
		local cellCfg = self._cfgs[i]
		local curTimeType = GameUtil.getTimePeriodType(cellCfg.startTime, cellCfg.endTime)

		self._infoList[cellCfg.id].txtTitle.text = cellCfg.titleDesc

		local startTime, endTime = GameUtil.string2date(cellCfg.startTime), GameUtil.string2date(cellCfg.endTime)

		self._infoList[cellCfg.id].timeDesc.text = string.format("%02d.%02d - %02d.%02d", startTime.month, startTime.day, endTime.month, endTime.day)
		self._infoList[cellCfg.id].openDesc.text = string.format("%02d月%02d日开启", startTime.month, startTime.day)

		GameUtil.setLocalScale(self._infoList[cellCfg.id].pet, cellCfg.flip > 0 and -1 or 1, 1, 1)

		if not string.nilorempty(cellCfg.resourceName) then
			uGuiUtil.setSpriteToImage(self._infoList[cellCfg.id].pet, uGuiUtil.BigBg, GameUrl.getBonusIconUrl(cellCfg.resourceName))
		end

		GameUtil.SetActive(self._infoList[cellCfg.id].openTime, curTimeType == GameUtil.beforeTimePeriod)
		GameUtil.SetActive(self._infoList[cellCfg.id].time, curTimeType == GameUtil.inTimePeriod)
		GameUtil.SetActive(self._infoList[cellCfg.id].btnGoto, curTimeType == GameUtil.inTimePeriod and not string.nilorempty(cellCfg.jumpTo))
		GameUtil.SetActive(self._infoList[cellCfg.id].over, curTimeType == GameUtil.afterTimePeriod)
		GameUtil.SetActive(self._infoList[cellCfg.id].btnInfo, cellCfg.showRaceId > 0)

		if cellCfg.posId > 0 then
			GameUtil.SetActive(self._petPos[cellCfg.posId].go, true)

			local modelCo = CharacterConfig.instance:getModelCo(checknumber(cellCfg.showRaceId))

			uGuiUtil.setSpriteToImage(self._petPos[cellCfg.posId].con, uGuiUtil.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		end
	end
end

function FulllevelmissionView:_onClickGoto(data)
	local jumpTo = data and data.jumpTo

	if not string.nilorempty(jumpTo) then
		GotoMgr.gotoByString(jumpTo)
	end

	local reportBehavior = data and data.reportBehavior

	SurveyController.instance:reportBehavior(reportBehavior)
end

function FulllevelmissionView:_onClickInfo(raceId)
	if raceId == nil then
		return
	end

	PetbookController.instance:openPetinfoView(raceId)
end

return FulllevelmissionView
