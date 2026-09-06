-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/RecommendphychicfmtView.lua

module("logic.extensions.recommendfmt.view.RecommendphychicfmtView", package.seeall)

local RecommendphychicfmtView = class("RecommendphychicfmtView", RecommendFmtWeekView)

function RecommendphychicfmtView:buildUI()
	RecommendphychicfmtView.super.buildUI(self)

	self._tabcellGo = self:getGo("tabcell")
	self._tabtableviewGo = self:getGo("tabtableview")
	self._tabScrollList = ScrollerList.create(self._tabtableviewGo, self._tabcellGo, GameUtil.handler(self._updateHeadCell, self), GameUtil.handler(self._clearHeadCell, self))
end

function RecommendphychicfmtView:onExit()
	RecommendphychicfmtView.super.onExit(self)
	self._tabScrollList:dispose()
end

function RecommendphychicfmtView:onEnter()
	local list = RecommendFmtModel.instance:getPsychicTabList()

	if #list <= 0 then
		printError("没有推荐阵型 看看是不是都不上线的")

		return
	end

	self._currSelectRaceId = list[1].raceId

	self._tabScrollList:reloadData(list)
end

function RecommendphychicfmtView:_updateHeadCell(view, cell, data, tag)
	local goIcon = goutil.findChild(cell.gameObject, "mask/icon")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local isSelect = self._currSelectRaceId == data.raceId

	MaterialMgr.setIcon(goIcon, MatType.Pet, data.raceId)
	goutil.setActive(goSelect, isSelect)
	btn:AddClickListener(function()
		if self._currSelectRaceId == data.raceId then
			return
		end

		self._currSelectRaceId = data.raceId

		self._tabScrollList:refresh()
	end)

	if isSelect and self._lastRaceId ~= data.raceId then
		self._lastRaceId = data.raceId
		self.currSelectTabId = -1

		self.scrollList:reloadData(data.cfgs)

		if #data.cfgs > 0 then
			self:onClickTab(data.cfgs[1])
		end
	end
end

function RecommendphychicfmtView:_clearHeadCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(goIcon)
end

function RecommendphychicfmtView:onClickTab(data)
	if self.currSelectTabId ~= data.id then
		self.currSelectTabId = data.id

		RecommendFmtModel.instance:setPhycgucFmt(data.id)
		self:_initSelfFormation()

		self.formationName.text = data.desc

		self.scrollList:refresh()

		local list = {}

		self._gotTipRoot:SetActive(true)

		local pos = self:_getCurPositions()

		self.petid2index = {}

		local fristPet

		for i, v in ipairs(pos) do
			self._gotTips[i]:SetActive(false)

			local petMo

			if v > 0 then
				self._gotTips[i]:SetActive(true)

				petMo = self:_getPet(v)

				table.insert(list, petMo)

				if BagPetsController.instance:getPetNumByRaceId(petMo.raceId) > 0 then
					self._gotTips[i]:SetActive(false)
				end

				self.petid2index[v] = i
				fristPet = fristPet or v
			end

			self:_showOpenDate(petMo, i)
		end

		self:_setPetShowInfo(fristPet)
	end
end

return RecommendphychicfmtView
