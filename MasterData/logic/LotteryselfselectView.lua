-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryselfselectView.lua

module("logic.extensions.lottery.view.LotteryselfselectView", package.seeall)

local LotteryselfselectView = class("LotteryselfselectView", ViewComponent)

function LotteryselfselectView:ctor()
	LotteryselfselectView.super.ctor(self)
end

function LotteryselfselectView:unbindEvents()
	LotteryselfselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._bigPrizeBtn)
	GameUtil.rmClickHandler(self._zhaohuanBtn)

	for i, go in ipairs(self._goodsList) do
		local btn = goutil.findChild(go, "clickBtn")
		local resetBtn = goutil.findChild(go, "resetBtn")

		GameUtil.rmClickHandler(btn)
		GameUtil.rmClickHandler(resetBtn)
	end
end

function LotteryselfselectView:bindEvents()
	LotteryselfselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._bigPrizeBtn, self._onBigPirzeClick, self)
	GameUtil.addClickHandler(self._zhaohuanBtn, self._onZhaohuanBtnClick, self)

	for i, go in ipairs(self._goodsList) do
		local btn = goutil.findChild(go, "clickBtn")
		local resetBtn = goutil.findChild(go, "resetBtn")

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onCellClick, self, i))
		GameUtil.addClickHandler(resetBtn, GameUtil.handler(self._onResetCellClick, self, i))
	end
end

function LotteryselfselectView:buildUI()
	LotteryselfselectView.super.buildUI(self)

	self._bigPrizeBtn = self:getGo("materialInfoGo/bigPrizeBtn")
	self._goodsList = {}

	for i = 1, 4 do
		local go = self:getGo("materialInfoGo/matTran/goodsGo_" .. i)

		table.insert(self._goodsList, go)
	end

	self._progrossGo = self:getGo("progrossGo")
	self._con = self:getGo("progrossGo/con")
	self._zhaohuanBtn = self:getGo("progrossGo/zhaohuanBtn")
	self._proogSlid = self:getGo("progrossGo/proogSlid"):GetComponent("Slider")
	self._proogTxt = self:getTxt("progrossGo/proogTxt")
	self._startTxt = self:getTxt("progrossGo/startTxt")
	self._endTxt = self:getTxt("progrossGo/endTxt")
	self._timeInfo = self:getGo("progrossGo/timeInfo")
	self._timeTxt = self:getTxt("progrossGo/timeInfo/showTimeTxt")
end

function LotteryselfselectView:onExit()
	LotteryselfselectView.super.onExit(self)
	GlobalDispatcher:removeListener(LotteryModel.UpdataZhaohuanTimes, self._refreshUI, self)
	GlobalDispatcher:removeListener(LotteryModel.ZhaohuanSelectPetUpdate, self._refreshUI, self)
	removetimer(self._calculationSurplusTime, self)
	MaterialMgr.resetAll(self._con)

	for i, go in ipairs(self._goodsList) do
		self:_updateCell(go, nil)
	end
end

function LotteryselfselectView:onEnter()
	LotteryselfselectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._poolId = checknumber(params[1])
	self._groupId = checknumber(params[2])

	self:_refreshUI()
	self:_showActivityTimer()
	GlobalDispatcher:addListener(LotteryModel.UpdataZhaohuanTimes, self._refreshUI, self)
	GlobalDispatcher:addListener(LotteryModel.ZhaohuanSelectPetUpdate, self._refreshUI, self)
end

function LotteryselfselectView:_refreshUI()
	local info = LotteryModel.instance:getSelfSelectInfo(self._poolId) or {}

	if not info.selfSelectPets then
		local selfSelectPets = {}
		local map = {}

		for i, petPb in ipairs(selfSelectPets) do
			local gridId = petPb.gridId

			map[gridId] = petPb
		end

		for i, go in ipairs(self._goodsList) do
			self:_updateCell(go, map[i])
		end

		local poolCfg = LotteryConfig.instance:GetPoolCfg(self._poolId)
		local path = "ui/bigbg/zhaohuan/" .. poolCfg.bonusBg .. ".png"

		uGuiUtil.setSpriteToImage(self._progrossGo, uGuiUtil.SpriteType.BigBg, path)
		MaterialMgr.resetAll(self._con)
		GameUtil.SetActive(self._proogSlid, false)

		self._proogTxt.text = lang("text_lottery_desc_4")
		self._startTxt.text = ""
		self._endTxt.text = ""

		Framework.TransformUtil.SetLocalPos(self._proogTxt.gameObject.transform, 20, -50, 0)

		local curTimes = checknumber(info.lotteryTimes)
		local last, cfg = self:GetLotteryProgressCfg(self._poolId, curTimes)

		if cfg then
			GameUtil.SetActive(self._proogSlid, true)

			self._proogSlid.value = (curTimes - last) / (cfg.times - last)
			self._proogTxt.text = langPara("text_lottery_desc_5", cfg.times - curTimes)
			self._startTxt.text = "0"

			Framework.TransformUtil.SetLocalPos(self._proogTxt.gameObject.transform, -22.5, -15, 0)

			self._endTxt.text = tostring(cfg.times - last)

			local list = string.split(cfg.prize, "#")

			if list and #list > 0 then
				local type, id, num = MaterialMgr.getMatParams(list[1])
				local arr = string.split(list[1], ":")
				local proxy = MaterialMgr.setCell(type, id, self._con)

				if proxy then
					proxy.binder:setNum(num)

					if type == MatType.Pet and #arr >= 4 then
						local lv = checknumber(arr[3])

						proxy.binder:setLvl(lv)
					end
				end
			end
		end
	end
