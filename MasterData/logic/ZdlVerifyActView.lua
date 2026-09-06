-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zdlverify/view/ZdlVerifyActView.lua

module("logic.extensions.zdlverify.view.ZdlVerifyActView", package.seeall)

local ZdlVerifyActView = class("ZdlVerifyActView", ViewComponent)

function ZdlVerifyActView:ctor()
	ZdlVerifyActView.super.ctor(self)
end

function ZdlVerifyActView:unbindEvents()
	ZdlVerifyActView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGetPrize)
	GameUtil.rmClickHandler(self._btnTip)
end

function ZdlVerifyActView:bindEvents()
	ZdlVerifyActView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGetPrize, self._onClickGetPrize, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function ZdlVerifyActView:buildUI()
	ZdlVerifyActView.super.buildUI(self)

	local goCell = self:getGo("tableview/cell")
	local goTableview = self:getGo("tableview")

	self._tableView = ScrollerList.create(goTableview, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnGetPrize = self:getGo("passPrize/btnGetPrize")
	self._txtPrize = self:getTxt("passPrize/txt")
	self._markGeted = self:getGo("passPrize/markGeted")
	self._conPrize = self:getGo("passPrize/con")
	self._btnTip = self:getGo("btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
end

function ZdlVerifyActView:onExit()
	ZdlVerifyActView.super.onExit(self)
	self._tableView:dispose()

	if self._progressEff then
		UIEffectManager.instance:stopEffect(self._progressEff)

		self._progressEff = nil
	end
end

function ZdlVerifyActView:onEnter()
	ZdlVerifyActView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ZdlVerifyInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_ZdlVerifyGainProgressRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = ZdlVerifyController.instance:getDefaultActivityId() or 0
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	ZdlVerifyController.instance:getInfo(self._activityId)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, self._btnGetPrize, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self._btnGetPrize.transform)
	end)

	uiEffect:setParent(self._btnGetPrize.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)
end

