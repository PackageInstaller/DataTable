-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormHotPvEView.lua

module("logic.extensions.masterform.view.MasterFormHotPvEView", package.seeall)

local MasterFormHotPvEView = class("MasterFormHotPvEView", ViewComponent)

MasterFormHotPvEView.ViewType = {
	System = 1,
	Master = 2,
	Collect = 3
}

function MasterFormHotPvEView:buildUI()
	MasterFormHotPvEView.super.buildUI(self)

	self._tabCol = {}

	local mainGo = goutil.findChild(self.mainGO, "tabCol")

	self._tabCol._mainGo = mainGo
	self._tabCol._tabScrollercell = goutil.findChild(mainGo, "tabScrollercell")
	self._tabCol._tabScrollerview = goutil.findChild(mainGo, "tabScrollerview")
	self._topCol = {}

	local mainGo = goutil.findChild(self.mainGO, "contentCol/topCol")

	self._topCol._mainGo = mainGo
	self._topCol._txtFmtName = goutil.findChildTextComponent(mainGo, "txtFmtName")
	self._topCol._btnCollect = goutil.findChild(mainGo, "btnCollect")
	self._topCol._btnShare = goutil.findChild(mainGo, "btnShare")
	self._petCol = {}

	local mainGo = goutil.findChild(self.mainGO, "contentCol/petCol")

	self._petCol._mainGo = mainGo
	self._petCol._petView = goutil.findChild(mainGo, "petView")
	self._petCol._emptyGo = goutil.findChild(mainGo, "emptyGo")
	self._petCol._txtEmptyGo = goutil.findChildTextComponent(mainGo, "emptyGo/txt")
	self._petCol._bottomCol = {}
	self._petCol._bottomCol._mainGo = goutil.findChild(mainGo, "bottomCol")
	self._petCol._bottomCol._scrView = goutil.findChild(mainGo, "bottomCol/fmtDesc")
	self._petCol._bottomCol._txtFmtDesc = goutil.findChildTextComponent(mainGo, "bottomCol/fmtDesc/Viewport/Content")
	self._tabScrollList = ScrollerList.create(self._tabCol._tabScrollerview, self._tabCol._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._funcCol = {}

	local funcMainGo = goutil.findChild(self.mainGO, "contentCol/funcCol")

	self._funcCol._mainGo = funcMainGo
	self._funcCol._btnSure = goutil.findChild(funcMainGo, "btnSure")
	self._txtWinRate = self:getTxt("contentCol/topCol/txtWinRate")
	self._txtCollectTime = self:getTxt("title/txtCollectTime")
end

function MasterFormHotPvEView:bindEvents()
	MasterFormHotPvEView.super.bindEvents(self)
	GameUtil.addClickHandler(self._topCol._btnCollect, self._onClickBtnCollect, self)
	GameUtil.addClickHandler(self._topCol._btnShare, self._onClickBtnShare, self)
	GameUtil.addClickHandler(self._funcCol._btnSure, self._onClickBtnSureOfFunc, self)
end

function MasterFormHotPvEView:unbindEvents()
	MasterFormHotPvEView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._topCol._btnCollect)
	GameUtil.rmClickHandler(self._topCol._btnShare)
	GameUtil.rmClickHandler(self._funcCol._btnSure)
end

function MasterFormHotPvEView:onEnter()
	MasterFormHotPvEView.super.onEnter(self)

	self._periodId = MasterFormController.instance:getPeriodId()

	if self._periodId == 0 then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	local params = self:getOpenParam() or {}

	self._viewType = checknumber(params[1])
	self._fmtPlanId = checknumber(params[2])

	if self._viewType == MasterFormHotPvEView.ViewType.System and self._fmtPlanId == 0 then
		FloatWordMgr.instance:show("阵容方案Id未定义")

		return
	end

	self._curTabIdx = 0
	self._masterFormMgr = MasterFormController.instance:getMasterFormMgr(self._periodId)

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.MasterFormViewFormRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormGetMyFormRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormGetCollectionFormRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormRevokeRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormCollectRes, self._onUpdateTopColUI, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormCancelCollectRes, self._onUpdateTopColUI, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormGetBaseInfoRes, self._onUpdate, self)

	if self._viewType == MasterFormHotPvEView.ViewType.System then
		self:_onUpdate()
	elseif self._viewType == MasterFormHotPvEView.ViewType.Master then
		MasterFormController.instance:sendPM_MasterFormViewFormReq(self._periodId, self._fmtPlanId)
	elseif self._viewType == MasterFormHotPvEView.ViewType.Collect then
		MasterFormController.instance:sendPM_MasterFormGetCollectionFormReq(self._periodId)
	end

	MasterFormController.instance:sendPM_MasterFormGetBaseInfoReq(self._periodId)
