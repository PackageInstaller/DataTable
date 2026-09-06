-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/view/DivineMiZongClgStageView.lua

module("logic.extensions.divinemizongclg.view.DivineMiZongClgStageView", package.seeall)

local DivineMiZongClgStageView = class("DivineMiZongClgStageView", ViewComponent)

function DivineMiZongClgStageView:ctor()
	DivineMiZongClgStageView.super.ctor(self)

	self._tagPassScrollListDic = {}
	self._stageLoaders = {}
end

function DivineMiZongClgStageView:buildUI()
	DivineMiZongClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._goldBarCon = self:getGo("goldBarCon")
	self._blackMask = self:getGo("blackMask")
	self._grayMask = self:getGo("grayMask")
	self._stageScrView = self:getGo("stageCol/scrView")
	self._stageScrViewport = self:getGo("stageCol/scrView/Viewport")

	local stageContent = self:getGo("stageCol/scrView/Viewport/Content")
	local stageScrCell = self:getGo("stageCol/scrCell")

	self._rootStageScrCell = self:getGo("stageCol/scrCell/root")
	self._rootPosVec = GameUtil.getLocalPos(self._rootStageScrCell)
	self._stageScrollerList = ScrollerList.create(self._stageScrView, stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._tableview = self._stageScrView:GetComponent("UITableview")
	self._tableview.useAnchorPosition = true
	self._stageScrViewportRectWidth = GameUtil.getWidth(self._stageScrViewport)
	self._stageScrViewportRectWidthOffest = 850
	self._infoCol = self:getGo("infoCol")
	self._infoColCanvas = self._infoCol:GetComponent(ComponentType.Canvas)
	self._txtStage = self:getTxt("infoCol/txtStage")
	self._imgPass = self:getGo("infoCol/fmt/imgPass")
	self._fmtView = self:getGo("infoCol/fmt/fmtView")

	local infoPassScrView = self:getGo("infoCol/passCol/scrView")
	local infoPassScrCell = self:getGo("infoCol/passCol/scrCell")

	self._infoPassScrollerList = ScrollerList.create(infoPassScrView, infoPassScrCell, GameUtil.handler(self._updateInfoPassCell, self), GameUtil.handler(self._clearInfoPassCell, self))

	local infoPrizeScrView = self:getGo("infoCol/prizeCol/scrView")
	local infoPrizeScrCell = self:getGo("infoCol/prizeCol/scrCell")

	self._infoPrizeScrollerList = ScrollerList.create(infoPrizeScrView, infoPrizeScrCell, GameUtil.handler(self._updateInfoPrizeCell, self), GameUtil.handler(self._clearInfoPrizeCell, self))
	self._btnEnter = self:getGo("infoCol/btnEnter")
	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollerClipGo = self:getGo("prizeCol/scrView/Viewport")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = self:getGo("prizeCol/total")
	self._prizeCol_total_txtNum = self:getTxt("prizeCol/total/txtNum")
	self._prizeCol_total_icon = self:getGo("prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._btnBuff = self:getGo("prizeCol/btnBuff")
	self._redBtnBuff = self:getGo("prizeCol/btnBuff/redPoint")
	self._nearBg1 = self:getGo("dynamicBg/nearBg1"):GetComponent(goutil.Type_UIImage)
	self._middleBg2 = self:getGo("dynamicBg/middleBg2"):GetComponent(goutil.Type_UIImage)
	self._farBg3 = self:getGo("dynamicBg/farBg3"):GetComponent(goutil.Type_UIImage)
	self._imgGos = {
		self._nearBg1.gameObject,
		self._middleBg2.gameObject,
		self._farBg3.gameObject
	}
	self._nearImageBigBG = self._nearBg1.gameObject:GetComponent("ImageBigBG")
	self._middleImageBigBG = self._middleBg2.gameObject:GetComponent("ImageBigBG")
	self._farImageBigBG = self._farBg3.gameObject:GetComponent("ImageBigBG")
	self._scrollAdapter = Framework.ScrollRectAdapter.Get(self._tableview.gameObject)
	self._scrollRectTransform = self._tableview.gameObject:GetComponent(goutil.Type_RectTransform)
	self._contentRectTransform = stageContent:GetComponent(goutil.Type_RectTransform)
	self._nearBgRectTrans = self._nearBg1:GetComponent(goutil.Type_RectTransform)
end

function DivineMiZongClgStageView:bindEvents()
	DivineMiZongClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._grayMask, self._onClickGrayMask, self)
	self._scrollAdapter:AddOnValueChanged(self._onScrollValueChanged, self)

	self._pointerClickHandler = PointerClickHandler.Get(self._stageScrViewport):AddLuaHandler(function(_go, eventData)
		self:_onPointerClickHandler(_go, eventData)
	end)
end

function DivineMiZongClgStageView:unbindEvents()
	DivineMiZongClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._grayMask)
	self._scrollAdapter:RemoveOnValueChanged()
	PointerClickHandler.Get(self._stageScrViewport):RemoveLuaHandler(self._pointerClickHandler)
