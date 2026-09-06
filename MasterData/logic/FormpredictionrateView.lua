-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/view/FormpredictionrateView.lua

module("logic.extensions.formprediction.view.FormpredictionrateView", package.seeall)

local FormpredictionrateView = class("FormpredictionrateView", ViewComponent)

function FormpredictionrateView:ctor()
	FormpredictionrateView.super.ctor(self)
end

function FormpredictionrateView:unbindEvents()
	FormpredictionrateView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, cell in ipairs(self._leftCellList) do
		local top = goutil.findChild(cell, "top")

		GameUtil.rmClickHandler(top)
	end
end

function FormpredictionrateView:bindEvents()
	FormpredictionrateView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, cell in ipairs(self._leftCellList) do
		local top = goutil.findChild(cell, "top")

		GameUtil.addClickHandler(top, GameUtil.handler(self._onClickCellIdx, self, i))
	end
end

function FormpredictionrateView:buildUI()
	FormpredictionrateView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._righttableview = self:getGo("righttableview")
	self._formation = self:getGo("formation")
	self._empty = self:getGo("empty")
	self._leftCellList = {}

	for i = 1, 9 do
		local cell = self:getGo("formation/cell_" .. i)

		table.insert(self._leftCellList, cell)
	end

	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._rightScrollList = ScrollerList.create(self._righttableview, self._cell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function FormpredictionrateView:onExit()
	FormpredictionrateView.super.onExit(self)
	self._scrollList:dispose()
end

function FormpredictionrateView:onEnter()
	FormpredictionrateView.super.onEnter(self)

	self._activityId = 385001
	self._curFormId = 0

	local param = self:getOpenParam() or {}
	local actId = checknumber(param[1])

	if actId > 0 then
		self._activityId = actId
	end

	local formId = checknumber(param[2])

	if formId > 0 then
		self._curFormId = formId
	end

	local tabCfg = FormPredictionConfig.instance:getFormationListCfgById(self._activityId) or {}
	local tabList = {}

	for k, v in pairs(tabCfg) do
		table.insert(tabList, v)
	end

	ArraySort.sortOn(tabList, "formId", ArraySort.NUMERIC)

	if self._curFormId == 0 and tabList and #tabList > 0 then
		self._curFormId = tabList[1].formId
	end

	self._scrollList:reloadData(tabList)
	self.addGEvent(self, GlobalNotify.FORMPREDICTION_RATIO_UPDATE, self._onRefreshUI, self)
	FormPredictionController.instance:sendGetRatio(self._activityId, self._curFormId)
	self:_onRefreshUI()
end

function FormpredictionrateView:_onRefreshUI()
	local tabCfg = FormPredictionConfig.instance:getFormationCfgById(self._activityId, self._curFormId) or {}

	if not tabCfg.posList then
		self._petPlanId = tabCfg.petPlanId
		self._prizePlanId = tabCfg.prizePlanId

		local petCfg = FormPredictionConfig.instance:getPetListCfgById(self._petPlanId) or {}
		local petsList = {}
		local petMap = {}
		local posMap = {}

		self._needPetCount = #tabCfg.posList

		for k, v in pairs(petCfg) do
			table.insert(petsList, v)

			petMap[v.petId] = v
		end

		for i, v in ipairs(tabCfg.posList) do
			posMap[v] = true
		end

		self._petPosMap = posMap
		self._petMap = petMap
		self._petsList = petsList
		self._curSelectCellPosIdx = 0

		local infoList = FormPredictionModel.instance:getRatioInfo(self._activityId, self._curFormId) or {}

		self._ratioMap = {}

		for i, v in ipairs(infoList) do
			local posId = v.posId

			self._ratioMap[posId] = self._ratioMap[posId] or {}

			table.insert(self._ratioMap[posId], v)

			if self._curSelectCellPosIdx == 0 then
				self._curSelectCellPosIdx = posId
			end
		end

		for k, arr in pairs(self._ratioMap) do
			ArraySort.sortOn(arr, "ratio", ArraySort.DESCENDING)
		end

		self:_refreshLeftForm(self._ratioMap)
		self:_onClickCellIdx(self._curSelectCellPosIdx)
	end
end

function FormpredictionrateView:_refreshLeftForm(ratioMap)
	for i, cell in ipairs(self._leftCellList) do
		local con = goutil.findChild(cell, "con")
		local icon = goutil.findChild(cell, "icon")

		MaterialMgr.resetAll(con)

		if self._petPosMap[i] ~= nil then
			GameUtil.SetActive(cell, true)
		else
			GameUtil.SetActive(cell, false)
		end

		GameUtil.SetActive(con, false)
		GameUtil.SetActive(icon, false)

		local arr = ratioMap[i]
		local petId = 0

		if arr and #arr > 0 then
			petId = arr[1].petId
		end

		if checknumber(petId) > 0 and self._petMap[checknumber(petId)] then
			local petCfg = self._petMap[checknumber(petId)]

			if checknumber(petCfg.raceId) > 0 then
				GameUtil.SetActive(con, true)
				MaterialMgr.setCell(MatType.Pet, petCfg.raceId, con)
			else
				GameUtil.SetActive(icon, true)
				uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petCfg.iconName))
			end
		end
	end
end

function FormpredictionrateView:_onClickCellIdx(idx)
	self._curSelectCellPosIdx = idx

	for i, cell in ipairs(self._leftCellList) do
		local select = goutil.findChild(cell, "select")

		GameUtil.SetActive(select, i == idx)
	end

	if not self._ratioMap[idx] then
		local arr = {}

		self._rightScrollList:reloadData(arr)
		GameUtil.SetActive(self._empty, #arr == 0)
	end
end

function FormpredictionrateView:_clearCell(cell)
	return
end

function FormpredictionrateView:_updateCell(view, cell, data, tag)
	local txt = goutil.findChildTextComponent(cell, "txt")
	local img = goutil.findChild(cell, "img")

	txt.text = data.name

	GameUtil.SetActive(img, self._curFormId == data.formId)
	GameUtil.setUITextColorIdx(txt, self._curFormId == data.formId and 0 or 1)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onSelectIdx, self, data))
end

function FormpredictionrateView:_clearPetCell(cell)
	local con = goutil.findChild(cell, "con")

	GameUtil.resetAll(con)
end

function FormpredictionrateView:_updatePetCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local icon = goutil.findChild(cell, "icon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtRate = goutil.findChildTextComponent(cell, "txtRate")
	local petId = data.petId
	local petCfg = self._petMap[checknumber(petId)]

	GameUtil.SetActive(con, false)
	GameUtil.SetActive(icon, false)

	if petCfg then
		if checknumber(petCfg.raceId) > 0 then
			GameUtil.SetActive(con, true)
			MaterialMgr.setCell(MatType.Pet, petCfg.raceId, con)

			txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, petCfg.raceId)
		else
			GameUtil.SetActive(icon, true)
			uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petCfg.iconName))
		end

		if not string.nilorempty(petCfg.petName) then
			txtName.text = petCfg.petName
		end
	else
		printError(">>>>一个不存在的精灵：", petId)
	end

	txtRate.text = string.format("选取率<color=#eb4642>%.2f%%</color>", data.ratio)
end

function FormpredictionrateView:_onSelectIdx(data)
	if self._curFormId ~= data.formId then
		self._curFormId = data.formId

		self._scrollList:refresh()
		FormPredictionController.instance:sendGetRatio(self._activityId, self._curFormId)
	end
end

return FormpredictionrateView
