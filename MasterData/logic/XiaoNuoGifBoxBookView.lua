-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/XiaoNuoGifBoxBookView.lua

module("logic.extensions.caiqingdraw.view.XiaoNuoGifBoxBookView", package.seeall)

local XiaoNuoGifBoxBookView = class("XiaoNuoGifBoxBookView", ViewComponent)

function XiaoNuoGifBoxBookView:ctor()
	XiaoNuoGifBoxBookView.super.ctor(self)
end

function XiaoNuoGifBoxBookView:unbindEvents()
	XiaoNuoGifBoxBookView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnAnim)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnTenLottery)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function XiaoNuoGifBoxBookView:bindEvents()
	XiaoNuoGifBoxBookView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnAnim, self._onClickAnim, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnTenLottery, self._onClickTenLottery, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
end

function XiaoNuoGifBoxBookView:buildUI()
	XiaoNuoGifBoxBookView.super.buildUI(self)

	self._costIcon = self:getImg("hidecom/txtCost/icon")
	self._txtTime = self:getTxt("hidecom/time/txtTime")
	self._txtlotteryNum = self:getTxt("hidecom/lotteryNum/txtNum")
	self._txtCost = self:getTxt("hidecom/txtCost")
	self._btnClose = self:getBtn("hidecom/btnClose")
	self._btnTip = self:getBtn("hidecom/btnTip")
	self._btnLottery = self:getGo("hidecom/btnLottery")
	self._btnTask = self:getBtn("hidecom/btnTask")
	self._btnAnim = self:getBtn("hidecom/btnAnim")
	self._btnTenLottery = self:getBtn("hidecom/btnTenLottery")
	self._roleView_role1 = self:getGo("hidecom/roleView/role1")
	self._roleView_role2 = self:getGo("hidecom/roleView/role2")
	self._rdTenLottery = self:getGo("hidecom/btnLottery/redpoint")
	self._rdTask = self:getGo("hidecom/btnTask/redpoint")
	self._animSelect = self:getGo("hidecom/btnAnim/imgSelect")
	self._tenSelect = self:getGo("hidecom/btnTenLottery/imgSelect")
	self._goldBarCon = self:getGo("hidecom/goldBarCon")
	self._tableview = self:getGo("hidecom/lotteryList/tableview")
	self._cell = self:getGo("hidecom/lotteryList/cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._effNode = self:getGo("hidecom/effNode")
	self._jumptos = self:getGo("hidecom/jumptos")
	self._btnRight = self:getGo("hidecom/btnRight")
	self._btnLeft = self:getGo("hidecom/btnLeft")
	self._jumpto = self:getGo("hidecom/jumptos/jumpto")

	goutil.setActive(self._jumpto, false)

	self._redpointLeft = self:getGo("hidecom/btnLeft/redpoint")
	self._redpointRight = self:getGo("hidecom/btnRight/redpoint")
	self._lockLeft = self:getGo("hidecom/btnLeft/lock")
	self._lockRight = self:getGo("hidecom/btnRight/lock")
	self._effPos = self:getGo("effPos")
	self._hideCom = self:getGo("hidecom")
	self._jumpToCellList = {}
	self._title2 = self:getTxt("hidecom/bg/rawimg/title2")
	self._title1 = self:getTxt("hidecom/bg/rawimg/title1")
end

function XiaoNuoGifBoxBookView:onExit()
	XiaoNuoGifBoxBookView.super.onExit(self)
	self._scrollList:dispose()

	if self._lotteryEffect then
		UIEffectManager.instance:stopEffect(self._lotteryEffect)

		self._lotteryEffect = nil
	end

	if self._effectEnoughCost then
		UIEffectManager.instance:stopEffect(self._effectEnoughCost)

		self._effectEnoughCost = nil
	end

	GlobalDispatcher:removeListener(GlobalNotify.CaiQingDrawGetInfoRes, self._initView, self)
	GlobalDispatcher:removeListener(GlobalNotify.CaiQingDrawPrizeRes, self._refreshView, self)
	RedPointController.instance:unregRedPoint(self._rdTenLottery)
	RedPointController.instance:unregRedPoint(self._rdTask)
	RedPointController.instance:unregRedPoint(self._redpointLeft)
	RedPointController.instance:unregRedPoint(self._redpointRight)

	for i, cell in ipairs(self._jumpToCellList) do
		GameUtil.rmClickHandler(cell.btn)
		uGuiUtil.clearImage(cell.imgBg)
		RedPointController.instance:unregRedPoint(cell.redpoint)
	end
end

function XiaoNuoGifBoxBookView:onEnter()
	XiaoNuoGifBoxBookView.super.onEnter(self)

	self._showJumpToId = self._showJumpToId or 1

	self:_initAnimPre()
	self:_setTimeUI()
	self:_lotteryCost()
	self:_animTenSelectState()
	GlobalDispatcher:addListener(GlobalNotify.CaiQingDrawGetInfoRes, self._initView, self)
	GlobalDispatcher:addListener(GlobalNotify.CaiQingDrawPrizeRes, self._refreshView, self)
	RedPointController.instance:regRedPoint(self._rdTenLottery, RedPointModel.ID_CAIQINGDRAW_TENLOTTERY)
	RedPointController.instance:regRedPoint(self._rdTask, RedPointModel.ID_CAIQINGDRAW_TASK)
	CaiQingDrawAgent.instance:sendPM_CaiQingDrawGetInfoReq(self._activityId)
end

function XiaoNuoGifBoxBookView:_initAnimPre()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Caiqingdraw)
	end

	self._activityCfg = CaiQingDrawConfig.instance:getActivityCfgById(self._activityId)
	self._jumpToPlanId = self._activityCfg.jumpToPlan
	self._jumpToPlanCfgs = CaiQingDrawConfig.instance:getJumpToPlanCfgsById(self._jumpToPlanId) or {}
	self._animationPreKey = self.__cname

	self:_swithToTag(self._showJumpToId)
