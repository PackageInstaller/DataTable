-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021gamelookbacksubView.lua

module("logic.extensions.recap2021.view.Recap2021gamelookbacksubView", package.seeall)

local Recap2021gamelookbacksubView = class("Recap2021gamelookbacksubView", ViewComponent)

function Recap2021gamelookbacksubView:ctor()
	Recap2021gamelookbacksubView.super.ctor(self)
end

function Recap2021gamelookbacksubView:unbindEvents()
	Recap2021gamelookbacksubView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnShare:RemoveClickListener()
end

function Recap2021gamelookbacksubView:bindEvents()
	Recap2021gamelookbacksubView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnRight:AddClickListener(self._onClickbtnRight, self)
	self._btnLeft:AddClickListener(self._onClickbtnLeft, self)
	self._btnReward:AddClickListener(self._onClickbtnReward, self)
	self._btnShare:AddClickListener(self._onClickbtnShare, self)
end

function Recap2021gamelookbacksubView:buildUI()
	Recap2021gamelookbacksubView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRight = self:getBtn("btnRight")
	self._btnLeft = self:getBtn("btnLeft")
	self._btnReward = self:getBtn("btnReward")
	self._notJoinGo = self:getGo("part1/notJoin")
	self._txtPart1Title = goutil.findChildTextComponent(self.mainGO, "part1/title/txtPart1Title")
	self._part2Go = self:getGo("part2")
	self._part1Go = self:getGo("part1")
	self._redpointGo = self:getGo("btnReward/redpoint")
	self._desccellGo = self:getGo("desccell")
	self._descCells = {}

	for i = 1, 7 do
		local go = self:getGo("cellcon/desccell" .. i)

		item = {
			go = go,
			txtDesc = goutil.findChildTextComponent(go, "txt")
		}
		self._descCells[i] = item
	end

	self._sharerewardconGo = self:getGo("part2/shareroot/sharerewardcon")
	self._btnShare = self:getBtn("part2/btnShare")
	self._txtTitleGo = self:getGo("txtTitle")
	self._ylqGo = self:getGo("btnReward/ylq")
	self._sharerootGo = self:getGo("part2/shareroot")
	self._bgGo = self:getGo("bg")
	self._itemGo = self:getGo("btnReward/item")
end

function Recap2021gamelookbacksubView:onExit()
	Recap2021gamelookbacksubView.super.onExit(self)
	GlobalDispatcher:removeListener(Recap2021Controller.PM_Recap21GainEditionPrizeRes, self._PM_Recap21GainEditionPrizeRes, self)
	MaterialMgr.resetAll(self._sharerewardconGo)
	MaterialMgr.resetAll(self._itemGo)
end

function Recap2021gamelookbacksubView:onEnter()
	Recap2021gamelookbacksubView.super.onEnter(self)
	GlobalDispatcher:addListener(Recap2021Controller.PM_Recap21GainEditionPrizeRes, self._PM_Recap21GainEditionPrizeRes, self)

	local params = self:getOpenParam()

	self._curViewDatas = params[1]
	self._currPage = params[2]
	self._maxPage = #self._curViewDatas
	self._minPage = 1

	self:_updateView()
end

function Recap2021gamelookbacksubView:_onClickbtnLeft()
	self._currPage = self._currPage - 1

	self:_updateView()
end

function Recap2021gamelookbacksubView:_onClickbtnRight()
	local currData = self._curViewDatas[self._currPage]

	if Recap2021Model.instance:isCanGainEditionIdPrize(currData.editionId) then
		Recap2021Controller.instance:sendPM_Recap21GainEditionPrizeReq(currData.editionId)
	end

	self._currPage = self._currPage + 1

	self:_updateView()
end

function Recap2021gamelookbacksubView:_onClickbtnClose()
	self:close()
end

function Recap2021gamelookbacksubView:_onClickbtnReward()
	local currData = self._curViewDatas[self._currPage]

	if Recap2021Model.instance:isGainEditionIdPrize(currData.editionId) then
		FloatWordMgr.instance:show("奖励已领取")

		return
	end

	if Recap2021Model.instance:isCanGainEditionIdPrize(currData.editionId) then
		Recap2021Controller.instance:sendPM_Recap21GainEditionPrizeReq(currData.editionId)
	end
end

function Recap2021gamelookbacksubView:_onClickbtnShare()
	ShareController.instance:share(9, {
		self._btnShare.gameObject,
		self._btnClose.gameObject,
		self._txtTitleGo,
		self._sharerootGo,
		self._btnReward.gameObject
	})
	SurveyController.instance:reportBehavior(SurveyBehaviorID.SHARE_GAME_RECAP2021)
