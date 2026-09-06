-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyView.lua

module("logic.extensions.family.view.FamilyView", package.seeall)

local FamilyView = class("FamilyView", ViewComponent)

function FamilyView:ctor()
	FamilyView.super.ctor(self)

	self._tabBtnsList = nil
	self._tabCfgsList = nil
	self._curTabId = nil
end

function FamilyView:unbindEvents()
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._settingBtn:RemoveClickListener()
	self._modifyBtn:RemoveClickListener()
	GameUtil.asBtn(self._dynamicGo):RemoveClickListener()
	self._applyListBtn:RemoveClickListener()
	self._seasonBtn:RemoveClickListener()
	GameUtil.asBtn(self._honorItem):RemoveClickListener()

	for _, v in pairs(self._tabBtnsList or {}) do
		if v and v.itemBtn then
			v.itemBtn:RemoveClickListener()
		end
	end

	GameUtil.rmClickHandler(self._btnManager)
	GameUtil.rmClickHandler(self._btnComRank)
end

function FamilyView:bindEvents()
	self._closeBtn:AddClickListener(function()
		FamilyController.instance:setFamilyViewTab(1)
		self:close()
	end)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "family")
	end, self)
	self._settingBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.FamilySetting)
	end, self)
	self._modifyBtn:AddClickListener(self._onClickModify, self)
	GameUtil.asBtn(self._dynamicGo):AddClickListener(function()
		UIStateManager.instance:open(ViewName.FamilyLog)
	end, self)
	self._applyListBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.FamilyApply)
	end, self)
	self._seasonBtn:AddClickListener(function()
		local seasonId = FamilyWarController.instance:getSeasonIdOfNfsRank()
		local isInTime = FamilyWarController.instance:isInSeasonTimeOfNfsRank(seasonId)

		if isInTime then
			UIStateManager.instance:push(ViewName.GodStatuesWarSeasonRankTabFrameView)
		else
			FloatWordMgr.instance:show(lang("text_family_desc_1"))
		end
	end, self)
	GameUtil.asBtn(self._honorItem):AddClickListener(function()
		UIStateManager.instance:push(ViewName.FamilyHonorWall)
	end, self)
	GameUtil.addClickHandler(self._btnManager, GameUtil.handler(self._onClickbtnManager, self))
	GameUtil.addClickHandler(self._btnComRank, self._onClickComRank, self)
end

function FamilyView:onExit()
	FamilyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DeclarationChange, self._updateDeclaration, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataNewFamilyHonorInfo, self._updateHonorInfo, self)
	UIEffectManager.instance:stopEffect(self._bloodEff)
	self:_clearTween()
	MaterialMgr.clearIcon(self._iconCost)
	RedPointController.instance:unregRedPoint(self._mgrRedpointGo)
end

