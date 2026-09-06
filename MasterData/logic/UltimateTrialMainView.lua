-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/view/UltimateTrialMainView.lua

module("logic.extensions.ultimatetrial.view.UltimateTrialMainView", package.seeall)

local UltimateTrialMainView = class("UltimateTrialMainView", ViewComponent)

function UltimateTrialMainView:buildUI()
	UltimateTrialMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._imgBg = self:getGo("imgBg")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redBtnJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redBtnJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redBtnJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._btnExt = self:getGo("btnExt/btn")
	self._passTagBtnExt = self:getGo("btnExt/passTag")
	self._btnNor = self:getGo("btnNor/btn")
	self._passTagBtnNor = self:getGo("btnNor/passTag")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/scrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._btnSignInBuff = self:getGo("buffCol")
	self._txtSignBuff = self:getTxt("buffCol/txtSign")
	self._strTxtSginBuff = self._txtSignBuff.text
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._iconBuff = self:getGo("buffCol/icon")
	self._redpointBuff = self:getGo("buffCol/redpoint")
end

function UltimateTrialMainView:bindEvents()
	UltimateTrialMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnExt, GameUtil.handler(self._onClickBtnClg, self, UltimateTrialEnum.ClgMode_Ext))
	GameUtil.addClickHandler(self._btnNor, GameUtil.handler(self._onClickBtnClg, self, UltimateTrialEnum.ClgMode_Nor))
	GameUtil.addClickHandler(self._btnSignInBuff, self._onClickBtnSignInBuff, self)
end

function UltimateTrialMainView:unbindEvents()
	UltimateTrialMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnExt)
	GameUtil.rmClickHandler(self._btnNor)
	GameUtil.rmClickHandler(self._btnSignInBuff)
end

function UltimateTrialMainView:onEnter()
	UltimateTrialMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = UltimateTrialController.instance:getActivityId()
	end

	self._activityType = UltimateTrialController.instance:getActivityType()

	local isInTime = UltimateTrialController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._trailMo = UltimateTrialController.instance:getTrialMo(self._activityId)
	self._actData = UltimateTrialConfig.instance:getActData(self._activityId)
	self._mainCfg = UltimateTrialConfig.instance:getMainCfg(self._activityId) or {}
	self._curTabIdx = self._trailMo:getCurTabId()

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateTrialGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateTrialSignInRes, self._onUpdate, self)
	UltimateTrialController.instance:sendPM_UltimateTrialGetInfoReq(self._activityId)
end

function UltimateTrialMainView:onExit()
	UltimateTrialMainView.super.onExit(self)
	self._trailMo:saveCurTabId(self._curTabIdx)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	uGuiUtil.clearImage(self._imgBg)
	RedPointController.instance:unregRedPoint(self._redBtnJump1)
	RedPointController.instance:unregRedPoint(self._redBtnJump2)
	RedPointController.instance:unregRedPoint(self._redBtnJump3)
end

function UltimateTrialMainView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local redInfoList = {
		{
			not string.nilorempty(self._actData.jumpRedIdOne) and string.split(self._actData.jumpRedIdOne, "#"),
			self._redBtnJump1
		},
		{
			not string.nilorempty(self._actData.jumpRedIdTwo) and string.split(self._actData.jumpRedIdTwo, "#"),
			self._redBtnJump2
		},
		{
			not string.nilorempty(self._actData.jumpRedIdThree) and string.split(self._actData.jumpRedIdThree, "#"),
			self._redBtnJump3
		}
	}

	for _, redInfo in ipairs(redInfoList) do
		local list = redInfo[1]
		local redGo = redInfo[2]

		if list then
			local redIdList = {}

			for _, redId in ipairs(list) do
				if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
					table.insert(redIdList, redId)
				end
			end

			if #redIdList > 0 and not goutil.isNil(redGo) then
				RedPointController.instance:regRedPoint(redGo, unpack(redIdList))
			end
		end
	end
end

