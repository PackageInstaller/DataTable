-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectingskinmainView.lua

module("logic.extensions.collectingskin.view.CollectingskinmainView", package.seeall)

local CollectingskinmainView = class("CollectingskinmainView", ViewComponent)

function CollectingskinmainView:buildUI()
	CollectingskinmainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._cellSkin = self:getGo("cell")
	self._tabSkin = self:getGo("tableview")
	self._tableviewSkin = ScrollerList.create(self._tabSkin, self._cellSkin, GameUtil.handler(self._updateSkinCell, self), GameUtil.handler(self._clearSkinCell, self))

	self._tableviewSkin:setCenterMode(true)

	self._txtTime = self:getTxt("time/txtTime")
	self._txtCollectingNum = self:getTxt("collectingNum/txtNum")
	self._progressBar = self:getSlider("progress/tableview/Viewport/Content/progressBar")

	local cellProgress = self:getGo("progress/cell")
	local tabProgress = self:getGo("progress/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
end

function CollectingskinmainView:bindEvents()
	CollectingskinmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
end

function CollectingskinmainView:unbindEvents()
	CollectingskinmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnTip)
end

function CollectingskinmainView:onEnter()
	CollectingskinmainView.super.onEnter(self)

	self._curActId = checkint(self:getFirstParam())

	if self._curActId and not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.CollectingSkin, self._curActId) then
		return
	end

	self._subMo = CollectingSkinController.instance:getSubMo(self._curActId)
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._curActId)

	self.addGEvent(self, GlobalNotify.CollectingSkinGetInfo, self._onGetInfo, self)
	self.addGEvent(self, GlobalNotify.CollectingSkinGainProgressPrize, self._onGainPrize, self)
	self.addGEvent(self, GlobalNotify.CollectingSkinGainSkinPrize, self._updateTableviewSkin, self)
	self:_refreshByCfgs()
	CollectingSkinController.instance:getInfo(self._curActId)
end

function CollectingskinmainView:onExit()
	CollectingskinmainView.super.onExit(self)
	self._tableviewSkin:dispose()
	self._tableviewProgress:dispose()
end

function CollectingskinmainView:_refreshByCfgs()
	self._skinCfgs = CollectingSkinConfig.instance:getSkinCfgs(self._curActId)
	self._progressCfgs = CollectingSkinConfig.instance:getProgressCfgs(self._curActId)
end

function CollectingskinmainView:_onGetInfo()
	self:_updateTableviewSkin()
	self:_onGainPrize()
end

function CollectingskinmainView:_onGainPrize()
	self._txtCollectingNum.text = self._curOwnNow

	self._tableviewProgress:reloadData(self._progressCfgs)

	local scoreList = {}

	for i, v in ipairs(self._progressCfgs) do
		table.insert(scoreList, v.progress)
	end

	self._tableviewProgress:updateUnderSlider(self._progressBar, self._curOwnNow, scoreList)
end

function CollectingskinmainView:_updateTableviewSkin()
	self._timeStampNow = ServerTime.now()
	self._curOwnNow = 0

	local temTable = {}

	for _, cfg in pairs(self._skinCfgs) do
		if MaterialModel.instance:getMaterialsNumber(MatType.PET_SKIN, cfg.skinId) > 0 then
			self._curOwnNow = self._curOwnNow + 1
		end

		table.insert(temTable, cfg)
	end

	table.sort(temTable, function(a, b)
		local endTimeA = GameUtil.string2time(a.endTime)
		local endTimeB = GameUtil.string2time(b.endTime)

		if endTimeA <= self._timeStampNow and endTimeB <= self._timeStampNow then
			return a.sortId < b.sortId
		elseif endTimeA > self._timeStampNow and endTimeB <= self._timeStampNow then
			return true
		elseif endTimeA <= self._timeStampNow and endTimeB > self._timeStampNow then
			return false
		elseif endTimeA > self._timeStampNow and endTimeB > self._timeStampNow then
			return a.sortId < b.sortId
		end

		return false
	end)
	self._tableviewSkin:reloadData(temTable)
