-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRedpackListView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRedpackListView", package.seeall)

local RedpackState = {
	Expire = 3,
	NotGetRedpack = 5,
	GetRedpack = 4,
	Remain = 1,
	Empty = 2
}
local GoddessCompetitionRedpackListView = class("GoddessCompetitionRedpackListView", ViewComponent)

function GoddessCompetitionRedpackListView:ctor()
	GoddessCompetitionRedpackListView.super.ctor(self)
end

function GoddessCompetitionRedpackListView:unbindEvents()
	GoddessCompetitionRedpackListView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRecord)
end

function GoddessCompetitionRedpackListView:bindEvents()
	GoddessCompetitionRedpackListView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickRecord, self)
end

function GoddessCompetitionRedpackListView:buildUI()
	GoddessCompetitionRedpackListView.super.buildUI(self)

	self._btnRecord = self:getGo("container/btnRecord")
	self._txtTips = self:getTxt("container/txtTips")
	self._txtTipsGain = self:getTxt("container/txtTipsGain")

	local tableviewGo = self:getGo("container/mid/tableview")
	local cellGo = self:getGo("container/mid/tablecell")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollRect = tableviewGo:GetComponent(ComponentType.ScrollRect)
	self._goEmpty = self:getGo("container/mid/goEmpty")
end

function GoddessCompetitionRedpackListView:onExit()
	GoddessCompetitionRedpackListView.super.onExit(self)
	self._tableview:dispose()
	removetimer(self._updateInfo, self)
end

function GoddessCompetitionRedpackListView:onEnter()
	GoddessCompetitionRedpackListView.super.onEnter(self)

	self._activityId = GoddessCompetitionModel.instance:getCurActId()
	self._curTypeId = checknumber(self:getFirstParam())

	GoddessCompetitionController.instance:getRedPackList(self._activityId, self._curTypeId)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGetRedPackListRes, self._updateUIByInfo, self)
	self:_updateUIByCfg()
	settimer(60, self._updateInfo, self, false)
end

function GoddessCompetitionRedpackListView:_updateUIByCfg()
	self._actCfg = GoddessCompetitionConfig.instance:getActCfg(self._activityId)
	self._typeCfgs = GoddessCompetitionConfig.instance:getRedPackCfgsByType(self._activityId, self._curTypeId)
	self._txtTips.text = string.format("为对应女神增加%s人气后，即可领取她的应援红包", self._actCfg.gainRedPackNeedPopularity)
end

function GoddessCompetitionRedpackListView:_updateInfo()
	GoddessCompetitionController.instance:getRedPackList(self._activityId, self._curTypeId)
end

