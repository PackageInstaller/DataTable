-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularityVersionLoginDetailView.lua

module("logic.extensions.popularitylist.view.PopularityVersionLoginDetailView", package.seeall)

local PopularityVersionLoginDetailView = class("PopularityVersionLoginDetailView", ViewComponent)

function PopularityVersionLoginDetailView:buildUI()
	PopularityVersionLoginDetailView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._con = goutil.findChild(self.mainGO, "mask/con")
	self._noLogin = goutil.findChild(self.mainGO, "noLogin")
	self._canGain = goutil.findChild(self.mainGO, "canGain")
	self._btnLeft = goutil.findChild(self.mainGO, "btnLeft")
	self._btnRight = goutil.findChild(self.mainGO, "btnRight")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")

	local petScrollerview = goutil.findChild(self.mainGO, "petCol/petScrollerview")
	local petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")

	self._petScrollList = ScrollerList.create(petScrollerview, petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	local skinScrollerview = goutil.findChild(self.mainGO, "skinCol/skinScrollerview")
	local skinScrollercell = goutil.findChild(self.mainGO, "skinCol/skinScrollercell")

	self._skinScrollList = ScrollerList.create(skinScrollerview, skinScrollercell, GameUtil.handler(self._updateSkinCell, self), GameUtil.handler(self._clearSkinCell, self))
	self._prizeCol = goutil.findChild(self.mainGO, "prizeCol")
	self._prizeCol_cell = goutil.findChild(self.mainGO, "prizeCol/cell")
	self._prizeCol_cell_icon = goutil.findChild(self.mainGO, "prizeCol/cell/icon")
	self._prizeCol_cell_icon_piece_tag = goutil.findChild(self.mainGO, "prizeCol/cell/pieceTag")
	self._prizeCol_cell_received = goutil.findChild(self.mainGO, "prizeCol/cell/received")
	self._prizeCol_txtCount = goutil.findChildTextComponent(self.mainGO, "prizeCol/count/txt")
	self._prizeCol_cell_xuanzhuanEff = goutil.findChild(self.mainGO, "prizeCol/cell/xuanzhuanEff")
	self._prizeCol_cell_dianliangEff = goutil.findChild(self.mainGO, "prizeCol/cell/dianliangEff")
end

function PopularityVersionLoginDetailView:bindEvents()
	PopularityVersionLoginDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._prizeCol_cell, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._onClickChangeVersion, self, -1))
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._onClickChangeVersion, self, 1))
end

function PopularityVersionLoginDetailView:unbindEvents()
	PopularityVersionLoginDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._prizeCol_cell)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function PopularityVersionLoginDetailView:onEnter()
	PopularityVersionLoginDetailView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._versionId = checknumber(params[2])
	self._activityType = PopularityListController.instance:getCurActivityType()

	local isInTime = PopularityListController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._versionData = PopularityListConfig.instance:getPlYearVersionData(self._activityId, self._versionId)

	self.addGEvent(self, GlobalNotify.PopularityListGetSkinVoteCountsRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PopularityListSkinVoteGainYearVersionPrizeRes, self._sendInfoReq, self)
	self:_onSetUI()
	self:_onUpdate()
end

function PopularityVersionLoginDetailView:onExit()
	PopularityVersionLoginDetailView.super.onExit(self)
	self:_onClear()
end

function PopularityVersionLoginDetailView:_sendInfoReq()
	PopularityListController.instance:sendPM_GetSkinVoteCountsReq(self._activityId)
end

function PopularityVersionLoginDetailView:_onSetUI()
	return
end

function PopularityVersionLoginDetailView:_onUpdate()
	self._versionData = PopularityListConfig.instance:getPlYearVersionData(self._activityId, self._versionId)

	if self._versionData == nil then
		self:_onClear()

		return
	end

	self:_onUpdatePlaneUI()
	self:_onUpdatePetColUI()
	self:_onUpdateSkinColUI()
	self:_onUpdatePrizeColUI()
	self:_onUpdateChangeBtnColUI()
end

function PopularityVersionLoginDetailView:_onClear()
	self:_clearPlaneUI()
	self:_clearPetColUI()
	self:_clearSkinColUI()
	self:_clearPrizeColUI()
end

function PopularityVersionLoginDetailView:_onUpdatePlaneUI()
	self._txtTitle.text = self._versionData.versionName

	self:_loadBigBg(self._con, self._versionData.showImgPath)
end

function PopularityVersionLoginDetailView:_clearPlaneUI()
	self:_unLoadBigBg(self._con)
end

function PopularityVersionLoginDetailView:_onUpdatePetColUI()
	local list = {}

	if self._versionData.skinIdListOfStrong then
		table.insertto(list, self._versionData.skinIdListOfStrong)
	end

	self._petScrollList:reloadData(list)
end

function PopularityVersionLoginDetailView:_clearPetColUI()
	self._petScrollList:dispose()
end

function PopularityVersionLoginDetailView:_updatePetCell(view, cell, skinId, tag)
	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)
	local isHave = HandbookModel.instance:isHasPet(raceId)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")

	MaterialMgr.setIcon(icon, MatType.PET_SKIN, skinId, nil, nil)
	GameUtil.SetGray(icon, not isHave)

	local function callBack()
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, skinId)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end

	GameUtil.addClickHandler(mainGo, callBack)
end

function PopularityVersionLoginDetailView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")

	MaterialMgr.resetAll(icon)
	GameUtil.rmClickHandler(mainGo)
end

function PopularityVersionLoginDetailView:_onUpdateSkinColUI()
	local list = {}

	if self._versionData.skinIdListOfSkin then
		table.insertto(list, self._versionData.skinIdListOfSkin)
	end

	self._skinScrollList:reloadData(list)