function FamilyView:buildUI()
	FamilyView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleftGo/closeBtn")
	self._tipsBtn = self:getBtn("topleftGo/tipsBtn")
	self._titleTxt = self:getTxt("topleftGo/titleTxt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._rightInfoGo = self:getGo("rightInfoGo")

	local userInfoGo = goutil.findChild(self._rightInfoGo, "userInfoGo")

	self._headIconIsc = goutil.findChildComponent(userInfoGo, "headBgGo/headIconIsc", "UIImageSpriteChange")
	self._familyTxt = goutil.findChildTextComponent(userInfoGo, "familyTxt")
	self._numberTxt = goutil.findChildTextComponent(userInfoGo, "numberTxt")
	self._chiefTxt = goutil.findChildTextComponent(userInfoGo, "chiefTxt")
	self._countTxt = goutil.findChildTextComponent(userInfoGo, "countTxt")
	self._conditionTxt = goutil.findChildTextComponent(userInfoGo, "conditionTxt")
	self._declarationTxt = goutil.findChildTextComponent(userInfoGo, "declarationTxt")
	self._purposeIcc = goutil.findChildComponent(userInfoGo, "purposeGo/purposeIcc", "UIImageColorChange")
	self._purposeTxt = goutil.findChildTextComponent(userInfoGo, "purposeGo/purposeTxt")
	self._settingBtn = Framework.ButtonAdapter.GetFrom(userInfoGo, "settingBtn")
	self._modifyBtn = Framework.ButtonAdapter.GetFrom(userInfoGo, "modifyBtn")
	self._honorItem = goutil.findChild(userInfoGo, "honorItem")
	self._honorIconGo = goutil.findChild(self._honorItem, "honorIconGo")

	local activeInfoGo = goutil.findChild(self._rightInfoGo, "activeInfoGo")

	self._bloodImg = goutil.findChildComponent(activeInfoGo, "bloodImg", "Image")
	self._levelTxt = goutil.findChildTextComponent(activeInfoGo, "levelTxt")
	self._activeTxt = goutil.findChildTextComponent(activeInfoGo, "activeTxt")
	self._dynamicGo = goutil.findChild(activeInfoGo, "dynamicGo")

	local dynamicTran = goutil.findChildComponent(self._dynamicGo, "dynamicTran", typeof(UnityEngine.RectTransform))

	self._dynamicTxt = goutil.findChildTextComponent(dynamicTran.gameObject, "dynamicTxt")
	self._dMaxWidth = dynamicTran.sizeDelta.x
	self._dTxtTran = self._dynamicTxt:GetComponent(typeof(UnityEngine.RectTransform))
	self._applyListBtn = Framework.ButtonAdapter.GetFrom(activeInfoGo, "btnsTranGo/applyListBtn")
	self._seasonBtn = Framework.ButtonAdapter.GetFrom(activeInfoGo, "btnsTranGo/seasonBtn")
	self._btnComRank = self:getGo("rightInfoGo/activeInfoGo/btnsTranGo/btnComRank")
	self._subParentGo = self:getGo("subParentGo")
	self._goldProgress = self:getSlider("rightInfoGo/activeInfoGo/gold/progressBar")
	self._txtGold = self:getTxt("rightInfoGo/activeInfoGo/gold/levelBg/txtGold")
	self._txtCost = self:getTxt("rightInfoGo/activeInfoGo/gold/txtCost")
	self._iconCost = self:getGo("rightInfoGo/activeInfoGo/gold/icon")
	self._iconGold = self:getGo("rightInfoGo/activeInfoGo/gold/levelBg/txtGold/icon")
	self._tabBtnsList = {}

	local tabGroupTran = self:getGo("tabGroupTran").transform

	for i = 1, tabGroupTran.childCount do
		local go = goutil.findChild(tabGroupTran.gameObject, "tabBtn_" .. i)

		self._tabBtnsList[i] = {
			itemGo = go,
			itemBtn = Framework.ButtonAdapter.Get(go),
			itemUIcg = go:GetComponent("UIChangeGroup"),
			itemTxt = goutil.findChildTextComponent(go, "tabBtnTxt"),
			pointGo = goutil.findChild(go, "pointGo"),
			tagGo = goutil.findChild(go, "tagGo"),
			tagTxt = goutil.findChildTextComponent(go, "tagGo/tagTxt")
		}
	end

	self._familyTxt.text = ""
	self._numberTxt.text = ""
	self._chiefTxt.text = ""
	self._countTxt.text = ""
	self._conditionTxt.text = ""
	self._declarationTxt.text = ""
	self._purposeTxt.text = ""
	self._levelTxt.text = ""
	self._activeTxt.text = ""
	self._dynamicTxt.text = ""

	GameUtil.SetActive(self._rightInfoGo, false)

	self._btnManager = self:getGo("btnManager")
	self._mgrRedpointGo = self:getGo("btnManager/redpoint")
end

function FamilyView:onEnter()
	FamilyView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DeclarationChange, self._updateDeclaration, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataNewFamilyHonorInfo, self._updateHonorInfo, self)
	self.addGEvent(self, GlobalNotify.FamilyUpdateTabRedpoints, self._updateRedpoints, self)

	self._loadFinished = false

	local param = checknumber(self:getFirstParam())

	if param <= 0 then
		param = FamilyController.instance:getFamilyViewTab()
	end

	self:showTabAt("")

	local temp

	self._tabCfgsList = FamilyConfig.instance:getFamilyActivityTabCfgs()

	for i = 1, #self._tabBtnsList do
		if self._tabCfgsList[i] and self._tabCfgsList[i].sort > 0 then
			if self._tabCfgsList[i].tabId == param then
				temp = param
			end

			GameUtil.SetActive(self._tabBtnsList[i].itemGo, true)

			self._tabBtnsList[i].itemTxt.text = self._tabCfgsList[i].name

			GameUtil.SetActive(self._tabBtnsList[i].pointGo, false)

			if string.nilorempty(self._tabCfgsList[i].tag) then
				GameUtil.SetActive(self._tabBtnsList[i].tagGo, false)
			else
				GameUtil.SetActive(self._tabBtnsList[i].tagGo, true)

				self._tabBtnsList[i].tagTxt.text = self._tabCfgsList[i].tag
			end

			self._tabBtnsList[i].itemBtn:AddClickListener(function()
				self:_onClickTabBtn(self._tabCfgsList[i].tabId)
			end, self)
		else
			self._tabBtnsList[i].itemBtn:RemoveClickListener()
			GameUtil.SetActive(self._tabBtnsList[i].itemGo, false)
		end
	end

	if checknumber(temp) <= 0 then
		param = self._tabCfgsList[1].tabId
	end

	FamilyController.instance:setFamilyViewTab(param)

	if FamilyController.instance:getFamilyViewNeedReq() then
		FamilyController.instance:getMyFamilyInfoReq(self._onFamilyInfoRes, self)
	else
		self:_onFamilyInfoRes()
	end

	self._bloodEff = UIEffectManager.instance:playEffect(self, "fx_ui_jiazuxitong/prefab/fx_jiazuxitong_jiemian.prefab", self._bloodImg.gameObject, 0, 0, true, false, nil, self._onLoadFinished, self)

	local btnsList = {
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

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnsList)
	FamilyHonorController.instance:csRequestFamilyMedalGetMedalListReq()
	RedPointController.instance:regRedPoint(self._mgrRedpointGo, RedPointModel.ID_FAMILY_MGR_PARTY)
