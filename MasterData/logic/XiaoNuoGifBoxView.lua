-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/XiaoNuoGifBoxView.lua

module("logic.extensions.caiqingdraw.view.XiaoNuoGifBoxView", package.seeall)

local XiaoNuoGifBoxView = class("XiaoNuoGifBoxView", ViewComponent)
local spineUrl = {
	{
		"effect/prefabs/ui/20240927/longhunchoujiang/longhunchoujiang-ui_p.prefab"
	},
	{
		"character/10137_xiaotian/10137_xiaotian-ui_p.prefab"
	}
}
local spinePos = {
	{
		-305,
		-165,
		0.6
	},
	{
		275,
		-165,
		0.6,
		-0.6
	},
	{
		0,
		-217,
		0.15,
		0.15
	}
}
local spineAnim = {
	[1] = "idle-all",
	[2] = "skill-all"
}
local drawAnimPath = {
	"storyconfig/animations/story_xingshicaiqing.txt",
	"storyconfig/animations/story_longfanchoujiang.txt",
	"storyconfig/animations/story_shikongxiuer.txt"
}
local bgEffPath = {
	[1] = "20230120/caiqinglinghaoli/fx_ui_caiqinglinghaoli.prefab",
	[2] = "20231222/shikongxiuer/fx_shikongxiuer_camera.prefab"
}

function XiaoNuoGifBoxView:ctor()
	XiaoNuoGifBoxView.super.ctor(self)
end

function XiaoNuoGifBoxView:unbindEvents()
	XiaoNuoGifBoxView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnAnim)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnTenLottery)

	for i, v in ipairs(self._btns) do
		GameUtil.rmClickHandler(v)
	end
end

function XiaoNuoGifBoxView:bindEvents()
	XiaoNuoGifBoxView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnAnim, self._onClickAnim, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnTenLottery, self._onClickTenLottery, self)

	for i, v in ipairs(self._btns) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBtnJump, self, i))
	end
end

function XiaoNuoGifBoxView:buildUI()
	XiaoNuoGifBoxView.super.buildUI(self)

	self._costIcon = self:getImg("txtCost/icon")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtlotteryNum = self:getTxt("lotteryNum/txtNum")
	self._txtCost = self:getTxt("txtCost")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnLottery = self:getGo("btnLottery")
	self._btnTask = self:getBtn("btnTask")
	self._btnAnim = self:getBtn("btnAnim")
	self._btnTenLottery = self:getBtn("btnTenLottery")
	self._roleView_role1 = self:getGo("roleView/role1")
	self._roleView_role2 = self:getGo("roleView/role2")
	self._rdTenLottery = self:getGo("btnLottery/redpoint")
	self._rdTask = self:getGo("btnTask/redpoint")
	self._animSelect = self:getGo("btnAnim/imgSelect")
	self._tenSelect = self:getGo("btnTenLottery/imgSelect")
	self._goldBarCon = self:getGo("goldBarCon")
	self._tableview = self:getGo("lotteryList/tableview")
	self._cell = self:getGo("lotteryList/cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._spineAnimRoot = self:getGo("spineAnimRoot")
	self._spineRoot_Role1 = self:getGo("spineAnimRoot/root")
	self._lotteryBg = self:getGo("roleView/bg")
	self._imgSlogan = self:getGo("imgSlogan")
	self._btns = {}
	self._redPoints = {}
	self._btnsGo = self:getGo("btns")

	for i = 1, self._btnsGo.transform.childCount do
		local btnGo = goutil.findChild(self._btnsGo, "btn_" .. i)

		table.insert(self._btns, btnGo)
		table.insert(self._redPoints, goutil.findChild(btnGo, "redpoint"))
	end
end

function XiaoNuoGifBoxView:onExit()
	XiaoNuoGifBoxView.super.onExit(self)
	self._scrollList:dispose()

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self:_clearAllSpine()
	GlobalDispatcher:removeListener(GlobalNotify.CaiQingDrawGetInfoRes, self._initView, self)
	GlobalDispatcher:removeListener(GlobalNotify.CaiQingDrawPrizeRes, self._refreshView, self)
	RedPointController.instance:unregRedPoint(self._rdTenLottery)
	RedPointController.instance:unregRedPoint(self._rdTask)
	removetimer(self._spineAnim, self)

	if self._lotteryEffect then
		UIEffectManager.instance:stopEffect(self._lotteryEffect)

		self._lotteryEffect = nil
	end

	if self._effectEnoughCost then
		UIEffectManager.instance:stopEffect(self._effectEnoughCost)

		self._effectEnoughCost = nil
	end

	for i, redPoint in ipairs(self._redPoints) do
		GameUtil.SetActive(redPoint, false)
		RedPointController.instance:unregRedPoint(redPoint)
	end
end

function XiaoNuoGifBoxView:onEnter()
	XiaoNuoGifBoxView.super.onEnter(self)
	self:_initAnimPre()
	self:_setTimeUI()
	self:_lotteryCost()
	self:_animTenSelectState()
	GlobalDispatcher:addListener(GlobalNotify.CaiQingDrawGetInfoRes, self._initView, self)
	GlobalDispatcher:addListener(GlobalNotify.CaiQingDrawPrizeRes, self._refreshView, self)
	RedPointController.instance:regRedPoint(self._rdTenLottery, RedPointModel.ID_CAIQINGDRAW_TENLOTTERY)
	RedPointController.instance:regRedPoint(self._rdTask, RedPointModel.ID_CAIQINGDRAW_TASK)
	CaiQingDrawAgent.instance:sendPM_CaiQingDrawGetInfoReq(self._activityId)

	if not self._activityCfg.redIdArray then
		local actRedIdArray = {}

		if #actRedIdArray > 0 then
			for i, redPoint in ipairs(self._redPoints) do
				GameUtil.SetActive(redPoint, false)
				RedPointController.instance:unregRedPoint(redPoint)

				local redIdArray = actRedIdArray[i]

				if redIdArray then
					RedPointController.instance:regRedPoint(redPoint, unpack(redIdArray))
				end
			end
		else
			for i, redPoint in ipairs(self._redPoints) do
				GameUtil.SetActive(redPoint, false)
				RedPointController.instance:unregRedPoint(redPoint)
			end
		end
	end
end

function XiaoNuoGifBoxView:_initAnimPre()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Caiqingdraw)
	end

	self._activityCfg = CaiQingDrawConfig.instance:getActivityCfgById(self._activityId)
	self._animationPreKey = self.__cname