end

function MasterFormHotPvEView:onExit()
	MasterFormHotPvEView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormViewFormRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormGetMyFormRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormGetCollectionFormRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormRevokeRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormCollectRes, self._onUpdateTopColUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormCancelCollectRes, self._onUpdateTopColUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormGetBaseInfoRes, self._onUpdate, self)
	self:_onClearTopColUI()
	self:_onClearTabCol()
	self:_onClearPetCol()
end

function MasterFormHotPvEView:_onSetUI()
	return
end

function MasterFormHotPvEView:_onUpdate()
	self:_onUpdateFmtInfoData()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function MasterFormHotPvEView:_onUpdateData()
	self:_onUpdateTabInfoData()
end

function MasterFormHotPvEView:_onUpdateUI()
	self:_onUpdateTitleColUI()
	self:_onUpdateTabColUI()
	self:_onUpdatePetColUI()
	self:_onUpdateTopColUI()
end

function MasterFormHotPvEView:_onUpdateFmtInfoData()
	self._fmtMoListOfData = {}

	if self._viewType == MasterFormHotPvEView.ViewType.System then
		local fmtMoList = self._masterFormMgr:getFmtMoList(MasterFormMgr.FmtType.System)

		for _, fmtMo in ipairs(fmtMoList) do
			if fmtMo:getFmtPlanId() == self._fmtPlanId then
				table.insert(self._fmtMoListOfData, fmtMo)
			end
		end
	elseif self._viewType == MasterFormHotPvEView.ViewType.Master then
		local fmtMoList = self._masterFormMgr:getFmtMoList(MasterFormMgr.FmtType.Master)

		for _, fmtMo in ipairs(fmtMoList) do
			if fmtMo:getFmtPlanId() == self._fmtPlanId then
				table.insert(self._fmtMoListOfData, fmtMo)
			end
		end
	elseif self._viewType == MasterFormHotPvEView.ViewType.Collect then
		for _, fmtType in pairs(MasterFormMgr.FmtType) do
			local fmtIdList = self._masterFormMgr:getFmtIdListAsCollectByType(fmtType)

			for _, fmtId in ipairs(fmtIdList) do
				local fmtMo = self._masterFormMgr:getFmtMo(fmtType, fmtId)

				if fmtMo then
					table.insert(self._fmtMoListOfData, fmtMo)
				end
			end
		end
	end
end