end

function XiaoNuoGifBoxBookView:_initView(msg)
	CaiqingdrawModel.instance:_setInfoData(msg)
	self._scrollList:reloadData(self:_sortPrizeCfg())

	self._txtlotteryNum.text = CaiqingdrawModel.instance:_getRewardProgress()

	local isRed = self:_canLottery(true)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_CAIQINGDRAW_TENLOTTERY, isRed)
	GameUtil.SetActive(self._effNode, false)
	GameUtil.SetActive(self._imgSlogan, true)
	GameUtil.SetActive(self._btnAnim, true)
	GameUtil.SetActive(self._btnTenLottery, true)

	local costList = string.split(self._activityCfg.cost, "#")
	local isEnough = true

	for i, v in ipairs(costList) do
		local matType, matId, matNum = MaterialMgr.getMatParams(v)

		if not MaterialModel.instance:IsEnough(matType, matId, matNum) then
			isEnough = false

			break
		end
	end

	if self._effectEnoughCost then
		UIEffectManager.instance:stopEffect(self._effectEnoughCost)

		self._effectEnoughCost = nil
	end

	if isEnough then
		local pathName = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"

		self._effectEnoughCost = UIEffectManager.instance:playEffect(self, pathName, nil, 0, 0, true, nil, nil, function(target, eff)
			eff:setClipping(self.mainGO:GetComponent(goutil.Type_RectTransform))
		end, self)

		self._effectEnoughCost:setParent(self._btnLottery.transform)
		self._effectEnoughCost:setScale(2, 1.7, 1)
		self._effectEnoughCost:setLocalPos(0, 10, 0)
	end
end

function XiaoNuoGifBoxBookView:_refreshView()
	CaiQingDrawAgent.instance:sendPM_CaiQingDrawGetInfoReq(self._activityId)
end

function XiaoNuoGifBoxBookView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	txtNum.text = CaiqingdrawModel.instance:_isPlayerRewardGeted(data.id) and "已抽中" or langPara("%d抽必得", data.maxHit)

	MaterialMgr.setCellByCfg(data.gain, item)
	GameUtil.SetActive(geted, CaiqingdrawModel.instance:_isPlayerRewardGeted(data.id))
