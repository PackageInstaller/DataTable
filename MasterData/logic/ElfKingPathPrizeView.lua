-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/view/ElfKingPathPrizeView.lua

module("logic.extensions.elfkingpath.view.ElfKingPathPrizeView", package.seeall)

local ElfKingPathPrizeView = class("ElfKingPathPrizeView", ViewComponent)

function ElfKingPathPrizeView:ctor()
	ElfKingPathPrizeView.super.ctor(self)
end

function ElfKingPathPrizeView:unbindEvents()
	ElfKingPathPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function ElfKingPathPrizeView:bindEvents()
	ElfKingPathPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function ElfKingPathPrizeView:buildUI()
	ElfKingPathPrizeView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._goTableview = self:getGo("tableview")

	local goTablecell = self:getGo("tableview/tablecell")

	self._tableviewPrize = ScrollerList.create(self._goTableview, goTablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txt = self:getTxt("txt")
end

function ElfKingPathPrizeView:onExit()
	ElfKingPathPrizeView.super.onExit(self)
	self._tableviewPrize:dispose()
	ElfKingPathController.instance:showCI()
end

function ElfKingPathPrizeView:onEnter()
	ElfKingPathPrizeView.super.onEnter(self)
	GuideController.instance:setViewVar("elf_king_path_battle", nil)

	self._curStageId = 1

	local params = self:getOpenParam()

	if params then
		self._curStageId = checknumber(params[1])
	end

	local stageCfg = ElfKingPathConfig.instance:getStageCfg(self._curStageId)

	if not stageCfg.prize then
		self._curPrizeStrArr = string.split(stageCfg.prize, "#")

		self._tableviewPrize:reloadData(self._curPrizeStrArr)
		self._tableviewPrize:setCenterMode(true)

		local isFirstPass = ElfKingPathController.instance:isCurStageFirstPass()

		if isFirstPass then
			self._txt.text = "恭喜您已完成本关所有挑战通关，获得奖励:"

			goutil.setActive(self._goTableview, true)
			GameUtil.setAnchoredPos(self._txt.gameObject, 0, 56)
		else
			self._txt.text = "恭喜您已完成本关所有挑战"

			goutil.setActive(self._goTableview, false)
			GameUtil.setAnchoredPos(self._txt.gameObject, 0, 0)
		end

		ElfKingPathController.instance:resetIsCurStageFirstPass()

		self._passAllStageTimeStamp = 0

		local curInfo = ElfKingPathModel.instance:getCurInfo()

		if curInfo then
			self._passAllStageTimeStamp = checknumber(curInfo.passAllStageTimeStamp) / 1000
		end

		local isAllPass = self._passAllStageTimeStamp > 0

		if isAllPass then
			local hideDays = checknumber(ElfKingPathConfig.instance:getCommonValue("HIDE_DAYS"))
			local startTime, endTime = GameUtil.getTimestampOnStartAndEnd(self._passAllStageTimeStamp, 1, hideDays)
			local dateFinish = GameUtil.time2date(endTime)
			local addTips = string.format("<color=#eb4642>\n功能将于%s月%s号05:00后永久关闭</color>", dateFinish.month, dateFinish.day)

			self._txt.text = self._txt.text .. addTips
		end

		GuideController.instance:setViewVar("elf_king_path_battle", nil)
	end
end

function ElfKingPathPrizeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function ElfKingPathPrizeView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return ElfKingPathPrizeView