end

function PopularityVersionLoginDetailView:_clearSkinColUI()
	self._skinScrollList:dispose()
end

function PopularityVersionLoginDetailView:_updateSkinCell(view, cell, skinId, tag)
	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)
	local cfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, skinId)

	if cfg then
		::label_20_0::

		local isHave = true
		local isHave

		if MaterialModel.instance:getMaterialsNumber(MatType.PET_SKIN, skinId) <= 0 then
			isHave = false
		end

		local mainGo = cell.gameObject
		local icon = goutil.findChild(mainGo, "mask/icon")

		MaterialMgr.setIcon(icon, MatType.PET_SKIN, skinId, nil, nil)
		GameUtil.SetGray(icon, not isHave)

		local function callBack()
			local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, skinId)

			CommonTipsMgr.instance:showPetTips(tmpMo, true)
		end

		GameUtil.addClickHandler(mainGo, callBack)
	end
end

function PopularityVersionLoginDetailView:_clearSkinCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")

	MaterialMgr.resetAll(icon)
	GameUtil.rmClickHandler(mainGo)
end

function PopularityVersionLoginDetailView:_onUpdatePrizeColUI()
	local isVersionLogin = PopularityListController.instance:isVersionLogin(self._activityId, self._versionId)
	local isHasGain = PopularityListController.instance:isHasGainLoginVersionPrize(self._activityId, self._versionId)
	local isCanGain = PopularityListController.instance:isCanGetPrizeOfLoginVersion(self._activityId, self._versionId)
	local matType, matId, matNum = MaterialMgr.getMatParams(self._versionData.loginPrize)
	local matCfg = MaterialMgr.getMatCfg(matType, matId)
	local isPiece = matCfg and checknumber(matCfg.subType) == MatType.Item_Piece or false

	MaterialMgr.setIcon(self._prizeCol_cell_icon, matType, matId, nil, nil)

	self._prizeCol_txtCount.text = matNum

	GameUtil.SetActive(self._prizeCol_cell_icon_piece_tag, isPiece)
	GameUtil.SetActive(self._prizeCol_cell_received, isHasGain)
	GameUtil.SetActive(self._prizeCol_cell_xuanzhuanEff, isCanGain)
	GameUtil.SetActive(self._prizeCol_cell_dianliangEff, isCanGain)
	GameUtil.SetActive(self._noLogin, not isVersionLogin)
	GameUtil.SetActive(self._canGain, isVersionLogin)

	if isCanGain then
		self:_playDianliangEffect(function()
			self:_playXuanzhuanEffect()
		end)
	else
		self:_stopDianliangEffect()
		self:_stopXuanzhuanEffect()
	end
end

function PopularityVersionLoginDetailView:_clearPrizeColUI()
	MaterialMgr.clearIcon(self._prizeCol_cell_icon)
	UIEffectManager.instance:stopEffect(self._prizeEff)
end

function PopularityVersionLoginDetailView:_onClickPrize()
	local result, tips = PopularityListController.instance:getGainLoginVersionPrizeResultAndTips(self._activityId, self._versionId)

	if result ~= GameEnum.ResultCode.Success then
		local matType, matId, matNum = MaterialMgr.getMatParams(self._versionData.loginPrize)

		CommonTipsMgr.instance:openMaterialTips(self._prizeCol_cell, matType, matId, matNum)
	else
		PopularityListController.instance:sendPM_GainYearVersionPrizeReq(self._activityId, self._versionId)
	end
end

function PopularityVersionLoginDetailView:_playDianliangEffect(_finishHandler)
	self._dianliangEffPlaying = self._dianliangEffPlaying or false

	if self._dianliangEffPlaying == true then
		return
	end

	local effParent = self._prizeCol_cell_dianliangEff
	local pathName = "20231222/nianzhongpandian/fx_ui_nianzhong_dianliang"

	self:_stopDianliangEffect()

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			GameUtil.callBack(_finishHandler, handlerTarget, eff)

			self._dianliangEffPlaying = false
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._dianliangEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function PopularityVersionLoginDetailView:_stopDianliangEffect()
	UIEffectManager.instance:stopEffect(self._dianliangEff)

	self._dianliangEffPlaying = false
end

function PopularityVersionLoginDetailView:_playXuanzhuanEffect()
	local effParent = self._prizeCol_cell_xuanzhuanEff
	local pathName = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan"

	self:_stopXuanzhuanEffect()

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._xuanzhuanEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function PopularityVersionLoginDetailView:_stopXuanzhuanEffect()
	UIEffectManager.instance:stopEffect(self._xuanzhuanEff)
end

function PopularityVersionLoginDetailView:_onUpdateChangeBtnColUI()
	local minVersion = PopularityListController.instance:getMinVersionId(self._activityId)
	local maxVersion = PopularityListController.instance:getMaxVersionId(self._activityId)

	GameUtil.SetActive(self._btnLeft, minVersion < self._versionId)
	GameUtil.SetActive(self._btnRight, maxVersion > self._versionId)
end

function PopularityVersionLoginDetailView:_onClickChangeVersion(delta)
	local minVersion = PopularityListController.instance:getMinVersionId(self._activityId)
	local maxVersion = PopularityListController.instance:getMaxVersionId(self._activityId)

	self._versionId = Mathf.Clamp(self._versionId + delta, minVersion, maxVersion)

	self:_onUpdate()
end

function PopularityVersionLoginDetailView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function PopularityVersionLoginDetailView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

return PopularityVersionLoginDetailView
