-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleReportView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleReportView", package.seeall)

local MahjongBattleReportView = class("MahjongBattleReportView", ViewComponent)

function MahjongBattleReportView:ctor()
	MahjongBattleReportView.super.ctor(self)
end

function MahjongBattleReportView:unbindEvents()
	MahjongBattleReportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MahjongBattleReportView:bindEvents()
	MahjongBattleReportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MahjongBattleReportView:buildUI()
	MahjongBattleReportView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local goTab = self:getGo("tableview")
	local goCell = self:getGo("tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("empty")
	self._petCell = self:getGo("petCell")
	self._buffCell = self:getGo("buffCell")
end

function MahjongBattleReportView:onExit()
	MahjongBattleReportView.super.onExit(self)
	self._tableView:dispose()
end

function MahjongBattleReportView:onEnter()
	MahjongBattleReportView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleViewBtlReportRes, self._updateUIByInfo, self)
	goutil.setActive(self._empty, false)
	goutil.setActive(self._petCell, false)
	goutil.setActive(self._buffCell, false)

	self._subTabviewDicPet = {}
	self._subTabviewDicBuff = {}
	self._showInfoMap = {}
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 571001
	end

	MahjongBattleController.instance:requestBtlReport(self._activityId)
	self:_updateUIByInfo()
end

function MahjongBattleReportView:_updateUIByInfo()
	local reportInfos = {}
	local info = MahjongBattleModel.instance:getReportInfo(self._activityId)

	if info then
		reportInfos = info.viewBtlReports or {}

		for _, reportInfo in ipairs(reportInfos) do
			if not reportInfo.winNum then
				local totalScore = 0
				local huNum = 0

				if not reportInfo.cardTypeToNum then
					for _, typeInfo in ipairs(reportInfo.cardTypeToNum) do
						local cardType = typeInfo.left
						local num = typeInfo.right

						if cardType == MahjongBattleModel.SUMMON_TYPE.QINGYISE then
							huNum = huNum + num
						elseif cardType == MahjongBattleModel.SUMMON_TYPE.PINGHU then
							huNum = huNum + num
						elseif cardType == MahjongBattleModel.SUMMON_TYPE.DIHU then
							huNum = huNum + num
						end

						local summonTypeCfg = MahjongBattleConfig.instance:getSummonTypeCfgById(self._activityId, cardType)

						if summonTypeCfg then
							totalScore = totalScore + summonTypeCfg.bonusScore * num
						end
					end

					totalScore = totalScore + MahjongBattleConfig.instance:getScoreByWinNum(reportInfo.winNum)

					if not reportInfo.creepsId then
						if not reportInfo.hasSelectSummonBuff then
							local showInfo = {}

							showInfo.totalScore = totalScore
							showInfo.huNum = huNum
							showInfo.creepIds = reportInfo.creepsId
							showInfo.buffIds = {}
							self._showInfoMap[reportInfo] = showInfo
						end
					end
				end
			end
		end
	end

	local reversedReportInfos = {}

	for i = #reportInfos, 1, -1 do
		table.insert(reversedReportInfos, reportInfos[i])
	end

	self._tableView:reloadData(reversedReportInfos)
	self._empty:SetActive(#reversedReportInfos <= 0)
end

function MahjongBattleReportView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local showInfo = self._showInfoMap[data]
	local subTableviewPet = self._subTabviewDicPet[go]

	if not subTableviewPet then
		local goTab = goutil.findChild(go, "tableviewPet")
		local goCell = self._petCell

		subTableviewPet = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearItemPet, self))
		self._subTabviewDicPet[go] = subTableviewPet
	end

	subTableviewPet:reloadData(showInfo.creepIds)
	subTableviewPet:dragNotifyParent()

	local subTableviewBuff = self._subTabviewDicBuff[go]

	if not subTableviewBuff then
		local goTab = goutil.findChild(go, "tableviewBuff")
		local goCell = self._buffCell

		subTableviewBuff = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCellBuff, self), GameUtil.handler(self._clearItemBuff, self))
		self._subTabviewDicBuff[go] = subTableviewBuff
	end

	subTableviewBuff:reloadData(showInfo.buffIds)
	subTableviewBuff:dragNotifyParent()
	subTableviewBuff:setCenterMode(true)

	local txtTips = goutil.findChildTextComponent(go, "txtTips")

	goutil.setActive(txtTips.gameObject, #showInfo.buffIds <= 0)

	local txtTotal = goutil.findChildTextComponent(go, "txtTotal")
	local txtHu = goutil.findChildTextComponent(go, "txtHu")
	local txtWin = goutil.findChildTextComponent(go, "txtWin")

	txtWin.text = data.winNum
	txtTotal.text = tostring(showInfo.totalScore)
	txtHu.text = showInfo.huNum

	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local date = GameUtil.time2date(checknumber(data.endTimeStamp) / 1000)

	txtTime.text = string.format("%s-%s %02d:%02d", date.month, date.day, date.hour, date.min)
end

function MahjongBattleReportView:_clearCell(cell)
	local go = cell.gameObject
	local subTableviewPet = self._subTabviewDicPet[go]

	if subTableviewPet then
		subTableviewPet:dispose()

		self._subTabviewDicPet[go] = nil
	end

	local subTableviewBuff = self._subTabviewDicBuff[go]

	if subTableviewBuff then
		subTableviewBuff:dispose()

		self._subTabviewDicBuff[go] = nil
	end
end

function MahjongBattleReportView:_updateCellPet(view, cell, data)
	local go = cell.gameObject
	local petMo = MahjongBattleModel.instance:getPetMo(self._activityId, checknumber(data), 0)

	if petMo then
		local proxy = MaterialMgr.setCellByMo(petMo, go)

		if proxy then
			proxy.binder:setAutoTips(false)
		end
	end
end

function MahjongBattleReportView:_clearItemPet(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function MahjongBattleReportView:_updateCellBuff(view, cell, data)
	local go = cell.gameObject
	local buffIcon = goutil.findChild(go, "icon/pic")
	local txt = goutil.findChildTextComponent(go, "txt")
	local buffCfg = MahjongBattleConfig.instance:getSummonBuffCfgById(self._activityId, checknumber(data))

	if buffCfg then
		local spriteName = GameUrl.getIconUrl(buffCfg.buffIcon)

		uGuiUtil.setSpriteToImage(buffIcon, nil, spriteName)
	end

	if buffCfg then
		txt.text = buffCfg.buffName or ""
	end
end

function MahjongBattleReportView:_clearItemBuff(cell)
	local go = cell.gameObject
	local buffIcon = goutil.findChild(go, "icon/pic")

	uGuiUtil.clearImage(buffIcon)
end

return MahjongBattleReportView