end

function CollectingskinmainView:_updateSkinCell(view, cellGo, data)
	local cell = self:_clearSkinCell(cellGo)

	cell.txtName.text = data.desc

	local startTime = GameUtil.string2time(data.startTime)
	local endTime = GameUtil.string2time(data.endTime)

	goutil.setActive(cell.btnGoto, false)

	if startTime <= self._timeStampNow and endTime > self._timeStampNow then
		goutil.setActive(cell.openTime, false)
		goutil.setActive(cell.btnGoto, true)
	elseif startTime > self._timeStampNow then
		goutil.setActive(cell.openTime, true)

		local dayNum = math.ceil((startTime - self._timeStampNow) / 86400)

		cell.txtOpenTime.text = string.format("%s天后开始", dayNum)
	elseif endTime <= self._timeStampNow then
		goutil.setActive(cell.openTime, true)

		cell.txtOpenTime.text = "已结束"
	end

	local isHave = MaterialModel.instance:getMaterialsNumber(MatType.PET_SKIN, data.skinId) > 0

	GameUtil.setUIImageColorIdx(cell.role, isHave and 0 or 1)
	goutil.setActive(cell.noGet, not isHave)
	goutil.setActive(cell.goRoleBlack, not isHave)
	GameUtil.addClickHandler(cell.btnBook, GameUtil.handler(self._onClickSkinBook, self, data.skinId, data.isPet))
	GameUtil.addClickHandler(cell.btnGoto, GameUtil.handler(self._onClickGoto, self, data.skinId, data.isPet))
	GameUtil.SetActive(cell.btnPlay, false)

	if checknumber(data.storyId) > 0 then
		cell.txtStroyName.text = data.storyName

		GameUtil.SetActive(cell.btnPlay, true)
		GameUtil.addClickHandler(cell.btnPlay, GameUtil.handler(self._onClickPlayStroy, self, data))
	end

	if not string.nilorempty(data.bgPath) then
		local imgPath = GameUrl.getBigbgFolderUrl("collectingrace", data.bgPath)

		uGuiUtil.setSpriteToImage(cell.role, uGuiUtil.SpriteType.BigBg, imgPath)
	else
		uGuiUtil.clearImage(cell.role)
	end

	if not string.nilorempty(data.bgBlackPath) then
		local imgPathBlack = GameUrl.getBigbgFolderUrl("collectingrace", data.bgBlackPath)

		uGuiUtil.setSpriteToImage(cell.goRoleBlack, uGuiUtil.SpriteType.BigBg, imgPathBlack)
	else
		uGuiUtil.clearImage(cell.goRoleBlack)
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(data.skinId) % 10 - 1

	GameUtil.getUIImageSpriteChange(cell.attrObj):SetState(race)

	if not string.nilorempty(data.prize) then
		GameUtil.SetActive(cell.prizeGo, true)
		MaterialMgr.setCellByCfg(data.prize, cell.prizeItem)

		local isHasGain = self._subMo:isHasGainPrizeInSkin(data.skinId)
		local isCanGet = self._subMo:isCanGetPrizeInSkin(data.skinId)

		GameUtil.SetActive(cell.tagHasGainPrize, isHasGain)
		GameUtil.SetActive(cell.btnGetPrize, isCanGet)

		if isCanGet then
			self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.effectRootPrize, nil, true, nil, nil)
		else
			self:stopViewEffectUniGo(cell.effectRootPrize)
		end

		GameUtil.addClickHandler(cell.btnGetPrize, function()
			if isCanGet then
				CollectingSkinController.instance:gainSkinPrize(self._curActId, data.skinId)
			end
		end, self)
	else
		GameUtil.SetActive(cell.prizeGo, false)
		self:stopViewEffectUniGo(cell.effectRootPrize)
		MaterialMgr.resetAll(cell.prizeItem)
	end
end

