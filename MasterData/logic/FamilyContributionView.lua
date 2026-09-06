-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyContributionView.lua

module("logic.extensions.family.view.FamilyContributionView", package.seeall)

local FamilyContributionView = class("FamilyContributionView", TableViewComponent)

FamilyContributionView.TipKey = "FamilyContributionViewTipKey"

function FamilyContributionView:ctor()
	FamilyContributionView.super.ctor(self)
end

function FamilyContributionView:onExit()
	FamilyContributionView.super.onExit(self)

	if self._ballEff then
		UIEffectManager.instance:stopEffect(self._ballEff)

		self._ballEff = nil
	end

	MaterialMgr.resetAll(self._costGo)
	self:_stopJuanxianAllEffect()
end

function FamilyContributionView:destroyUI()
	FamilyContributionView.super.destroyUI(self)
end

function FamilyContributionView:unbindEvents()
	FamilyContributionView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._contriBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
end

function FamilyContributionView:bindEvents()
	FamilyContributionView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._contriBtn:AddClickListener(self._onClickContriBtn, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:open(ViewName.RulesView, "familyluckey")
	end)
end

function FamilyContributionView:buildUI()
	FamilyContributionView.super.buildUI(self)

	self._closeBtn = self:getBtn("topInfoGo/closeBtn")
	self._levelTxt = self:getTxt("levelIma/levelTxt")
	self._activationTxt = self:getTxt("activationTxt")
	self._levelSld = goutil.findChildComponent(self.mainGO, "levelSld", "Slider")
	self._levelSldHandle = goutil.findChild(self._levelSld, "handle")
	self._goldBarCon = self:getGo("goldBarCon")

	local infoGo = self:getGo("infoGo")

	self._descTxt = goutil.findChildTextComponent(infoGo, "descGo/descTxt")
	self._emptyGo = goutil.findChild(infoGo, "newsInfoGo/emptyGo")
	self._crystalFill = goutil.findChild(infoGo, "contriPoolGo/crystalFill")
	self._tipsBtn = Framework.ButtonAdapter.GetFrom(infoGo, "jxxyzGo/tipsBtn")
	self._addnumTxt = goutil.findChildTextComponent(infoGo, "addnumTxt")
	self._progressTxt = goutil.findChildTextComponent(infoGo, "progressTxt")
	self._contriBtn = Framework.ButtonAdapter.GetFrom(infoGo, "contriBtn")
	self._freeGo = goutil.findChild(self._contriBtn.gameObject, "freeGo")
	self._costTxt = goutil.findChildTextComponent(infoGo, "costTxt")
	self._costGo = goutil.findChild(infoGo, "costTxt/costGo")
	self._supContriTxt = goutil.findChildTextComponent(infoGo, "supContriTxt")
	self._goodsPos = goutil.findChild(infoGo, "goodsBgGo/goodsPos")
	self._activityTxt = goutil.findChildTextComponent(infoGo, "activityGo/activityTxt")
	self._contriTxt = goutil.findChildTextComponent(infoGo, "contriGo/contriTxt")
	self._luckeyTxt = goutil.findChildTextComponent(infoGo, "luckeyGo/luckeyTxt")
	self._advancedTxt = goutil.findChildTextComponent(infoGo, "advancedGo/advancedTxt")
	self._moneyTxt = goutil.findChildTextComponent(infoGo, "moneyGo/txt")
	self._levelTxt.text = ""
	self._activationTxt.text = ""
	self._descTxt.text = ""

	GameUtil.SetActive(self._emptyGo, false)

	self._addnumTxt.text = ""
	self._progressTxt.text = ""

	GameUtil.SetActive(self._freeGo, false)

	self._costTxt.text = ""
	self._supContriTxt.text = ""
	self._activityTxt.text = ""
	self._contriTxt.text = ""
	self._luckeyTxt.text = ""
	self._advancedTxt.text = ""
end

