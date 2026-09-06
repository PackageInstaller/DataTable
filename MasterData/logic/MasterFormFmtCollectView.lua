-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormFmtCollectView.lua

module("logic.extensions.masterform.view.MasterFormFmtCollectView", package.seeall)

local MasterFormFmtCollectView = class("MasterFormFmtCollectView", ViewComponent)

function MasterFormFmtCollectView:ctor()
	MasterFormFmtCollectView.super.ctor(self)
end

function MasterFormFmtCollectView:unbindEvents()
	MasterFormFmtCollectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._funcCol._btnSure)
	GameUtil.rmClickHandler(self._btnGainPrize)
end

function MasterFormFmtCollectView:bindEvents()
	MasterFormFmtCollectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._funcCol._btnSure, self._onClickBtnSureOfFunc, self)
	GameUtil.addClickHandler(self._btnGainPrize, self._onClickGainPrize, self)
end

function MasterFormFmtCollectView:buildUI()
	MasterFormFmtCollectView.super.buildUI(self)

	self._petView = self:getGo("contentCol/petCol/petView")
	self._emptyGo = self:getGo("contentCol/petCol/emptyGo")
	self._txtFmtName = self:getTxt("contentCol/topCol/txtFmtName")
	self._fmtDescScroll = self:getGo("contentCol/petCol/bottomCol/fmtDesc")
	self._txtFmtDesc = self:getTxt("contentCol/petCol/bottomCol/fmtDesc/Viewport/Content")
	self._funcCol = {}

	local mainGo = self:getGo("contentCol/funcCol")

	self._funcCol._mainGo = mainGo
	self._funcCol._btnSure = goutil.findChild(mainGo, "btnSure")
	self._funcCol._posBtnSure = goutil.findChild(mainGo, "btnSure/pos")
	self._funcCol._redPointBtnSure = goutil.findChild(mainGo, "btnSure/redPoint")
	self._prizeCon = self:getGo("contentCol/prizeCol/prizeCon")
	self._gainGo = self:getGo("contentCol/prizeCol/gain")
	self._btnGainPrize = self:getGo("contentCol/prizeCol/btnGainPrize")
	self._tabScrollCell = self:getGo("tabCol/tabScrollercell")
	self._tabScrollView = self:getGo("tabCol/tabScrollerview")
	self._tabScrollList = ScrollerList.create(self._tabScrollView, self._tabScrollCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._redPointPrize = self:getGo("contentCol/prizeCol/redpoint")
	self._txtPrizeNum = self:getTxt("contentCol/prizeCol/txtNum")
end

function MasterFormFmtCollectView:onExit()
	MasterFormFmtCollectView.super.onExit(self)

	self._curFmtId = nil

	if self._tabScrollList then
		self._tabScrollList:dispose()
	end

	MaterialMgr.resetAll(self._prizeCon)
	self:_clearPrize()
	self:_clearPetCells()
end

function MasterFormFmtCollectView:onEnter()
	MasterFormFmtCollectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FormationCollectInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.FormationCollectGetPrizeRes, self._refreshView, self)

	local dataList = MasterFormConfig.instance:getFmtCollectDataList()

	if dataList[1] then
		self._curFmtId = dataList[1].fmtId or nil
	end
end

function MasterFormFmtCollectView:onEnterFinished()
	self:_refreshView()
	FormationCollectController.instance:sendPM_FormationCollectInfoReq()
end

function MasterFormFmtCollectView:_refreshView()
	self:_refreshTabCol()
	self:_refreshContentCol()
end

function MasterFormFmtCollectView:_refreshTabCol()
	self._tabScrollList:reloadData(MasterFormConfig.instance:getFmtCollectDataList())
end

