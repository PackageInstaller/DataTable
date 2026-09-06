-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackSelectView.lua

module("logic.extensions.springredpack.view.SpringRedPackSelectView", package.seeall)

local SpringRedPackSelectView = class("SpringRedPackSelectView", ViewComponent)
local MAXCOUNT = 8
local MAXGETEDCOUNT = 4

function SpringRedPackSelectView:ctor()
	SpringRedPackSelectView.super.ctor(self)
end

function SpringRedPackSelectView:buildUI()
	SpringRedPackSelectView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._cell = self:getGo("cell")
	self._container = self:getGo("container")

	goutil.setActive(self._cell, false)

	self._redPackList = {}

	for i = 1, MAXCOUNT do
		local go = goutil.cloneAndSetParent(self._cell, self._container.transform, "redpack" .. i)

		goutil.setActive(go, true)

		local element = {}

		element.go = go
		element.coverOff = goutil.findChild(go, "coverOff")
		element.coverOn = goutil.findChild(go, "coverOn")
		element.item = goutil.findChild(go, "coverOn/item")
		element.imgBest = goutil.findChild(go, "coverOn/imgBest")
		element.txtName = goutil.findChildTextComponent(go, "coverOn/txtName")
		element.isSelect = goutil.findChild(go, "bigReward")
		element.btn = Framework.ButtonAdapter.Get(go)

		table.insert(self._redPackList, element)
	end
end

function SpringRedPackSelectView:bindEvents()
	SpringRedPackSelectView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)

	for i, v in ipairs(self._redPackList) do
		v.btn:AddClickListener(function()
			self:_onClickRedPack(i)
		end)
	end
end

function SpringRedPackSelectView:unbindEvents()
	SpringRedPackSelectView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for i, v in ipairs(self._redPackList) do
		v.btn:RemoveClickListener()
	end
end

function SpringRedPackSelectView:onEnter()
	SpringRedPackSelectView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GainSpringRedPackRes, self._onGainSpringRedPackRes, self)

	self._redPackType = self:getFirstParam()
	self._getedCount = 0
	self._getedList = {}

	self:_updateRedPackList()
	settimer(1, self._onSecond, self)
end

function SpringRedPackSelectView:onExit()
	SpringRedPackSelectView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GainSpringRedPackRes, self._onGainSpringRedPackRes, self)
	removetimer(self._onSecond, self)

	for i, v in ipairs(self._redPackList) do
		MaterialMgr.resetAll(v.item)
		uGuiUtil.clearImage(v.coverOn)
		uGuiUtil.clearImage(v.coverOff)
	end
end

function SpringRedPackSelectView:_onSecond()
	if self._redPackType == SpringRedPackModel.RedPackType.RoundRedPack then
		local curState = SpringRedPackModel.instance:getCurRedPackState()

		if curState ~= SpringRedPackModel.StartRedPack then
			local title = lang("tip")
			local text = "本轮抢红包已结束"
			local btnText = lang("tip_know")

			local function func()
				if self._redPackType == SpringRedPackModel.RedPackType.RoundRedPack then
					SpringRedPackModel.instance:setHasGainThisRound(true)
				else
					SpringRedPackModel.instance:setHasGainDailyPrize(true)
				end

				ViewMgr.instance:close(ViewName.SpringRedPackSelectView)
				ViewMgr.instance:close(ViewName.SpringRedPackPopView)
			end

			TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
			removetimer(self._onSecond, self)
		end
	elseif self._redPackType == SpringRedPackModel.RedPackType.DailyRedPack and not SpringRedPackController.instance:isInActivityTime() then
		FloatWordMgr.instance:show("每日红包领取时间已结束")

		local title = lang("tip")
		local text = "每日红包领取时间已结束"
		local btnText = lang("tip_know")

		local function func()
			ViewMgr.instance:close(ViewName.SpringRedPackSelectView)
			ViewMgr.instance:close(ViewName.SpringRedPackPopView)
		end

		TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
		removetimer(self._onSecond, self)
	end
end

function SpringRedPackSelectView:_onClickClose()
	if self._getedCount < MAXGETEDCOUNT and self._getedCount >= 1 then
		local title = lang("tip")
		local text = lang("red_pocket_leave")

		local function cencelFunc()
			if self._redPackType == SpringRedPackModel.RedPackType.RoundRedPack then
				SpringRedPackModel.instance:setHasGainThisRound(true)
			else
				SpringRedPackModel.instance:setHasGainDailyPrize(true)
			end

			ViewMgr.instance:close(ViewName.SpringRedPackSelectView)
			ViewMgr.instance:close(ViewName.SpringRedPackPopView)
		end

		local okFuncText = "留下来"
		local cancelFuncText = "坚持要走"

		TipsFacade.instance:openPopupWindow(title, text, nil, cencelFunc, okFuncText, cancelFuncText)

		return
	end

	self:close()
end