end

function LotteryselfselectView:GetLotteryProgressCfg(poolId, times)
	local allCfgs = LotteryConfig.instance:GetProgPrizeCfgs(poolId)

	for i = 1, #allCfgs do
		local last = 0

		if i > 1 then
			last = allCfgs[i - 1].times
		end

		if last <= times and times < allCfgs[i].times then
			return last, allCfgs[i]
		end
	end

	return 0, nil
end

function LotteryselfselectView:_updateCell(go, data)
	local goodsPos = goutil.findChild(go, "goodsPos")
	local clickBtn = goutil.findChild(go, "clickBtn")
	local redPoint = goutil.findChild(go, "redPoint")
	local getGo = goutil.findChild(go, "getGo")
	local resetBtn = goutil.findChild(go, "resetBtn")

	GameUtil.SetActive(getGo, false)
	GameUtil.SetActive(redPoint, false)
	GameUtil.SetActive(resetBtn, false)
	MaterialMgr.resetAll(goodsPos)
	GameUtil.SetActive(clickBtn, true)

	if data then
		local raceId = checknumber(data.raceId)

		if raceId > 0 then
			GameUtil.SetActive(clickBtn, false)

			local cfgStr = MaterialMgr.createSerName(MatType.Pet, raceId, 0, 0)

			MaterialMgr.setCellByCfg(cfgStr, goodsPos)
		end
	end
end

function LotteryselfselectView:_showActivityTimer()
	self._timeTxt.text = lang("text_lottery_desc_6")

	removetimer(self._calculationSurplusTime, self)

	local cfg = LotteryConfig.instance:GetPoolCfg(self._poolId)

	if cfg == nil then
		return
	end

	self._supTime = 0

	GameUtil.SetActive(self._timeInfo, false)

	if cfg.countdown then
		GameUtil.SetActive(self._timeInfo, true)

		local isOpen, isPre, endTime = LotteryModel.instance:getPoolIsOpenParams(cfg)

		if not isOpen or endTime <= ServerTime.nowServerLook() then
			return
		else
			self._supTime = endTime - ServerTime.nowServerLook()
		end
	end

	self:_calculationSurplusTime()
	settimer(1, self._calculationSurplusTime, self, true)
end

function LotteryselfselectView:_calculationSurplusTime()
	self._supTime = self._supTime - 1

	if self._supTime <= 0 then
		self._timeTxt.text = lang("text_lottery_desc_6")

		removetimer(self._calculationSurplusTime, self)

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)

	self._timeTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
end

function LotteryselfselectView:_onResetCellClick(index)
	return
end

function LotteryselfselectView:_onCellClick(index)
	UIStateManager.instance:push(ViewName.LotteryselfprizeView, self._poolId, self._groupId, index)
end

function LotteryselfselectView:_onBigPirzeClick()
	if LotteryController.instance:checkMustPickPet(self._poolId, self._groupId) then
		return
	end

	local info = LotteryModel.instance:getSelfSelectInfo(self._poolId)

	if info then
		if not info.selfSelectPets then
			local selfSelectPets = {}
			local nums = table.nums(selfSelectPets)

			if nums > 0 then
				local content = "重置精灵将清空自选精灵的选择以及当前已累计的召唤次数，是否重置"

				TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
					LotteryController.instance:sendResetSelfSelectPetUp(self._poolId, self._groupId)
				end)
			end
		end
	end
end

function LotteryselfselectView:_onZhaohuanBtnClick()
	self:OpenLotteryCountView()
end

function LotteryselfselectView:OpenLotteryCountView()
	local poolCfg = LotteryConfig.instance:GetPoolCfg(self._poolId)

	if poolCfg == nil then
		return false
	end

	if not string.nilorempty(poolCfg.jumpTo) then
		GotoMgr.gotoByString(poolCfg.jumpTo)

		return true
	end

	if checknumber(poolCfg.poolId) < 1 then
		return false
	end

	local list = LotteryConfig.instance:GetProgPrizeCfgs(poolCfg.poolId)

	if list == nil or #list == 0 then
		return false
	end

	UIStateManager.instance:push(ViewName.LotteryCount, poolCfg.poolId)

	return true
end

return LotteryselfselectView
