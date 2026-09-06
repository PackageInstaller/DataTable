-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardePrizeView.lua

module("logic.extensions.luyngarde.view.LuyngardePrizeView", package.seeall)

local LuyngardePrizeView = class("LuyngardePrizeView", ViewComponent)

function LuyngardePrizeView:ctor()
	LuyngardePrizeView.super.ctor(self)
end

function LuyngardePrizeView:unbindEvents()
	LuyngardePrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGain)
end

function LuyngardePrizeView:bindEvents()
	LuyngardePrizeView.super.bindEvents(self)
	GameUtil.rmClickHandler(self._btnGain)
	GameUtil.addClickHandler(self._btnGain, self._onClickBtnGain, self)
end

function LuyngardePrizeView:buildUI()
	LuyngardePrizeView.super.buildUI(self)

	self._itemTableCell = self:getGo("itemTableCell")
	self._rankTableView = self:getGo("normalRank/rankTableview")
	self._rankTableCell = self:getGo("normalRank/rankTableview/rankTableCell")

	local tabGo = self:getGo("com/tableview")
	local cellGo = self:getGo("com/tableview/cell")

	self._tableview = ScrollerList.create(tabGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._rdBtnGain = self:getGo("btnGain/rd")
	self._btnGain = self:getGo("btnGain")
	self._txtBtnGain = self:getTxt("btnGain/txt")
end

function LuyngardePrizeView:onExit()
	LuyngardePrizeView.super.onExit(self)
	self._tableview:dispose()

	for i, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end

	self._itemScrollListDic = nil

	RedPointController.instance:unregRedPoint(self._rdBtnGain)
end

function LuyngardePrizeView:onEnter()
	LuyngardePrizeView.super.onEnter(self)

	self._activityId = 466001

	self.addGEvent(self, GlobalNotify.LuyngardeGainChapter2KillPrize, self._handleGetPrize, self)

	self._typeId = checknumber(self:getFirstParam())

	LuyngardeController.instance:getChapter2SimpleRankInfo(self._activityId)
	goutil.setActive(self._btnGain, false)

	self._needDeal = false
	self._canGainPrize = false
	self._hasGainPrize = false

	local dataList = {}

	if self._typeId == 1 then
		dataList = LuyngardeConfig.instance:getChapter2RankPrizeCfgs(self._activityId, 1)
	elseif self._typeId == 2 then
		dataList = LuyngardeConfig.instance:getChapter2RankPrizeCfgs(self._activityId, 2)
	elseif self._typeId == 3 then
		dataList = LuyngardeConfig.instance:getChapter2AreaKillCfgs(self._activityId)

		goutil.setActive(self._btnGain, true)
		self:_handleGetPrize()
	elseif self._typeId == 4 then
		dataList = LuyngardeConfig.instance:getChapter3RankPrizeCfgs(self._activityId)
	elseif self._typeId == 5 then
		dataList = LuyngardeConfig.instance:getChapter4RankPrizeCfgs(self._activityId)
	end

	self._itemScrollListDic = {}

	self._tableview:reloadData(dataList)
	RedPointController.instance:regRedPoint(self._rdBtnGain, RedPointModel.ID_Luyngarde_AreaKill_Prize)
end

function LuyngardePrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject
	local proxy = MaterialMgr.setCellByCfg(data.matStr, go)

	if proxy then
		proxy:setGray(data.isGray)
	end
end

function LuyngardePrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function LuyngardePrizeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	local itemListGo = goutil.findChild(go, "itemTableView")

	txtTitle.text = data.title

	if itemListGo and self._itemTableCell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[go] then
			local prizeScrollList = ScrollerList.create(itemListGo, self._itemTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go]:setCenterMode(true)

			self._itemScrollListDic[go] = self._itemScrollListDic[go]

			local prizeArr = {}

			for _, str in ipairs(prizeStrArr) do
				local isGray = false

				if self._typeId == 3 then
					isGray = self._needDeal and self._matchDay ~= data.day or self._relDay > data.day
				end

				table.insert(prizeArr, {
					matStr = str,
					isGray = isGray
				})
			end

			self._itemScrollListDic[go]:reloadData(prizeArr)
			self._itemScrollListDic[go]:dragNotifyParent()
		end
	end
end

function LuyngardePrizeView:_clearCell(cell)
	local go = cell.gameObject
	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:removeDragNotifyParent()
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function LuyngardePrizeView:_onClickBtnGain()
	if self._needDeal then
		if self._canGainPrize then
			LuyngardeController.instance:gainChapter2KillPrize(self._activityId)
		elseif self._hasGainPrize then
			FloatWordMgr.instance:show("已领取")
		else
			FloatWordMgr.instance:show("已超时，无法领取")
		end
	end
end

function LuyngardePrizeView:_handleGetPrize()
	self._needDeal = false
	self._canGainPrize = false
	self._hasGainPrize = false

	if self._typeId == 3 then
		local info = LuyngardeModel.instance:getChapter2SimpleRankInfoByActId(self._activityId)
		local chapterCfg = LuyngardeConfig.instance:getChapterCfg(self._activityId, 2)
		local startTime = GameUtil.string2time(chapterCfg.openTime)

		self._relDay = Mathf.Ceil((ServerTime.now() - startTime) / 86400)

		if info and info.killTimeMillis then
			self._needDeal = true
			self._matchDay = LuyngardeModel.instance:getMatchAreaKillBossRelativeDay(self._activityId)
			self._hasGainPrize = info.hadGainKillPrize
			self._canGainPrize = self._matchDay > 0 and not self._hasGainPrize

			if self._canGainPrize then
				self._txtBtnGain.text = "领取"

				GameUtil.SetGray(self._btnGain, false)
			else
				GameUtil.SetGray(self._btnGain, true)

				self._txtBtnGain.text = self._hasGainPrize and "已领取" or "已超时"
			end
		else
			GameUtil.SetGray(self._btnGain, false)

			self._txtBtnGain.text = "挑战中"
		end
	end
end

return LuyngardePrizeView