function FamilyContributionView:onEnter()
	FamilyContributionView.super.onEnter(self)
	FamilyController.instance:getDonatePoolInfoReq(self._updataShowViewInfo, self)

	local btnList = {
		{
			showAdd = false,
			id = GameEnum.GoldType.FamilyCoin
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.Coin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)

	self._loadFinished = false
	self._ballEff = UIEffectManager.instance:playEffect(self, "20221223/jiazujuanxian/fx_ui_jzjx_changzhu.prefab", self.mainGO, 0, 0, true, false, nil, function(view, eff)
		goutil.addChildToParent(eff.effGo, self.mainGO)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
	end, self)
end

function FamilyContributionView:_updataShowViewInfo()
	local familyInfo = FamilyModel.instance:getMyFamilyInfo()
	local level, curVal, needVal, isMaxLv = FamilyConfig.instance:getCurLvProgress(familyInfo.score)

	self._levelTxt.text = level
	self._activationTxt.text = isMaxLv and "已满级" or string.format("<color=#00834DFF>%s</color>/%s", curVal, needVal)

	if needVal > 0 then
		self._levelSld.value = curVal / needVal or 1
	end

	self._donateInfo = FamilyModel.instance:getDonateInfo()

	local infos = {}

	if self._donateInfo and self._donateInfo.infos then
		infos = self._donateInfo.infos
	end

	self._descTxt.text = langPara("text_family_desc_38", infos.myDonation)

	local poolCfg = FamilyConfig.instance:getDonatePoolCfg(checknumber(infos.poolFamilyLevel))

	self._progressTxt.text = string.format("%s/%s", checknumber(infos.poolDonateValue), poolCfg.poolFullValue)

	if self._donateInfo then
		self._curViewDatas = self._donateInfo.records or {}
	end

	GameUtil.SetActive(self._emptyGo, #self._curViewDatas == 0)
	self:reloadData()

	local donateTimes = checknumber(infos.donateTimes)

	self._donateCfg = FamilyConfig.instance:getDonateCfg(donateTimes + 1)
	self._activityTxt.text = self._donateCfg.scoreValue
	self._luckeyTxt.text = self._donateCfg.donateValue
	self._moneyTxt.text = self._donateCfg.moneyValue
	self._contriTxt.text = "0"
	self._advancedTxt.text = "0"

	local list = string.split(self._donateCfg.contributeMp, "#")

	for i, v in ipairs(list) do
		local type, id, num = MaterialMgr.getMatParams(v)

		if type == MatType.Coin then
			if id == MatType.Coin_Family then
				self._contriTxt.text = checknumber(num)
			elseif id == MatType.Coin_Family_Luck then
				self._advancedTxt.text = checknumber(num)
			elseif id == MatType.Coin_Family_Money then
				self._moneyTxt.text = checknumber(num)
			end
		end
	end

	local curPoolCfg = FamilyConfig.instance:getDonatePoolCfg(level)

	self._supContriTxt.text = langPara("text_family_desc_39", curPoolCfg.maxDonateTimes - donateTimes, curPoolCfg.maxDonateTimes)
	self._hasLeftCount = donateTimes < curPoolCfg.maxDonateTimes

	local prizeCfg = FamilyConfig.instance:getDonatePrizeCfg(checknumber(infos.poolFamilyLevel), checknumber(infos.poolFullCount) + 1)

	MaterialMgr.setCellByCfg(prizeCfg.prize, self._goodsPos)

	if string.nilorempty(self._donateCfg.donateResource) then
		goutil.setActive(self._costTxt.gameObject, false)
		goutil.setActive(self._freeGo, true)
	else
		goutil.setActive(self._costTxt.gameObject, true)
		goutil.setActive(self._freeGo, false)

		local matType, matId, matNum = MaterialMgr.getMatParams(self._donateCfg.donateResource)

		MaterialMgr.setIcon(self._costGo, matType, matId)

		if matType == MatType.Diamond_Consume then
			local goodCfg = GoodsConfig.instance:getCfg(matId)

			if goodCfg then
				if not goodCfg.price then
					local price = 1

					self._costTxt.text = tostring(price * matNum)
				end
			end
		else
			self._costTxt.text = tostring(matNum)
		end
	end

	uGuiUtil.setGoGrayState(self._contriBtn.gameObject, not self._hasLeftCount)
	GameUtil.SetActive(self._costTxt, self._hasLeftCount)
end

function FamilyContributionView:_onClickContriBtn()
	if self._donateCfg == nil then
		return
	end

	if not self._hasLeftCount then
		FloatWordMgr.instance:show(lang("text_family_desc_40"))

		return
	end

	if not string.nilorempty(self._donateCfg.donateResource) and not MaterialFacade.instance:isMatsEnough(self._donateCfg.donateResource) then
		FloatWordMgr.instance:show(langPara("text_mirror_desc_6", MaterialMgr.getMaterialsNameByCfg(self._donateCfg.donateResource)))

		return
	end

	if string.nilorempty(self._donateCfg.donateResource) then
		self:_playJuanxianEffects()

		return
	end

	local todayNoTip, tipKey = self:_getTipParams(self._donateCfg.donateResource)

	if todayNoTip then
		self:_contriEffect()
	else
		local function funcTog()
			GameUtil.saveUserDayData(tipKey, true)
		end

		local costInfo = TipsFacade.instance:getContentMatStr(self._donateCfg.donateResource, 50, -10, true)
		local getInfo = TipsFacade.instance:getContentMatStr("8:5", 50, -10, true)
		local moneyInfo = TipsFacade.instance:getContentMatStr("8:41", 50, -10, true)
		local content = langPara("text_family_desc_42", costInfo, "x" .. self._costTxt.text, self._activityTxt.text, getInfo, "x" .. self._contriTxt.text, moneyInfo, "x" .. self._moneyTxt.text)

		TipsFacade.instance:openPopupWindowWithTog(lang("text_family_desc_43"), content, function()
			self:_contriEffect()
		end, nil, funcTog)
	end
end

function FamilyContributionView:_contriEffect()
	self:_stopJuanxianAllEffect()
	self:_playJuanxianEffects()
	self:_sendFamilyDonateReq()
end

function FamilyContributionView:_playJuanxianEffects()
	self._effectList = {}

	local path = "20221223/jiazujuanxian/fx_ui_jzjx_juanxian.prefab"
	local effect = UIEffectManager.instance:playEffect(self, path, self._crystalFill, 0, 0, false, false, nil, function(view, eff)
		goutil.addChildToParent(eff.effGo, self._crystalFill)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 31, 0)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
		settimer(0.8, self._playChufaEffects, self, false)
	end)

	table.insert(self._effectList, effect)
end

function FamilyContributionView:_playChufaEffects()
	removetimer(self._playChufaEffects, self)

	local path = "20221223/jiazujuanxian/fx_ui_jzjx_chufa.prefab"
	local effect = UIEffectManager.instance:playEffect(self, path, self._crystalFill, 0, 0, false, false, nil, function(view, eff)
		goutil.addChildToParent(eff.effGo, self._crystalFill)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 20, 0)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
	end)

	table.insert(self._effectList, effect)
