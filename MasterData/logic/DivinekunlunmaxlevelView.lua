-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/view/DivinekunlunmaxlevelView.lua

module("logic.extensions.divinekunlun.view.DivinekunlunmaxlevelView", package.seeall)

local DivinekunlunmaxlevelView = class("DivinekunlunmaxlevelView", ViewComponent)

function DivinekunlunmaxlevelView:ctor()
	DivinekunlunmaxlevelView.super.ctor(self)
end

function DivinekunlunmaxlevelView:unbindEvents()
	DivinekunlunmaxlevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivinekunlunmaxlevelView:bindEvents()
	DivinekunlunmaxlevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivinekunlunmaxlevelView:buildUI()
	DivinekunlunmaxlevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._container = goutil.findChild(self.mainGO, "container")
	self._ovalmove = self._container:GetComponent("UIOvalMove")
	self._center = self:getGo("container/center")
	self._txtDesc = self:getTxt("bg/txtDesc")
end

function DivinekunlunmaxlevelView:onExit()
	DivinekunlunmaxlevelView.super.onExit(self)
	LateUpdateBeat:Remove(self._lateUpdateHandler, self)
end

function DivinekunlunmaxlevelView:onEnter()
	DivinekunlunmaxlevelView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = DivineKunlunController.instance:getDefaultActivityId()
	end

	self._activityCfg = DivineKunlunConfig.instance:getActivityCfgById(self._activityId) or {}
	self._txtDesc.text = self._activityCfg.extremeDesc

	local list = DivineKunlunConfig.instance:getExtremeCfgListById(self._activityId) or {}

	self._extremeList = {}

	for k, v in pairs(list) do
		table.insert(self._extremeList, v)
	end

	ArraySort.sortOn(self._extremeList, "stageId")

	self._cellLength = #self._extremeList
	self._cenderIdx = math.floor(self._cellLength / 2)
	self._extInfoMap = {}
	self._colorStrMap = {}
	self._cellList = {}

	LateUpdateBeat:Add(self._lateUpdateHandler, self)
	self.addGEvent(self, GlobalNotify.DIVINE_KUNLUN_INFO_UPDATE, self._onRefreshUI, self)
	DivineKunlunController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()

	self._ovalmove._r = 180
	self._ovalmove._R = 340
	self._ovalmove._angleOffset = 20

	self._ovalmove:CreateObjs(self._cellLength)
	self._ovalmove:CenterOn(0)
end

function DivinekunlunmaxlevelView:_onRefreshUI()
	self._info = DivineKunlunModel.instance:getInfo(self._activityId) or {}

	if not self._info.extremeStageInfo then
		local extremeStageInfo = {}

		for i, v in ipairs(extremeStageInfo) do
			self._extInfoMap[v.left] = v.right
		end

		self._isSuccess = true

		local colG = "#00ff00"
		local colR = "#eb4642"
		local color = colG

		for i, v in ipairs(self._extremeList) do
			local value = checknumber(self._extInfoMap[i])

			if i == 1 then
				if value > 0 then
					color = colG
				else
					color = colR
					self._isSuccess = false
				end
			elseif value <= checknumber(self._extInfoMap[i - 1]) then
				color = colR
				self._isSuccess = false
			end

			self._colorStrMap[i] = langPara("<color=%s>%s</color>", color, value)
		end

		self._ovalmove:RefreshAll(self._updateCell, self)
	end
end

function DivinekunlunmaxlevelView:_lateUpdateHandler()
	for i = 1, self._cellLength do
		local n = "cell_" .. i

		self._cellList[i] = goutil.findChild(self._container, n)
	end

	ArraySort.sortOn(self._cellList, function(go)
		local x, y, z = Framework.TransformUtil.GetLocalPos(go.transform, 0, 0, 0)

		return y
	end, ArraySort.DESCENDING)

	for i, v in ipairs(self._cellList) do
		if i > self._cenderIdx then
			v.transform:SetSiblingIndex(i + 2)
		else
			v.transform:SetSiblingIndex(i)

			if i == self._cenderIdx then
				self._center.transform:SetSiblingIndex(i + 1)
			end
		end
	end
end

function DivinekunlunmaxlevelView:_updateCell(parent, index)
	local idx = self._cellLength - index

	parent.transform.name = "cell_" .. idx

	local cell = goutil.findChild(parent, "container")
	local con = goutil.findChild(parent, "container/buff/conMask/con")
	local txtName = goutil.findChildTextComponent(parent, "container/txtName")
	local txtGroup = goutil.findChildTextComponent(parent, "container/txtGroup")

	MaterialMgr.resetAll(con)

	if not self._extremeList[idx] then
		local creeps = DivineKunlunConfig.instance:getCreeps(self._extremeList[idx].creepsMasterId) or {}
		local raceId = 0

		for k, v in pairs(creeps) do
			if checknumber(v.posId) > 0 then
				raceId = v.raceId

				break
			end
		end

		if raceId > 0 then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, raceId)
		end

		txtName.text = langPara("连击次数：%s", self._colorStrMap[checknumber(self._extremeList[idx].stageId)])
		txtGroup.text = idx

		GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, self._extremeList[idx]))
	end
end

function DivinekunlunmaxlevelView:_onClickCell(cfg)
	if self._isSuccess then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "通关条件已达成，请到主界面领取奖励", function()
			return
		end)
	else
		DivineKunlunController.instance:openExtremeMissionView(self._activityId, cfg.stageId)
	end
end

return DivinekunlunmaxlevelView