end

function DivineMiZongClgStageView:onEnter()
	DivineMiZongClgStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._clgMo = DivineMiZongClgController.instance:getClgMo(self._activityId)
	self._actData = DivineMiZongClgConfig.instance:getActData(self._activityId)
	self._newStarStageId = 0

	self:_loadDynamicBg()

	self._curStageId = self._curStageId or 0

	local cfg = DivineMiZongClgConfig.instance:getStageCfg(self._activityId) or {}

	self._curStageId = Mathf.Min(self._curStageId, #cfg)
	self._infoColCanvas.overrideSorting = true
	self._infoColCanvas.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + 2

	local list = {}
	local tab = {
		showAdd = false,
		id = DivineMiZongClgConfig.instance:getUpgradeItem(self._activityId)
	}

	table.insert(list, tab)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiZongClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiZongClgGainPrizeRes, self._onUpdate, self)
	self:_onUpdate()
	RedPointController.instance:regRedPoint(self._redBtnBuff, RedPointModel.ID_DIVINEMIZONGCLG_BUFFUPDATE)
	DivineMiZongClgController.instance:sendPM_DivineMiZongClgGetInfoReq(self._activityId)
end

function DivineMiZongClgStageView:onExit()
	DivineMiZongClgStageView.super.onExit(self)

	self._infoColCanvas.overrideSorting = false

	RedPointController.instance:unregRedPoint(self._redBtnBuff)
	self:_removeDynamicBg()
	self:_onClearStageCol()
	self:_onClearInfoCol()
	self:_onClearPrizeCol()
end

function DivineMiZongClgStageView:_loadDynamicBg()
	local fields = DivineMiZongClgEnum.StageBgFields

	for idx, field in ipairs(fields) do
		local bgName = self._actData[field]

		if not string.nilorempty(bgName) then
			local url = string.format("ui/bigbg/%s.png", bgName)
			local imgGo = self._imgGos[idx]

			uGuiUtil.setSpriteToImage(imgGo, uGuiUtil.SpriteType.BigBg, url)
		end
	end

	self._nearBgMat1 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._middleBgMat2 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._nearBg1.material = self._nearBgMat1
	self._middleBg2.material = self._middleBgMat2

	self._nearImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
	self._middleImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
end

function DivineMiZongClgStageView:_removeDynamicBg()
	for k, v in pairs(self._imgGos) do
		uGuiUtil.clearImage(v)
	end

	self._nearBg1.material = nil
	self._middleBg2.material = nil

	goutil.destroy(self._nearBgMat1)
	goutil.destroy(self._middleBgMat2)

	self._nearBgMat1 = nil
	self._middleBgMat2 = nil
end

