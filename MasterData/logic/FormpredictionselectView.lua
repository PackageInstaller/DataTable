-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/view/FormpredictionselectView.lua

module("logic.extensions.formprediction.view.FormpredictionselectView", package.seeall)

local FormpredictionselectView = class("FormpredictionselectView", ViewComponent)

function FormpredictionselectView:ctor()
	FormpredictionselectView.super.ctor(self)
end

function FormpredictionselectView:unbindEvents()
	FormpredictionselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClear)
	GameUtil.rmClickHandler(self._btnOK)
	GameUtil.rmClickHandler(self._BtnClearSearch)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnHelp)
	GameUtil.rmClickHandler(self._btnShow)

	for i, cell in ipairs(self._leftCellList) do
		local obj = self._leftDragMap[i]

		DropHandler.Get(cell.gameObject):RemoveLuaHandler(obj.dropHash)
		BeginDragHandler.Get(cell.gameObject):RemoveLuaHandler(obj.beginDragHash)
		DragHandler.Get(cell.gameObject):RemoveLuaHandler(obj.dragHash)
		EndDragHandler.Get(cell.gameObject):RemoveLuaHandler(obj.endDragHash)
	end

	self._InputC_Search:RemoveOnValueChanged()
end

function FormpredictionselectView:bindEvents()
	FormpredictionselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClear, self._onClickClear, self)
	GameUtil.addClickHandler(self._btnOK, self._onClickOK, self)
	GameUtil.addClickHandler(self._BtnClearSearch, self._onClickClearInput, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickPrizeShow, self)

	self._leftDragMap = {}

	for i, cell in ipairs(self._leftCellList) do
		local obj = {}

		obj.dropHash = DropHandler.Get(cell.gameObject):AddLuaHandler(function(_go, eventData)
			self:_onDropDownCell(_go, eventData, cell, i)
		end)
		obj.beginDragHash = BeginDragHandler.Get(cell.gameObject):AddLuaHandler(function(go, eventData)
			self:_OnDragPetBegin(go, eventData, cell, i)
		end)
		obj.dragHash = DragHandler.Get(cell.gameObject):AddLuaHandler(function(go, eventData)
			self:_OnDragPetMoved(go, eventData, cell, i)
		end)
		obj.endDragHash = EndDragHandler.Get(cell.gameObject):AddLuaHandler(function(go, eventData)
			self:_OnDragPetEnded(go, eventData, cell, i)
		end)
		self._leftDragMap[i] = obj
	end

	self._InputC_Search:AddOnValueChanged(self._onSearchValueChanged, self)
end