end

function XiaoNuoGifBoxView:_initSpine()
	self:_loadSpine(self._roleView_role1, spineUrl[1], spinePos[3])
end

function XiaoNuoGifBoxView:_initView(msg)
	CaiqingdrawModel.instance:_setInfoData(msg)
	self._scrollList:reloadData(self:_sortPrizeCfg())

	self._txtlotteryNum.text = CaiqingdrawModel.instance:_getRewardProgress()

	local isRed = self:_canLottery(true)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_CAIQINGDRAW_TENLOTTERY, isRed)
	GameUtil.SetActive(self._lotteryBg, false)
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

function XiaoNuoGifBoxView:_refreshView()
	CaiQingDrawAgent.instance:sendPM_CaiQingDrawGetInfoReq(self._activityId)
end

function XiaoNuoGifBoxView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	txtNum.text = CaiqingdrawModel.instance:_isPlayerRewardGeted(data.id) and "已抽中" or langPara("%d抽必得", data.maxHit)

	MaterialMgr.setCellByCfg(data.gain, item)
	GameUtil.SetActive(geted, CaiqingdrawModel.instance:_isPlayerRewardGeted(data.id))
end

function XiaoNuoGifBoxView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function XiaoNuoGifBoxView:_sortPrizeCfg()
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

function XiaoNuoGifBoxView:_setTimeUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Caiqingdraw, self._activityId)
	local startDate, endDate = GameUtil.time2date(startTime), GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function XiaoNuoGifBoxView:_playEffect()
	local effPath = bgEffPath[2]

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)
	self._pmEff:setLocalPos(0, 0, 0)
end