function DivineMiZongClgStageView:_onScrollValueChanged(vec2)
	if not self._nearBgMat1 or not self._middleBgMat2 then
		return
	end

	if goutil.getWidth(self._contentRectTransform) < goutil.getWidth(self._scrollRectTransform) then
		self._nearBgMat1:SetTextureOffset("_MainTex", Vector2.zero)
		self._middleBgMat2:SetTextureOffset("_MainTex", Vector2.zero)
	else
		self._nearBgWidth = goutil.getWidth(self._nearBgRectTrans)

		local percentPos = self._contentRectTransform.anchoredPosition.x / self._nearBgWidth

		percentPos = -1 * percentPos
		vec2.x = percentPos
		vec2.y = 0

		self._nearBgMat1:SetTextureOffset("_MainTex", vec2)
		self._middleBgMat2:SetTextureOffset("_MainTex", vec2 * 0.8)
	end
end

function DivineMiZongClgStageView:_onUpdate()
	self:_onUpdateStageColUI()
	self:_onUpdateInfoColUI()
	self:_onUpdatePrizeCol()
end

function DivineMiZongClgStageView:_onUpdateStageColUI()
	local cfg = DivineMiZongClgConfig.instance:getStageCfg(self._activityId) or {}
	local index = 1
	local minStar = 99999

	self._newStarStageId = 0

	for idx, data in ipairs(cfg) do
		local stageId = data.stageId
		local star = self._clgMo:getStageStart(stageId)

		if star == 0 then
			self._newStarStageId = stageId
			index = idx

			break
		elseif star <= minStar then
			minStar = star
			index = idx
		end
	end

	self._stageScrollerList:reloadData(cfg)

	if self._curStageId <= 0 then
		self._stageScrollerList:MoveCellToCenter(index - 1)
	end
end

function DivineMiZongClgStageView:_onUpdateStageColUIOffest()
	local stageData = DivineMiZongClgConfig.instance:getStageData(self._activityId, self._curStageId)

	if stageData then
		if not self._stageScrViewportRectWidthOffest then
			local width = self._stageScrViewportRectWidth

			if width ~= GameUtil.getWidth(self._stageScrViewport) then
				GameUtil.setWidth(self._stageScrViewport, width)
				self._stageScrollerList:refresh()
			end

			if self._curStageId > 0 then
				self._stageScrollerList:MoveCellInView(Mathf.Max(0, self._curStageId - 1), false)
			end
		end
	end
end

function DivineMiZongClgStageView:_onClearStageCol()
	self._lastCanvas = nil

	self._stageScrollerList:dispose()
end

function DivineMiZongClgStageView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local startPrizeCfg = DivineMiZongClgConfig.instance:getStartPrizeCfg(self._activityId, stageId) or {}
	local isUnlock = self._clgMo:isUnlockStage(stageId)
	local star = self._clgMo:getStageStart(stageId)
	local index = cell.index
	local mainGo = cell.gameObject
	local canvas = mainGo:GetComponent(ComponentType.Canvas)
	local root = goutil.findChild(mainGo, "root")
	local txtName = goutil.findChildTextComponent(root, "txtName")
	local role = goutil.findChild(root, "role")
	local tagLock = goutil.findChild(root, "tagLock")
	local tagNew = goutil.findChild(root, "tagNew")
	local tagPassScrView = goutil.findChild(root, "tagPass/scrView")
	local tagPassScrCell = goutil.findChild(root, "tagPass/scrCell")
	local btnSelect = goutil.findChild(root, "btnSelect")

	GameUtil.SetActive(mainGo, true)

	if self._curStageId == stageId then
		if self._lastStageId ~= self._curStageId then
			local list = self._stageScrollerList:getData()

			if list then
				for i, v in ipairs(list) do
					if v.stageId == self._lastStageId then
						self._stageScrollerList:updateCellInViewByIndex(i - 1)

						break
					end
				end
			end
		end

		self._lastStageId = self._curStageId
		canvas.overrideSorting = true
		canvas.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + 1
	else
		canvas.overrideSorting = false
	end

	GameUtil.setLocalPos(root, self._rootPosVec.x, (index % 2 == 1 or nil) and (self._rootPosVec.y + 112 or self._rootPosVec.y), self._rootPosVec.z)

	txtName.text = string.format("第%s关", stageId)

	GameUtil.SetActive(tagLock, not isUnlock)
	GameUtil.SetActive(tagNew, stageId == self._newStarStageId and star <= 0)

	local loader = self._stageLoaders[mainGo]

	self._stageLoaders[mainGo] = RoleObjectPool.instance:addRoleToParent(loader, data.skinId, role, 1, nil, false, 0, 0)

	local infoList = {}

	for i, v in ipairs(startPrizeCfg) do
		table.insert(infoList, {
			stageId = stageId,
			data = v
		})
	end

	if not self._tagPassScrollListDic[mainGo] then
		local scrollList = ScrollerList.create(tagPassScrView, tagPassScrCell, GameUtil.handler(self._updateTagPassCell, self), GameUtil.handler(self._clearTagPassCell, self))

		self._tagPassScrollListDic[mainGo] = scrollList

		scrollList:setCenterMode(true)
		scrollList:dragNotifyParent()
		scrollList:reloadData(infoList)
		GameUtil.addClickHandler(btnSelect, function()
			if not isUnlock then
				FloatWordMgr.instance:show("未解锁")

				return
			end

			self._curStageId = stageId == self._curStageId and 0 or stageId

			local list = self._stageScrollerList:getData()

			if list then
				for i, v in ipairs(list) do
					if v.stageId == stageId then
						self._stageScrollerList:updateCellInViewByIndex(i - 1)

						break
					end
				end
			end

			self:_onUpdateInfoColUI()
			self:_onUpdateStageColUIOffest()
		end, self)
	end
