-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakBuffTreeView.lua

module("logic.extensions.skypeak.view.SkyPeakBuffTreeView", package.seeall)

local SkyPeakBuffTreeView = class("SkyPeakBuffTreeView", ViewComponent)

function SkyPeakBuffTreeView:ctor()
	SkyPeakBuffTreeView.super.ctor(self)
end

local MAX_CHAIN_LENGTH = 4

function SkyPeakBuffTreeView:unbindEvents()
	SkyPeakBuffTreeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnunlock)
end

function SkyPeakBuffTreeView:bindEvents()
	SkyPeakBuffTreeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnunlock, self._onClickBtnUnlock, self)
end

function SkyPeakBuffTreeView:buildUI()
	SkyPeakBuffTreeView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnReset = self:getGo("btnReset")

	local goTab = self:getGo("tableview")
	local goSkillcell = self:getGo("tableview/skillcell")

	self._tableViewTree = ScrollerList.create(goTab, goSkillcell, GameUtil.handler(self._updateCellSkill, self), GameUtil.handler(self._clearCellSkill, self))
	self._desc = self:getGo("desc")
	self._txtName = self:getTxt("desc/txtName")
	self._txtBuffDesc = self:getTxt("desc/txtBuffDesc")
	self._iconDesc = self:getGo("desc/buff/icon")
	self._btnunlock = self:getGo("desc/btnunlock")
	self._costicon = self:getGo("desc/txtCost/costicon")
	self._txtCost = self:getTxt("desc/txtCost")
end

function SkyPeakBuffTreeView:onExit()
	SkyPeakBuffTreeView.super.onExit(self)
	self._tableViewTree:dispose()
	uGuiUtil.clearImage(self._iconDesc)
	MaterialMgr.resetAll(self._iconDesc)
end

function SkyPeakBuffTreeView:onEnter()
	SkyPeakBuffTreeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SkyPeakUnlockBuffNodeRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_SkyPeakResetBuffRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = SkyPeakController.instance:getDefaultActivityId() or 0
	end

	self._curSelectBuffId = nil

	self:_updateUIByCfg()

	self._isFirstEnter = true

	self:_updateUIByInfo()
end

function SkyPeakBuffTreeView:_updateUIByCfg()
	self._actCfg = SkyPeakConfig.instance:getActivityCfg(self._activityId) or {}
	self._buffTreeRootIdList = SkyPeakConfig.instance:getBuffTreeRootIdList(self._activityId) or {}

	if not self._actCfg.scoreShowItem then
		local scoreShowItem = ""
		local costType, costId, costNum = MaterialMgr.getMatParams(scoreShowItem)

		MaterialMgr.setIcon(self._costicon, costType, costId)
	end
end

function SkyPeakBuffTreeView:_updateUIByInfo()
	self._curBuffScoreTotal = SkyPeakModel.instance:getBossScore(self._activityId) or 0
	self._curBuffScoreCost = SkyPeakModel.instance:getUsedBuffScore(self._activityId) or 0
	self._curBuffScoreSurplus = self._curBuffScoreTotal - self._curBuffScoreCost

	if self._isFirstEnter then
		self._isFirstEnter = false
		self._curSelectBuffId = self._buffTreeRootIdList[1]

		self:_switchToBuffId(self._curSelectBuffId)
		self._tableViewTree:MoveCellToBegin(0)
	else
		self:_switchToBuffId(self._curSelectBuffId)
	end
end

function SkyPeakBuffTreeView:_updateCellSkill(view, cell, data, tag)
	local go = cell.gameObject
	local rootNode = SkyPeakConfig.instance:getBuffNode(self._activityId, data)
	local goNode0 = goutil.findChild(go, "node0")

	self:_freshNode(goNode0, rootNode)

	if rootNode then
		if not rootNode.children then
			local children = {}
			local goNode1 = goutil.findChild(go, "node1")

			self:_freshNode(goNode1, children[1])

			if children[1] then
				if not children[1].children then
					local children1 = {}
					local goChain1 = goutil.findChild(go, "chain1")
					local goChain2 = goutil.findChild(go, "chain2")

					self:_freshChain(goChain1, children1[1])
					self:_freshChain(goChain2, children1[2])
				end
			end
		end
	end
end