function FormpredictionselectView:buildUI()
	FormpredictionselectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtDesc = self:getTxt("left/txtDesc")
	self._btnOK = self:getGo("left/btnOK")
	self._btnHelp = self:getGo("left/btnHelp")
	self._btnClear = self:getGo("left/btnClear")
	self._btnSort = self:getGo("petlist/btnSort")
	self._Btn_Attr = self:getGo("petlist/Nego_Popup/Btn_Attr")
	self._SrlC_Pet = self:getGo("petlist/SrlC_Pet")
	self._Cell = self:getGo("petlist/Cell")
	self._rightcell = self:getGo("right/tablecell")
	self._txtDesc2 = self:getTxt("right/txtDesc")
	self._rightTableview = self:getGo("right/prize/tableview")
	self._txtTime = self:getTxt("txtTime/txt")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._txtApplyTime = self:getTxt("left/txtApplyTime")
	self._petlist = self:getGo("petlist")
	self._right = self:getGo("right")
	self._txtOK = self:getTxt("left/btnOK/txt")
	self._InputC_Search = self:getInput("petlist/InputC_Search")
	self._BtnClearSearch = self:getGo("petlist/InputC_Search/BtnClear")
	self._btnPrize = self:getGo("right/prize/btnPrize")
	self._empty = self:getGo("right/prize/empty")
	self._btnShow = self:getGo("left/btnShow")
	self._dragObj = self:getGo("dragObj")

	GameUtil.SetActive(self._dragObj, false)

	self._leftCellList = {}
	self._rightCellList = {}

	for i = 1, 9 do
		local cell = self:getGo("left/formation/cell_" .. i)

		table.insert(self._leftCellList, cell)

		local cell = self:getGo("right/formation/cell_" .. i)

		table.insert(self._rightCellList, cell)
	end

	self._rightScrollList = ScrollerList.create(self._rightTableview, self._rightcell, GameUtil.handler(self._updateRightCell, self), GameUtil.handler(self._clearRightCell, self))
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._petScrollList = ScrollerList.create(self._SrlC_Pet, self._Cell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollList:setDragCallBack("top", GameUtil.handler(self._onDragBegin, self), GameUtil.handler(self._onDragMove, self), GameUtil.handler(self._onDragEnd, self))
end

function FormpredictionselectView:onExit()
	FormpredictionselectView.super.onExit(self)
	self._scrollList:dispose()
	self._petScrollList:dispose()
	self._rightScrollList:dispose()
	removetimer(self._onTimer, self)
end

function FormpredictionselectView:onEnter()
	FormpredictionselectView.super.onEnter(self)

	self._activityId = 385001

	local actId = checknumber(self:getFirstParam())

	if actId > 0 then
		self._activityId = actId
	end

	local tabCfg = FormPredictionConfig.instance:getFormationListCfgById(self._activityId) or {}
	local tabList = {}

	for k, v in pairs(tabCfg) do
		table.insert(tabList, v)
	end

	ArraySort.sortOn(tabList, "formId", ArraySort.NUMERIC)

	self._curFormId = 0

	if tabList and #tabList > 0 then
		self._curFormId = tabList[1].formId
	end

	self._scrollList:reloadData(tabList)
	self.addGEvent(self, GlobalNotify.FORMPREDICTION_UPDATE, self._onRefreshUI, self)
	FormPredictionController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function FormpredictionselectView:_onRefreshUI()
	self:_refreshInfo()
end

function FormpredictionselectView:_refreshInfo()
	self._selectPosList = {}

	for i = 1, 9 do
		self._selectPosList[i] = 0
	end

	local tabCfg = FormPredictionConfig.instance:getFormationCfgById(self._activityId, self._curFormId) or {}
	local publicationTime = tabCfg.publicationTime

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

		self:_onSearchValueChanged()
		GameUtil.SetGray(self._btnClear, false)
		GameUtil.SetGray(self._btnOK, false)
		GameUtil.SetActive(self._right, false)
		GameUtil.SetActive(self._petlist, false)

		local info = FormPredictionModel.instance:getInfo(self._activityId) or {}

		if not info.formList then
			local formList = {}
			local formInfo

			for i, v in ipairs(formList) do
				if v.formId == self._curFormId then
					formInfo = v

					break
				end
			end

			self._hasPet = false

			local timestamp = 0
			local publicationPetIds = {}
			local formScore = 0
			local gainPrize = false

			if formInfo then
				formScore = checknumber(formInfo.formScore)
				timestamp = checknumber(formInfo.submitTime)
				gainPrize = formInfo.gainPrize
				publicationPetIds = formInfo.publicationPetIds

				for i, v in ipairs(formInfo.petIdsOnForm or {}) do
					if v > 0 then
						self._hasPet = true
						self._selectPosList[i] = v
					end
				end
			end

			self._hasGetPrize = gainPrize

			self:_refreshLeftForm(self._selectPosList)

			if publicationPetIds and #publicationPetIds > 0 then
				GameUtil.SetActive(self._right, true)
				self:_refreshRightForm(publicationPetIds, formScore, gainPrize)
			else
				GameUtil.SetActive(self._petlist, true)
			end

			self._txtOK.text = "提交"
			self._txtApplyTime.text = "提交后阵容不能修改!\n预测精灵正确：50分\n预测站位正确：10分"

			if self._hasPet then
				self._txtOK.text = "已提交"

				local startDate = GameUtil.time2date(timestamp / 1000)
				local timeStr = string.format("%d月%d日 %d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min)

				self._txtApplyTime.text = langPara("提交时间：%s", timeStr)
			end

			GameUtil.SetGray(self._btnClear, self._hasPet)
			GameUtil.SetGray(self._btnOK, self._hasPet)

			self._lastTime = GameUtil.string2time(publicationTime)

			removetimer(self._onTimer, self)
			settimer(1, self._onTimer, self)
			self:_onTimer()
		end
	end
end

function FormpredictionselectView:_onTimer()
	local now = ServerTime.now()
	local leftTime = math.max(0, self._lastTime - now)

	self._txtTime.text = langPara("倒计时：%s", GameUtil.FormatTimeSymbol(leftTime))

	if leftTime == 0 then
		removetimer(self._onTimer, self)
	end
end

function FormpredictionselectView:_refreshLeftForm(list)
	self._selectPetPosMap = {}

	local count = 0

	for i, cell in ipairs(self._leftCellList) do
		local con = goutil.findChild(cell, "con")
		local icon = goutil.findChild(cell, "icon")

		MaterialMgr.resetAll(con)
		GameUtil.rmClickHandler(cell)

		if self._petPosMap[i] ~= nil then
			GameUtil.SetActive(cell, true)
		else
			GameUtil.SetActive(cell, false)
		end

		GameUtil.SetActive(con, false)
		GameUtil.SetActive(icon, false)

		local petId = list[i]

		self._selectPetPosMap[petId] = i

		if checknumber(petId) > 0 and self._petMap[checknumber(petId)] then
			local petCfg = self._petMap[checknumber(petId)]

			if checknumber(petCfg.raceId) > 0 then
				GameUtil.SetActive(con, true)
				MaterialMgr.setCell(MatType.Pet, petCfg.raceId, con)
			else
				GameUtil.SetActive(icon, true)
				uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petCfg.iconName))
				GameUtil.addClickHandler(cell, function()
					CommonTipsMgr.instance:openTipsByConfStr(cell, petCfg.fakeItem)
				end)
			end

			count = count + 1
		end
	end

	self._txtDesc.text = langPara("需要放入精灵：%s/%s\n将精灵头像拖入左侧布阵即可预测", count, self._needPetCount)

	self._petScrollList:refresh()