end

function DivineMiZongClgStageView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local root = goutil.findChild(mainGo, "root")
	local role = goutil.findChild(root, "role")
	local btnSelect = goutil.findChild(root, "btnSelect")
	local loader = self._stageLoaders[mainGo]

	if loader then
		self._stageLoaders[mainGo] = RoleObjectPool.instance:removeRole(loader)
	end

	local scrollList = self._tagPassScrollListDic[mainGo]

	if scrollList then
		scrollList:dispose()

		self._tagPassScrollListDic[mainGo] = nil
	end

	GameUtil.rmClickHandler(btnSelect)
end

function DivineMiZongClgStageView:_updateTagPassCell(view, cell, info, tag)
	local stageId = info.stageId
	local data = info.data
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local star = self._clgMo:getStageStart(stageId)

	GameUtil.setUIGroupIdx(mainGo, star >= data.star and 1 or 0)
end

function DivineMiZongClgStageView:_clearTagPassCell(cell)
	return
end

function DivineMiZongClgStageView:_onUpdateInfoColUI()
	local stageId = self._curStageId
	local stageData = DivineMiZongClgConfig.instance:getStageData(self._activityId, stageId)
	local isEmptyStage = stageData == nil

	GameUtil.SetActive(self._infoCol, not isEmptyStage)
	GameUtil.SetActive(self._blackMask, not isEmptyStage)
	GameUtil.SetActive(self._grayMask, not isEmptyStage)

	if isEmptyStage then
		self._curStageId = 0

		self:_onClearInfoCol()

		return
	end

	local creepsMasterId = stageData.creepsMasterId
	local creepsCfg = DivineMiZongClgConfig.instance:getCreepsCfg(creepsMasterId) or {}

	self._txtStage.text = string.format("第%s关", stageId)

	for posId = 1, self._fmtView.transform.childCount do
		local go = self._fmtView.transform:GetChild(posId - 1)
		local mask = goutil.findChild(go, "mask")
		local icon = goutil.findChild(go, "mask/icon")
		local creepsData

		for _, cData in ipairs(creepsCfg) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		GameUtil.SetActive(mask, creepsData ~= nil)

		if creepsData then
			local petMo = FightingPowerPetMo.New()

			petMo:fromChallengeCreepCo(creepsData, creepsCfg)

			petMo.creepName = creepsData.creepName

			MaterialMgr.setIcon(icon, MatType.Pet, petMo.curFaceId)
			GameUtil.addClickHandler(go, function()
				CommonTipsMgr.instance:showPetTips(petMo)
			end)
		else
			MaterialMgr.clearIcon(icon)
		end
	end

	local startPrizeCfg = DivineMiZongClgConfig.instance:getStartPrizeCfg(self._activityId, stageId) or {}
	local infoList = {}

	for i, v in ipairs(startPrizeCfg) do
		table.insert(infoList, {
			stageId = stageId,
			data = v
		})
	end

	self._infoPassScrollerList:reloadData(infoList)

	local prizeList = {}

	for _, data in ipairs(startPrizeCfg) do
		if not string.nilorempty(data.firstPassPrize) then
			local arr = string.split(data.firstPassPrize, "#")

			table.insertto(prizeList, arr)
		end
	end

	self._infoPrizeScrollerList:reloadData(prizeList)
