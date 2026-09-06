-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorLevelCell.lua

module("logic.extensions.jumpfloor.view.JumpFloorLevelCell", package.seeall)

local JumpFloorLevelCell = class("JumpFloorLevelCell")

function JumpFloorLevelCell:ctor(luaComponentContainer)
	local mainGo = luaComponentContainer.gameObject

	self._moveNodeRect = goutil.findChildRectTransformComponent(mainGo, "moveNode")
	self._txtNum = goutil.findChildTextComponent(mainGo, "moveNode/btn/txtNum")
	self._txtGameNum = goutil.findChild(mainGo, "moveNode/btn/txtNum")
	self._txtGameNumColorChange = self._txtGameNum:GetComponent(ComponentType.UITextColorChange)
	self._reward = goutil.findChild(mainGo, "moveNode/reward")
	self._rewardBtn = Framework.ButtonAdapter.GetFrom(mainGo, "moveNode/reward")
	self._rewardCell = goutil.findChild(mainGo, "moveNode/reward/rewardCell")
	self._txtReward = goutil.findChildTextComponent(mainGo, "moveNode/reward/txtReward")
	self._btn = Framework.ButtonAdapter.GetFrom(mainGo, "moveNode/btn")

	self._btn:AddClickListener(self._onBtnClick, self)

	self._pass = goutil.findChild(mainGo, "moveNode/btn/pass")
	self._lock = goutil.findChild(mainGo, "moveNode/btn/lock")
	self._txtLock = goutil.findChildTextComponent(mainGo, "moveNode/btn/lock/txtLock")
end

function JumpFloorLevelCell:init(data, activityId)
	self._data = data
	self._activityId = activityId
	self._txtNum.text = data.stageName

	local matType, id, matNum = MaterialMgr.getMatParams(data.prize)

	self._txtReward.text = "x" .. matNum

	self._rewardBtn:AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self._rewardBtn, matType, id, matNum)
	end, self)
	MaterialMgr.setCell(matType, id, self._rewardCell)

	local openTimestamp = GameUtil.string2time(data.opTime)
	local curTimestamp = ServerTime.now()
	local isOpen = openTimestamp <= curTimestamp
	local isPass = JumpFloorModel.instance:isStagePass(data.stageId)
	local newsetStageId = JumpFloorModel.instance:getFinishNum() + 1

	goutil.setActive(self._reward, not isPass)
	goutil.setActive(self._txtNum.gameObject, isOpen)
	goutil.setActive(self._pass, isOpen and isPass)
	goutil.setActive(self._lock, not isOpen)

	if isOpen and not isPass then
		self._txtGameNumColorChange:SetState(0)
	elseif isOpen and isPass then
		self._txtGameNumColorChange:SetState(1)
	else
		self._txtGameNumColorChange:SetState(1)
	end

	if not isOpen then
		local date = GameUtil.time2date(openTimestamp)

		self._txtLock.text = string.format("%02d.%02d 5:00\n后开启", date.month, date.day)
	end

	self._isPass = isPass
	self._isOpen = isOpen

	self:_updateMoveNodePos()
end

function JumpFloorLevelCell:reset()
	MaterialMgr.clearIcon(self._rewardIcon)
end

function JumpFloorLevelCell:_onBtnClick()
	if not self._isOpen then
		local date = GameUtil.string2date(self._data.opTime)

		FloatWordMgr.instance:show(string.format("%02d.%02d 5:00后开启", date.month, date.day))

		return
	end

	if JumpFloorModel.instance:isStagePass(self._data.stageId) then
		FloatWordMgr.instance:show(string.format("%s已通关", self._data.stageName))

		return
	end

	local finishNum = JumpFloorModel.instance:getFinishNum()

	if self._data.stageId ~= finishNum + 1 then
		FloatWordMgr.instance:show(string.format("请先通过第%d关", finishNum + 1))

		return
	end

	if JumpFloorController.instance:getDailyLeftNum(self._activityId) <= 0 then
		FloatWordMgr.instance:show("游戏次数用尽")

		return
	end

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(JumpFloorModel.instance:getActivityType(), self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	JumpFloorController.instance:openLevelGame(self._activityId, self._data.stagePlanId, self._data.stageId)
end

function JumpFloorLevelCell:_updateMoveNodePos()
	local num = self._data.stageId % 2

	Framework.TransformUtil.SetAnchoredPos(self._moveNodeRect, num == 1 and 0 or 120, 0)
end

return JumpFloorLevelCell
