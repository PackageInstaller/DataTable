-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilySeasonRankView.lua

module("logic.extensions.familyteamplay.view.FamilySeasonRankView", package.seeall)

local FamilySeasonRankView = class("FamilySeasonRankView", TableViewComponent)

function FamilySeasonRankView:ctor()
	FamilySeasonRankView.super.ctor(self)

	self._leftBtnsList = nil
	self._curViewDatas = nil
	self._currPeriodId = nil
	self._currZoneId = nil
	self._choiseZoneId = nil
end

function FamilySeasonRankView:bindEvents()
	FamilySeasonRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function FamilySeasonRankView:unbindEvents()
	FamilySeasonRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FamilySeasonRankView:onExit()
	FamilySeasonRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilySeasonRankInfo, self._updataRightRankList, self)

	self._currPeriodId = nil
	self._currZoneId = nil
	self._choiseZoneId = nil
end

function FamilySeasonRankView:destroyUI()
	FamilySeasonRankView.super.destroyUI(self)

	self._curViewDatas = nil
end

function FamilySeasonRankView:buildUI()
	FamilySeasonRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")

	local leftBtnsTran = self:getGo("leftBtnsTran").transform

	self._leftBtnsList = {}

	for i = 1, leftBtnsTran.childCount do
		local go = leftBtnsTran:GetChild(i - 1).gameObject

		self._leftBtnsList[i] = {
			itemGo = go,
			itemGrp = go:GetComponent("UIChangeGroup"),
			lockGo = goutil.findChild(go, "lockGo"),
			btnsTxt = goutil.findChildTextComponent(go, "btnsTxt")
		}
	end

	local rightInfoGo = self:getGo("rightInfoGo")

	self._emptyGo = goutil.findChild(rightInfoGo, "emptyGo")
	self._myRankTxt = goutil.findChildTextComponent(rightInfoGo, "myRankGo/myRankTxt")
	self._myTipsTxt = goutil.findChildTextComponent(rightInfoGo, "myRankGo/myTipsTxt")
end

function FamilySeasonRankView:onEnter()
	FamilySeasonRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilySeasonRankInfo, self._updataRightRankList, self)

	local baseInfo = FamilyteamplayModel.instance:getBaseProgressInfo()

	self._currPeriodId = baseInfo.periodId

	local id = checknumber(baseInfo.curZoneId) <= 0 and 1 or baseInfo.curZoneId

	self._currZoneId = id

	self:_initLeftBtnsShow()
	self:_onClickPlayItemBtn(id, true)
end

function FamilySeasonRankView:_initLeftBtnsShow()
	self._allCfgs = FamilyteamplayConfig.instance:getTeamPlayWarZoneCfgs()

	for i = 1, #self._leftBtnsList do
		GameUtil.asBtn(self._leftBtnsList[i].itemGo):RemoveClickListener()

		if self._allCfgs and self._allCfgs[i] and self._allCfgs[i].zoneId == i then
			GameUtil.SetActive(self._leftBtnsList[i].itemGo, true)
			self._leftBtnsList[i].itemGrp:SetState(0)

			self._leftBtnsList[i].btnsTxt.text = self._allCfgs[i].name

			GameUtil.SetActive(self._leftBtnsList[i].lockGo, not self._allCfgs[i].isOpen)
			GameUtil.asBtn(self._leftBtnsList[i].itemGo):AddClickListener(function()
				self:_onClickPlayItemBtn(i)
			end, self)
		else
			GameUtil.SetActive(self._leftBtnsList[i].itemGo, false)
		end
	end
end

function FamilySeasonRankView:_onClickPlayItemBtn(index, isForce)
	if self._choiseZoneId == index and not isForce then
		return
	end

	if self._allCfgs then
		if not self._allCfgs[index] then
			local cfg = {}

			if cfg == nil or cfg.zoneId ~= index then
				return
			end

			if not cfg.isOpen then
				FloatWordMgr.instance:show("暂未开放，敬请期待！")

				return
			end

			self._choiseZoneId = index

			for i = 1, #self._leftBtnsList do
				if i == self._choiseZoneId then
					self._leftBtnsList[i].itemGrp:SetState(1)
				else
					self._leftBtnsList[i].itemGrp:SetState(0)
				end
			end

			FamilyteamplayController.instance:getFamilySeasonRankList(self._currPeriodId, self._choiseZoneId)
		end
	end
end

function FamilySeasonRankView:_updataRightRankList(ranklist, myRank)
	self._curViewDatas = ranklist or {}

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		GameUtil.SetActive(self._emptyGo, true)
	else
		GameUtil.SetActive(self._emptyGo, false)
	end

	self._myRankTxt.text = checknumber(self._choiseZoneId) ~= self._currZoneId and "暂未加入该战区" or checknumber(myRank) > 0 and tostring(myRank) or "未上榜"

	self._tableview:ReloadData()
end

function FamilySeasonRankView:_getPath()
	return {
		cellPath = "rightInfoGo/rankItem",
		viewPath = "rightInfoGo/rankListSR"
	}
end

function FamilySeasonRankView:_cellSize()
	return 976, 108
end

function FamilySeasonRankView:_updateCell(view, cell, data)
	local rankIma = goutil.findChildComponent(cell, "rankIma", typeof(UIImageSpriteChange))
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local familyTxt = goutil.findChildTextComponent(cell, "familyTxt")
	local levleTxt = goutil.findChildTextComponent(cell, "levleTxt")
	local hurtTxt = goutil.findChildTextComponent(cell, "hurtTxt")

	if checknumber(data.rank) <= 3 then
		GameUtil.SetActive(rankIma, true)
		rankIma:SetState(data.rank - 1)

		rankTxt.text = ""
	else
		GameUtil.SetActive(rankIma, false)

		rankTxt.text = tostring(data.rank)
	end

	familyTxt.text = data.familyName
	levleTxt.text = tostring(data.maxBossId)
	hurtTxt.text = tostring(data.lastBossDamage)
end

return FamilySeasonRankView
