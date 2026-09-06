-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotTaskView.lua

module("logic.extensions.defendcarrot.view.DefendCarrotTaskView", package.seeall)

local DefendCarrotTaskView = class("DefendCarrotTaskView", ViewComponent)

function DefendCarrotTaskView:ctor()
	DefendCarrotTaskView.super.ctor(self)
end

function DefendCarrotTaskView:unbindEvents()
	DefendCarrotTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DefendCarrotTaskView:bindEvents()
	DefendCarrotTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DefendCarrotTaskView:buildUI()
	DefendCarrotTaskView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tableview/tablecell")
	self._tableview = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DefendCarrotTaskView:onExit()
	DefendCarrotTaskView.super.onExit(self)
	GlobalDispatcher:dispatch(GlobalNotify.DefendCarrotGameResumesRunning)
	self._tableview:dispose()
end

function DefendCarrotTaskView:onEnter()
	DefendCarrotTaskView.super.onEnter(self)

	self._curActivityId = 0
	self._curStageId = 0

	local params = self:getOpenParam()

	if params then
		self._curActivityId = checknumber(params[1])
		self._curStageId = checknumber(params[2])
	end

	if self._curActivityId <= 0 then
		self._curActivityId = 517001
	end

	self:_updateUI()
end

function DefendCarrotTaskView:_updateUI()
	self._txtTitle.text = string.format("第%d关", self._curStageId)

	local taskCfgs = DefendCarrotConfig.instance:getStageTaskCfgs(self._curActivityId, self._curStageId)

	self._killCountMap = DefendCarrotGameController.instance:getCurkillCountMap()
	self._buildInfoMap = DefendCarrotGameController.instance:getCurBuildCountMap()
	self._recycleCountMap = DefendCarrotGameController.instance:getCurRecycleCountMap()

	self._tableview:reloadData(taskCfgs)
end

function DefendCarrotTaskView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local iconReward = goutil.findChild(go, "reward/icon")
	local txtNum = goutil.findChildTextComponent(go, "reward/txt")
	local prizeType, prizeId, prizeNum = MaterialMgr.getMatParams(data.prize)

	txtNum.text = string.format("%d", prizeNum)

	MaterialMgr.setIcon(iconReward, prizeType, prizeId)

	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local taskId = data.taskId
	local param = GameUtil.jsonToTable(data.param)
	local weaponId = 0
	local num = 0
	local isFinish = false
	local goFinished = goutil.findChild(go, "finished")
	local taskDesc = ""

	if param then
		weaponId = checknumber(param.x)
		num = checknumber(param.n)
	end

	local curKillCount = checknumber(self._killCountMap[weaponId])
	local curBuildCount = checknumber(self._buildInfoMap[weaponId])
	local curRecycleCount = checknumber(self._recycleCountMap[weaponId])
	local weaponCfg = DefendCarrotConfig.instance:getWeaponCfg(self._curActivityId, weaponId)

	if weaponCfg then
		taskDesc = data.taskDesc
		taskDesc = string.gsub(data.taskDesc, "{x}", weaponCfg.weaponName)
		taskDesc = string.gsub(data.taskDesc, "{n}", num)

		if taskId == DefendCarrotEnum.TaskType.BuildNotLessThan then
			isFinish = num <= curBuildCount - curRecycleCount
		elseif taskId == DefendCarrotEnum.TaskType.KillNotLessThan then
			isFinish = num <= curKillCount
		elseif taskId == DefendCarrotEnum.TaskType.BuildNotGreaterThan then
			isFinish = curBuildCount <= num
		end
	else
		printError("额外任务参数出错: " .. self._curActivityId .. ", weaponId: " .. weaponId .. ", taskId: " .. taskId)
	end

	txtDesc.text = taskDesc

	goutil.setActive(goFinished, isFinish)

	local iconWeapon = goutil.findChildComponent(go, "weaponicon", "UIImageSpriteChange")
	local imageIcon = iconWeapon:GetComponent(goutil.Type_UIImage)

	iconWeapon:ChangeSprite(weaponCfg.weaponPic)
	imageIcon:SetNativeSize()
end

function DefendCarrotTaskView:_clearCell(cell)
	local iconReward = goutil.findChild(cell.gameObject, "reward/icon")

	MaterialMgr.resetAll(iconReward)
end

return DefendCarrotTaskView