function MasterFormFmtCollectView:_updateTabCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtFmtName = goutil.findChildTextComponent(mainGo, "txtFmtName")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local txtComp = goutil.findChildTextComponent(mainGo, "tagCol/compCell/txt")
	local gainPrizeGo = goutil.findChild(mainGo, "gainPrize")
	local redPoint = goutil.findChild(mainGo, "redpoint")
	local isCollectedAll = self:_isCollectedAll(data)
	local isGain = FormationCollectModel.instance:isGainedFmtPrize(data.fmtId)

	GameUtil.SetActive(gainPrizeGo, isGain)
	GameUtil.SetActive(redPoint, isCollectedAll and not isGain)

	txtFmtName.text = langPara("%s", data.fmtName or "")

	GameUtil.SetActive(imgSelect, data.fmtId == self._curFmtId)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTabCell, self, data.fmtId))

	txtComp.text = langPara("完成度：%s%%", self:_getCompletion(data))
end

function MasterFormFmtCollectView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function MasterFormFmtCollectView:_onClickTabCell(fmtId)
	if self._curFmtId == fmtId then
		return
	end

	self._curFmtId = fmtId

	self:_refreshView()
end

function MasterFormFmtCollectView:_refreshContentCol()
	local data = self:_getCurData()
	local isEmpty = data == nil

	GameUtil.SetActive(self._emptyGo, isEmpty)
	GameUtil.SetActive(self._petView, not isEmpty)
	GameUtil.SetActive(self._funcCol._mainGo, false)

	if isEmpty then
		GameUtil.SetActive(self._funcCol._mainGo, false)

		self._txtFmtName.text = lang("")
		self._txtFmtDesc.text = lang("")

		self:_clearPrize()

		return
	end

	self._txtFmtName.text = langPara("%s", data.fmtName or "")
	self._txtFmtDesc.text = langPara("%s", data.fmtDesc or "")

	self:_refreshPetCells(data)
	self:_refreshPrize(data)
end

function MasterFormFmtCollectView:_refreshPetCells(data)
	local children = GameUtil.getChildren(self._petView)

	if not data.petList then
		local petList = {}

		for index, mainGo in ipairs(children) do
			local raceId = checknumber(petList[index])

			GameUtil.SetActive(mainGo, raceId > 0)

			if raceId > 0 then
				self:_updatePetCell(mainGo, raceId)
			end
		end
	end
end

function MasterFormFmtCollectView:_updatePetCell(mainGo, raceId)
	local con = goutil.findChild(mainGo, "con")
	local imgPet = goutil.findChild(mainGo, "con/img/pet")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	MaterialMgr.setIcon(imgPet, MatType.Pet, raceId, nil, nil)

	txtName.text = langPara("%s", MaterialMgr.getMaterialsName(MatType.Pet, raceId))

	GameUtil.SetGray(con, not BagModel.instance:isExistRaceId(raceId))
	GameUtil.rmClickHandler(con)
	GameUtil.addClickHandler(con, function()
		local hotPetCfg = MasterFormConfig.instance:getHotPetCfg(raceId)

		if hotPetCfg and (checknumber(hotPetCfg.cutePetId) > 0 or hotPetCfg.equipDefineId or hotPetCfg.holyStripeId or hotPetCfg.starGodsId) then
			UIStateManager.instance:push(ViewName.MasterFormHotPetDetailView, raceId)
		else
			local str = string.format("%s:%s", MatType.Pet, raceId)

			TipsFacade.instance:openItemSourceView(str)
		end
	end, self)
end

function MasterFormFmtCollectView:_clearPetCells()
	local children = GameUtil.getChildren(self._petView)

	for _, mainGo in ipairs(children) do
		local con = goutil.findChild(mainGo, "con")
		local imgPet = goutil.findChild(mainGo, "con/img/pet")

		MaterialMgr.resetAll(imgPet)
		GameUtil.rmClickHandler(con)
	end
end

