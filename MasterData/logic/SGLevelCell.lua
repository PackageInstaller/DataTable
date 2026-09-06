-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/spheregame/SGLevelCell.lua

module("logic.extensions.anniversarycake.view.spheregame.SGLevelCell", package.seeall)

local SGLevelCell = class("SGLevelCell")

function SGLevelCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._btnClick = Framework.ButtonAdapter.Get(go)
	self._txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	self._lock = goutil.findChild(go, "lock")
	self._txtLock = goutil.findChildTextComponent(go, "lock/txt")
	self._empty = goutil.findChild(go, "empty")
	self.cell = goutil.findChild(go, "rewardcell")
	self.tableview = goutil.findChild(go, "rewardview")
	self._passGo = goutil.findChild(go, "pass")
	self._selectGo = goutil.findChild(go, "select")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._btnClick:AddClickListener(self._onClick, self)

	self._rankGroup = goutil.findChild(go, "rankGroup")
	self._rankItems = {}

	for i = 1, 3 do
		local item = {}

		item.go = goutil.findChild(go, string.format("rankGroup/rank%d", i))
		item.head = goutil.findChild(go, string.format("rankGroup/rank%d/head", i))
		item.txtName = goutil.findChildTextComponent(go, string.format("rankGroup/rank%d/txtName", i))
		item.txtScore = goutil.findChildTextComponent(go, string.format("rankGroup/rank%d/txtScore", i))

		table.insert(self._rankItems, item)
	end
end

function SGLevelCell:init(data)
	self._data = data
	self._isUnlock = false
	self._isOpen = false
	self._tipContent = ""
	self._txtLevel.text = string.format(lang("makecake_tip4"), GameUtil.getChineseNumber(data.stage))

	self:_initLockState()
	self:_initReward()
	self:_initRank()
end

function SGLevelCell:clear()
	self.scrollList:dispose()
	self:_removeHead()
end

function SGLevelCell:_onClick()
	local isPass = MakeCakeModel.instance:isStagePass(self._data.stage)

	if isPass then
		local activityId = MakeCakeModel.instance:getActivityId()
		local stagePlanId = self._data.stagePlanId
		local stageId = self._data.stage

		UIStateManager.instance:push(ViewName.SphereGameMainView, activityId, stagePlanId, stageId)

		return
	end

	if self._isUnlock then
		if not MakeCakeModel.instance:isExistGameCountToday() then
			FloatWordMgr.instance:show(lang("makecake_tip5"))

			return
		end

		local activityId = MakeCakeModel.instance:getActivityId()
		local stagePlanId = self._data.stagePlanId
		local stageId = self._data.stage

		UIStateManager.instance:push(ViewName.SphereGameMainView, activityId, stagePlanId, stageId)
	elseif not string.nilorempty(self._tipContent) then
		FloatWordMgr.instance:show(self._tipContent)
	end
end

function SGLevelCell:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function SGLevelCell:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function SGLevelCell:_initLockState()
	local startTimestamp = GameUtil.string2time(self._data.openTime)
	local curTimestamp = ServerTime.now()

	self._isOpen = startTimestamp <= curTimestamp
	self._isUnlock = MakeCakeModel.instance:isStageOpen(self._data.stage)

	goutil.setActive(self._lock, not self._isUnlock)

	local startDate = GameUtil.time2date(startTimestamp)

	if not self._isOpen then
		self._txtLock.text = string.format(lang("makecake_tip6"), startDate.month, startDate.day)
		self._tipContent = string.format(lang("makecake_tip7"), startDate.month, startDate.day)
	else
		self._tipContent = lang("makecake_tip8")
		self._txtLock.text = self._tipContent
	end

	local isPass = MakeCakeModel.instance:isStagePass(self._data.stage)

	goutil.setActive(self._passGo, isPass)
	goutil.setActive(self._selectGo, self._isUnlock and not isPass)
end

function SGLevelCell:_initReward()
	local list = string.split(self._data.firstPassPrize, "#")

	self.scrollList:reloadData(list)
end

function SGLevelCell:_initRank()
	self:_removeHead()

	local rankInfos = MakeCakeModel.instance:getStageRankInfo(self._data.stage)

	if self._isOpen and self._isUnlock and rankInfos and #rankInfos > 0 then
		goutil.setActive(self._empty, false)
		goutil.setActive(self._rankGroup, true)

		local count = #rankInfos

		for i = 1, 3 do
			if i <= count then
				goutil.setActive(self._rankItems[i].go, true)
				self:_setHeadInfo(self._rankItems[i], rankInfos[i])
			else
				goutil.setActive(self._rankItems[i].go, false)
			end
		end
	else
		goutil.setActive(self._empty, true)
		goutil.setActive(self._rankGroup, false)
	end
end

function SGLevelCell:_setHeadInfo(item, rankInfo)
	item.txtScore.text = "通关：" .. rankInfo.gameTimeSeconds .. lang("tip_second")
	item.txtName.text = rankInfo.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(item.head, rankInfo.headInfo)
end

function SGLevelCell:_removeHead()
	for i, v in ipairs(self._rankItems) do
		MaterialMgr.resetAll(v.head)
	end
end

return SGLevelCell