end

function FormpredictionselectView:_refreshRightForm(list, score, hasGet)
	local count = 0

	for i, cell in ipairs(self._rightCellList) do
		local con = goutil.findChild(cell, "con")
		local icon = goutil.findChild(cell, "icon")
		local img = goutil.findChild(cell, "img")

		GameUtil.SetActive(img, false)
		MaterialMgr.resetAll(con)
		GameUtil.rmClickHandler(cell)

		if self._petPosMap[i] ~= nil then
			GameUtil.SetActive(cell, true)
		else
			GameUtil.SetActive(cell, false)
		end

		GameUtil.SetActive(con, false)
		GameUtil.SetActive(icon, false)

		local petId = list[i]

		if checknumber(petId) > 0 and self._petMap[checknumber(petId)] then
			local petCfg = self._petMap[checknumber(petId)]

			if checknumber(petCfg.raceId) > 0 then
				GameUtil.SetActive(con, true)
				MaterialMgr.setCell(MatType.Pet, petCfg.raceId, con)
			else
				GameUtil.SetActive(icon, true)
				uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petCfg.iconName))
				GameUtil.addClickHandler(cell, function()
					CommonTipsMgr.instance:openTipsByConfStr(cell, petCfg.fakeItem)
				end)
			end

			local myIdx = checknumber(self._selectPetPosMap[petId])

			if myIdx == i then
				count = count + 1

				GameUtil.SetActive(img, true)
			end
		end
	end

	self._txtDesc2.text = langPara("获得分数：%s", score)

	local arr = {}
	local cfg = FormPredictionConfig.instance:getPrizeCfgById(self._prizePlanId) or {}
	local tem = {}

	for i, v in ipairs(cfg) do
		table.insert(tem, v)
	end

	ArraySort.sortOn(tem, "prizeId", ArraySort.NUMERIC)

	for i = #tem, 1, -1 do
		if score >= tem[i].needScore then
			arr = string.split(tem[i].prize, "#")

			break
		end
	end

	self._rightScrollList:reloadData(arr)
	GameUtil.SetActive(self._empty, #arr == 0)
	GameUtil.SetActive(self._btnPrize, true)

	if hasGet then
		GameUtil.SetActive(self._btnPrize, false)
	end

	if #arr == 0 then
		GameUtil.SetActive(self._btnPrize, false)
	end
end

function FormpredictionselectView:_onClickPrizeShow()
	UIStateManager.instance:push(ViewName.FormpredictionprizeView, self._activityId, self._curFormId)
end

function FormpredictionselectView:_onClickHelp()
	UIStateManager.instance:push(ViewName.FormpredictionrateView, self._activityId, self._curFormId)
end

function FormpredictionselectView:_onClickPrize()
	FormPredictionController.instance:sendGetPrize(self._activityId, self._curFormId)
end

function FormpredictionselectView:_onClickClear()
	if self._hasPet then
		TipsFacade.instance:openCommonTips("提交后阵容不能修改")

		return
	end

	local now = ServerTime.now()
	local leftTime = math.max(0, self._lastTime - now)

	if leftTime <= 0 then
		TipsFacade.instance:openCommonTips("预测时间已过，下次再参与吧")

		return
	end

	self._selectPosList = {}

	for i = 1, 9 do
		self._selectPosList[i] = 0
	end

	self:_refreshLeftForm(self._selectPosList)
end

function FormpredictionselectView:_onClickOK()
	if self._hasPet then
		TipsFacade.instance:openCommonTips("提交后阵容不能修改")

		return
	end

	local now = ServerTime.now()
	local leftTime = math.max(0, self._lastTime - now)

	if leftTime <= 0 then
		TipsFacade.instance:openCommonTips("预测时间已过，下次再参与吧")

		return
	end

	local count = 0

	for i, v in ipairs(self._selectPosList) do
		if v > 0 then
			count = count + 1
		end
	end

	if count < self._needPetCount then
		TipsFacade.instance:openCommonTips("未放入足够的精灵进行预测，无法提交哦~")
	elseif count == self._needPetCount then
		TipsFacade.instance:openPopupWindow(lang("tip"), "是否确认提交当前阵容？提交后将无法修改！", function()
			FormPredictionController.instance:sendSetForm(self._activityId, self._curFormId, self._selectPosList)
		end)
	end
end

function FormpredictionselectView:_onClickClearInput()
	self._InputC_Search:SetText("")
end

function FormpredictionselectView:_onSearchValueChanged(searchStr)
	local searchStr = self._InputC_Search:GetText()
	local result = {}

	if not string.nilorempty(searchStr) then
		for i, v in ipairs(self._petsList) do
			local matName = ""

			matName = not string.nilorempty(v.petName) and v.petName or MaterialMgr.getMaterialsName(MatType.Pet, v.raceId)

			local cfg = {}

			if checknumber(v.raceId) > 0 then
				cfg = MaterialMgr.getMatCfg(MatType.Pet, v.raceId)
			end

			if string.find(matName, searchStr) or not string.nilorempty(cfg.searchKey) and string.find(cfg.searchKey, searchStr) then
				table.insert(result, v)
			end
		end

		self._petScrollList:reloadData(result)
	else
		self._petScrollList:reloadData(self._petsList)
	end
end

function FormpredictionselectView:_onClickTip()
	TipsFacade.instance:openRulesView("FormpredictionmainView_rule")
end

function FormpredictionselectView:_clearCell(cell)
	return
end

function FormpredictionselectView:_updateCell(view, cell, data, tag)
	local txt = goutil.findChildTextComponent(cell, "txt")
	local img = goutil.findChild(cell, "img")

	txt.text = data.name

	GameUtil.SetActive(img, self._curFormId == data.formId)
	GameUtil.setUITextColorIdx(txt, self._curFormId == data.formId and 0 or 1)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onSelectIdx, self, data))
