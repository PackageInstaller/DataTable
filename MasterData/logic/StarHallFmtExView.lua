-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starhall/view/StarHallFmtExView.lua

module("logic.extensions.starhall.view.StarHallFmtExView", package.seeall)

local StarHallFmtExView = class("StarHallFmtExView", ViewComponent)

function StarHallFmtExView:ctor()
	StarHallFmtExView.super.ctor(self)
end

function StarHallFmtExView:unbindEvents()
	StarHallFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSwitch)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.asBtn(self._mask):RemoveClickListener()
end

function StarHallFmtExView:bindEvents()
	StarHallFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSwitch, self._onClickSwitch, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.asBtn(self._mask):AddClickListener(self._onClickSwitch, self)
end

function StarHallFmtExView:buildUI()
	StarHallFmtExView.super.buildUI(self)

	self._mask = self:getGo("mask")
	self._btnSwitch = self:getGo("viewBgGo/btnSwitch")
	self._viewBgGo = self:getGo("viewBgGo")
	self._allInfoGo = self:getGo("viewBgGo/allInfoGo")
	self._btnReset = self:getGo("viewBgGo/allInfoGo/rightInfo/btnReset")
	self._txtBestScore = self:getTxt("viewBgGo/allInfoGo/rightInfo/txtBestScore")
	self._txtCurScore = self:getTxt("viewBgGo/allInfoGo/rightInfo/txtCurScore")
	self._txtDiff = self:getTxt("viewBgGo/allInfoGo/rightInfo/txtDiff")
	self._txtTarget = self:getTxt("viewBgGo/allInfoGo/rightInfo/txtTarget")
	self._txtSettletype = self:getTxt("viewBgGo/allInfoGo/rightInfo/txtSettletype")
	self._arrowTran = self:getGo("viewBgGo/btnSwitch/arrowTran")
	self._tableviewGo1 = self:getGo("viewBgGo/allInfoGo/leftInfoGo/tableview1")

	local tablecell1 = self:getGo("viewBgGo/allInfoGo/leftInfoGo/tableview1/tablecell")

	self._tableview1 = ScrollerList.create(self._tableviewGo1, tablecell1, GameUtil.handler(self._updatCell1, self), GameUtil.handler(self._clearCell1, self))
	self._tableviewGo2 = self:getGo("viewBgGo/allInfoGo/leftInfoGo/tableview2")

	local tablecell2 = self:getGo("viewBgGo/allInfoGo/leftInfoGo/tableview2/tablecell")

	self._tableview2 = ScrollerList.create(self._tableviewGo2, tablecell2, GameUtil.handler(self._updatCell2, self), GameUtil.handler(self._clearCell2, self))
	self._tableviewGo3 = self:getGo("viewBgGo/allInfoGo/leftInfoGo/tableview3")

	local tablecell3 = self:getGo("viewBgGo/allInfoGo/leftInfoGo/tableview3/tablecell")

	self._tableview3 = ScrollerList.create(self._tableviewGo3, tablecell3, GameUtil.handler(self._updatCell3, self), GameUtil.handler(self._clearCell3, self))
	self._tableviewGoRight = self:getGo("viewBgGo/allInfoGo/rightInfo/tableview")

	local tablecellRight = self:getGo("viewBgGo/allInfoGo/rightInfo/tableview/tablecell")

	self._tableviewRight = ScrollerList.create(self._tableviewGoRight, tablecellRight, GameUtil.handler(self._updatCellRight, self), GameUtil.handler(self._clearCellRight, self))
end

function StarHallFmtExView:onExit()
	StarHallFmtExView.super.onExit(self)
	self._tableview1:dispose()
	self._tableview2:dispose()
	self._tableview3:dispose()
	self._tableviewRight:dispose()
end

function StarHallFmtExView:onEnter()
	StarHallFmtExView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.StarHallResetStage, self._handleResetStage, self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]
	self._activityId = self.customFmtMo.activityId
	self._stageId = self.customFmtMo.stageId
	self._curType3 = -1

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self:_updatePart1()
	self:_updatePart2()
	self:_updatePart3()

	self._isOpenView = false

	self:_onClickSwitch()
end

