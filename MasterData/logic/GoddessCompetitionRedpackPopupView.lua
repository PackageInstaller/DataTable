-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRedpackPopupView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRedpackPopupView", package.seeall)

local GoddessCompetitionRedpackPopupView = class("GoddessCompetitionRedpackPopupView", ViewComponent)
local RedpackState = {
	Expire = 3,
	NotGetRedpack = 5,
	GetRedpack = 4,
	Remain = 1,
	Empty = 2
}
local PopUpType = {
	Close = 1,
	Open = 2
}

function GoddessCompetitionRedpackPopupView:ctor()
	GoddessCompetitionRedpackPopupView.super.ctor(self)
end

function GoddessCompetitionRedpackPopupView:unbindEvents()
	GoddessCompetitionRedpackPopupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._cBtnClose)
end

function GoddessCompetitionRedpackPopupView:bindEvents()
	GoddessCompetitionRedpackPopupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._cBtnClose, self._onClickOpen, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function GoddessCompetitionRedpackPopupView:buildUI()
	GoddessCompetitionRedpackPopupView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._cGoClose = self:getGo("closeGo")
	self._cBtnClose = goutil.findChild(self._cGoClose, "btn")
	self._cGoHead = goutil.findChild(self._cGoClose, "headGo")
	self._cGoPetHead = goutil.findChild(self._cGoClose, "goddessHeadGo/headIcon")
	self._cTxtName = goutil.findChildTextComponent(self._cGoClose, "nameGo/nameTxt")
	self._cPrize = goutil.findChild(self._cGoClose, "prize")
	self._cTxtPrize = goutil.findChildTextComponent(self._cGoClose, "prize/descTxt")
	self._cIconPrize = goutil.findChild(self._cGoClose, "prize/prizeIconGo")
	self._oGoOpenCol = self:getGo("openCol")
	self._oGoOpen = self:getGo("openCol/openGo")
	self._oGoHead = goutil.findChild(self._oGoOpen, "headGo")
	self._oTxtName = goutil.findChildTextComponent(self._oGoOpen, "nameGo/nameTxt")
	self._oTxtDesc = goutil.findChildTextComponent(self._oGoOpen, "descGo/descTxt")
	self._oBtnVote = goutil.findChildButtonComponent(self._oGoOpen, "btnVote")
	self._petCon = self:getGo("openCol/petCard/pet/petIcon")
	self._effShowGo = self:getGo("effShowGo")
	self._goContinue = self:getGo("continue")
	self._goTableview = self:getGo("openCol/openGo/itemListSR")

	local goCell = self:getGo("openCol/openGo/recordItem")

	self._tableview = ScrollerList.create(self._goTableview, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._oPool = self:getGo("openCol/pool")

	local item1 = self:getGo("openCol/pool/item")
	local Scrollerview1 = self:getGo("openCol/pool/ScrollerviewMy")

	self._tableviewPMy = ScrollerList.create(Scrollerview1, item1, GameUtil.handler(self._updateItemCellMy, self), GameUtil.handler(self._clearItemCellMy, self))

	self._tableviewPMy:setCenterMode(true)

	self._cPool = self:getGo("closeGo/pool")

	local item2 = self:getGo("closeGo/pool/item")
	local Scrollerview2 = self:getGo("closeGo/pool/Scrollerview")

	self._tableviewP2 = ScrollerList.create(Scrollerview2, item2, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	local ScrollerviewAll = self:getGo("openCol/pool/ScrollerviewAll")

	self._tableviewPAll = ScrollerList.create(ScrollerviewAll, item1, GameUtil.handler(self._updateItemCellAll, self), GameUtil.handler(self._clearItemCellMy, self))
end

function GoddessCompetitionRedpackPopupView:onExit()
	GoddessCompetitionRedpackPopupView.super.onExit(self)
	self._tableview:dispose()
	MaterialMgr.resetAll(self._cGoPetHead)
	MaterialMgr.resetAll(self._cIconPrize)
	uGuiUtil.clearImage(self._petCon)
	uGuiUtil.clearImage(self._cGoClose)
	uGuiUtil.clearImage(self._oGoOpen)
	HeadItemController.instance:resetHeadCell(self._cGoHead)
	HeadItemController.instance:resetHeadCell(self._oGoHead)
	GameUtil.SetActive(self._cGoClose, false)
	GameUtil.SetActive(self._oGoOpenCol, false)
	GameUtil.SetActive(self._goContinue, false)
	self:_removeCellEff(self._effShowGo)

	if self._activityId > 0 and self._redPackCfg then
		GoddessCompetitionController.instance:getRedPackList(self._activityId, self._redPackCfg.type)
	end
end

function GoddessCompetitionRedpackPopupView:onEnter()
	GoddessCompetitionRedpackPopupView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		TipsFacade.instance:openCommonTips("不在活动期间")
		self:close()
	end

	self._redPackDefineId = checknumber(params[2])
	self._redPackId = checknumber(params[3])
	self._goddessFaceId = checknumber(params[4])
	self._userId = tostring(RoleModel.instance:getUserId())
	self._popupType = PopUpType.Close

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGetBaseInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGetRedPackInfoRes, self._updateUIByRedpackInfo, self)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGrabRedPackRes, self._handleGrabRedPack, self)
	self.addGEvent(self, GlobalNotify.PM_GoddessCompetitionError, self._handleError, self)
	GoddessCompetitionController.instance:getInfo(self._activityId)

	self._checkData = false

	GameUtil.SetActive(self._cGoClose, false)
	GameUtil.SetActive(self._oGoOpenCol, false)
	GameUtil.SetActive(self._goContinue, false)