function MasterFormHotPvEView:_onUpdateTabInfoData()
	local moList = {}

	for _, fmtMo in ipairs(self._fmtMoListOfData) do
		table.insert(moList, fmtMo)
	end

	if self._viewType == MasterFormHotPvEView.ViewType.System then
		local count = MasterFormConfig.instance:getMfCommonValue("MAX_SYSTEM_FMT_SHOW_COUNT", true)

		moList = self:_getRadomList(moList, count)

		local id1, id2 = 0, 0
		local index1, index2 = 0, 0

		table.sort(moList, function(a, b)
			id1, id2 = a:getFmtId(), b:getFmtId()

			local data1 = MasterFormConfig.instance:getMfSysFmtDataById(id1)
			local data2 = MasterFormConfig.instance:getMfSysFmtDataById(id2)

			if data1 then
				index1 = data1.index or 0
			end

			if data2 then
				index2 = data2.index or 0
			end

			if index1 == index2 then
				if a:getFmtType() < b:getFmtType() then
					return true
				end

				return false
			end

			return index1 < index2
		end)
	elseif self._viewType == MasterFormHotPvEView.ViewType.Master then
		local id1, id2 = 0, 0

		table.sort(moList, function(a, b)
			id1, id2 = a:getFmtId(), b:getFmtId()

			if id1 == id2 then
				if a:getFmtType() < b:getFmtType() then
					return true
				end

				return false
			end

			return id1 < id2
		end)
	elseif self._viewType == MasterFormHotPvEView.ViewType.Collect then
		local id1, id2 = 0, 0

		table.sort(moList, function(a, b)
			id1, id2 = a:getFmtId(), b:getFmtId()

			if id1 == id2 then
				if a:getFmtType() < b:getFmtType() then
					return true
				end

				return false
			end

			return id1 < id2
		end)
	end

	local tabIdx = 0
	local infoList = {}

	for _, fmtMo in ipairs(moList) do
		tabIdx = tabIdx + 1

		local info = {}

		info.tabIdx = tabIdx
		info.fmtMo = fmtMo

		table.insert(infoList, info)
	end

	self._tabInfoList = infoList
	self._curTabIdx = Mathf.Clamp(self._curTabIdx or 1, 1, #infoList)
end

function MasterFormHotPvEView:_getTabInfo(tabIdx)
	return self._tabInfoList[tabIdx]
end

function MasterFormHotPvEView:_getRadomList(list, count)
	local array = {}

	for i, v in ipairs(list) do
		table.insert(array, v)
	end

	GameUtil.permuteArray(array)

	local resList = {}

	for i = 1, count do
		if array[i] then
			table.insert(resList, array[i])
		end
	end

	return resList
end

function MasterFormHotPvEView:_onUpdateTopColUI()
	local tabInfo = self:_getTabInfo(self._curTabIdx)

	self._topCol._txtFmtName.text = tabInfo and tabInfo.fmtMo:getFmtName() or ""

	GameUtil.SetActive(self._topCol._btnCollect, tabInfo ~= nil)
	GameUtil.SetActive(self._topCol._btnShare, tabInfo ~= nil)
	GameUtil.setUIGroupIdx(self._topCol._btnCollect, (tabInfo or nil) and self._masterFormMgr:isCollect(tabInfo.fmtMo:getFmtType(), tabInfo.fmtMo:getFmtId()) and 1 or 0)
end

function MasterFormHotPvEView:_onClearTopColUI()
	return
end

function MasterFormHotPvEView:_onClickBtnCollect()
	local tabInfo = self:_getTabInfo(self._curTabIdx)

	if tabInfo then
		local fmtId = tabInfo.fmtMo:getFmtId()
		local fmtType = tabInfo.fmtMo:getFmtType()

		if self._masterFormMgr:isCollect(fmtType, fmtId) then
			MasterFormController.instance:sendPM_MasterFormCancelCollectReq(self._periodId, fmtId, fmtType)
		else
			MasterFormController.instance:sendPM_MasterFormCollectReq(self._periodId, fmtId, fmtType)
		end
	end
end

function MasterFormHotPvEView:_onClickBtnShare()
	local tabInfo = self:_getTabInfo(self._curTabIdx)
	local fmtMo = tabInfo and tabInfo.fmtMo

	if fmtMo then
		local params = {}

		params.periodId = self._periodId
		params.viewType = self._viewType
		params.fmtPlanId = self._fmtPlanId
		params.fmtId = fmtMo:getFmtId()

		UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.MasterForm, params)
	end
end

function MasterFormHotPvEView:_onUpdateTabColUI()
	self._tabScrollList:regReloadFinish(function()
		local comps = self._tabCol._tabScrollerview:GetComponentsInChildren(goutil.Type_RectTransform)

		for i = 0, comps.Length - 1 do
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(comps[i])
		end
	end)
	self._tabScrollList:reloadData(self._tabInfoList)
end

function MasterFormHotPvEView:_onClearTabCol()
	self._tabScrollList:dispose()
end

