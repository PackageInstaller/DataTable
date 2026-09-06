-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddessGloryMainView.lua

module("logic.extensions.goddessglory.view.GoddessGloryMainView", package.seeall)

local GoddessGloryMainView = class("GoddessGloryMainView", ViewComponent)

function GoddessGloryMainView:buildUI()
	GoddessGloryMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("txtTitle/btnTip")
	self._btnTask = self:getBtn("btnTask")
	self._btnRank = self:getBtn("btnRank")
	self._btnElfRank = self:getBtn("btnElfRanking")
	self._btnExchange = self:getBtn("btnExchange")
	self._btnShop = self:getBtn("btnShop")
	self._taskRedpoint = self:getGo("btnTask/redPoint")
	self._txtTitle = self:getTxt("txtTitle")
	self._imgNode = self:getGo("con")
	self._tableview = self:getGo("tableview"):GetComponent(ComponentType.UITableview)
	self._tableCell = self:getGo("btnCell")

	self._tableCell:SetActive(false)
	self:_initItemBubble()
end

function GoddessGloryMainView:_initItemBubble()
	self._itemBubble = self:getGo("bubble")
	self._itemBubbleTips = self:getTxt("bubble/txtTip")
	self._itemBubbleNode = self:getGo("bubble/pointItem")
end

function GoddessGloryMainView:bindEvents()
	GoddessGloryMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTips, self)
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnElfRank:AddClickListener(self._onClickElfRank, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnShop:AddClickListener(self._onClickShop, self)
	self._tableview:RegisterCallback(self._numStagesInView, nil, self._stageCellAtIndex, self)
end

function GoddessGloryMainView:unbindEvents()
	GoddessGloryMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnElfRank:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function GoddessGloryMainView:onEnter()
	GoddessGloryMainView.super.onEnter(self)

	self._challengeId = checknumber(self:getFirstParam())

	if self._challengeId == 0 then
		self._challengeId = GoddessGloryModel.instance:getDefaultGoddesGloryId()
	end

	GoddessGloryModel.instance:setCurGoddessGloryId(self._challengeId)
	GoddessGloryModel.instance:setCurStageId(0)

	self._goddesGloryData = GoddessGloryModel.instance:getGoddessGlory(self._challengeId)

	if not self._goddesGloryData then
		GoddessGloryController.instance:requestGoddessGlory(self._challengeId)

		self._goddesGloryData = GoddessGloryModel.instance:getGoddessGlory(self._challengeId)
	end

	self:_createMainImage()
	self:_refreshView()
	self._tableview:SetOffsetWithoutRefresh(0)
	self:_refreshStages()
	self:_checkPlayStory()
end

function GoddessGloryMainView:onExit()
	GoddessGloryMainView.super.onExit(self)

	self._goddesGloryData = nil

	MaterialMgr.clearIcon(self._itemBubbleNode)

	if self._goMainImage then
		goutil.destroy(self._goMainImage)

		self._goMainImage = nil
	end

	self._tableview:Travel(function(cell)
		local icon = goutil.findChild(cell.gameObject, "icon")
		local btn = Framework.ButtonAdapter.Get(cell.gameObject)

		btn:RemoveClickListener()
		Framework.ImageBigBG.Get(icon):ClearImage()
	end, nil)

	self._lockStages = nil

	removetimer(self._checkStateUnlocked, self)
end

function GoddessGloryMainView:_refreshView()
	self._txtTitle.text = GoddessGloryModel.instance:getGoddessGloryName()

	self:_refreshPushItem()

	local redPointId = GoddessGloryModel.instance:getTaskRedPointId()

	self._taskRedpoint:SetActive(RedPointModel.instance:isActive(redPointId))
end

function GoddessGloryMainView:_createMainImage()
	local imgPath = GoddessGloryModel.instance:getMainImage()

	if string.nilorempty(imgPath) then
		return
	end

	local res = rescache:GetResourceNoLoadIfNotExists(imgPath)

	if not res then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	self._goMainImage = goutil.clone(mainAsset)

	self._goMainImage.transform:SetParent(self._imgNode.transform, false)

	local x, y, scale = GoddessGloryModel.instance:getMainImagePose()

	Framework.TransformUtil.SetLocalPos(self._imgNode.transform, x, y, 0)
	Framework.TransformUtil.SetLocalScale(self._imgNode.transform, scale, scale, scale)
end

function GoddessGloryMainView:_refreshPushItem()
	local item = GoddessGloryModel.instance:getExchangePushItem()
	local isEmpty = string.nilorempty(item)

	self._itemBubble:SetActive(not isEmpty)

	if isEmpty then
		return
	end

	local list = string.split(item, ":")
	local matType = checknumber(list[1])
	local cfgId = checknumber(list[2])
	local itemNum = checknumber(list[3])
	local matName = MaterialMgr.getMaterialsName(matType, cfgId)

	MaterialMgr.setIcon(self._itemBubbleNode, matType, cfgId)

	self._itemBubbleTips.text = GoddessGloryModel.instance:getExchangePushItemTips()
end

function GoddessGloryMainView:_refreshStages()
	self._lockStages = {}

	removetimer(self._checkStateUnlocked, self)

	if self._goddesGloryData then
		local now = ServerTime.now()

		for i = 1, #self._goddesGloryData.stages do
			local stageData = self._goddesGloryData.stages[i]
			local timeStart = GameUtil.string2time(stageData.startTime)

			if now < timeStart then
				table.insert(self._lockStages, stageData)
			end
		end
	end

	if #self._lockStages > 0 then
		settimer(1, self._checkStateUnlocked, self)
	end

	self._tableview:ReloadData()
end

function GoddessGloryMainView:_checkStateUnlocked()
	local dirty = false

	if self._lockStages then
		local now = ServerTime.now()

		for i = 1, #self._lockStages do
			local stageData = self._lockStages[i]
			local timeStart = GameUtil.string2time(stageData.startTime)

			if timeStart <= now then
				dirty = true

				break
			end
		end
	end

	if dirty then
		self:_refreshStages()
	end
end

function GoddessGloryMainView:_onClickClose()
	self:close()
end

function GoddessGloryMainView:_onClickTips()
	TipsFacade.instance:openRulesView(GoddessGloryModel.instance:getTipsKey())
end

function GoddessGloryMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.GoddessGloryTasksView)
end

function GoddessGloryMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.GoddesGloryRankView)
end

function GoddessGloryMainView:_onClickElfRank()
	local jumptoStr = GoddessGloryConfig.instance:getParamString("ELF_RANKING")

	GotoMgr.gotoByString(jumptoStr)
end

function GoddessGloryMainView:_onClickExchange()
	local jumptoStr = GoddessGloryConfig.instance:getParamString("JUMP_TO_SHOP")

	GotoMgr.gotoByString(jumptoStr)
end

function GoddessGloryMainView:_onClickShop()
	local jumptoStr = GoddessGloryConfig.instance:getParamString("JUMP_TO_ACTIVITY_SHOP")

	GotoMgr.gotoByString(jumptoStr)
end

function GoddessGloryMainView:_checkPlayStory()
	local storyId = GoddessGloryModel.instance:getGoddessGloryStoryId(self._challengeId)

	if storyId == 0 then
		return
	end

	if not GoddessGloryModel.instance:hasGoddessGloryStoryPlayed(self._challengeId) then
		GoddessGloryModel.instance:setGoddessGloryStoryPlayed(self._challengeId)
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
	end
end

function GoddessGloryMainView:_numStagesInView(view)
	if not self._goddesGloryData then
		return 0
	end

	return #self._goddesGloryData.stages
end

function GoddessGloryMainView:_stageCellAtIndex(view, idx)
	local stageData = self._goddesGloryData.stages[idx + 1]
	local cell = self._tableview:DequeueCell()

	cell = cell or self._tableview:AddChild(self._tableCell)

	local icon = goutil.findChild(cell.gameObject, "icon")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")

	Framework.ImageBigBG.Get(icon):SetImage(stageData.icon)

	txtName.text = stageData.stageName

	local now = ServerTime.now()
	local timeStart = GameUtil.string2time(stageData.startTime)

	if now < timeStart then
		local openDate = GameUtil.string2date(stageData.startTime)

		txtTime.text = string.format("%d/%d %d:%02d开启", openDate.month, openDate.day, openDate.hour, openDate.min)
	else
		txtTime.text = ""
	end

	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		local nowTime = ServerTime.now()

		if nowTime < timeStart then
			FloatWordMgr.instance:show("当前试炼尚未开启")

			return
		end

		GoddessGloryController.instance:enterStage(self._challengeId, stageData.stageId)
	end)

	return cell
end

return GoddessGloryMainView