end

function XiaoNuoGifBoxBookView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function XiaoNuoGifBoxBookView:_sortPrizeCfg()
	local planId = self._activityCfg.drawPlan
	local maxHitRewardCfg = CaiQingDrawConfig.instance:getMaxHitReward(planId)

	table.sort(maxHitRewardCfg, function(a, b)
		local bHasGet = CaiqingdrawModel.instance:_isPlayerRewardGeted(b.id)
		local aHasGet = CaiqingdrawModel.instance:_isPlayerRewardGeted(a.id)

		if bHasGet == aHasGet then
			return a.maxHit < b.maxHit
		elseif aHasGet then
			return false
		else
			return true
		end
	end)

	return maxHitRewardCfg
end

function XiaoNuoGifBoxBookView:_setTimeUI()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function XiaoNuoGifBoxBookView:_lotteryCost()
	local costStr = self._activityCfg.cost
	local matType, matId, matNum = MaterialMgr.getMatParams(costStr)

	self._curCostCount = matNum
	self._txtCost.text = matNum

	MaterialMgr.setIcon(self._costIcon, matType, matId)

	local objList = {
		{
			showAdd = false,
			id = costStr
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function XiaoNuoGifBoxBookView:_animTenSelectState()
	local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")

	GameUtil.SetActive(self._animSelect, isPass)
	GameUtil.SetActive(self._tenSelect, isTen)

	if isTen then
		self._txtCost.text = self._curCostCount * 10 or self._curCostCount
	end
end

function XiaoNuoGifBoxBookView:_onClickTip()
	TipsFacade.instance:openRulesView("caiqingdraw")
end

function XiaoNuoGifBoxBookView:_onClickTask()
	GotoMgr.gotoByString(self._activityCfg.jumpTo)
end

function XiaoNuoGifBoxBookView:_onClickAnim()
	if not GameUtil.getUserDayData(self._animationPreKey .. "FristAnim") then
		FloatWordMgr.instance:show("首次动画不可跳过哦~")
	else
		local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")

		GameUtil.saveUserDayData(self._animationPreKey .. "PassAnim", not isPass)
		GameUtil.SetActive(self._animSelect, not isPass)
	end
end

function XiaoNuoGifBoxBookView:_onClickTenLottery()
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")

	GameUtil.saveUserData(self._animationPreKey .. "Ten", not isTen)
	GameUtil.SetActive(self._tenSelect, not isTen)

	if not isTen then
		self._txtCost.text = self._curCostCount * 10 or self._curCostCount
	end
end

function XiaoNuoGifBoxBookView:_onClickLottery()
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")
	local isCanLottery, curState = self:_canLottery(isTen)

	if not isCanLottery then
		if curState == 1 then
			local limit = self._activityCfg.weekLimit

			FloatWordMgr.instance:show(string.format("目前已达到每周抽奖次数上限%s次，等周五5点刷新后再来抽吧~", limit))

			return
		elseif curState == 2 then
			FloatWordMgr.instance:show("请去获得足够的抽奖道具后再来抽吧~")

			return
		elseif curState == 3 then
			FloatWordMgr.instance:show("剩余的次数已不足10连，请取消勾选重试")

			return
		end
	end

	local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")

	if not isPass then
		GameUtil.SetActive(self._effNode, true)

		if self._lotteryEffect then
			UIEffectManager.instance:stopEffect(self._lotteryEffect)

			self._lotteryEffect = nil
		end

		local effectPath = "20241122/fx_ui_choujiang_xiaonuo.prefab"

		self._lotteryEffect = UIEffectManager.instance:playEffect(self, effectPath, nil, 0, 0, false, nil, function()
			GameUtil.SetActive(self._effNode, false)
			self:_CaiQingDrawPrizeReq()
		end)

		self._lotteryEffect:setParent(self._effNode.transform)
		self._lotteryEffect:setLocalPos(0, 0, 0)
		self._lotteryEffect:setScale(1)
	else
		self:_CaiQingDrawPrizeReq()
	end
end

function XiaoNuoGifBoxBookView:_CaiQingDrawPrizeReq()
	if not GameUtil.getUserDayData(self._animationPreKey .. "FristAnim") then
		GameUtil.saveUserDayData(self._animationPreKey .. "FristAnim", true)
	end

	local isTen = checkbool(GameUtil.getUserData(self._animationPreKey .. "Ten"))

	CaiQingDrawAgent.instance:sendPM_CaiQingDrawPrizeReq(self._activityId, isTen)
end

function XiaoNuoGifBoxBookView:_canLottery(isTen)
	local weekLotteryCount = CaiqingdrawModel.instance:_getRewardProgress()

	if isTen then
		if not (weekLotteryCount + 10) then
			local addWeekCount = weekLotteryCount + 1

			if addWeekCount > self._activityCfg.weekLimit then
				if isTen and weekLotteryCount < self._activityCfg.weekLimit then
					return false, 3
				end

				return false, 1
			else
				local costStr = self._activityCfg.cost
				local arr = string.split(costStr, "#")

				for i, cfgStr in ipairs(arr) do
					local matType, matId, matNum = MaterialMgr.getMatParams(cfgStr)
					local haveNum = MaterialModel.instance:getMaterialsNumber(matType, matId) or 0

					if isTen then
						if not (matNum * 10) then
							local needCostNum = matNum

							if haveNum < needCostNum then
								return false, 2
							end
						end
					end
				end
			end

			return true
		end
	end
end

function XiaoNuoGifBoxBookView:_swithToTag(jumpToId)
	self._showJumpToId = jumpToId

	goutil.setActive(self._btnLeft, self._showJumpToId > 1)
	goutil.setActive(self._btnRight, self._showJumpToId < #self._jumpToPlanCfgs)
	goutil.setActive(self._lockLeft, true)
	goutil.setActive(self._lockRight, true)

	local jumptoPlanCfg = self._jumpToPlanCfgs[self._showJumpToId]

	if jumptoPlanCfg then
		if not jumptoPlanCfg.title1 then
			local title1Str = ""

			if jumptoPlanCfg then
				if not jumptoPlanCfg.title2 then
					self._title1.text = title1Str
					self._title2.text = ""

					RedPointController.instance:unregRedPoint(self._redpointLeft)
					RedPointController.instance:unregRedPoint(self._redpointRight)

					local redStrLeft = ""
					local redStrRight = ""

					for i, cfg in ipairs(self._jumpToPlanCfgs) do
						if not cfg.startTime then
							local timeNow = ServerTime.now()

							if timeNow > GameUtil.string2time(cfg.startTime) then
								if not cfg.rpIds then
									local rpStr = ""

									if i < self._showJumpToId then
										redStrLeft = not GameUtil.isEmptyString(redStrLeft) and redStrLeft .. "#" .. rpStr or rpStr
									elseif i > self._showJumpToId then
										redStrRight = not GameUtil.isEmptyString(redStrRight) and redStrRight .. "#" .. rpStr or rpStr
									end

									if i == self._showJumpToId - 1 then
										goutil.setActive(self._lockLeft, false)
									elseif i == self._showJumpToId + 1 then
										goutil.setActive(self._lockRight, false)
									end
								end
							end
						end
					end

					RedPointController.instance:regRedPoint(self._redpointLeft, unpack(string.split(redStrLeft or "", "#")))
					RedPointController.instance:regRedPoint(self._redpointRight, unpack(string.split(redStrRight or "", "#")))

					self._jumpToCellList = self._jumpToCellList or {}

					for i, cell in ipairs(self._jumpToCellList) do
						goutil.setActive(cell.go, false)
						uGuiUtil.clearImage(cell.imgBg)
						GameUtil.rmClickHandler(cell.btn)
						RedPointController.instance:unregRedPoint(cell.redpoint)
					end

					local jumptoPlanCfg = self._jumpToPlanCfgs[self._showJumpToId]
					local planCfg = CaiQingDrawConfig.instance:getBtnPlanCfgById((jumptoPlanCfg or nil) and (jumptoPlanCfg.btnPlanId or 0)) or {}

					for i, cfg in ipairs(planCfg) do
						self:_refreshJumpto(i, cfg)
					end
				end
			end
		end
	end
end

function XiaoNuoGifBoxBookView:_refreshJumpto(id, cfg)
	if not self._jumpToCellList[id] then
		local cell = self:_createJumpToCell(id)

		if not cfg.tagTxt then
			self._jumpToCellList[id].txtTag.text = ""
		end

		self._jumpToCellList[id].txtName.text = cfg.showTxt or ""

		if not cfg.pos then
			local pos = {}

			GameUtil.setAnchoredPos(self._jumpToCellList[id].go.transform, checknumber(pos[1]), checknumber(pos[2]))
			RedPointController.instance:regRedPoint(self._jumpToCellList[id].redpoint, unpack(string.split(cfg.rpIds or "", "#")))
			GameUtil.addClickHandler(self._jumpToCellList[id].btn, function()
				GotoMgr.gotoByString(cfg.gotoStr or "")
			end, self)

			local imgPath = GameUrl.getBigbgPngUrl(cfg.picPath or "")

			uGuiUtil.setSpriteToImage(self._jumpToCellList[id].imgBg, uGuiUtil.SpriteType.BigBg, imgPath)

			if not cfg.picPos then
				GameUtil.setAnchoredPos(self._jumpToCellList[id].imgBg.transform, checknumber(cfg.picPos[1]), checknumber(cfg.picPos[2]))
				goutil.setActive(self._jumpToCellList[id].go, true)
			end
		end
	end
end

function XiaoNuoGifBoxBookView:_createJumpToCell(id)
	local cell = {}

	cell.go = goutil.cloneAndSetParent(self._jumpto, self._jumptos.transform, "jumpTo" .. id)
	cell.btn = goutil.findChild(cell.go, "btn")
	cell.imgBg = goutil.findChild(cell.go, "imgBg")
	cell.txtTag = goutil.findChildTextComponent(cell.go, "txtTag")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.redpoint = goutil.findChild(cell.go, "redpoint")
	self._jumpToCellList[id] = cell

	return cell
end

function XiaoNuoGifBoxBookView:_onClickLeft()
	if self._showJumpToId > 1 then
		local cfg = self._jumpToPlanCfgs[self._showJumpToId - 1]
		local timeNow = ServerTime.now()

		if not cfg.startTime then
			if timeNow > GameUtil.string2time(cfg.startTime) then
				self:_swithToTag(self._showJumpToId - 1)
				self:_playFanshuEff(true)
			else
				FloatWordMgr.instance:show(string.format("%s开放", cfg.startTime))
			end
		end
	end
end

function XiaoNuoGifBoxBookView:_onClickRight()
	if self._showJumpToId < #self._jumpToPlanCfgs then
		local cfg = self._jumpToPlanCfgs[self._showJumpToId + 1]
		local timeNow = ServerTime.now()

		if not cfg.startTime then
			if timeNow > GameUtil.string2time(cfg.startTime) then
				self:_swithToTag(self._showJumpToId + 1)
				self:_playFanshuEff(false)
			else
				FloatWordMgr.instance:show(string.format("%s开放", cfg.startTime))
			end
		end
	end
end

function XiaoNuoGifBoxBookView:_playFanshuEff(isLeft)
	goutil.setActive(self._hideCom, false)

	if self._fanshuEff then
		UIEffectManager.instance:stopEffect(self._fanshuEff)

		self._fanshuEff = nil
	end

	local effPath = "251121/shengrichoujiang/choujiang_fanye/choujiang_fanye-ui_p.prefab"

	self._fanshuEff = UIEffectManager.instance:playEffect(self, effPath, self._effPos, 0, 0, false, false, nil, function(target, eff)
		local aniName = "fanye"

		eff.effGo.transform:SetParent(self._effPos.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
		RoleObjectPool.instance:playAnimation(eff.effGo, aniName, false, function()
			goutil.setActive(self._hideCom, true)
			goutil.setActive(eff.effGo, false)
		end)
	end)
end

return XiaoNuoGifBoxBookView