end

function FormpredictionselectView:_clearRightCell(cell)
	local con = goutil.findChild(cell, "con")
	local effGo = goutil.findChild(cell, "eff")

	self:_clearEffect(effGo)
	MaterialMgr.resetAll(con)
end

function FormpredictionselectView:_updateRightCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local effGo = goutil.findChild(cell, "eff")
	local received = goutil.findChild(cell, "received")

	MaterialMgr.setCellByCfg(data, con)
	self:_clearEffect(effGo)
	GameUtil.SetActive(received, self._hasGetPrize)

	if not self._hasGetPrize then
		self:_playEffect(effGo)
	end
end

function FormpredictionselectView:_clearPetCell(cell)
	local con = goutil.findChild(cell, "con")
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(con)
	uGuiUtil.clearImage(icon)
end

function FormpredictionselectView:_updatePetCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local icon = goutil.findChild(cell, "icon")
	local img = goutil.findChild(cell, "img")
	local txt = goutil.findChild(cell, "img/txt")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	GameUtil.SetActive(icon, false)
	GameUtil.SetActive(con, false)
	MaterialMgr.resetAll(con)

	txtName.text = ""

	if checknumber(data.raceId) > 0 then
		GameUtil.SetActive(con, true)
		MaterialMgr.setCell(MatType.Pet, data.raceId, con)

		txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, data.raceId)
	else
		GameUtil.SetActive(icon, true)
		uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(data.iconName))
	end

	GameUtil.SetActive(img, false)

	if self._selectPetPosMap and self._selectPetPosMap[data.petId] then
		GameUtil.SetActive(img, true)
		GameUtil.setUIImageSpriteIdx(txt, checknumber(self._selectPetPosMap[data.petId]))
	end

	if not string.nilorempty(data.petName) then
		txtName.text = data.petName
	end
