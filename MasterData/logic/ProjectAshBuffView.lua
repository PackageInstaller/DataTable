-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshBuffView.lua

module("logic.extensions.projectash.view.ProjectAshBuffView", package.seeall)

local ProjectAshBuffView = class("ProjectAshBuffView", ViewComponent)

function ProjectAshBuffView:ctor()
	ProjectAshBuffView.super.ctor(self)
end

function ProjectAshBuffView:buildUI()
	ProjectAshBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("area1/btnSure")
	self._btnChallenge = self:getBtn("area2/btnChallenge")
	self._txtNum1 = self:getTxt("area1/num/txt")
	self._txtNum2 = self:getTxt("area2/num/txt")
	self.scrollerGo1 = self:getGo("area1/rewardList")
	self.cellGo1 = self:getGo("area1/cell")
	self.scrollList1 = ScrollerList.create(self.scrollerGo1, self.cellGo1, GameUtil.handler(self._updateCell1, self), GameUtil.handler(self.clearCell1, self))
	self.scrollerGo2 = self:getGo("area2/rewardList")
	self.cellGo2 = self:getGo("area2/cell")
	self.scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self.clearCell2, self))
end

function ProjectAshBuffView:bindEvents()
	ProjectAshBuffView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
end

function ProjectAshBuffView:unbindEvents()
	ProjectAshBuffView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function ProjectAshBuffView:onEnter()
	ProjectAshBuffView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = ProjectAshConfig.instance:getActivityCfg(self._activityId)
	self._stage2CostPlanId = self._cfgActivity.stage2CostPlanId
	self._stage2BuffPlanId = self._cfgActivity.stage2BuffPlanId
	self._maxSelectBuffLimit = self._cfgActivity.selectBuffLimit
	self._dailyChallengeLimit = self._cfgActivity.dailyChallengeLimit
	self._curSelectCostNum = 0
	self._curLeftBuffSelectNum = 0
	self._isClickSubmit = false
	self._costIds = {}
	self._buffIds = {}

	goutil.setActive(self._btnSure.gameObject, true)
	self:_initCostPlanList()
	self:_initBuffPlanList()
	self:_updateTxtNum1()
	self:_updateTxtNum2()
end

function ProjectAshBuffView:onExit()
	ProjectAshBuffView.super.onExit(self)
end

function ProjectAshBuffView:_onClickClose()
	self:close()
end

function ProjectAshBuffView:_onClickSure()
	if self._curSelectCostNum == 0 then
		FloatWordMgr.instance:show("请先选择恶魔欲望单的物品进行提交")

		return
	end

	self._curLeftBuffSelectNum = self._curSelectCostNum
	self._isClickSubmit = true

	goutil.setActive(self._btnSure.gameObject, false)
	self:_updateTxtNum2()

	local curViewDatas = self.scrollList1:getData()
	local costIds = {}

	for i, v in ipairs(curViewDatas) do
		if v.isSelect then
			table.insert(costIds, v.cfg.id)
		end
	end

	self._costIds = costIds
end

function ProjectAshBuffView:_onClickChallenge()
	local curUsedTimes = ProjectAshModel.instance:getTodayChallengeTimes()

	if curUsedTimes >= self._dailyChallengeLimit then
		FloatWordMgr.instance:show(string.format("每日最多挑战%d次", self._dailyChallengeLimit))

		return
	end

	local maxScore = ProjectAshController.instance:getStage2WorldPrizeMaxScore(self._activityId)
	local curScore = ProjectAshModel.instance:getWorldProgress()

	if maxScore <= curScore then
		FloatWordMgr.instance:show("BOSS已被击败")

		return
	end

	local curViewDatas = self.scrollList2:getData()
	local buffIds = {}

	for i, v in ipairs(curViewDatas) do
		if v.isSelect then
			table.insert(buffIds, v.cfg.buffId)
		end
	end

	self._buffIds = buffIds

	if #self._buffIds == 0 then
		local text = "当前未选择加成效果，是否继续挑战？"

		local function okFunc()
			self:_enterMissonView()
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
	elseif #self._buffIds < #self._costIds then
		FloatWordMgr.instance:show("还可以选择更多buff哟，快去选择吧")
	else
		self:_enterMissonView()
	end
end

function ProjectAshBuffView:_enterMissonView()
	if #self._buffIds == 0 then
		self._costIds = {}
	end

	local customFmtMo = ProjectAshModel.instance:getCustomFmtMo()

	customFmtMo:initParams(self._activityId, self._costIds, self._buffIds)
	CustomFmtController.instance:showMissionView(customFmtMo)
	self:_onClickClose()
end

