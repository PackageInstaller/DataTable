-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191NodeListItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191NodeListItem", package.seeall)

local Act191NodeListItem = class("Act191NodeListItem", LuaCompBase)

function Act191NodeListItem:ctor(view)
	self.handleView = view
end

function Act191NodeListItem:init(go)
	self.go = go
	self.txtStage = gohelper.findChildText(go, "bg/stage/#txt_Stage")
	self.goNodeItem = gohelper.findChild(go, "bg/#go_NodeItem")
	self.goSalary = gohelper.findChild(go, "#go_Salary")
	self.txtCoin1 = gohelper.findChildText(go, "#go_Salary/Coin1/#txt_Coin1")
	self.txtCoin2 = gohelper.findChildText(go, "#go_Salary/Coin2/#txt_Coin2")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "#btn_Click")
	self.nodeItemList = {}
	self.goFly1 = gohelper.findChild(go, "#go_Salary/Coin1/#fly")
	self.goFly2 = gohelper.findChild(go, "#go_Salary/Coin2/#fly")
end

function Act191NodeListItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClick, self)
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.UpdateGameInfo, self.refreshUI, self)
end

function Act191NodeListItem:removeEventListeners()
	return
end

function Act191NodeListItem:onClick()
	local param = self.goSalary.activeInHierarchy and "false" or "true"

	Act191StatController.instance:statButtonClick(self.handleView.viewName, string.format("showSalary_%s", param))
	self:showSalary()
end

function Act191NodeListItem:onStart()
	self.actId = Activity191Model.instance:getCurActId()

	self:refreshUI()
end

function Act191NodeListItem:onDestroy()
	TaskDispatcher.cancelTask(self.playSalaryAnim, self)
	TaskDispatcher.cancelTask(self.hideSalary, self)
	TaskDispatcher.cancelTask(self.hideFly, self)
end

function Act191NodeListItem:refreshUI()
	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	self.nodeInfoList = self.gameInfo:getStageNodeInfoList()

	local stageCo = Activity191Config.instance:getStageCfg(self.actId, self.gameInfo.curStage)

	self.txtCoin1.text = stageCo.coin
	self.txtCoin2.text = stageCo.score

	local nodeCoDic = lua_activity191_node.configDict[tonumber(stageCo.rule)]

	for k, v in ipairs(self.nodeInfoList) do
		local nodeItem = self.nodeItemList[k]

		nodeItem = nodeItem or self:creatNodeItem(k)

		local nodeCo = nodeCoDic[k]
		local nodeIcon

		if nodeCo.random == 1 then
			nodeIcon = Activity191Helper.getNodeIcon(v.nodeType)
		elseif #v.selectNodeStr == 0 then
			nodeIcon = Activity191Helper.getNodeIcon(v.nodeType)
		else
			local mo = Act191NodeDetailMO.New()

			mo:init(v.selectNodeStr[1])

			nodeIcon = Activity191Helper.getNodeIcon(mo.type)
		end

		if nodeIcon then
			UISpriteSetMgr.instance:setAct174Sprite(nodeItem.imageNode, nodeIcon)
			UISpriteSetMgr.instance:setAct174Sprite(nodeItem.imageNodeS, nodeIcon .. "_light")
		end

		if v.nodeId == self.gameInfo.curNode then
			if k == 1 and self.gameInfo.curNode ~= 1 then
				self.firstNode = true
			end

			self.txtStage.text = string.format("<#FAB459>%s</color>-%d", stageCo.name, k)

			gohelper.setActive(nodeItem.goSelect, true)
		else
			gohelper.setActive(nodeItem.goSelect, false)
		end
	end

	gohelper.setActive(self.goNodeItem, false)
end

function Act191NodeListItem:creatNodeItem(index)
	local nodeItem = self:getUserDataTb_()
	local goNode = gohelper.cloneInPlace(self.goNodeItem)

	nodeItem.imageNode = gohelper.findChildImage(goNode, "image_Node")
	nodeItem.goSelect = gohelper.findChildImage(goNode, "go_Select")
	nodeItem.imageNodeS = gohelper.findChildImage(goNode, "go_Select/image_NodeS")
	self.nodeItemList[index] = nodeItem

	return nodeItem
end

function Act191NodeListItem:showSalary()
	if self.goSalary.activeInHierarchy then
		TaskDispatcher.cancelTask(self.hideSalary, self)
		self:hideSalary()

		return
	end

	gohelper.setActive(self.goSalary, true)
	TaskDispatcher.runDelay(self.hideSalary, self, 2)
end

function Act191NodeListItem:hideSalary()
	gohelper.setActive(self.goSalary, false)
end

function Act191NodeListItem:setClickEnable(bool)
	gohelper.setActive(self.btnClick, bool)
end

function Act191NodeListItem:playSalaryAnim(go1, go2)
	gohelper.setActive(self.goFly1, true)
	gohelper.setActive(self.goFly2, true)

	local pos = recthelper.rectToRelativeAnchorPos(go1.transform.position, self.goFly1.transform.parent)

	ZProj.TweenHelper.DOAnchorPos(self.goFly1.transform, pos.x, pos.y, 1)

	pos = recthelper.rectToRelativeAnchorPos(go2.transform.position, self.goFly2.transform.parent)

	ZProj.TweenHelper.DOAnchorPos(self.goFly2.transform, pos.x, pos.y, 1)
	TaskDispatcher.runDelay(self.hideFly, self, 1)
end

function Act191NodeListItem:hideFly()
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_earn_gold)
	gohelper.setActive(self.goFly1, false)
	gohelper.setActive(self.goFly2, false)
end

return Act191NodeListItem