function StarHallFmtExView:_updateUIByCfg()
	self._actCfg = StarHallConfig.instance:getActCfgById(self._activityId)
	self._diffCfgs = StarHallConfig.instance:getStageDifficultyCfgsById(self._activityId, self._stageId)
	self._settlementCfgs = StarHallConfig.instance:getSettlementCfgsById(self._activityId)
end

function StarHallFmtExView:_updateUIByInfo()
	if not self._actCfg.numbers then
		self._settleNumberInfoList = {}

		for i, number in ipairs(self._actCfg.numbers) do
			table.insert(self._settleNumberInfoList, {
				stageId = -1,
				id = i,
				number = number
			})
		end

		local stageInfoMap = StarHallModel.instance:getCurStageInfoMap(self._activityId)

		for stageId, info in pairs(stageInfoMap) do
			if info.number ~= -1 then
				for _, numberInfo in ipairs(self._settleNumberInfoList) do
					if numberInfo.stageId == -1 and numberInfo.number == info.number then
						numberInfo.stageId = stageId

						break
					end
				end
			end
		end

		local info = StarHallModel.instance:getBaseInfo(self._activityId)

		self._txtBestScore.text = info.bestTotalScore
	end
end

function StarHallFmtExView:_updatCell1(view, cell, data)
	local btn = goutil.findChild(cell.gameObject, "btn")
	local select = goutil.findChild(btn, "select")
	local txt = goutil.findChildTextComponent(btn, "txt")

	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickCell1, self, data))
	goutil.setActive(select, data.settlementId == self.customFmtMo.settleTypeId)

	txt.text = data.typeName
end

function StarHallFmtExView:_updatCell2(view, cell, data)
	local btn = goutil.findChild(cell.gameObject, "btn")
	local select = goutil.findChild(btn, "select")
	local txt = goutil.findChildTextComponent(btn, "txt")

	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickCell2, self, data))
	goutil.setActive(select, self.customFmtMo.diffcultId == data.id)

	txt.text = string.format("%s星", data.id)
end

function StarHallFmtExView:_updatCell3(view, cell, data)
	local btn = goutil.findChild(cell.gameObject, "btn")
	local select = goutil.findChild(btn, "select")
	local txt = goutil.findChildTextComponent(btn, "txt")
	local stage = goutil.findChild(cell.gameObject, "stage")
	local txtStageId = goutil.findChildTextComponent(stage, "txt")

	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickCell3, self, data))
	goutil.setActive(select, self._curType3 == data.id)

	txt.text = data.number

	goutil.setActive(stage, data.stageId ~= -1)

	txtStageId.text = data.stageId ~= -1 and string.format("第%s关", data.stageId) or ""
end

function StarHallFmtExView:_updatCellRight(view, cell, data)
	local txtSocre = goutil.findChildTextComponent(cell.gameObject, "txtSocre")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")

	txtSocre.text = data.score
	txtDesc.text = data.desc
end

function StarHallFmtExView:_clearCell1(cell)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.rmClickHandler(btn)
end

function StarHallFmtExView:_clearCell2(cell)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.rmClickHandler(btn)
end

function StarHallFmtExView:_clearCell3(cell)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.rmClickHandler(btn)
end

function StarHallFmtExView:_clearCellRight(cell)
	return
end

function StarHallFmtExView:_onClickCell1(data)
	self.customFmtMo.settleTypeId = data.settlementId

	self:_updatePart1()
end

function StarHallFmtExView:_onClickCell2(data)
	self.customFmtMo.diffcultId = data.id

	self:_updatePart2()
end

function StarHallFmtExView:_onClickCell3(data)
	if data.stageId ~= -1 then
		local stageId = data.stageId
		local tipTxt = string.format("您已在第%s关使用此投注点数，获得了%s积分，是否立即清空第%s关的成绩，将投注点数“%s”使用至本关？\n注意：[兑换代币]按照所有关卡积分的历史最高记录发放", stageId, StarHallModel.instance:getScoreByStage(self._activityId, stageId), stageId, data.number)

		TipsFacade.instance:openPopupWindow(lang("tip"), tipTxt, function()
			self._lastType3 = data.id
			self._lastSettleNumber = data.number

			StarHallController.instance:resetStage(self._activityId, data.stageId)
		end)
	else
		self._curType3 = data.id
		self.customFmtMo.settleNumber = data.number

		self:_updatePart3()
	end