function SpringRedPackSelectView:_getRedPackId()
	local activityId = SpringRedPackModel.instance:getCurActivityId()
	local cfgActivity = SpringRedPackConfig.instance:getActivityCfg(activityId)
	local roundId = self._redPackType == SpringRedPackModel.RedPackType.RoundRedPack and SpringRedPackModel.instance:getCurRoundId() or -1
	local redPackId = 0

	if roundId > 0 then
		local cfgRound = SpringRedPackConfig.instance:getRoundCfg(activityId, roundId)

		if cfgRound then
			redPackId = cfgRound.redPackId
		end
	else
		redPackId = cfgActivity.dailyRedPackId
	end

	return redPackId
end

function SpringRedPackSelectView:_onClickRedPack(index)
	if self:_isGetedRedPack(index) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if self._getedCount >= MAXGETEDCOUNT then
		FloatWordMgr.instance:show(string.format("最多领取%d个红包", MAXGETEDCOUNT))

		return
	end

	local activityId = SpringRedPackModel.instance:getCurActivityId()
	local simlateOtherResults = self._getedCount >= 3

	if self._redPackType == SpringRedPackModel.RedPackType.RoundRedPack then
		if SpringRedPackModel.instance:getCurRedPackState() ~= SpringRedPackModel.StartRedPack then
			FloatWordMgr.instance:show("不在红包领取时间，敬请期待下一轮")

			return
		end

		local roundId = SpringRedPackModel.instance:getCurRoundId()

		UIStateManager.instance:push(ViewName.SpringRedPackPopView, activityId, roundId, simlateOtherResults, index)
	elseif self._redPackType == SpringRedPackModel.RedPackType.DailyRedPack then
		if not SpringRedPackController.instance:isInActivityTime() then
			FloatWordMgr.instance:show("不在每日红包领取时间")

			return
		end

		local roundId = -1

		UIStateManager.instance:push(ViewName.SpringRedPackPopView, activityId, roundId, simlateOtherResults, index)
	end
end

function SpringRedPackSelectView:_onGainSpringRedPackRes(roundId, index, redPackPrizeId, otherPrizeIds)
	self:_setGetedList(index, redPackPrizeId)
	self:_updateRedPackList(otherPrizeIds)
end

function SpringRedPackSelectView:_setGetedList(index, redPackPrizeId)
	self._getedList[index] = redPackPrizeId
	self._getedCount = self._getedCount + 1
end

function SpringRedPackSelectView:_isGetedRedPack(index)
	return self._getedList[index]
end

function SpringRedPackSelectView:_updateRedPackList(otherPrizeIds)
	if otherPrizeIds then
		if not #otherPrizeIds then
			local count = 0

			for i, v in ipairs(self._redPackList) do
				local redPackId = self:_getRedPackId()
				local redPackSkinCfg = SpringRedPackConfig.instance:getRedPackSkinByRedId(redPackId)
				local coverOnBgPath = GameUrl.getBigbgFolderUrl("springredpack", redPackSkinCfg.smallOnPath)
				local coverOffBgPath = GameUrl.getBigbgFolderUrl("springredpack", redPackSkinCfg.smallOffPath)

				uGuiUtil.setSpriteToImage(v.coverOn, uGuiUtil.SpriteType.BigBg, coverOnBgPath)
				uGuiUtil.setSpriteToImage(v.coverOff, uGuiUtil.SpriteType.BigBg, coverOffBgPath)

				local redPackPrizeId = self._getedList[i]

				goutil.setActive(v.imgBest, false)

				if redPackPrizeId then
					goutil.setActive(v.coverOn, true)
					goutil.setActive(v.coverOff, false)
					goutil.setActive(v.isSelect, false)

					local cfg = SpringRedPackConfig.instance:getPrizeCfg(redPackPrizeId)

					if cfg then
						MaterialMgr.setCellByCfg(cfg.prize, v.item)

						v.txtName.text = MaterialMgr.getMaterialsNameByCfg(cfg.prize)

						goutil.setActive(v.isSelect, true)
						goutil.setActive(v.imgBest, cfg.bigPrize == 1)
					end
				elseif count > 0 then
					goutil.setActive(v.coverOn, true)
					goutil.setActive(v.coverOff, false)
					goutil.setActive(v.isSelect, false)

					local cfg = SpringRedPackConfig.instance:getPrizeCfg(otherPrizeIds[count])

					count = count - 1
					count = count >= 1 and count or 1

					if cfg then
						MaterialMgr.setCellByCfg(cfg.prize, v.item)

						v.txtName.text = MaterialMgr.getMaterialsNameByCfg(cfg.prize)

						goutil.setActive(v.imgBest, cfg.bigPrize == 1)
					end
				else
					goutil.setActive(v.coverOn, false)
					goutil.setActive(v.coverOff, true)
					goutil.setActive(v.isSelect, false)
				end
			end
		end
	end
end

return SpringRedPackSelectView