end

function GoddessCompetitionRedpackPopupView:_updateUIByCfg()
	self._actCfg = GoddessCompetitionConfig.instance:getActCfg(self._activityId)
	self._redPackCfg = GoddessCompetitionConfig.instance:getRedPackCfg(self._activityId, self._redPackDefineId)

	local imgPath = string.split(self._redPackCfg.imgPath, "#")
	local imgClose, imgOpen = imgPath[4], imgPath[5]

	uGuiUtil.setSpriteToImage(self._cGoClose, uGuiUtil.SpriteType.BigBg, GameUrl.getGoddessRedpackUrl(imgClose))
	uGuiUtil.setSpriteToImage(self._oGoOpen, uGuiUtil.SpriteType.BigBg, GameUrl.getGoddessRedpackUrl(imgOpen))

	local petCo = CharacterConfig.instance:getModelCo(self._goddessFaceId)

	uGuiUtil.setSpriteToImage(self._petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(petCo.cardName))
	MaterialMgr.setIcon(self._cGoPetHead, MatType.PET_SKIN, self._goddessFaceId)
	GameUtil.SetActive(self._cPrize, false)
	GameUtil.SetActive(self._cPool, false)
	GameUtil.SetActive(self._oPool, false)

	local cfgParams = string.split(self._redPackCfg.param, "&")

	if self._redPackCfg.type == 1 then
		GameUtil.setAnchoredPos(self._cGoClose, -5.5, -0.4)
		GameUtil.SetActive(self._cPrize, true)

		local matStr = cfgParams[1]
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

		MaterialMgr.setIcon(self._cIconPrize, matType, matId)

		self._cTxtPrize.text = matNum
	elseif self._redPackCfg.type == 2 then
		GameUtil.setAnchoredPos(self._cGoClose, -160, -0.4)

		local prizeList = {}

		table.insert(prizeList, {
			showRate = 100,
			str = cfgParams[1]
		})

		local planId = checknumber(cfgParams[2])
		local cfgs = GoddessCompetitionConfig.instance:getPoolCfgs(planId)

		for _, cfg in ipairs(cfgs) do
			local addStrs = string.split(cfg.content, "#")

			for _, str in ipairs(addStrs) do
				table.insert(prizeList, {
					str = str,
					showRate = cfg.showRate
				})
			end
		end

		GameUtil.SetActive(self._cPool, true)
		GameUtil.SetActive(self._oPool, true)
		self._tableviewPAll:reloadData(prizeList)
		self._tableviewP2:reloadData(prizeList)
	end
end

function GoddessCompetitionRedpackPopupView:_updateUIByInfo()
	local baseInfo = GoddessCompetitionModel.instance:getBaseInfo(self._activityId)

	if not baseInfo.gainTimesList then
		self._gainTimeMap = {}

		for _, timeInfo in ipairs(baseInfo.gainTimesList) do
			self._gainTimeMap[timeInfo.redPackDefineId] = timeInfo.todayTimes
		end

		if not baseInfo.totalPopularityList then
			self._myPopularityMap = {}

			for _, popularityInfo in ipairs(baseInfo.totalPopularityList) do
				self._myPopularityMap[popularityInfo.faceId] = checknumber(popularityInfo.popularity)
			end

			GoddessCompetitionController.instance:getRedPackInfo(self._activityId, self._redPackCfg.type, self._redPackId)
		end
	end