function MasterFormHotPvEView:_updateTabCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local fmtMo = info.fmtMo
	local tabIdx = info.tabIdx
	local txtFmtName = goutil.findChildTextComponent(mainGo, "txtFmtName")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local tagCol = goutil.findChild(mainGo, "tagCol")
	local tagView = goutil.findChild(mainGo, "tagCol/tagView")
	local txtCompCell = goutil.findChildTextComponent(mainGo, "tagCol/compCell/txt")
	local thresholdGo = goutil.findChild(mainGo, "txtThreshold")
	local txtThreshold = goutil.findChildTextComponent(mainGo, "txtThreshold/txt")
	local fmtType = fmtMo:getFmtType()
	local isSelected = tabIdx == self._curTabIdx

	GameUtil.SetActive(imgSelect, isSelected)

	txtFmtName.text = fmtMo:getFmtName()

	local tagCellStrList = {}
	local tagIds = fmtMo:getFmtTagIds()

	for _, tagId in ipairs(tagIds) do
		local tagData = MasterFormConfig.instance:getMfTagData(tagId)

		if tagData then
			table.insert(tagCellStrList, tagData.desc)
		end
	end

	local parentTran = tagView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, go in ipairs(children) do
		GameUtil.SetActive(go, false)
	end

	for i, v in ipairs(tagCellStrList) do
		if not children[i] then
			local mainGo = goutil.cloneAndSetParent(children[1], parentTran)
			local txt = goutil.findChildTextComponent(mainGo, "txt")

			txt.text = v

			GameUtil.SetActive(mainGo, true)
		end
	end

	local fmtCompletion = checkint(fmtMo:getFmtCompletion() * 100)

	txtCompCell.text = string.format("完成度：%s%%", fmtCompletion)

	local isNeedThreshold = fmtType == MasterFormMgr.FmtType.Master

	GameUtil.SetActive(thresholdGo, isNeedThreshold)

	if isNeedThreshold then
		txtThreshold.text = fmtMo:getThresholdStr()
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTabCell, self, mainGo, tabIdx))
end

function MasterFormHotPvEView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local headIcon = goutil.findChild(mainGo, "headIcon")

	HeadItemController.instance:resetHeadCell(headIcon)
	GameUtil.rmClickHandler(mainGo)
end

function MasterFormHotPvEView:_onClickTabCell(mainGo, tabIdx)
	if self._curTabIdx == tabIdx then
		return
	end

	self._curTabIdx = tabIdx

	self:_onUpdateUI()
end

function MasterFormHotPvEView:_onUpdateTitleColUI()
	local cfg = MasterFormConfig.instance:getMfBaseData(self._periodId)

	if cfg and not string.nilorempty(cfg.winRateStatisticalPeriod) then
		local timeArray = string.split(cfg.winRateStatisticalPeriod, "#")
		local startDate = GameUtil.string2date(timeArray[1])
		local endDate = GameUtil.string2date(timeArray[2])

		self._txtCollectTime.text = langPara("统计时间：%s.%s-%s.%s", startDate.month, startDate.day, endDate.month, endDate.day)
	else
		self._txtCollectTime.text = ""
	end
end

function MasterFormHotPvEView:_onUpdatePetColUI()
	local tabInfo = self:_getTabInfo(self._curTabIdx)
	local fmtMo = tabInfo and tabInfo.fmtMo
	local petId = 0
	local petIdList = fmtMo and fmtMo:getFmtPetIdList() or {}
	local children = GameUtil.getChildren(self._petCol._petView)

	for index, mainGo in ipairs(children) do
		petId = checknumber(petIdList[index])

		GameUtil.SetActive(mainGo, petId > 0)

		if petId > 0 then
			self:_updatePetCell(mainGo, fmtMo, petId)
		end
	end

	self._petCol._bottomCol._txtFmtDesc.text = fmtMo and fmtMo:getSingleWinRateDesc() or ""

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._petCol._bottomCol._txtFmtDesc.gameObject:GetComponent(goutil.Type_RectTransform))

	self._petCol._bottomCol._scrView:GetComponent(ComponentType.ScrollRect).verticalNormalizedPosition = 1

	if tabInfo == nil then
		local str = "没有阵容"

		if self._viewType == MasterFormHotPvEView.ViewType.System then
			str = "当前没有推荐阵容"
		elseif self._viewType == MasterFormHotPvEView.ViewType.Master then
			str = "当前没有已发布的阵容"
		elseif self._viewType == MasterFormHotPvEView.ViewType.Collect then
			str = "当前没有收藏阵容"
		end

		self._petCol._txtEmptyGo.text = str

		GameUtil.SetActive(self._petCol._emptyGo, true)
		GameUtil.SetActive(self._petCol._petView, false)
	else
		GameUtil.SetActive(self._petCol._emptyGo, false)
		GameUtil.SetActive(self._petCol._petView, true)
	end

	self._txtWinRate.text = fmtMo and fmtMo:getWinRateDesc() or ""