end

function FamilyContributionView:_sendFamilyDonateReq()
	FamilyController.instance:familyDonateReq(((self._donateInfo and self._donateInfo.infos and self._donateInfo.infos.donateTimes or nil) and checknumber(self._donateInfo.infos.donateTimes)) + 1, function()
		self:_updataShowViewInfo()
	end, self, nil)
end

function FamilyContributionView:_stopJuanxianAllEffect()
	removetimer(self._playChufaEffects, self)

	if self._effectList then
		for _, effect in ipairs(self._effectList) do
			if effect then
				UIEffectManager.instance:stopEffect(effect)
			end
		end
	end

	self._effectList = {}
end

function FamilyContributionView:_getPath()
	return {
		cellPath = "infoGo/newsInfoGo/newsItem",
		viewPath = "infoGo/newsInfoGo/newsListSR"
	}
end

function FamilyContributionView:_cellSize()
	return 356, 80
end

function FamilyContributionView:_updateCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local showTxt = goutil.findChildTextComponent(cell, "showTxt")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")

	nameTxt.text = data.userName
	showTxt.text = langPara("text_family_desc_44", data.donateVal)

	local timer = GameUtil.time2date(data.donateTimeMillis / 1000)

	timeTxt.text = string.format("%s月%s日\n%s:%s", timer.month, timer.day, timer.hour, timer.min)
end

function FamilyContributionView:_getTipParams(donateResource)
	local todayNoTip = false
	local tipKey = ""
	local idx8 = string.find(donateResource, "8:")

	if idx8 == 1 then
		tipKey = FamilyContributionView.TipKey .. "8"
		todayNoTip = GameUtil.getUserDayData(FamilyContributionView.TipKey .. "8")
	else
		local idx105 = string.find(donateResource, "105:")

		if idx105 == 1 then
			tipKey = FamilyContributionView.TipKey .. "105"
			todayNoTip = GameUtil.getUserDayData(FamilyContributionView.TipKey .. "105")
		end
	end

	return todayNoTip, tipKey
end

return FamilyContributionView
