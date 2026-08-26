-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191SwitchView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191SwitchView", package.seeall)

local Act191SwitchView = class("Act191SwitchView", BaseView)

function Act191SwitchView:onInitView()
	self._txtStage = gohelper.findChildText(self.viewGO, "bg/stage/#txt_Stage")
	self._goItem = gohelper.findChild(self.viewGO, "bg/#go_Item")
	self._txtTips = gohelper.findChildText(self.viewGO, "#txt_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191SwitchView:addEvents()
	return
end

function Act191SwitchView:removeEvents()
	return
end

function Act191SwitchView:_onEscBtnClick()
	return
end

function Act191SwitchView:_editableInitView()
	self.actId = Activity191Model.instance:getCurActId()
	self.nodeItemList = {}

	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
end

function Act191SwitchView:onOpen()
	gohelper.setActive(self._txtTips, false)

	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	self.nodeInfoList = self.gameInfo:getStageNodeInfoList()
	self.gameInfo.nodeChange = false

	local stageCo = Activity191Config.instance:getStageCfg(self.actId, self.gameInfo.curStage)
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
			self._txtStage.text = string.format("<#FAB459>%s</color>-%d", stageCo.name, k)
			self._txtTips.text = nodeCo.desc

			gohelper.setActive(nodeItem.goSelect, true)
			TaskDispatcher.runDelay(self.delayAudio, self, 1)
			nodeItem.animSwitch:Play("switch_open")
			gohelper.setActive(self._txtTips, true)
		elseif v.nodeId == self.gameInfo.curNode - 1 then
			gohelper.setActive(nodeItem.goSelect, true)
			AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_01)
			nodeItem.animSwitch:Play("switch_close")
		else
			gohelper.setActive(nodeItem.goSelect, false)
		end
	end

	gohelper.setActive(self._goItem, false)
	TaskDispatcher.runDelay(self.closeThis, self, 2.3)
end

function Act191SwitchView:onDestroyView()
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self.delayAudio, self)
end

function Act191SwitchView:creatNodeItem(index)
	local nodeItem = self:getUserDataTb_()
	local goNode = gohelper.cloneInPlace(self._goItem)

	nodeItem.imageNode = gohelper.findChildImage(goNode, "image_Node")
	nodeItem.goSelect = gohelper.findChildImage(goNode, "go_Select")
	nodeItem.animSwitch = nodeItem.goSelect:GetComponent(gohelper.Type_Animator)
	nodeItem.imageNodeS = gohelper.findChildImage(goNode, "go_Select/image_NodeS")
	self.nodeItemList[index] = nodeItem

	return nodeItem
end

function Act191SwitchView:delayAudio()
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_02)
end

return Act191SwitchView