end

function MasterFormHotPvEView:_onClearPetCol()
	local children = GameUtil.getChildren(self._petCol._petView)

	for _, mainGo in ipairs(children) do
		self:_clearPetCell(mainGo)
	end
end

function MasterFormHotPvEView:_updatePetCell(mainGo, fmtMo, petId)
	local con = goutil.findChild(mainGo, "con")
	local imgPet = goutil.findChild(mainGo, "con/img/pet")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	MaterialMgr.setIcon(imgPet, MatType.Pet, fmtMo:getPetRaceId(petId), nil, nil)

	txtName.text = fmtMo:getPetName(petId)

	local isWithPet = BagModel.instance:isExistRaceId(fmtMo:getPetRaceId(petId))

	GameUtil.SetGray(con, not isWithPet)

	local function func()
		local raceId = fmtMo:getPetRaceId(petId)
		local hotPetCfg = MasterFormConfig.instance:getHotPetCfg(raceId)

		if hotPetCfg and (checknumber(hotPetCfg.cutePetId) > 0 or hotPetCfg.equipDefineId or hotPetCfg.holyStripeId or hotPetCfg.starGodsId) then
			UIStateManager.instance:push(ViewName.MasterFormHotPetDetailView, raceId)
		else
			local str = string.format("%s:%s", MatType.Pet, fmtMo:getPetRaceId(petId))

			TipsFacade.instance:openItemSourceView(str)
		end
	end

	GameUtil.addClickHandler(con, func, self)
end

function MasterFormHotPvEView:_clearPetCell(mainGo)
	local con = goutil.findChild(mainGo, "con")
	local imgPet = goutil.findChild(mainGo, "con/img/pet")

	MaterialMgr.resetAll(imgPet)
	GameUtil.rmClickHandler(con)
end

function MasterFormHotPvEView:_onClickBtnSureOfFunc()
	local tabInfo = self:_getTabInfo(self._curTabIdx)

	if tabInfo and tabInfo.fmtMo:getFmtCompletion() >= 1 then
		self:_openBtnFormationView()
	else
		FloatWordMgr.instance:show("所选推荐阵中存在未收集精灵，使用失败")
	end
end

function MasterFormHotPvEView:_openBtnFormationView()
	local tabInfo = self:_getTabInfo(self._curTabIdx)

	if tabInfo then
		local tipsContent = "确定要添加此方案到阵型预设中吗？"

		TipsFacade.instance:openPopupWindow(lang("tip"), tipsContent, function()
			local idList = tabInfo.fmtMo:getFmtPetIdList()
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
			local fmtData

			if tabInfo.fmtMo:getFmtType() == MasterFormMgr.FmtType.System then
				fmtData = MasterFormConfig.instance:getMfSysFmtDataById(tabInfo.fmtMo:getFmtId())
			end

			if fmtData then
				if not fmtData.posList then
					local posList = {}
					local raceId, petId = 0, 0

					for i, id in ipairs(idList) do
						petId = BagModel.instance:getMaxZdlPetIdByRaceId((tabInfo.fmtMo:getPetRaceId(id)))

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

					if checknumber(tabInfo.fmtMo:getSummonPetRaceId()) > 0 then
						local targetRaceId = tabInfo.fmtMo:getSummonPetRaceId()

						for i, v in ipairs(positions) do
							local petMo = BagPetsController.instance:getPet(v)

							if petMo.raceId == targetRaceId then
								summonPetId = v

								break
							end
						end
					end

					local summonMasterPetId = 0
					local var_35_1

					if checknumber(tabInfo.fmtMo:getSummonMasterRaceId()) > 0 then
						do
							local targetRaceId = tabInfo.fmtMo:getSummonMasterRaceId()

							for i, v in ipairs(positions) do
								local petMo = BagPetsController.instance:getPet(v)

								if petMo.raceId == targetRaceId then
									summonMasterPetId = v

									break
								end
							end
						end

						var_35_1 = tabInfo.fmtMo:getFmtName() or lang("推荐阵克隆")
					end

					FormationGroupController.instance:sendAddNewTab(FormationGroupController.DEFAULT_GROUP_ID, var_35_1, positions, summonMasterPetId, summonPetId)
				end
			end
		end)
	end
end

return MasterFormHotPvEView
