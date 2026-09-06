-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaStoryView.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaStoryView", package.seeall)

local PowerPillaStoryView = class("PowerPillaStoryView", ViewComponent)

function PowerPillaStoryView:ctor()
	PowerPillaStoryView.super.ctor(self)
end

function PowerPillaStoryView:unbindEvents()
	PowerPillaStoryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PowerPillaStoryView:bindEvents()
	PowerPillaStoryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PowerPillaStoryView:buildUI()
	PowerPillaStoryView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._cellcon = self:getGo("cellcon")
	self._cell = self:getGo("cell")

	GameUtil.SetActive(self._cell, false)

	self._goldBar = self:getGo("goldBarCon")
end

function PowerPillaStoryView:onExit()
	PowerPillaStoryView.super.onExit(self)

	for i, cell in ipairs(self._cellList) do
		MaterialMgr.resetAll(cell.iconCost)
	end
end

function PowerPillaStoryView:onEnter()
	PowerPillaStoryView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.MPPGetActInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.MPPUnlockStoryRes, self._handleUnlock, self)

	self._activityId = PowerPillaModel.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.MaintainPowerPilla, self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self:_updateUIByCfg()
	MaintainPowerPillaAgent.instance:sendPM_MPPGetActInfoReq(self._activityId)
end

function PowerPillaStoryView:_updateUIByCfg()
	self._storyCfgs = PowerPillaConfig.instance:getStoryCfgs(self._activityId) or {}

	local childCount = self._cellcon.transform.childCount

	for i = 1, childCount do
		local trans = self._cellcon.transform:GetChild(i - 1)

		GameUtil.SetActive(trans.gameObject, false)
	end

	self._cellList = {}

	local showItemStr = ""

	for i, cfg in ipairs(self._storyCfgs) do
		local cell = {}
		local path = "cell_" .. i

		cell.go = goutil.findChild(self._cellcon, path) or goutil.cloneAndSetParent(self._cell, self._cellcon.transform, path)
		cell.cost = goutil.findChild(cell.go, "cost")
		cell.cover = goutil.findChild(cell.go, "cover")
		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		cell.iconCost = goutil.findChild(cell.cost, "icon")
		cell.txtNumCost = goutil.findChildTextComponent(cell.cost, "txtNum")
		cell.txt.text = cfg.showDesc

		GameUtil.setAnchoredPos(cell.go, checknumber(cfg.pos[1]), checknumber(cfg.pos[2]))
		GameUtil.SetActive(cell.go, true)

		local matType, cfgId, matNum = MaterialMgr.getMatParams(cfg.cost)

		MaterialMgr.setIcon(cell.iconCost, matType, cfgId)

		cell.txtNumCost.text = matNum

		GameUtil.rmClickHandler(cell.go)
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickStory, self, i))

		self._cellList[i] = cell

		if GameUtil.isEmptyString(showItemStr) then
			showItemStr = matType .. ":" .. cfgId
		end
	end

	if not GameUtil.isEmptyString(showItemStr) then
		local matMo = string.splitToNumber(showItemStr, ":")
		local name = matMo[1] .. ":" .. matMo[2]
		local objList = {
			{
				showAdd = false,
				id = name
			}
		}

		MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)
	end
end

function PowerPillaStoryView:_updateUIByInfo()
	self._curStoryId = PowerPillaModel.instance:getCurStoryId()

	for i, cell in ipairs(self._cellList) do
		if i <= self._curStoryId then
			GameUtil.SetActive(cell.cost, false)
			GameUtil.SetActive(cell.cover, false)
		elseif i == self._curStoryId + 1 then
			GameUtil.SetActive(cell.cost, true)
			GameUtil.SetActive(cell.cover, false)
		else
			GameUtil.SetActive(cell.cost, false)
			GameUtil.SetActive(cell.cover, true)
		end
	end
end

function PowerPillaStoryView:_handleUnlock()
	self:_updateUIByInfo()

	local cfg = self._storyCfgs[self._curStoryId]

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, cfg.storyId, StoryModel.StoryType.SCCopy)
end

function PowerPillaStoryView:_onClickStory(id)
	local cfg = self._storyCfgs[id]

	if id <= self._curStoryId then
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, cfg.storyId, StoryModel.StoryType.SCCopy)
	elseif id == self._curStoryId + 1 then
		if MaterialMgr.getMatEnough(cfg.cost) then
			MaintainPowerPillaAgent.instance:sendPM_MPPUnlockStoryReq(self._activityId)
		else
			local matName = MaterialMgr.getMaterialsNameByCfg(cfg.cost)

			FloatWordMgr.instance:show(string.format("%s不足，去龙塔探秘获得更多吧!", matName))
		end
	else
		FloatWordMgr.instance:show("请优先解锁前面碎片")
	end
end

return PowerPillaStoryView