end

function GoddessCompetitionRedpackPopupView:_updateUIByRedpackInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local rpInfo = info.redPackView

	self._redPackInfo = rpInfo
	self._curRPState = 0

	local isExpire = ServerTime.now() > checknumber(rpInfo.timestamp) / 1000 + self._redPackCfg.duration

	if isExpire then
		self._curRPState = RedpackState.Expire
	elseif rpInfo.state == 0 then
		if rpInfo.remainCount > 0 then
			self._curRPState = RedpackState.Remain or RedpackState.Empty
		end
	elseif rpInfo.state == 1 then
		self._curRPState = RedpackState.GetRedpack
	elseif rpInfo.state == 2 then
		self._curRPState = RedpackState.NotGetRedpack
	end

	self:_refreshView()

	if self._checkData then
		return
	end

	GameUtil.SetActive(self._cGoClose, false)
	GameUtil.SetActive(self._oGoOpenCol, false)
	GameUtil.SetActive(self._goContinue, false)

	local popularValue = checknumber(self._myPopularityMap[self._goddessFaceId])
	local grabLimitValue = self._actCfg.gainRedPackNeedPopularity

	if checknumber(popularValue) < checknumber(grabLimitValue) then
		TipsFacade.instance:openCommonTips(string.format("累计为这名女神增加的人气值达到%s后可领取红包", grabLimitValue))
		self:close()

		return
	end

	local dailyLimit = self._redPackCfg.dailyGainLimit
	local todayGainTimes = self._gainTimeMap[self._redPackDefineId]
	local isLimit = dailyLimit <= todayGainTimes

	if isLimit then
		TipsFacade.instance:openCommonTips("当日领取该类型红包已达上限")
		self:close()

		return
	end

	if self._curRPState == RedpackState.Expire then
		TipsFacade.instance:openCommonTips("该红包已过期")
		self:close()

		return
	elseif self._curRPState == RedpackState.GetRedpack then
		TipsFacade.instance:openCommonTips("该红包已领取")
		self:close()

		return
	elseif self._curRPState == RedpackState.NotGetRedpack then
		TipsFacade.instance:openCommonTips("该红包已领完")
		self:close()

		return
	elseif self._curRPState == RedpackState.Empty then
		TipsFacade.instance:openCommonTips("该红包已领完")
		self:close()

		return
	end

	self._checkData = true

	GoddessCompetitionController.instance:grabRedPack(self._activityId, self._redPackDefineId, self._redPackId)
end

function GoddessCompetitionRedpackPopupView:_handleError(status)
	if status == -2 then
		TipsFacade.instance:openCommonTips("红包数据已刷新")
	end

	self:close()
end

function GoddessCompetitionRedpackPopupView:_handleGrabRedPack(msg)
	local info = GameUtil.pbToTable(msg)

	self._changeSetId = info.changeSetId
	self._grabSuc = info.grabSuc

	if self._grabSuc then
		self._popupType = PopUpType.Close or PopUpType.Open
	end

	if not self._grabSuc then
		TipsFacade.instance:openCommonTips("该红包已领完")
		self:close()
	end

	GameUtil.SetActive(self._cGoClose, self._popupType == PopUpType.Close)
	GameUtil.SetActive(self._oGoOpenCol, self._popupType == PopUpType.Open)
	GameUtil.SetActive(self._goContinue, self._popupType == PopUpType.Open)
end