function UltimateTrialMainView:_onUpdate()
	self._curTabIdx = Mathf.Max(self._curTabIdx, 1)
	self._curTabIdx = Mathf.Min(self._curTabIdx, #self._mainCfg)

	local clgIndex = self._curTabIdx
	local clgData = UltimateTrialConfig.instance:getMainData(self._activityId, clgIndex)

	if clgData then
		if not clgData.skinId then
			local skinId = 0
			local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

			if not modelCfg[1] then
				if not modelCfg[2] then
					local y = 0

					if not modelCfg[3] then
						local scale = 1

						self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, modelCfg[1], y)

						local signDay = self._trailMo:getSignInDays()
						local maxDay = self._trailMo:getMaxSignDay()
						local curDay = self._trailMo:getCurSignDay()

						self._txtSignBuff.text = string.format(self._strTxtSginBuff, curDay, maxDay)

						local buffData = UltimateTrialConfig.instance:getSignInBuffData(self._activityId, Mathf.Clamp(curDay, 1, maxDay))

						self._txtDescBuff.text = buffData.desc

						if not string.nilorempty(buffData.iconPath) and self._iconBuff then
							local spriteName = string.format("ui/icon/%s.png", buffData.iconPath)

							uGuiUtil.setSpriteToImage(self._iconBuff, uGuiUtil.SpriteType.BigBg, spriteName)
						else
							uGuiUtil.clearImage(self._iconBuff)
						end

						local result = UltimateTrialController.instance:getTryResultAndTipsSignInBuff(false, self._activityId)

						GameUtil.SetActive(self._redpointBuff, result == GameEnum.ResultCode.Success)

						if not string.nilorempty(clgData.bgPath) then
							local spriteName = GameUrl.getBigbgPngUrl(clgData.bgPath)

							uGuiUtil.setSpriteToImage(self._imgBg, uGuiUtil.SpriteType.BigBg, spriteName, function()
								self._imgBg:GetComponent(goutil.Type_UIImage):SetNativeSize()
							end)
						else
							uGuiUtil.clearImage(self._imgBg)
						end

						local norClgData = UltimateTrialConfig.instance:getChallengeDataByIndex(self._activityId, clgIndex, UltimateTrialEnum.ClgMode_Nor)
						local norClgActId = norClgData.clgActId
						local extClgData = UltimateTrialConfig.instance:getChallengeDataByIndex(self._activityId, clgIndex, UltimateTrialEnum.ClgMode_Ext)
						local extClgActId = extClgData.clgActId

						GameUtil.SetActive(self._passTagBtnNor, self._trailMo:isFirstPassClg(norClgActId))
						GameUtil.SetActive(self._passTagBtnExt, self._trailMo:isFirstPassClg(extClgActId))
						self:_onUpdateTabColUI()
					end
				end
			end
		end
	end
end

function UltimateTrialMainView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._mainCfg)
end

function UltimateTrialMainView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.data
	local clgIndex = tabIdx
	local skinId = data.skinId
	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)
	local norClgData = UltimateTrialConfig.instance:getChallengeDataByIndex(self._activityId, clgIndex, UltimateTrialEnum.ClgMode_Nor)
	local norClgActId = norClgData.clgActId
	local extClgData = UltimateTrialConfig.instance:getChallengeDataByIndex(self._activityId, clgIndex, UltimateTrialEnum.ClgMode_Ext)
	local extClgActId = extClgData.clgActId
	local clgData

	if clgData == nil then
		clgData = self._trailMo:isFirstPassClg(extClgActId) and extClgData or norClgData
	end

	if clgData == nil then
		clgData = UltimateTrialController.instance:isInUltTrialTime(extClgActId) and extClgData or norClgData
	end

	local clgActId = clgData.clgActId
	local isInTime = UltimateTrialController.instance:isInUltTrialTime(clgActId)
	local passScore = self._trailMo:getPassClgScore(clgActId)
	local mainGo = cell.gameObject
	local imgBg = goutil.findChild(mainGo, "imgBg")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local lockTag = goutil.findChild(mainGo, "lockTag")
	local txtLockTag = goutil.findChildTextComponent(mainGo, "lockTag/txt")
	local normalPassTag = goutil.findChild(mainGo, "passTag/normal")
	local extremePassTag = goutil.findChild(mainGo, "passTag/extreme")

	txtName.text = CharacterConfig.instance:getPetName(raceId)
	txtScore.text = string.format(data.formatScore, passScore)
	txtLockTag.text = GameUtil.formatTimeString("%Y.%m.%d\n%H:%M:%S\n开启", clgData.limitStartTime)

	GameUtil.SetActive(lockTag, not isInTime)
	GameUtil.SetActive(imgSelected, self._curTabIdx == tabIdx)
	GameUtil.SetActive(normalPassTag, self._trailMo:isFirstPassClg(norClgActId))
	GameUtil.SetActive(extremePassTag, self._trailMo:isFirstPassClg(extClgActId))

	if not string.nilorempty(data.tabPath) then
		local spriteName = GameUrl.getBigbgPngUrl(data.tabPath)

		uGuiUtil.setSpriteToImage(imgBg, uGuiUtil.SpriteType.BigBg, spriteName, function()
			imgBg:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end)
	else
		uGuiUtil.clearImage(imgBg)
	end

	GameUtil.addClickHandler(mainGo, function()
		if not isInTime then
			FloatWordMgr.instance:show("挑战未开启")

			return
		end

		if self._curTabIdx == tabIdx then
			return
		end

		self._curTabIdx = tabIdx

		self:_onUpdate()
	end)
end

function UltimateTrialMainView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local imgBg = goutil.findChild(mainGo, "imgBg")

	uGuiUtil.clearImage(imgBg)
	GameUtil.rmClickHandler(mainGo)
end

function UltimateTrialMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function UltimateTrialMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function UltimateTrialMainView:_onClickBtnClg(mode)
	local clgIndex = self._curTabIdx
	local clgData = UltimateTrialConfig.instance:getChallengeDataByIndex(self._activityId, clgIndex, mode)

	if clgData then
		if not clgData.clgActId then
			local clgActId = 0
			local result = UltimateTrialController.instance:getTryResultAndTipsEnterUltClg(true, clgActId)

			if result ~= GameEnum.ResultCode.Success then
				return
			end

			GotoMgr.gotoByString(clgData.jumpStr)
		end
	end
end

function UltimateTrialMainView:_onClickBtnSignInBuff()
	local result = UltimateTrialController.instance:getTryResultAndTipsSignInBuff(true, self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UltimateTrialController.instance:sendPM_UltimateTrialSignInReq(self._activityId)
end

return UltimateTrialMainView