function SkyPeakBuffTreeView:_freshNode(nodeGo, data)
	if not nodeGo then
		return
	end

	if not data or not data.cfg then
		self:_clearNode(nodeGo)

		return
	end

	local cfg = data.cfg
	local goIcon = goutil.findChild(nodeGo, "icon/icon")
	local txtName = goutil.findChildTextComponent(nodeGo, "name/txt")
	local btnSelect = goutil.findChild(nodeGo, "btnSelect")
	local markSelect = goutil.findChild(nodeGo, "markSelect")
	local spriteName = GameUrl.getIconUrl(cfg.buffIcon)

	uGuiUtil.setSpriteToImage(goIcon, nil, spriteName)

	txtName.text = cfg.buffName or ""

	GameUtil.addClickHandler(btnSelect, function()
		self:_switchToBuffId(cfg.nodeId)
	end, self)
	goutil.setActive(markSelect, self._curSelectBuffId == cfg.nodeId)

	local isUnlock = SkyPeakModel.instance:isBuffNodeUnlock(self._activityId, cfg.nodeId)

	if not cfg.parentNodeId then
		local preNodeId = 0
		local isPreUnlock = preNodeId == 0 or SkyPeakModel.instance:isBuffNodeUnlock(self._activityId, preNodeId)
		local line = goutil.findChild(nodeGo, "line")
		local bg = goutil.findChild(nodeGo, "bg")
		local showId = isUnlock and 1 or 0

		GameUtil.setUIImageSpriteIdx(line, showId)
		GameUtil.setUIImageSpriteIdx(bg, showId)
		GameUtil.SetGray(goIcon, not isUnlock)

		local isUnlockPreStage = true

		if not cfg.unlockStageId then
			if cfg.unlockStageId ~= 0 then
				isUnlockPreStage = SkyPeakModel.instance:isStagePassed(self._activityId, cfg.unlockStageId)
			end

			local markluckTips = goutil.findChild(nodeGo, "markluckTips")

			goutil.setActive(markluckTips, not isUnlockPreStage)

			local txtLuckTips = goutil.findChildTextComponent(markluckTips, "txt")

			if txtLuckTips then
				txtLuckTips.text = langPara("通关%s层可解锁", cfg.unlockStageId)
			end

			local isSocreEnough = (cfg.costBuffScore or 0) <= self._curBuffScoreSurplus
			local isOtherBranchUnlock = false

			if preNodeId ~= 0 then
				local preNode = SkyPeakConfig.instance:getBuffNode(self._activityId, preNodeId)

				if preNode then
					if not preNode.children then
						local children = {}

						for _, child in ipairs(children) do
							if child.cfg.nodeId ~= cfg.nodeId and SkyPeakModel.instance:isBuffNodeUnlock(self._activityId, child.cfg.nodeId) then
								isOtherBranchUnlock = true

								break
							end
						end
					end
				end
			end

			local isCanlock = isPreUnlock and isUnlockPreStage and isSocreEnough and not isOtherBranchUnlock and not isUnlock
			local markunlockTips = goutil.findChild(nodeGo, "markunlockTips")

			goutil.setActive(markunlockTips, isCanlock)
		end
	end
end

function SkyPeakBuffTreeView:_freshChain(goChain, rootNode)
	if not goChain then
		return
	end

	if not rootNode or not rootNode.cfg then
		self:_clearChain(goChain)

		return
	end

	local node = rootNode

	for i = 1, MAX_CHAIN_LENGTH do
		local goNode = goutil.findChild(goChain, "node" .. i)

		if node then
			self:_freshNode(goNode, node)

			if not node.children then
				node = node.children[1]
			end
		else
			self:_clearNode(goNode)
		end
	end
end

function SkyPeakBuffTreeView:_clearChain(goChain)
	if not goChain then
		return
	end

	for i = 1, MAX_CHAIN_LENGTH do
		local goNode = goutil.findChild(goChain, "node" .. i)

		self:_clearNode(goNode)
	end

	goutil.setActive(goChain, false)
end

function SkyPeakBuffTreeView:_clearNode(nodeGo)
	if not nodeGo then
		return
	end

	goutil.setActive(nodeGo, false)

	local goIcon = goutil.findChild(nodeGo, "icon")

	uGuiUtil.clearImage(goIcon)

	local btnSelect = goutil.findChild(nodeGo, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)