function MasterFormFmtCollectView:_refreshPrize(data)
	self:_clearPrize()

	local proxy = MaterialMgr.setCellByCfg(data.collectPrize, self._prizeCon)
	local isGained = FormationCollectModel.instance:isGainedFmtPrize(data.fmtId)
	local isCollectedAll = self:_isCollectedAll(data)

	GameUtil.SetActive(self._funcCol._mainGo, true)
	GameUtil.SetActive(self._funcCol._btnSure, true)
	GameUtil.SetActive(self._funcCol._redPointBtnSure, false)
	GameUtil.SetActive(self._gainGo, isGained)
	GameUtil.SetActive(self._btnGainPrize, isCollectedAll and not isGained)

	self._txtPrizeNum.text = ""

	if proxy then
		proxy.binder:setEffStatus(not isGained)
	end

	if isCollectedAll == true and not isGained then
		GameUtil.SetActive(self._redPointPrize, true)
	else
		GameUtil.SetActive(self._redPointPrize, false)
	end
end

function MasterFormFmtCollectView:_clearPrize()
	if self._prizeCon then
		MaterialMgr.resetAll(self._prizeCon)
	end
end

function MasterFormFmtCollectView:_onClickBtnSureOfFunc()
	local data = self:_getCurData()

	if data == nil then
		return
	end

	if self:_isCollectedAll(data) then
		self:_openBtnFormationView(data)
	else
		FloatWordMgr.instance:show("所选推荐阵中存在未收集精灵，使用失败")
	end
end

function MasterFormFmtCollectView:_openBtnFormationView(data)
	local tipsContent = "确定要添加此方案到阵型预设中吗？"

	TipsFacade.instance:openPopupWindow(lang("tip"), tipsContent, function()
		local positions = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}

		if not data.posList then
			local posList = {}
			local raceId, petId = 0, 0

			for i, id in ipairs(data.petList or {}) do
				petId = BagModel.instance:getMaxZdlPetIdByRaceId((checknumber(id)))

				if petId then
					local pos = checknumber(posList[i])

					if pos < 1 or pos > #positions or positions[pos] ~= 0 then
						pos = table.indexof(positions, 0)
					end

					if pos then
						positions[pos] = petId
					end
				end
			end

			local summonPetId = 0

			if checknumber(data.summonPetRaceId) > 0 then
				local targetRaceId = data.summonPetRaceId

				for i, v in ipairs(positions) do
					local petMo = BagPetsController.instance:getPet(v)

					if petMo.raceId == targetRaceId then
						summonPetId = v

						break
					end
				end
			end

			local summonMasterPetId = 0

			if checknumber(data.summonMasterId) > 0 then
				local targetRaceId = summonMasterId

				for i, v in ipairs(positions) do
					local petMo = BagPetsController.instance:getPet(v)

					if petMo.raceId == targetRaceId then
						summonMasterPetId = v

						break
					end
				end
			end

			FormationGroupController.instance:sendAddNewTab(FormationGroupController.DEFAULT_GROUP_ID, data.fmtName or lang("推荐阵克隆"), positions, summonMasterPetId, summonPetId)
		end
	end)
end

function MasterFormFmtCollectView:_getCurData()
	return self._curFmtId and MasterFormConfig.instance:getFmtCollectData(self._curFmtId)
end

function MasterFormFmtCollectView:_getCompletion(data)
	if not data.petList then
		local petList = {}
		local total = #petList

		if total <= 0 then
			return 0
		end

		local hasCount = 0

		for _, raceId in ipairs(petList) do
			if BagModel.instance:isExistRaceId(raceId) then
				hasCount = hasCount + 1
			end
		end

		return math.floor(hasCount * 100 / total)
	end
end

function MasterFormFmtCollectView:_isCollectedAll(data)
	return self:_getCompletion(data) >= 100
end

function MasterFormFmtCollectView:_onClickGainPrize()
	local data = self:_getCurData()

	if data == nil then
		return
	end

	local isGained = FormationCollectModel.instance:isGainedFmtPrize(data.fmtId)

	if isGained then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if self:_isCollectedAll(data) then
		FormationCollectAgent.instance:sendPM_FormationCollectGetPrizeReq(data.fmtId)
	else
		FloatWordMgr.instance:show("未集齐全部精灵")
	end
end

return MasterFormFmtCollectView