end

function StarHallFmtExView:_updatePart1()
	self._tableview1:reloadData(self._settlementCfgs)
	self:_updateTotalScore()
end

function StarHallFmtExView:_updatePart2()
	self._tableview2:reloadData(self._diffCfgs)
	self:_updateTotalScore()
end

function StarHallFmtExView:_updatePart3()
	self._tableview3:reloadData(self._settleNumberInfoList)
	self:_updateTotalScore()
end

function StarHallFmtExView:_updateTotalScore()
	local score = 0

	if self.customFmtMo.settleTypeId ~= -1 and self.customFmtMo.settleNumber ~= -1 then
		local stageCfg = StarHallConfig.instance:getStageCfgByStageId(self._activityId, self._stageId)

		score = score + stageCfg.numberScore
	end

	if self.customFmtMo.diffcultId ~= -1 then
		local diffCfg = StarHallConfig.instance:getStageDifficultyCfgsByDiffId(self._activityId, self._stageId, self.customFmtMo.diffcultId)

		score = score + diffCfg.score
	end

	self._txtCurScore.text = score

	local descDatalist = {}

	if self.customFmtMo.settleTypeId ~= -1 then
		local settleCfg = self._settlementCfgs[self.customFmtMo.settleTypeId]

		table.insert(descDatalist, {
			score = "",
			desc = settleCfg.typeDesc
		})
	end

	if self.customFmtMo.diffcultId ~= -1 then
		table.insert(descDatalist, {
			score = "",
			desc = string.format("%s星难度", self.customFmtMo.diffcultId)
		})
	end

	if self.customFmtMo.settleTypeId ~= -1 and self.customFmtMo.settleNumber ~= -1 then
		local settleCfg = self._settlementCfgs[self.customFmtMo.settleTypeId]
		local stageCfg = StarHallConfig.instance:getStageCfgByStageId(self._activityId, self._stageId)

		table.insert(descDatalist, {
			score = stageCfg.numberScore,
			desc = string.format(settleCfg.detailedDesc, self.customFmtMo.settleNumber)
		})
	end

	if self.customFmtMo.diffcultId ~= -1 then
		local diffCfg = StarHallConfig.instance:getStageDifficultyCfgsByDiffId(self._activityId, self._stageId, self.customFmtMo.diffcultId)

		table.insert(descDatalist, {
			desc = "成功破阵积分",
			score = diffCfg.score
		})
	end

	self._tableviewRight:reloadData(descDatalist)
end

function StarHallFmtExView:_onClickSwitch()
	self._isOpenView = not self._isOpenView

	if self._isOpenView then
		self._mask:SetActive(true)
		self._allInfoGo:SetActive(true)
		GameUtil.setLocalScale(self._arrowTran, 1, 1, 1)
		UnityTweens.TweenPosition.StartTween(self._viewBgGo, Vector3.New(500, 80, 0), Vector3.New(-570, 80, 0), 0.4, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
	else
		self._mask:SetActive(false)
		GameUtil.setLocalScale(self._arrowTran, -1, 1, 1)

		local tweenPos = UnityTweens.TweenPosition.StartTween(self._viewBgGo, Vector3.New(-570, 80, 0), Vector3.New(500, 80, 0), 0.4, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)

		tweenPos:AddListener(function()
			if not self._isOpenView then
				self._allInfoGo:SetActive(false)
			end
		end)
	end
end

function StarHallFmtExView:_onClickReset()
	self._curType3 = -1
	self.customFmtMo.settleNumber = -1
	self.customFmtMo.diffcultId = -1
	self.customFmtMo.settleTypeId = -1

	self._tableview1:reloadData(self._settlementCfgs)
	self._tableview2:reloadData(self._diffCfgs)
	self._tableview3:reloadData(self._settleNumberInfoList)
	self:_updateTotalScore()
end

function StarHallFmtExView:_handleResetStage()
	self:_updateUIByInfo()

	self._curType3 = self._lastType3
	self.customFmtMo.settleNumber = self._lastSettleNumber

	self:_updatePart3()
end

return StarHallFmtExView