function ProjectAshBuffView:_updateCell1(view, cell, data, tag)
	local node = goutil.findChild(cell.gameObject, "node")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txt")
	local select = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")
	local matType, matId = MaterialMgr.getMatParams(data.cfg.cost)

	MaterialMgr.setCellByCfg(data.cfg.cost, node)

	txtName.text = MaterialMgr.getMaterialsName(matType, matId)

	goutil.setActive(select, data.isSelect)
	btnClick:AddClickListener(function()
		if not self._isClickSubmit then
			if self._curSelectCostNum > 0 and self._curSelectCostNum < self._maxSelectBuffLimit then
				data.isSelect = not data.isSelect

				self:_updateSelectCostNum(data.isSelect)
			elseif self._curSelectCostNum == self._maxSelectBuffLimit then
				if data.isSelect then
					data.isSelect = false

					self:_updateSelectCostNum(false)
				end
			elseif self._curSelectCostNum == 0 and not data.isSelect then
				data.isSelect = true

				self:_updateSelectCostNum(true)
			end
		end

		goutil.setActive(select, data.isSelect)
	end)
end

function ProjectAshBuffView:clearCell1(cell)
	local node = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(node)
end

function ProjectAshBuffView:_updateCell2(view, cell, data, tag)
	local node = goutil.findChild(cell.gameObject, "node")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txt")
	local select = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")

	uGuiUtil.setSpriteToImage(node, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(data.cfg.iconPath))

	txtName.text = data.cfg.name

	goutil.setActive(select, data.isSelect)
	btnClick:AddClickListener(function()
		if self._isClickSubmit then
			if self._curLeftBuffSelectNum > 0 and self._curLeftBuffSelectNum < self._maxSelectBuffLimit then
				data.isSelect = not data.isSelect

				self:_updateLeftBuffSelectNum(not data.isSelect)
			elseif self._curLeftBuffSelectNum == self._maxSelectBuffLimit then
				if not data.isSelect then
					data.isSelect = true

					self:_updateLeftBuffSelectNum(false)
				end
			elseif self._curLeftBuffSelectNum == 0 and data.isSelect then
				data.isSelect = false

				self:_updateLeftBuffSelectNum(true)
			end
		else
			FloatWordMgr.instance:show("请先提交恶魔欲望单的物品进行兑换")
		end

		goutil.setActive(select, data.isSelect)
	end)
end

function ProjectAshBuffView:clearCell2(cell)
	local node = goutil.findChild(cell.gameObject, "node")

	uGuiUtil.clearImage(node)
end

function ProjectAshBuffView:_initCostPlanList()
	local cfgList = ProjectAshConfig.instance:getCostPanCfgList(self._stage2CostPlanId)
	local list = {}

	for i, v in ipairs(cfgList) do
		if MaterialMgr.getMatEnough(v.cost) then
			local item = {}

			item.isSelect = false
			item.cfg = v

			table.insert(list, item)
		end
	end

	self.scrollList1:reloadData(list)
end

function ProjectAshBuffView:_initBuffPlanList()
	local cfgList = ProjectAshConfig.instance:getBuffCfgList(self._stage2BuffPlanId)
	local list = {}

	for i, v in ipairs(cfgList) do
		local item = {}

		item.isSelect = false
		item.cfg = v

		table.insert(list, item)
	end

	self.scrollList2:reloadData(list)
end

function ProjectAshBuffView:_updateTxtNum1()
	self._txtNum1.text = string.format("(%d/%d)", self._curSelectCostNum, self._maxSelectBuffLimit)
end

function ProjectAshBuffView:_updateTxtNum2()
	self._txtNum2.text = string.format("剩余选择次数：%d", self._curLeftBuffSelectNum)
end

function ProjectAshBuffView:_updateSelectCostNum(isAdd)
	if isAdd then
		self._curSelectCostNum = self._curSelectCostNum + 1

		if self._curSelectCostNum > self._maxSelectBuffLimit then
			self._curSelectCostNum = self._maxSelectBuffLimit
		end
	else
		self._curSelectCostNum = self._curSelectCostNum - 1

		if self._curSelectCostNum < 0 then
			self._curSelectCostNum = 0
		end
	end

	self:_updateTxtNum1()
end

function ProjectAshBuffView:_updateLeftBuffSelectNum(isAdd)
	if isAdd then
		self._curLeftBuffSelectNum = self._curLeftBuffSelectNum + 1

		if self._curLeftBuffSelectNum > self._maxSelectBuffLimit then
			self._curLeftBuffSelectNum = self._maxSelectBuffLimit
		end
	else
		self._curLeftBuffSelectNum = self._curLeftBuffSelectNum - 1

		if self._curLeftBuffSelectNum < 0 then
			self._curLeftBuffSelectNum = 0
		end
	end

	self:_updateTxtNum2()
end

return ProjectAshBuffView