end

function FormpredictionselectView:_onDragBegin(eventData, data)
	if self._hasPet then
		return
	end

	GameUtil.SetActive(self._dragObj, true)

	self._dragData = data
	self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()

	if checknumber(data.raceId) > 0 then
		MaterialMgr.setIcon(self._dragObj, MatType.Pet, data.raceId)
	else
		uGuiUtil.setSpriteToImage(self._dragObj.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(data.iconName))
	end
end

function FormpredictionselectView:_onDragMove(eventData, data)
	if self._hasPet then
		return
	end

	if not self._dragObj then
		return
	end

	self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function FormpredictionselectView:_onDragEnd(eventData, data)
	self._dragData = nil

	if self._hasPet then
		return
	end

	if not self._dragObj then
		return
	end

	MaterialMgr.clearIcon(self._dragObj)
	GameUtil.SetActive(self._dragObj, false)
end

function FormpredictionselectView:_OnDragPetBegin(go, eventData, cell, idx)
	if self._hasPet then
		return
	end

	local petId = self._selectPosList[idx]
	local data = FormPredictionConfig.instance:getPetCfgById(self._petPlanId, petId)

	if data then
		GameUtil.SetActive(self._dragObj, true)

		self._dragData = data
		self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()

		if checknumber(data.raceId) > 0 then
			MaterialMgr.setIcon(self._dragObj, MatType.Pet, data.raceId)
		else
			uGuiUtil.setSpriteToImage(self._dragObj.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(data.iconName))
		end
	end
end

function FormpredictionselectView:_OnDragPetMoved(go, eventData)
	if self._hasPet then
		return
	end

	if not self._dragObj then
		return
	end

	self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function FormpredictionselectView:_OnDragPetEnded(go, eventData)
	self._dragData = nil

	if self._hasPet then
		return
	end

	if not self._dragObj then
		return
	end

	MaterialMgr.clearIcon(self._dragObj)
	GameUtil.SetActive(self._dragObj, false)
end

function FormpredictionselectView:_onDropDownCell(_go, eventData, cell, idx)
	if self._dragData then
		local petId = self._dragData.petId

		self._dragData = nil

		local lastPos = -1

		for i, v in ipairs(self._selectPosList) do
			if v == petId then
				self._selectPosList[i] = 0
				lastPos = i

				break
			end
		end

		if lastPos > 0 then
			self._selectPosList[lastPos] = self._selectPosList[idx]
		end

		self._selectPosList[idx] = petId

		self:_refreshLeftForm(self._selectPosList)
		self._scrollList:refresh()
	end
end

function FormpredictionselectView:_onSelectIdx(data)
	if self._curFormId ~= data.formId then
		self._curFormId = data.formId

		self._scrollList:refresh()
		self:_refreshInfo()
	end
end

function FormpredictionselectView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(self._rightTableview.transform) then
			eff:setClipping(self._rightTableview.transform)
		end
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function FormpredictionselectView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return FormpredictionselectView