function XiaoNuoGifBoxView:_lotteryCost()
	local costStr = self._activityCfg.cost
	local matType, matId, matNum = MaterialMgr.getMatParams(costStr)
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")

	self._txtCost.text = matNum * (isTen and 10 or 1)

	MaterialMgr.setIcon(self._costIcon, matType, matId)

	local objList = {
		{
			showAdd = false,
			id = costStr
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function XiaoNuoGifBoxView:_animTenSelectState()
	local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")

	GameUtil.SetActive(self._animSelect, isPass)
	GameUtil.SetActive(self._tenSelect, isTen)
end

function XiaoNuoGifBoxView:_loadSpine(mainGo, spinePath, pos)
	if self._spineCtrlPool == nil then
		self._spineCtrlPool = {}
	end

	if not self._spineCtrlPool[mainGo] then
		local ctrl = CaiqingdrawSpineCtrl.New()

		self._spineCtrlPool[mainGo] = ctrl

		ctrl:onInit(mainGo, self._view, spinePath)

		pos = pos or {}

		if not pos[3] then
			local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

			if not pos[4] then
				local scaleX = scale

				GameUtil.setLocalPos(mainGo, x, y)
				GameUtil.setLocalScale(mainGo, scaleX, scale, scale)
			end
		end
	end
end

function XiaoNuoGifBoxView:_clearSpine(mainGo)
	if self._spineCtrlPool then
		local ctrl = self._spineCtrlPool[mainGo]

		if ctrl then
			ctrl:onClear()
		end
	end
end

function XiaoNuoGifBoxView:_clearAllSpine()
	if self._spineCtrlPool then
		for mainGo, ctrl in pairs(self._spineCtrlPool) do
			self:_clearSpine(mainGo)
		end
	end
end

function XiaoNuoGifBoxView:_onClickTip()
	TipsFacade.instance:openRulesView("caiqingdraw")
end

function XiaoNuoGifBoxView:_onClickTask()
	GotoMgr.gotoByString(self._activityCfg.jumpTo)
end

function XiaoNuoGifBoxView:_onClickAnim()
	local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")

	GameUtil.saveUserDayData(self._animationPreKey .. "PassAnim", not isPass)
	GameUtil.SetActive(self._animSelect, not isPass)
end

function XiaoNuoGifBoxView:_onClickTenLottery()
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")

	GameUtil.saveUserData(self._animationPreKey .. "Ten", not isTen)
	GameUtil.SetActive(self._tenSelect, not isTen)
	self:_lotteryCost()
end

function XiaoNuoGifBoxView:_onClickLottery()
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
		end
	end

	local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")

	if not isPass then
		GameUtil.SetActive(self._lotteryBg, true)

		if self._lotteryEffect then
			UIEffectManager.instance:stopEffect(self._lotteryEffect)

			self._lotteryEffect = nil
		end

		local effectPath = "20241122/fx_ui_choujiang_xiaonuo.prefab"

		self._lotteryEffect = UIEffectManager.instance:playEffect(self, effectPath, nil, 0, 0, false, nil, function()
			GameUtil.SetActive(self._lotteryBg, false)
			self:_CaiQingDrawPrizeReq()
		end)

		self._lotteryEffect:setParent(self._lotteryBg.transform)
		self._lotteryEffect:setLocalPos(0, 0, 0)
		self._lotteryEffect:setScale(1)
	else
		self:_CaiQingDrawPrizeReq()
	end
end

function XiaoNuoGifBoxView:_onClickBtnJump(index)
	if self._activityCfg.jumpToBtn[index] then
		GotoMgr.gotoByString(self._activityCfg.jumpToBtn[index])
	end
end

function XiaoNuoGifBoxView:_spineAnim()
	if self._isPlayAnim then
		return
	end

	GameUtil.SetActive(self._spineAnimRoot, true)
	GameUtil.SetActive(self._roleView_role1, false)
	GameUtil.SetActive(self._roleView_role2, false)

	if self._status == spineAnim[1] then
		self._isPlayAnim = true

		local function callBack()
			self._status = spineAnim[2]
			self._isPlayAnim = false
		end

		self:_playAnimSpine(self._status, callBack)
	elseif self._status == spineAnim[2] then
		self._isPlayAnim = true

		local function callBack()
			self._status = spineAnim[3]
			self._isPlayAnim = false
		end

		self:_playAnimSpine(self._status, callBack)
	elseif self._status == spineAnim[3] then
		self._isPlayAnim = true

		local function callBack()
			self:_CaiQingDrawPrizeReq()
			GameUtil.SetActive(self._spineAnimRoot, false)
			GameUtil.SetActive(self._roleView_role1, true)
			GameUtil.SetActive(self._roleView_role2, true)

			self._status = spineAnim[1]

			self._spineCtrlPool[self._spineRoot_Role1]:playDefaultAnim()
		end

		self:_playAnimSpine(self._status, callBack)
	end
end

function XiaoNuoGifBoxView:_playAnimSpine(animName, callBack)
	if self._spineCtrlPool[self._spineRoot_Role1] and not string.nilorempty(animName) then
		self._spineCtrlPool[self._spineRoot_Role1]:_playAnim(animName, false, callBack)
	end
end

function XiaoNuoGifBoxView:_getDrawAnimPath()
	return drawAnimPath[3]
end

function XiaoNuoGifBoxView:_CaiQingDrawPrizeReq()
	if not GameUtil.getUserDayData(self._animationPreKey .. "FristAnim") then
		GameUtil.saveUserDayData(self._animationPreKey .. "FristAnim", true)
	end

	local isTen = checkbool(GameUtil.getUserData(self._animationPreKey .. "Ten"))

	CaiQingDrawAgent.instance:sendPM_CaiQingDrawPrizeReq(self._activityId, isTen)
	removetimer(self._CaiQingDrawPrizeReq, self)
	removetimer(self._spineAnim, self)
end

function XiaoNuoGifBoxView:_canLottery(isTen)
	local weekLotteryCount = CaiqingdrawModel.instance:_getRewardProgress()

	if isTen then
		if not (weekLotteryCount + 10) then
			local addWeekCount = weekLotteryCount + 1

			if addWeekCount > self._activityCfg.weekLimit then
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

return XiaoNuoGifBoxView