function ZdlVerifyActView:_updateUIByCfg()
	self._actCfg = ZdlVerifyConfig.instance:getActCfgByActId(self._activityId) or {}
	self._raceCfgList = ZdlVerifyConfig.instance:getRaceCfgListByActId(self._activityId) or {}
	self._progressCfgList = ZdlVerifyConfig.instance:getProgressCfgListByActId(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function ZdlVerifyActView:_updateUIByInfo()
	self._hasVerCount = 0
	self._verInfoMap = {}
	self._showDatalist = {}

	for verifyId, cfg in ipairs(self._raceCfgList) do
		local hasVerify = ZdlVerifyModel.instance:hasVerify(self._activityId, verifyId)

		self._verInfoMap[verifyId] = hasVerify

		if hasVerify then
			self._hasVerCount = self._hasVerCount + 1
		end

		table.insert(self._showDatalist, cfg)
	end

	self._showProgressCfg = nil

	for _, cfg in ipairs(self._progressCfgList) do
		local hasGain = ZdlVerifyModel.instance:hasGainProgress(self._activityId, cfg.progressId)

		if not hasGain then
			self._showProgressCfg = cfg

			break
		end
	end

	self._showProgressCfg = self._showProgressCfg or self._progressCfgList[#self._progressCfgList]

	if not self._showProgressCfg.progressId then
		local curPrizeId = 0
		local hasGain = ZdlVerifyModel.instance:hasGainProgress(self._activityId, curPrizeId)

		goutil.setActive(self._markGeted, hasGain)

		if not self._showProgressCfg.prize then
			MaterialMgr.setCellByCfg(self._showProgressCfg.prize, self._conPrize)

			self._txtPrize.text = self._hasVerCount >= self._showProgressCfg.verifyRaceNum and langPara("满足战力精灵数量：<color=%s>%s</color> / %s", "#51e764", self._hasVerCount, self._showProgressCfg.verifyRaceNum or 0) or langPara("满足战力精灵数量：%s / %s", self._hasVerCount, (not self._showProgressCfg.verifyRaceNum or nil) and 0)

			goutil.setActive(self._btnGetPrize, not hasGain and self._hasVerCount >= self._showProgressCfg.verifyRaceNum)
			ArraySort.sortOn(self._showDatalist, {
				function(data)
					local verifyId = data.verifyId
					local hasVerify = self._verInfoMap[verifyId] == true

					if hasVerify then
						return 1
					else
						return 0
					end
				end,
				function(data)
					if not data.unlockTime then
						if not GameUtil.isEmptyString(data.unlockTime) then
							local unlockTime = GameUtil.string2time(data.unlockTime)

							if unlockTime <= ServerTime.now() then
								return 0
							else
								return 1
							end
						end

						return 0
					end
				end,
				function(data)
					if not data.raceId then
						local petIdMaxZdl = BagModel.instance:getMaxZdlPetIdByRaceId(data.raceId) or nil

						if petIdMaxZdl then
							return 0
						else
							return 1
						end
					end
				end
			}, {
				ArraySort.NUMERIC,
				ArraySort.NUMERIC,
				ArraySort.NUMERIC
			})
			self._tableView:reloadData(self._showDatalist)
		end
	end
end

function ZdlVerifyActView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local hide = goutil.findChild(go, "container/hide")
	local petCard = goutil.findChild(go, "container/petCard")
	local txtTitle = goutil.findChildTextComponent(go, "container/title/txt")
	local zdlver = goutil.findChild(go, "container/zdlver")
	local txtZdlver = goutil.findChildTextComponent(go, "container/zdlver/txt")
	local markNotGain = goutil.findChild(go, "container/markNotGain")
	local btnGet = goutil.findChild(go, "container/btnGet")
	local btnGoto = goutil.findChild(go, "container/btnGoto")
	local verifyId = data.verifyId
	local hasVerify = self._verInfoMap[verifyId] == true

	if not data.raceId then
		local raceId = 0
		local zdlVerify = checknumber(data.zdl)
		local petIdMaxZdl = BagModel.instance:getMaxZdlPetIdByRaceId(raceId) or nil
		local curPetMo = BagModel.instance:getPet(petIdMaxZdl)
		local curZdl = 0

		if curPetMo then
			local petMoDuplicated = curPetMo:GetClone()

			petMoDuplicated.attrMo:resetPublicAttr()
			petMoDuplicated.attrMo:calcTotalAttrs()
			petMoDuplicated:refreshAllAttr()

			curZdl = petMoDuplicated:getFightingPower()
		end

		local ModelCo = CharacterConfig.instance:getModelCo(raceId)
		local petCo = CharacterConfig.instance:getPetCo(raceId)
		local imgPath = GameUrl.getPetImgUrl(ModelCo.cardName)

		uGuiUtil.setSpriteToImage(petCard, uGuiUtil.SpriteType.BigBg, imgPath)

		local isUnlock = true

		if not GameUtil.isEmptyString(data.unlockTime) then
			local unlockTime = GameUtil.string2time(data.unlockTime)

			isUnlock = unlockTime <= ServerTime.now()
		end

		goutil.setActive(hide, false)
		goutil.setActive(petCard, false)
		goutil.setActive(zdlver, false)
		goutil.setActive(markNotGain, false)
		goutil.setActive(btnGet, false)
		goutil.setActive(btnGoto, false)
		GameUtil.SetGray(petCard, false)

		if isUnlock then
			goutil.setActive(petCard, true)
			goutil.setActive(markNotGain, curPetMo == nil)
			goutil.setActive(btnGet, curPetMo == nil and not hasVerify)
			goutil.setActive(btnGoto, curPetMo ~= nil and not hasVerify)
			goutil.setActive(zdlver, curPetMo ~= nil)

			local addColor = zdlVerify <= curZdl and "#00FF00" or "#FF0000"

			txtZdlver.text = langPara("<color=%s>%s</color>/%s", addColor, curZdl, zdlVerify)
			txtTitle.text = petCo.name or ""

			GameUtil.SetGray(petCard, curPetMo == nil)
			GameUtil.addClickHandler(btnGet, function()
				local cfgStr = string.format("%s:%s:1:1", MatType.Pet, raceId)

				MaterialMgr.openGetSourceByStr(cfgStr)
			end, self)
			GameUtil.addClickHandler(btnGoto, function()
				if not hasVerify and curZdl >= zdlVerify then
					ZdlVerifyController.instance:verifyRace(self._activityId, verifyId, petIdMaxZdl)
				end

				UIStateManager.instance:push(ViewName.PowercheckView, petIdMaxZdl)
			end, self)
		else
			goutil.setActive(hide, true)

			local unlockDate = GameUtil.string2date(data.unlockTime)

			txtTitle.text = langPara("%s月%s日解锁", unlockDate.month, unlockDate.day)
		end
	end
end

function ZdlVerifyActView:_clearCell(cell)
	local go = cell.gameObject
	local petCard = goutil.findChild(go, "container/petCard")

	uGuiUtil.clearImage(petCard)

	local btnGet = goutil.findChild(go, "container/btnGet")
	local btnGoto = goutil.findChild(go, "container/btnGoto")

	GameUtil.rmClickHandler(btnGet)
	GameUtil.rmClickHandler(btnGoto)
end

function ZdlVerifyActView:_onClickGetPrize()
	if self._showProgressCfg then
		if not self._showProgressCfg.progressId then
			local progressId = 0
			local hasGain = ZdlVerifyController.instance:gainProgress(self._activityId, progressId)
			local isMatch = self._hasVerCount >= self._showProgressCfg.verifyRaceNum

			if not hasGain and isMatch then
				ZdlVerifyController.instance:gainProgress(self._activityId, progressId)
			end
		end
	end
end

function ZdlVerifyActView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

return ZdlVerifyActView