end

function SkyPeakBuffTreeView:_clearCellSkill()
	return
end

function SkyPeakBuffTreeView:_onClickBtnReset()
	local isExistUnlock = false

	for _, nodeId in ipairs(self._buffTreeRootIdList) do
		if SkyPeakModel.instance:isBuffNodeUnlock(self._activityId, nodeId) then
			isExistUnlock = true

			break
		end
	end

	if not isExistUnlock then
		FloatWordMgr.instance:show(lang("没有已解锁的Buff节点，无需重置"))

		return
	end

	local tips = lang("是否重置所有buff技能,并返还所有消耗的积分?")

	TipsFacade.instance:openPopupWindow(lang("提示"), tips, function()
		SkyPeakController.instance:resetBuff(self._activityId)
	end)
end

function SkyPeakBuffTreeView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function SkyPeakBuffTreeView:_onClickBtnUnlock()
	local node = SkyPeakConfig.instance:getBuffNode(self._activityId, self._curSelectBuffId)

	if not node or not node.cfg then
		return
	end

	if not node.cfg.parentNodeId then
		local preNodeId = 0

		if preNodeId ~= 0 and not SkyPeakModel.instance:isBuffNodeUnlock(self._activityId, preNodeId) then
			FloatWordMgr.instance:show(lang("请先解锁前置Buff"))

			return
		end

		if not node.cfg.unlockStageId then
			local unlockStageId = 0

			if unlockStageId ~= 0 and not SkyPeakModel.instance:isStagePassed(self._activityId, unlockStageId) then
				FloatWordMgr.instance:show(langPara("请先通关解锁关卡%s", unlockStageId))

				return
			end

			local isOtherBranchUnlock = false

			if preNodeId ~= 0 then
				local preNode = SkyPeakConfig.instance:getBuffNode(self._activityId, preNodeId)

				if preNode then
					if not preNode.children then
						local children = {}

						for _, child in ipairs(children) do
							if child.cfg.nodeId ~= node.cfg.nodeId and SkyPeakModel.instance:isBuffNodeUnlock(self._activityId, child.cfg.nodeId) then
								isOtherBranchUnlock = true

								break
							end
						end
					end
				end
			end

			if isOtherBranchUnlock then
				FloatWordMgr.instance:show(lang("已点亮其他分支的Buff，当前Buff不可点亮"))

				return
			end

			if not node.cfg.costBuffScore then
				local costScore = 0

				if costScore > self._curBuffScoreSurplus then
					FloatWordMgr.instance:show(lang("积分不足"))

					return
				end

				SkyPeakController.instance:unlockBuffNode(self._activityId, node.cfg.nodeId)
			end
		end
	end
end

function SkyPeakBuffTreeView:_switchToBuffId(buffId)
	self._curSelectBuffId = buffId

	self._tableViewTree:reloadData(self._buffTreeRootIdList)

	local node = SkyPeakConfig.instance:getBuffNode(self._activityId, buffId)

	goutil.setActive(self._desc, false)

	if node then
		goutil.setActive(self._desc, true)

		if not node.cfg then
			local cfg = {}

			self._txtName.text = cfg.buffName and langPara("%s:", cfg.buffName) or ""
			self._txtBuffDesc.text = cfg.buffDesc or ""

			local spriteName = GameUrl.getIconUrl(cfg.buffIcon)

			uGuiUtil.clearImage(self._iconDesc)
			uGuiUtil.setSpriteToImage(self._iconDesc, nil, spriteName)

			if not cfg.costBuffScore then
				local costScore = 0
				local isEnoughScore = costScore <= self._curBuffScoreSurplus
				local costColor = isEnoughScore and "#20b376" or "#eb4642"

				self._txtCost.text = langPara("<color=%s>%s</color>/%s", costColor, self._curBuffScoreSurplus, costScore)

				local isUnlock = SkyPeakModel.instance:isBuffNodeUnlock(self._activityId, buffId)

				goutil.setActive(self._btnunlock, not isUnlock)
				goutil.setActive(self._txtCost.gameObject, not isUnlock)
			end
		end
	end
end

return SkyPeakBuffTreeView