end

function FamilyView:_onLoadFinished(eff)
	self._loadFinished = true

	local effGo = eff.effGo.transform

	goutil.addChildToParent(effGo, self._bloodImg.gameObject)
	Framework.TransformUtil.SetLocalPos(effGo, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(effGo, 1, 1, 1)

	self._surface = goutil.findChild(effGo, "ring/shuimian").transform

	if self._cacheVal then
		self:_updateProgress(self._cacheVal)
	end
end

function FamilyView:_updateProgress(val)
	self._cacheVal = val

	if self._loadFinished then
		local z = 0.317 - val * 0.66
		local scale = math.sqrt(0.25 - math.pow(val - 0.5, 2)) * 2

		Framework.TransformUtil.SetLocalPos(self._surface, 0, 0, z)
	end
end

function FamilyView:_onFamilyInfoRes()
	self._familyInfo = FamilyModel.instance:getMyFamilyInfo()

	self:_updateRedpoints()
	self:_onClickTabBtn(FamilyController.instance:getFamilyViewTab(), true)
end

function FamilyView:_updateRedpoints()
	for i = 1, #self._tabBtnsList do
		if self._tabBtnsList[i].itemGo.activeSelf and self._tabCfgsList[i] then
			self:_updataTabRedpoint(self._tabCfgsList[i].tabId)
		end
	end
end

function FamilyView:_updataTabRedpoint(tabId)
	if self._tabCfgsList == nil or #self._tabCfgsList == 0 then
		return
	end

	local index

	for i = 1, #self._tabCfgsList do
		if self._tabCfgsList[i] and self._tabCfgsList[i].tabId == tabId then
			index = i

			break
		end
	end

	if checknumber(index) <= 0 or self._tabBtnsList[index] == nil or not self._tabBtnsList[index].itemGo.activeSelf then
		return
	end

	if string.nilorempty(self._tabCfgsList[index].redIds) then
		GameUtil.SetActive(self._tabBtnsList[index].pointGo, false)

		return
	end

	local ids = string.split(self._tabCfgsList[index].redIds, "#")

	for _, v in pairs(ids or {}) do
		if RedPointModel.instance:isActive(v) then
			GameUtil.SetActive(self._tabBtnsList[index].pointGo, true)

			return
		end
	end

	GameUtil.SetActive(self._tabBtnsList[index].pointGo, false)
end

function FamilyView:_onClickTabBtn(tabId, isForce)
	FamilyController.instance:setFamilyViewTab(tabId)

	tabId = checknumber(tabId)

	if self._familyInfo == nil or tabId <= 0 or self._tabCfgsList == nil or #self._tabCfgsList == 0 then
		return
	end

	if self._curTabId == tabId and not isForce then
		return
	end

	local temp

	for i = 1, #self._tabCfgsList do
		if self._tabCfgsList[i] and self._tabCfgsList[i].tabId == tabId then
			temp = i

			break
		end
	end

	temp = checknumber(temp)

	if temp == 0 or self._tabCfgsList[temp] == nil then
		return
	end

	self:showTabAt("")

	self._curTabId = tabId

	goutil.setActive(self._btnManager, tabId == 1)

	for i = 1, #self._tabBtnsList do
		self._tabBtnsList[i].itemUIcg:SetState(i == temp and 1 or 0)
	end

	self:_updataTabRedpoint(self._curTabId)
	FamilyController.instance:setFamilyViewTab(self._curTabId)

	self._titleTxt.text = self._tabCfgsList[temp].name

	GameUtil.SetActive(self._rightInfoGo, false)

	if not string.nilorempty(self._tabCfgsList[temp].subViewName) then
		if string.nilorempty(self._tabCfgsList[temp].params) then
			self:showTabAt(self._subParentGo, self._tabCfgsList[temp].subViewName)
		else
			self:showTabAt(self._subParentGo, self._tabCfgsList[temp].subViewName, self._tabCfgsList[temp].params)
		end

		return
	end

	if string.nilorempty(self._tabCfgsList[temp].params) then
		FloatWordMgr.instance:show("subViewName 和 params 不能同时空！！")

		return
	end

	if self._tabCfgsList[temp].params == "openinfo" then
		GameUtil.SetActive(self._rightInfoGo, true)
		self:_updateFamilyInfoUI()
	end
end

function FamilyView:_updateFamilyInfoUI()
	self._settingInfo = FamilyModel.instance:getMyFamilySettingInfo()
	self._familyTxt.text = self._settingInfo.familyName
	self._numberTxt.text = tostring(self._familyInfo.familyId)

	local level, curVal, needVal, isMaxLv = FamilyConfig.instance:getCurLvProgress(self._familyInfo.score)
	local lvCfg = FamilyConfig.instance:getLvCfgByLv(level)

	self._countTxt.text = string.format("%s/%s", self._familyInfo.memberCount, (lvCfg or nil) and (lvCfg.maxAllMemberCount or 0))

	self._purposeIcc:SetState(self._settingInfo.purpose)

	self._purposeTxt.text = lang("tip_family_purpose_" .. self._settingInfo.purpose + 1)
	self._conditionTxt.text = FamilyFacade.instance:getFamilyTagText(self._settingInfo, "\t")
	self._levelTxt.text = langPara("text_family_desc_2", level)
	self._activeTxt.text = isMaxLv and "已满级" or string.format("%s/%s", curVal, needVal)

	if needVal > 0 then
		if not (curVal / needVal) then
			local value = 1

			self:_updateProgress(value)

			self._bloodImg.fillAmount = value
			self._chiefTxt.text = self._familyInfo.cheifName

			self._headIconIsc:SetState(self._settingInfo.iconId)
			GameUtil.SetActive(self._modifyBtn, FamilyConfig.instance:isHasAuthority("MODIFY_DECLARATION", self._familyInfo.myRole))
			GameUtil.SetActive(self._applyListBtn, FamilyConfig.instance:isHasAuthority("ALLOW_APPLY", self._familyInfo.myRole))
			GameUtil.SetActive(self._settingBtn, FamilyConfig.instance:isHasAuthority("MODIFY_INFO", self._familyInfo.myRole))
			self:_updateDeclaration()
			self:_updateDynamicShow()
			self:_updateHonorInfo()
			self:_updateGold(lvCfg)
		end
	end
end

function FamilyView:_updateGold(lvCfg)
	local money = FamilyModel.instance:getMoney()
	local cost = lvCfg.decrMoneyDaily
	local limit = checknumber(lvCfg.maxMoney)

	MaterialMgr.updateItemByStr(self._iconCost, GameEnum.GoldType.FamilyFund)
	MaterialMgr.updateItemByStr(self._iconGold, GameEnum.GoldType.FamilyFund)

	self._txtCost.text = langPara("%s/每天", cost)
	self._txtGold.text = langPara("%s/%s", money, limit)

	self._goldProgress:SetValue(money / limit)
end

function FamilyView:_updateDynamicShow()
	local log = FamilyModel.instance:getLastLog()

	if log and not string.nilorempty(log.logTypeId) then
		local userName, content = FamilyConfig.instance:getLogContent(log.logTypeId, log.logParam)

		self._dynamicTxt.text = string.format("<color=#F7F8A2FF>%s</color>%s", userName, content)
	else
		self._dynamicTxt.text = ""
	end

	local textWidth = self._dynamicTxt.preferredWidth

	Framework.TransformUtil.SetAnchoredPos(self._dTxtTran, 0, 0)
	self:_clearTween()

	if textWidth > self._dMaxWidth then
		local duration = (textWidth - self._dMaxWidth) / 75

		self._tweenLog = TweenUtil.ValueTo(0, 1, duration, function(val)
			Framework.TransformUtil.SetAnchoredPos(self._dTxtTran, -val * (textWidth - self._dMaxWidth), 0)
		end, nil, self)
	end
end

function FamilyView:_updateDeclaration()
	self._declarationTxt.text = FamilyModel.instance:getDeclaration()
end

function FamilyView:_updateHonorInfo()
	local honorList = FamilyHonorModel.instance:getOtherHonorWallInfo()

	MaterialMgr.resetAll(self._honorIconGo)

	if honorList == nil or #honorList == 0 then
		self._honorItem:GetComponent("UIImageSpriteChange"):SetState(0)
		GameUtil.SetActive(self._honorIconGo, false)

		return
	end

	local cfg = self:_getMaxLevelHonor(honorList)

	if cfg == nil or checknumber(cfg.id) <= 0 then
		self._honorItem:GetComponent("UIImageSpriteChange"):SetState(0)
		GameUtil.SetActive(self._honorIconGo, false)

		return
	end

	GameUtil.SetActive(self._honorIconGo, true)

	local iconPath = "ui/bigbg/familycallorder/" .. cfg.icon .. ".png"

	uGuiUtil.setSpriteToImage(self._honorIconGo, uGuiUtil.SpriteType.BigBg, iconPath)
	self._honorItem:GetComponent("UIImageSpriteChange"):SetState(cfg.level - 1)
end

function FamilyView:_getMaxLevelHonor(list)
	local temp, cfg

	for _, info in pairs(list or {}) do
		if info and checknumber(info.defineId) then
			cfg = FamilyHonorConfig.instance:getFamilyMedalCfg(info.defineId)

			if cfg and (temp == nil or temp.cfg.level < cfg.level or temp.cfg.level == cfg.level and temp.gainedTime > info.gainedTime) then
				temp = {
					cfg = cfg,
					gainedTime = info.gainedTime
				}
			end
		end
	end

	if temp and temp.cfg then
		return temp.cfg
	end

	return nil
end

function FamilyView:_clearTween()
	if self._tweenLog then
		self._tweenLog:Kill(false)
	end

	self._tweenLog = nil
end

function FamilyView:_onClickModify()
	local v = FriendConfig.instance:getCommonValue("NO_RENAME_PERIOD")
	local times = string.split(v, "#")

	if #times == 2 and GameUtil.checkIsInTimePeriod(times[1], times[2]) then
		FloatWordMgr.instance:show(lang("text_family_desc_3"))

		return
	end

	UIStateManager.instance:open(ViewName.FamilyDelaration)
end

function FamilyView:_onClickbtnManager()
	UIStateManager.instance:push(ViewName.FamilymanagerView)
end

function FamilyView:_onClickComRank()
	GodStatuesWarController.instance:openCommonTabRankView()
end

return FamilyView