end

function DivineMiZongClgStageView:_onClearInfoCol()
	for posId = 1, self._fmtView.transform.childCount do
		local go = self._fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "mask/icon")

		MaterialMgr.clearIcon(icon)
		GameUtil.rmClickHandler(go)
	end

	self._infoPassScrollerList:dispose()
	self._infoPrizeScrollerList:dispose()
end

function DivineMiZongClgStageView:_getInfoColVisuable()
	return GameUtil.GetActive(self._infoCol)
end

function DivineMiZongClgStageView:_updateInfoPassCell(view, cell, info, tag)
	local stageId = info.stageId
	local data = info.data
	local mainGo = cell.gameObject
	local passTag = goutil.findChild(mainGo, "passTag")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local star = self._clgMo:getStageStart(stageId)

	GameUtil.setUIGroupIdx(mainGo, star >= data.star and 1 or 0)

	txtDesc.text = data.gainStarDecs
end

function DivineMiZongClgStageView:_clearInfoPassCell(cell)
	return
end

function DivineMiZongClgStageView:_updateInfoPrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function DivineMiZongClgStageView:_clearInfoPrizeCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function DivineMiZongClgStageView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress
end

function DivineMiZongClgStageView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
end

function DivineMiZongClgStageView:_getProgressDataList()
	return DivineMiZongClgConfig.instance:getProgressPrizeCfg(self._activityId) or {}
end

function DivineMiZongClgStageView:_getSliderComp()
	return self._sliderComp
end

function DivineMiZongClgStageView:_getScrollClipGo()
	return self._prizeScrollerClipGo
end

function DivineMiZongClgStageView:_getCurProgress()
	return self._clgMo:getTotalStar()
end

function DivineMiZongClgStageView:_getProgressByData(data)
	return data.starProgress
end

function DivineMiZongClgStageView:_getPrizeIdByData(data)
	return data.prizeId
end

function DivineMiZongClgStageView:_getPrizeStrByData(data)
	return data.prize
end

function DivineMiZongClgStageView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._clgMo:isHasGainPrize(prizeId)
end

function DivineMiZongClgStageView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._clgMo:isEnoughGetPrize(prizeId)
end

function DivineMiZongClgStageView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._clgMo:isCanGetPrize(prizeId)
end

function DivineMiZongClgStageView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local clipGo = self:_getScrollClipGo()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtScore then
		txtScore.text = progress
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	if isCanGet then
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, clipGo, true, nil)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function DivineMiZongClgStageView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function DivineMiZongClgStageView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	DivineMiZongClgController.instance:sendPM_DivineMiZongClgGainPrizeReq(self._activityId, prizeId)
end

function DivineMiZongClgStageView:_onClickBtnEnter()
	if self._curStageId > 0 then
		DivineMiZongClgController.instance:enterBattle(self._activityId, self._curStageId)
	end
end

function DivineMiZongClgStageView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineMiZongClgStageView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.DivineMiZongClgBuffView, self._activityId)
end

function DivineMiZongClgStageView:_onPointerClickHandler(go, eventData)
	self:_onClickGrayMask()
end

function DivineMiZongClgStageView:_onClickGrayMask()
	local list = self._stageScrollerList:getData()

	if list then
		for i, v in ipairs(list) do
			if v.stageId == self._curStageId then
				self._stageScrollerList:updateCellInViewByIndex(i - 1)

				break
			end
		end
	end

	self._curStageId = 0

	self:_onUpdateInfoColUI()
	self:_onUpdateStageColUIOffest()
end

return DivineMiZongClgStageView
