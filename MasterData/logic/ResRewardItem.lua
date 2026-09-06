-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/ResRewardItem.lua

module("logic.extensions.materialchallenge.view.ResRewardItem", package.seeall)

local ResRewardItem = class("ResRewardItem")

function ResRewardItem:buildUI(go)
	self._txtDesc = goutil.findChild(go, "txtDesc"):GetComponent(goutil.Type_UIText)
	self._btnNotGet = Framework.ButtonAdapter.GetFrom(go, "btnNotGet")
	self._btnCanGet = Framework.ButtonAdapter.GetFrom(go, "btnCanGet")
	self._btnGeted = Framework.ButtonAdapter.GetFrom(go, "btnGeted")
	self._tableview = goutil.findChild(go, "rewardList"):GetComponent("UITableview")
	self._tableCell = goutil.findChild(go, "rewardList/item")

	self._tableCell:SetActive(false)
end

function ResRewardItem:bindEvents()
	self._btnNotGet:AddClickListener(self._onClickNotGet, self)
	self._btnCanGet:AddClickListener(self._onClickCanGet, self)
	self._btnGeted:AddClickListener(self._onClickGeted, self)
end

function ResRewardItem:unbindEvents()
	self._btnNotGet:RemoveClickListener()
	self._btnCanGet:RemoveClickListener()
	self._btnGeted:RemoveClickListener()
end

function ResRewardItem:onEnter(chapterId, index)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_DailyTaskRewardRes, self._onDailyTaskRewardRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_OneKeyDailyTaskRewardRes, self._onOneKeyDailyTaskRewardRes, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._chapterId = chapterId
	self._index = index

	local progress = MaterialChallengeModel.instance:curDailyTaskProgress(chapterId)
	local cfgs = MaterialChallengeConfig.instance:getProcessorSectionCfgs(chapterId, progress)
	local rewardStr = ""

	if cfgs[index + 1] then
		self._txtDesc.text = string.format(cfgs[index + 1].taskDes, cfgs[index + 1].processorSection)
		rewardStr = cfgs[index + 1].reward
	else
		self._txtDesc.text = "nil"
	end

	self._curViewDatas = {}

	if not string.nilorempty(rewardStr) then
		local str = MaterialMgr.changeItemStr(rewardStr)
		local rewardItems = string.split(str, "#")

		for i = 1, #rewardItems do
			local element = {}

			element.rewardStr = rewardItems[i]
			self._curViewDatas[i] = element
		end
	end

	self._tableview:ReloadData()
	self:_initRewardState(self._chapterId, self._index)
end

function ResRewardItem:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_DailyTaskRewardRes, self._onDailyTaskRewardRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_OneKeyDailyTaskRewardRes, self._onOneKeyDailyTaskRewardRes, self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil

	self._tableview:UnRegisterAllCallbacks()
end

function ResRewardItem:updateState()
	self:_initRewardState(self._chapterId, self._index)
end

function ResRewardItem:_onClickNotGet()
	FloatWordMgr.instance:show("请先达成条件哦")
end

function ResRewardItem:_onClickCanGet()
	MaterialChallengeAgent.instance:sendMCLG_DailyTaskRewardReq(self._chapterId, self._index)
end

function ResRewardItem:_onClickGeted()
	FloatWordMgr.instance:show("奖励已经领取了呢")
end

function ResRewardItem:_onDailyTaskRewardRes(msg)
	if msg.typeId == self._chapterId and msg.index == self._index then
		self:_initRewardState(self._chapterId, self._index)
	end
end

function ResRewardItem:_onOneKeyDailyTaskRewardRes(msg)
	if msg.typeId == self._chapterId then
		self:_initRewardState(self._chapterId, self._index)
	end
end

function ResRewardItem:_initRewardState(chapterId, index)
	local isGeted = MaterialChallengeModel.instance:isGetedReward(chapterId, index)

	if isGeted then
		self._btnNotGet.gameObject:SetActive(false)
		self._btnCanGet.gameObject:SetActive(false)
		self._btnGeted.gameObject:SetActive(true)
	else
		local isCanGet = MaterialChallengeModel.instance:isCanGetReward(chapterId, index)

		if isCanGet then
			self._btnNotGet.gameObject:SetActive(false)
			self._btnCanGet.gameObject:SetActive(true)
			self._btnGeted.gameObject:SetActive(false)
		else
			self._btnNotGet.gameObject:SetActive(true)
			self._btnCanGet.gameObject:SetActive(false)
			self._btnGeted.gameObject:SetActive(false)
		end
	end
end

function ResRewardItem:_numInView()
	return #self._curViewDatas
end

function ResRewardItem:_cellSize(view, idx)
	if idx + 1 == #self._curViewDatas then
		return 110, 90
	end

	return 90, 90
end

function ResRewardItem:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function ResRewardItem:_updateCell(view, cell, data)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	Framework.TransformUtil.SetLocalScale(parentGo.transform, 0.9, 0.9, 0.9)

	local proxy = MaterialMgr.setCellByCfg(data.rewardStr, parentGo)
end

function ResRewardItem:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

return ResRewardItem