function GoddessCompetitionRedpackListView:_updateUIByInfo()
	local info = GoddessCompetitionModel.instance:getRedPackListInfo(self._activityId, self._curTypeId)

	if not info.gainTimesList then
		self._gainTimeMap = {}

		for _, timeInfo in ipairs(info.gainTimesList) do
			self._gainTimeMap[timeInfo.redPackDefineId] = timeInfo.todayTimes
		end

		local showTxt = ""

		for _, cfg in ipairs(self._typeCfgs) do
			local defineId = cfg.redPackId
			local time = checknumber(self._gainTimeMap[defineId])
			local leftTime = cfg.dailyGainLimit - time
			local showColor = leftTime > 0 and "#73FFC5" or "#eb4642"

			showTxt = showTxt == "" and string.format("%s:<color=%s>%s</color>/%s", cfg.name, showColor, leftTime, cfg.dailyGainLimit) or showTxt .. "," .. string.format("%s:<color=%s>%s</color>/%s", cfg.name, showColor, leftTime, cfg.dailyGainLimit)
		end

		self._txtTipsGain.text = string.format("红包领取：%s", showTxt)

		if not info.totalPopularityList then
			self._myPopularityMap = {}

			for _, popularityInfo in ipairs(info.totalPopularityList) do
				self._myPopularityMap[popularityInfo.faceId] = checknumber(popularityInfo.popularity)
			end

			if not info.redPackList then
				self._curRedPackList = {}

				for i, redPackInfo in ipairs(info.redPackList) do
					table.insert(self._curRedPackList, redPackInfo)

					redPackInfo._curState = self:_getCurRedpackState(redPackInfo)
				end

				table.sort(self._curRedPackList, function(a, b)
					local aRedPackCfg = GoddessCompetitionConfig.instance:getRedPackCfg(self._activityId, a.redPackDefineId)
					local aDailyLimit = aRedPackCfg.dailyGainLimit
					local aTodayGainTimes = self._gainTimeMap[a.redPackDefineId]
					local aIsLimit = aDailyLimit <= aTodayGainTimes
					local bRedPackCfg = GoddessCompetitionConfig.instance:getRedPackCfg(self._activityId, b.redPackDefineId)
					local bDailyLimit = bRedPackCfg.dailyGainLimit
					local bTodayGainTimes = self._gainTimeMap[b.redPackDefineId]
					local bIsLimit = bDailyLimit <= bTodayGainTimes

					if aIsLimit ~= bIsLimit then
						return bIsLimit
					elseif a._curState == b._curState then
						return aRedPackCfg.incPopularity > bRedPackCfg.incPopularity
					else
						return a._curState < b._curState
					end
				end)
				self._tableview:reloadData(self._curRedPackList)
				goutil.setActive(self._goEmpty, #self._curRedPackList == 0)
			end
		end
	end
end

function GoddessCompetitionRedpackListView:_onClickRedpack(data)
	local curState = data._curState

	if curState == RedpackState.Remain then
		local faceId = data.goddessFaceId
		local defineId = data.redPackDefineId
		local rdCfg = GoddessCompetitionConfig.instance:getRedPackCfg(self._activityId, defineId)
		local popularValue = checknumber(self._myPopularityMap[faceId])
		local grabLimitValue = self._actCfg.gainRedPackNeedPopularity

		if checknumber(popularValue) < checknumber(grabLimitValue) then
			TipsFacade.instance:openCommonTips(string.format("累计为对应女神增加的人气值达到%s，即可领取该女神的红包", grabLimitValue))

			return
		end

		local dailyLimit = rdCfg.dailyGainLimit
		local todayGainTimes = self._gainTimeMap[defineId]
		local isLimit = dailyLimit <= todayGainTimes

		if isLimit then
			TipsFacade.instance:openCommonTips("当日领取该类型红包已达上限")

			return
		end

		UIStateManager.instance:push(ViewName.GoddessCompetitionRedpackPopupView, self._activityId, defineId, data.redPackId, faceId)
	elseif curState == RedpackState.Empty then
		TipsFacade.instance:openCommonTips("该红包已抢完")
	elseif curState == RedpackState.GetRedpack then
		TipsFacade.instance:openCommonTips("已领过此红包！")
	elseif curState == RedpackState.NotGetRedpack then
		TipsFacade.instance:openCommonTips("该红包已抢完")
	else
		TipsFacade.instance:openCommonTips("本红包已过期，无法领取")
	end
end

function GoddessCompetitionRedpackListView:_onClickRecord()
	UIStateManager.instance:push(ViewName.GoddessCompetitionRedpackRecordView)
end

function GoddessCompetitionRedpackListView:_updateCell(view, cell, data)
	local goOpen = goutil.findChild(cell.gameObject, "container/open")
	local goddessHeadConOpen = goutil.findChild(cell.gameObject, "container/open/goddessHeadGo/headIcon")
	local goClose = goutil.findChild(cell.gameObject, "container/close")
	local goddessHeadConClose = goutil.findChild(cell.gameObject, "container/close/goddessHeadGo/headIcon")
	local headCon = goutil.findChild(cell.gameObject, "container/headGo")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "container/name/txtName")
	local getCon = goutil.findChild(cell.gameObject, "container/get")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "container/get/txtGet")
	local getIcon = goutil.findChild(cell.gameObject, "container/get/getIcon")
	local txtCount = goutil.findChildTextComponent(cell.gameObject, "container/count/txtCount")
	local redpack = goutil.findChild(cell.gameObject, "container/redPack")
	local btn = goutil.findChild(cell.gameObject, "container/btn")
	local effectCon = goutil.findChild(cell.gameObject, "container/redPack/effectCon")
	local defineId = data.redPackDefineId
	local rpCfg = GoddessCompetitionConfig.instance:getRedPackCfg(self._activityId, defineId)
	local cfgParams = string.split(rpCfg.param, "&")

	if rpCfg.type == 1 then
		goutil.setActive(getCon, true)

		local matStr = cfgParams[1]
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

		MaterialMgr.setIcon(getIcon, matType, matId)

		txtNum.text = matNum
	elseif rpCfg.type == 2 then
		txtNum.text = ""

		goutil.setActive(getCon, false)
	end

	GameUtil.SetGray(redpack, data._curState == RedpackState.Expire)
	HeadItemController.instance:setHeadCellByInfo(headCon, data.headInfo)

	txtName.text = string.format("%s-%s", data.areaId, data.headInfo.userName)

	local imgPath = string.split(rpCfg.imgPath, "#")
	local closeImg, openImg = imgPath[1], imgPath[2]
	local isOpen = false

	if data._curState == RedpackState.GetRedpack then
		isOpen = true
	elseif data._curState == RedpackState.NotGetRedpack then
		isOpen = true
	end

	uGuiUtil.setSpriteToImage(redpack, uGuiUtil.SpriteType.BigBg, GameUrl.getGoddessRedpackUrl(isOpen and openImg or closeImg))
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickRedpack, self, data))

	local petCon = isOpen and goddessHeadConOpen or goddessHeadConClose

	MaterialMgr.setIcon(petCon, MatType.PET_SKIN, data.goddessFaceId)
	GameUtil.SetActive(goOpen, isOpen)
	GameUtil.SetActive(goClose, not isOpen)
	self:_removeCellEff(effectCon)

	local txtLeftTime = goutil.findChildTextComponent(cell.gameObject, "container/leftTime/txtCount")
	local leftTime = goutil.findChild(cell.gameObject, "container/leftTime")

	goutil.setActive(leftTime, false)

	local content = ""

	if data._curState == RedpackState.Remain then
		local EffPath = "20230303/hongbao/fx_ui_hongbao_kelingqu.prefab"

		self:_playCellEff(effectCon, EffPath, 0, 0, true, nil)

		content = string.format("剩余%s个", data.remainCount)

		goutil.setActive(leftTime, true)

		local leftSecs = checknumber(data.timestamp) / 1000 + rpCfg.duration - ServerTime.now()

		if leftSecs <= 60 then
			txtLeftTime.text = "剩余：不足一分钟"
		else
			local hour, min, sec = GameUtil.getTimeHHMMSS(leftSecs)

			txtLeftTime.text = string.format("剩余：%02d:%02d", hour, min)
		end
	else
		content = data._curState == RedpackState.Empty and "已抢完" or data._curState == RedpackState.GetRedpack and "成功领取" or data._curState == RedpackState.NotGetRedpack and "已领完" or "已过期"
	end

	txtCount.text = content
