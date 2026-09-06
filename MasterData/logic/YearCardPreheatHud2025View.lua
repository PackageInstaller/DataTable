-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/hud/YearCardPreheatHud2025View.lua

module("logic.extensions.yearcard.view.yearcard2025.hud.YearCardPreheatHud2025View", package.seeall)

local YearCardPreheatHud2025View = class("YearCardPreheatHud2025View", ViewComponent)

function YearCardPreheatHud2025View:buildUI()
	YearCardPreheatHud2025View.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnPoster = self:getGo("btnPoster")

	local parentEnterCell = self:getGo("enterList")

	self._enterList = {}

	for i = 1, 6 do
		local childPath = "enterCell" .. i
		local cell = {}

		cell.go = goutil.findChild(parentEnterCell, childPath)
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.redPoint = goutil.findChild(cell.btn, "redpoint")
		cell.txt = goutil.findChildTextComponent(cell.btn, "txt")
		cell.cfg = nil
		self._enterList[childPath] = cell
	end

	self.skinId1 = YearCardConfig.instance:getYearcardCommonValue("RaceId_2025", true)

	self:_buildPetInfo()

	self._txt6 = self:getTxt("enterList/enterCell6/btn/txt")
end

function YearCardPreheatHud2025View:bindEvents()
	YearCardPreheatHud2025View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPoster, self._onClickPoster, self)

	for k, v in pairs(self._enterList) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickGotoBtn, self, k))
	end

	for i, v in ipairs(self._petInfoItems) do
		GameUtil.addClickHandler(v.btnInfo, GameUtil.handler(self._onClickInfo, self, i))
		GameUtil.addClickHandler(v.btnSkill, GameUtil.handler(self._onClickSkill, self, i))
	end
end

function YearCardPreheatHud2025View:unbindEvents()
	YearCardPreheatHud2025View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPoster)

	for k, v in pairs(self._enterList) do
		GameUtil.rmClickHandler(v.btn)
	end

	for i, v in ipairs(self._petInfoItems) do
		GameUtil.rmClickHandler(v.btnInfo)
		GameUtil.rmClickHandler(v.btnSkill)
	end
end

function YearCardPreheatHud2025View:_buildPetInfo()
	self._petInfoItems = {}

	for i = 1, 1 do
		self._petInfoItems[i] = {
			rare = self:getGo(string.format("petInfo%s/rare", i)),
			btnInfo = self:getGo(string.format("petInfo%s/btnInfo", i)),
			btnSkill = self:getGo(string.format("petInfo%s/btnSkill", i)),
			txtName = self:getTxt(string.format("petInfo%s/txtName", i))
		}
	end
end

function YearCardPreheatHud2025View:onExit()
	YearCardPreheatHud2025View.super.onExit(self)
	self:resetView()

	for i, v in ipairs(self._petInfoItems) do
		MaterialMgr.resetAll(v.rare)
	end

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function YearCardPreheatHud2025View:onEnter()
	YearCardPreheatHud2025View.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.AnnuityInfoChange, self.refreshView, self)

	self._activityId = 8005
	self._planId = self:getFirstParam()

	local cfgs = YearCardConfig.instance:getPreheatCfgs(self._activityId)

	if not GameUtil.checkIsInTimePeriod(cfgs[self._planId].startTime, cfgs[self._planId].endTime) then
		self:close()

		return
	end

	self._hudCfgs = YearCardConfig.instance:getpreheatviewCfgById(checkint(self._planId))

	self:refreshView()

	local key = self:_getKey()

	if checkint(GameUtil.getUserData(key)) <= 0 then
		self:_onClickPoster()
	end

	self:_setPetInfos()
	self:_playEffect()
	self:_playAni()
end

function YearCardPreheatHud2025View:_getKey()
	return YearCardController.YearCard2025_AniKey .. "_show_poster"
end

function YearCardPreheatHud2025View:_setTxt6()
	local cfgs = YearCardConfig.instance:getNewGiftCfgs(self._activityId)
	local appointmentCfg

	for i, v in ipairs(cfgs) do
		if not string.nilorempty(v.preorderStartTime) then
			appointmentCfg = v

			break
		end
	end

	local isAbleToBuy, isDateMatch, isBuyTimeLimit, isActive, isInPreoderTime, isUnlockCondition, isPreoderLimit = YearCardModel.instance:isAbleToBuyGiftId(self._activityId, appointmentCfg.giftId)
	local isSet = false

	if isInPreoderTime and isPreoderLimit then
		isSet = true
		self._txt6.text = "预购成功"
	end

	if not isSet then
		self._txt6.text = string.format("%s元预购", PayConfig.instance:getPayMoneyYuan(appointmentCfg.payGoodsId))
	end
end

function YearCardPreheatHud2025View:resetView()
	for k, v in pairs(self._enterList) do
		v.cfg = nil

		goutil.setActive(v.go, false)
		goutil.setActive(v.redPoint, false)
		RedPointController.instance:unregRedPoint(v.redPoint)
	end
end

function YearCardPreheatHud2025View:refreshView()
	self:resetView()

	if self._hudCfgs then
		for k, cfg in ipairs(self._hudCfgs) do
			local cell = self._enterList[cfg.enterPath]

			if GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) and cell then
				cell.cfg = cfg

				goutil.setActive(cell.go, true)

				cell.txt.text = cfg.showTip == 0 and "" or lang(cfg.showTip)

				RedPointController.instance:regRedPoint(cell.redPoint, unpack(string.split(cfg.redpointId or "", "#")))
			end
		end
	end

	self:_setTxt6()
end

function YearCardPreheatHud2025View:_onClickGotoBtn(id)
	if id == "enterCell6" then
		YearCardController.instance:payAppointment(self._activityId)

		return
	end

	if self._enterList[id] then
		local cfg = self._enterList[id].cfg

		if cfg then
			local gotoStr = cfg.gotoStr

			if not string.nilorempty(gotoStr) then
				GotoMgr.gotoByString(gotoStr)

				return
			end

			local showMatStr = cfg.showReward

			if not string.nilorempty(showMatStr) then
				CommonTipsMgr.instance:openTipsByConfStr(self._enterList[id].go, showMatStr)
			end
		end
	end
end

function YearCardPreheatHud2025View:_onClickPoster()
	UIStateManager.instance:push(ViewName.YearCardPoster2025View)
end

function YearCardPreheatHud2025View:_onClickInfo(index)
	PetbookController.instance:openPetinfoView(self["skinId" .. index])
end

function YearCardPreheatHud2025View:_onClickSkill(index)
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self["skinId" .. index])

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self["skinId" .. index])
	end
end

function YearCardPreheatHud2025View:_setPetInfos()
	for i, v in ipairs(self._petInfoItems) do
		local skinId = self["skinId" .. i]

		MaterialMgr.setCell(MatType.Rare, skinId, v.rare)

		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		v.txtName.text = skinCfg.name
	end
end

function YearCardPreheatHud2025View:_playEffect()
	local path = "20241220/mianbanfw_fx/fx_ui_zhizunnianfei_chuanshuo_fw.prefab"

	self._eff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setLocalPos(0, 0, 0)
	end)
end

function YearCardPreheatHud2025View:_playAni()
	local key = string.format("%s_%s", self._activityId, "anikey")
	local isPlay = GameUtil.getUserData(key)

	if isPlay then
		return
	end

	GameUtil.saveUserData(key, true)

	local animConfig = {
		animName = "feixisi01_dengchang",
		callbackTarget = self
	}

	ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
end

return YearCardPreheatHud2025View