function GoddessCompetitionRedpackPopupView:_refreshView()
	GameUtil.SetActive(self._cGoClose, self._popupType == PopUpType.Close)
	GameUtil.SetActive(self._oGoOpenCol, self._popupType == PopUpType.Open)
	GameUtil.SetActive(self._goContinue, self._popupType == PopUpType.Open)
	self:_playCellEff(self._effShowGo, (self._popupType == PopUpType.Open or nil) and "20230303/hongbao/fx_ui_hongbao_dakai.prefab", 0, 0, true, nil)
	HeadItemController.instance:setHeadCellByInfo(self._cGoHead, self._redPackInfo.headInfo)
	HeadItemController.instance:setHeadCellByInfo(self._oGoHead, self._redPackInfo.headInfo)
	GameUtil.setUITextColorIdx(self._cTxtPrize, 0)

	self._cTxtName.text = string.format("%s-%s", self._redPackInfo.areaId, self._redPackInfo.headInfo.userName)
	self._oTxtName.text = self._redPackInfo.headInfo.userName

	local getedCount = self._redPackCfg.gainCount - checknumber(self._redPackInfo.remainCount)
	local content = string.format("当前领取情况：%s/%s个", getedCount, self._redPackCfg.gainCount)

	if self._redPackInfo.state == 2 then
		content = content .. "/n手慢啦，没抢上哦"
	end

	self._oTxtDesc.text = content

	if not self._redPackInfo.accountList then
		local showInfoList = {}
		local myRedpackRecord

		for i, v in ipairs(self._redPackInfo.accountList) do
			if checknumber(v.headInfo.userId) == checknumber(self._userId) then
				myRedpackRecord = v
			else
				table.insert(showInfoList, v)
			end
		end

		if myRedpackRecord then
			table.insert(showInfoList, 1, myRedpackRecord)
		end

		goutil.setActive(self._goTableview, false)

		if self._redPackCfg.type == 1 then
			goutil.setActive(self._goTableview, true)
			self._tableview:reloadData(showInfoList)
		elseif self._redPackCfg.type == 2 then
			local cfgParams = string.split(self._redPackCfg.param, "&")
			local matStr = cfgParams[1]
			local planId = checknumber(cfgParams[2])
			local cfgs = GoddessCompetitionConfig.instance:getPoolCfgs(planId)

			if not myRedpackRecord then
				self._tableviewPMy:reloadData({})

				return
			end

			local prizeId = checknumber(myRedpackRecord.param)
			local cfg = cfgs[prizeId]
			local content = cfg.content
			local prizeList = string.split(content .. "#" .. matStr, "#")

			self._tableviewPMy:reloadData(prizeList)
		end
	end
end

function GoddessCompetitionRedpackPopupView:_updateCell(view, cell, data)
	local goKing = goutil.findChild(cell.gameObject, "kingGo")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/nameTxt")
	local txtGet = goutil.findChildTextComponent(cell.gameObject, "getTxt")
	local imgName = goutil.findChild(cell.gameObject, "name")
	local goHead = goutil.findChild(cell.gameObject, "userGo")

	HeadItemController.instance:setHeadCellByInfo(goHead, data.headInfo)

	txtName.text = data.headInfo.userName
	txtGet.text = data.param

	GameUtil.SetActive(goKing, data.isBestLuck)
	GameUtil.setUIImageColorIdx(imgName, data.headInfo.userId == self._userId and 1 or 0)
end

function GoddessCompetitionRedpackPopupView:_clearCell(cell)
	local goHead = goutil.findChild(cell.gameObject, "userGo")

	HeadItemController.instance:resetHeadCell(goHead)
end

function GoddessCompetitionRedpackPopupView:_playCellEff(go, path, x, y, isLoop, callback)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local function loadCallBack(view, uiEffect)
		uiEffect:setParent(go.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(x, y, 0)

		uiEffect.hideEffWhileNotOnTop = true
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, path, nil, x, y, isLoop, nil, callback, loadCallBack)
end

function GoddessCompetitionRedpackPopupView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function GoddessCompetitionRedpackPopupView:_onClickOpen()
	self._popupType = PopUpType.Open

	GoddessCompetitionController.instance:getRedPackInfo(self._activityId, self._redPackCfg.type, self._redPackId)
end

function GoddessCompetitionRedpackPopupView:_onClickClose()
	if self._popupType == PopUpType.Open then
		self:close()

		if self._grabSuc then
			MaterialController.instance:showChangeSetInTemp(self._changeSetId)
		end
	end
end

function GoddessCompetitionRedpackPopupView:_updateItemCell(view, cell, data)
	local icon = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.setCellByCfg(data.str, icon)

	local txt = goutil.findChildTextComponent(cell.gameObject, "txt")

	txt.text = string.format("%s%%", data.showRate)
end

function GoddessCompetitionRedpackPopupView:_clearItemCell(cell)
	local icon = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(icon)
end

function GoddessCompetitionRedpackPopupView:_updateItemCellMy(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function GoddessCompetitionRedpackPopupView:_updateItemCellAll(view, cell, data)
	MaterialMgr.setCellByCfg(data.str, cell.gameObject)
end

function GoddessCompetitionRedpackPopupView:_clearItemCellMy(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return GoddessCompetitionRedpackPopupView