end

function GoddessCompetitionRedpackListView:_clearCell(cell)
	local effectCon = goutil.findChild(cell.gameObject, "container/redPack/effectCon")

	self:_removeCellEff(effectCon)

	local goddessHeadConOpen = goutil.findChild(cell.gameObject, "container/open/goddessHeadGo/headIcon")

	MaterialMgr.clearIcon(goddessHeadConOpen)

	local getIcon = goutil.findChild(cell.gameObject, "container/get/getIcon")

	MaterialMgr.clearIcon(getIcon)

	local goddessHeadConClose = goutil.findChild(cell.gameObject, "container/close/goddessHeadGo/headIcon")

	MaterialMgr.clearIcon(goddessHeadConClose)

	local redpack = goutil.findChild(cell.gameObject, "container/redPack")

	uGuiUtil.clearImage(redpack)

	local btn = goutil.findChild(cell.gameObject, "container/btn")

	GameUtil.rmClickHandler(btn)

	local headCon = goutil.findChild(cell.gameObject, "container/headGo")

	HeadItemController.instance:resetHeadCell(headCon)
end

function GoddessCompetitionRedpackListView:_getCurRedpackState(data)
	local defineId = data.redPackDefineId
	local rpCfg = GoddessCompetitionConfig.instance:getRedPackCfg(self._activityId, defineId)
	local isExpire = ServerTime.now() > checknumber(data.timestamp) / 1000 + rpCfg.duration

	if isExpire then
		return RedpackState.Expire
	elseif data.state == 0 then
		return (data.remainCount > 0 or nil) and (RedpackState.Remain or RedpackState.Empty)
	elseif data.state == 1 then
		return RedpackState.GetRedpack
	elseif data.state == 2 then
		return RedpackState.NotGetRedpack
	end

	return 0
end

function GoddessCompetitionRedpackListView:_playCellEff(go, path, x, y, isLoop, callback)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local function loadCallBack(view, uiEffect)
		uiEffect:setScrollRectClipping(self._scrollRect)
		uiEffect:setParent(go.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(x, y, 0)

		uiEffect.hideEffWhileNotOnTop = true
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, path, nil, x, y, isLoop, nil, callback, loadCallBack)
end

function GoddessCompetitionRedpackListView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

return GoddessCompetitionRedpackListView