function CollectingskinmainView:_clearSkinCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.container = goutil.findChild(cell.go, "container")
	cell.role = goutil.findChild(cell.container, "role")
	cell.txtName = goutil.findChildTextComponent(cell.container, "namebg/txt")
	cell.openTime = goutil.findChild(cell.container, "openTime")
	cell.txtOpenTime = goutil.findChildTextComponent(cell.openTime, "txt")
	cell.noGet = goutil.findChild(cell.container, "noGet")
	cell.btnBook = goutil.findChild(cell.container, "btnBook")
	cell.btnGoto = goutil.findChild(cell.container, "btnGoto")
	cell.goRoleBlack = goutil.findChild(cell.container, "roleBlack")
	cell.prizeGo = goutil.findChild(cell.container, "prize")
	cell.prizeItem = goutil.findChild(cell.container, "prize/item")
	cell.tagHasGainPrize = goutil.findChild(cell.container, "prize/tagHasGain")
	cell.btnGetPrize = goutil.findChild(cell.container, "prize/btnGet")
	cell.effectRootPrize = goutil.findChild(cell.container, "prize/effectRoot")
	cell.btnPlay = goutil.findChild(cell.container, "btnPlay")
	cell.txtStroyName = goutil.findChildTextComponent(cell.container, "btnPlay/name/txtStroyName")

	GameUtil.rmClickHandler(cell.btnBook)
	GameUtil.rmClickHandler(cell.btnGoto)
	GameUtil.rmClickHandler(cell.btnGetPrize)
	MaterialMgr.resetAll(cell.prizeItem)
	self:stopViewEffectUniGo(cell.effectRootPrize)

	cell.attrObj = goutil.findChild(cell.container, "imgattribute")

	uGuiUtil.clearImage(cell.role)
	uGuiUtil.clearImage(cell.goRoleBlack)

	return cell
end

function CollectingskinmainView:_updateProgressCell(view, cellGo, data)
	local cell = self:_clearProgressCell(cellGo)

	cell.txtNum.text = data.progress

	MaterialMgr.setCellByCfg(data.prize, cell.item)

	local isGain = self._subMo:getPrizeIsGain(data.dataBitId)
	local isMatchGain = not isGain and self._curOwnNow >= data.progress

	goutil.setActive(cell.btnGet, isMatchGain)

	if isMatchGain then
		self:_playCellEffect(cell.effect)
		GameUtil.addClickHandler(cell.btnGet, GameUtil.handler(self._onClickGainPrize, self, data.dataBitId))
	end

	goutil.setActive(cell.geted, isGain)
end

function CollectingskinmainView:_clearProgressCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)

	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.btnGet = goutil.findChild(cell.go, "btnGet")
	cell.effect = goutil.findChild(cell.go, "effect")
	cell.geted = goutil.findChild(cell.go, "geted")

	GameUtil.rmClickHandler(cell.btnGet)
	self:_clearCellEffect(cell.effect)

	return cell
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function CollectingskinmainView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progress/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function CollectingskinmainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function CollectingskinmainView:_onClickSkinBook(skinId, isPet)
	if skinId then
		if isPet == 1 then
			PetbookController.instance:openPetinfoViewNoSetAttr(skinId)
		else
			PetbookController.instance:openSkinViewNoSetAttr(checkint(skinId))
		end
	end
end

function CollectingskinmainView:_onClickGoto(skinId, isPet)
	if isPet == 1 then
		MaterialMgr.openGetSource(MatType.Pet, skinId)
	else
		MaterialMgr.openGetSource(MatType.PET_SKIN, skinId)
	end
end

function CollectingskinmainView:_onClickGainPrize(dataBitId)
	CollectingSkinController.instance:gainProgressPrzie(self._curActId, dataBitId)
end

function CollectingskinmainView:_onClickPlayStroy(data)
	StoryPrizeController.instance:playStroyAndGetPrize(checknumber(data.storyId))
end

function CollectingskinmainView:_onClickTips(data)
	TipsFacade.instance:openRulesView("collectingskinmainview_rule")
end

return CollectingskinmainView