end

function Recap2021gamelookbacksubView:_updateView()
	goutil.setActive(self._btnRight.gameObject, self._currPage < self._maxPage)
	goutil.setActive(self._btnLeft.gameObject, self._currPage > self._minPage)

	self._currData = self._curViewDatas[self._currPage]
	self._isZongjie = self._currPage == self._maxPage

	goutil.setActive(self._part1Go, not self._isZongjie)
	goutil.setActive(self._part2Go, false)
	self:_showDescCells()
	self:_setBg()
	self:_setBaseReward()
	self:_chechkRewardDot()

	if self._isZongjie then
		self:_updatePart2()
		SurveyController.instance:reportBehavior(SurveyBehaviorID.READ_GAME_RECAP2021)
	else
		self:_updatePart1()
	end

	local ylq = Recap2021Model.instance:isGainEditionIdPrize(self._currData.editionId)

	goutil.setActive(self._ylqGo, ylq)
end

function Recap2021gamelookbacksubView:_showDescCells()
	self:_clearAllText()

	local planIds = string.split(self._currData.descPlanId, ",")
	local finalCfgs = {}

	for i, v in ipairs(planIds) do
		local id = checkint(v)
		local cfgs = Recap2021Config.instance:getEditionDescCfgs(id)

		table.insertto(finalCfgs, cfgs)
	end

	local isJoinVersionAct = false
	local index = 1

	for i, v in ipairs(finalCfgs) do
		local item = self:_getFreeDescCell(index)

		if v.wordType == 2 then
			isJoinVersionAct = true
			item.txtDesc.text = string.format(v.desc, Recap2021Model.instance:getDescByDataId(v.dataId))
		elseif v.dataId <= 0 then
			index = index + 1
			item.txtDesc.text = v.desc
		else
			local value = Recap2021Model.instance:getVaueByEditionDataId(self._currData.editionId, v.dataId)

			if checkint(value) <= 0 then
				value = 0
			else
				index = index + 1
				isJoinVersionAct = true
				item.txtDesc.text = string.format(v.desc, value)
			end
		end
	end

	self:_checkIsJoinVersion(isJoinVersionAct)
end

function Recap2021gamelookbacksubView:_clearAllText()
	for i, v in ipairs(self._descCells) do
		goutil.setActive(v.go, false)
	end
end

function Recap2021gamelookbacksubView:_updatePart1()
	self._txtPart1Title.text = self._currData.versionName
end

function Recap2021gamelookbacksubView:_updatePart2()
	MaterialMgr.resetAll(self._sharerewardconGo)

	local prize = ShareController.activeByTimes(9, self._sharerootGo)

	if string.find(prize, "#") then
		local list = string.split(prize, "#")

		for i, v in ipairs(list) do
			if string.find(v, "^" .. MatType.Cloth .. ":%d+:") then
				local list2 = string.split(v, ":")
				local clothId = checknumber(list2[2])
				local cfg = DressConfig.instance:getDressCfgById(clothId)

				if cfg.clothesGender == GameEnum.Gender.Neutral or cfg.clothesGender == RoleModel.instance:getGender() then
					MaterialMgr.setCellByCfg(v, self._sharerewardconGo)

					break
				end
			else
				MaterialMgr.setCellByCfg(v, self._sharerewardconGo)

				break
			end
		end
	else
		MaterialMgr.setCellByCfg(prize, self._sharerewardconGo)
	end
end

function Recap2021gamelookbacksubView:_PM_Recap21GainEditionPrizeRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function Recap2021gamelookbacksubView:_getFreeDescCell(index)
	local item = self._descCells[index]

	goutil.setActive(item.go, true)

	return item
end

function Recap2021gamelookbacksubView:_setBg()
	uGuiUtil.setSpriteToImage(self._bgGo, nil, GameUrl.getBigbgPngUrl(self._currData.bgName))
end

function Recap2021gamelookbacksubView:_checkIsJoinVersion(isJoinVersionAct)
	goutil.setActive(self._notJoinGo, not isJoinVersionAct)
end

function Recap2021gamelookbacksubView:_setBaseReward()
	local hasReward = not string.nilorempty(self._currData.prize)

	goutil.setActive(self._btnReward.gameObject, hasReward)

	if hasReward then
		MaterialMgr.setCellByCfg(self._currData.prize, self._itemGo)
	end
end

function Recap2021gamelookbacksubView:_chechkRewardDot()
	local isRed = Recap2021Model.instance:isCanGainEditionIdPrize(self._currData.editionId)

	goutil.setActive(self._redpointGo, isRed)
end

return Recap2021gamelookbacksubView
