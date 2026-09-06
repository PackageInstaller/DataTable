-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/view/VrspacenorView.lua

module("logic.extensions.vrspace.view.VrspacenorView", package.seeall)

local VrspacenorView = class("VrspacenorView", ViewComponent)

function VrspacenorView:ctor()
	VrspacenorView.super.ctor(self)
end

function VrspacenorView:unbindEvents()
	VrspacenorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnHelp)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnJump2)
end

function VrspacenorView:bindEvents()
	VrspacenorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickJump, self)
end

function VrspacenorView:buildUI()
	VrspacenorView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tableviewV = self:getGo("tableviewV")
	self._tablecellV = self:getGo("tableviewV/tablecell")
	self._tableviewR = self:getGo("tableviewR")
	self._tablecellR = self:getGo("tableviewR/tablecell")
	self._petCell = self:getGo("petCell")
	self._tableviewRight = self:getGo("tableviewRight")
	self._btnReset = self:getGo("btnReset")
	self._btnHelp = self:getGo("btnHelp")
	self._buffCol = self:getGo("buffCol")
	self._btnGain = self:getGo("buffCol/btnGain")
	self._txtDesc = self:getTxt("buffCol/txtDesc")
	self._red = self:getGo("buffCol/red")
	self._goEmpty = self:getGo("goEmpty")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnJump2 = self:getGo("btnJump2")
	self._scrollListV = ScrollerList.create(self._tableviewV, self._tablecellV, GameUtil.handler(self._updateVCell, self), GameUtil.handler(self._clearVCell, self))
	self._scrollListR = ScrollerList.create(self._tableviewR, self._tablecellR, GameUtil.handler(self._updateRCell, self), GameUtil.handler(self._clearRCell, self))
	self._scrollListPet = ScrollerList.create(self._tableviewRight, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function VrspacenorView:onExit()
	VrspacenorView.super.onExit(self)
	self._scrollListV:dispose()
	self._scrollListR:dispose()
	self._scrollListPet:dispose()

	self._buffParam = nil

	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGain)
end

function VrspacenorView:onEnter()
	VrspacenorView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = VRSpaceController.instance:getDefaultActivityId()
	end

	self._activityCfg = VRSpaceConfig.instance:getActivityCfgById(self._activityId)

	local params = self:getOpenParam() or {}

	self._mode = checknumber(params[2])
	self._scrollListMap = {}

	self.addGEvent(self, GlobalNotify.VR_SPACE_INFO_UPDATE, self._onRefreshUI, self)
	VRSpaceController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	GameUtil.SetActive(self._buffCol, false)

	if self._mode == 0 then
		GameUtil.SetActive(self._buffCol, true)

		self._txtTitle.text = "简单模式"
	else
		self._txtTitle.text = "困难模式"
	end

	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGain, function(param)
		self:_onUpdateBuffUI(param)
	end, GameUtil.handler(self._onClickTwice, self))
end

function VrspacenorView:_onRefreshUI()
	self._info = VRSpaceModel.instance:getInfo(self._activityId) or {}

	if not self._info.modeInfos then
		local modeInfos = {}

		self._modeInfoMap = {}

		for i, v in ipairs(modeInfos) do
			self._modeInfoMap[v.mode] = v
		end

		local list = {}
		local map = {}

		self._stageInfoMap = {}

		if not self._modeInfoMap[self._mode] then
			local modeInfo = {}

			self._deadPetIdMap = {}

			for i, v in ipairs(modeInfo.deadPetIds or {}) do
				self._deadPetIdMap[v] = true
			end

			self._curLeftPet = 0

			for i, v in ipairs(modeInfo.virtualStageInfos or {}) do
				self._stageInfoMap[v.stageId] = v

				for j, pp in ipairs(v.virtualPetIds or {}) do
					local petMo = MaterialMgr.getModel(MatType.Pet, pp.right)

					if petMo and map[petMo.raceId] == nil then
						map[petMo.raceId] = true

						local tem = {}

						tem.id = pp.left
						tem.raceId = petMo.raceId

						table.insert(list, tem)

						if not self._deadPetIdMap[pp.left] then
							self._curLeftPet = self._curLeftPet + 1
						end
					end
				end
			end

			self._scrollListPet:reloadData(list)
			GameUtil.SetActive(self._goEmpty, #list == 0)

			local vplanCfg = VRSpaceConfig.instance:getPlanCfgById(self._activityId, self._mode, 0) or {}
			local vstagePlanId = checknumber(vplanCfg.stagePlanId)
			local vlist = VRSpaceConfig.instance:getStageCfgListById(vstagePlanId) or {}

			self._scrollListV:reloadData(vlist)

			for i, v in ipairs(vlist) do
				local aa = self._stageInfoMap[v.stageId]

				if aa == nil then
					self._scrollListV:MoveCellInView(i - 1)

					break
				end
			end

			local rplanCfg = VRSpaceConfig.instance:getPlanCfgById(self._activityId, self._mode, 1) or {}
			local rstagePlanId = checknumber(rplanCfg.stagePlanId)
			local rlist = VRSpaceConfig.instance:getStageCfgListById(rstagePlanId) or {}

			self._scrollListR:reloadData(rlist)

			for i, v in ipairs(vlist) do
				if v.stageId > checknumber(modeInfo.passedRealityStageId) then
					self._scrollListR:MoveCellInView(i - 1)

					break
				end
			end

			if not modeInfo.virtualStageInfos then
				local virtualStageInfos = {}

				self._isCanFightR = #virtualStageInfos >= #vlist

				self:_onUpdateBuffUI()
			end
		end
	end
end

function VrspacenorView:_onUpdateBuffUI(param)
	if param then
		self._buffParam = param

		GameUtil.SetActive(self._red, param.isCanGain)

		local buffCfg = param.buffCfg

		if buffCfg then
			self._txtDesc.text = buffCfg.des or "无效果"
		end
	end

	if _G.next(self._info) and self._buffParam then
		GameUtil.SetActive(self._red, self._buffParam.isCanGain)

		local selectBuffLv = self._info.selectBuffLv
		local buffCfg = SignInBuffConfig.instance:getBuffByActIdAndDay(self._activityId, selectBuffLv)

		if buffCfg then
			if not buffCfg.des then
				local desc = "无效果（可切换）"

				if self._buffParam.isCanGain then
					desc = "【可签到】" .. desc
				end

				self._txtDesc.text = desc
			end
		end
	end
end

function VrspacenorView:_onClickTwice(param)
	if not param.info then
		return
	end

	if not param.buffCfg then
		return
	end

	if param.hasSignInToday then
		UIStateManager.instance:push(ViewName.VrspacebuffView, self._activityId, self._info, param)

		return
	end

	if param.isCurLvMax then
		UIStateManager.instance:push(ViewName.VrspacebuffView, self._activityId, self._info, param)

		return
	end
end

function VrspacenorView:_updateVCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local pass = goutil.findChild(cell, "pass")
	local tableview = goutil.findChild(cell, "tableview")
	local btn = goutil.findChild(cell, "btn")
	local img_1 = goutil.findChild(cell, "img_1")
	local img_2 = goutil.findChild(cell, "img_2")

	GameUtil.SetActive(img_1, self._mode == 0)
	GameUtil.SetActive(img_2, self._mode ~= 0)

	txtName.text = langPara("第<size=36>%s</size>关", data.stageId)

	local info = self._stageInfoMap[data.stageId]

	GameUtil.SetActive(pass, info ~= nil)

	local list = {}

	if info then
		if not info.virtualPetIds then
			do
				local virtualPetIds = {}

				for i, v in ipairs(virtualPetIds) do
					local petMo = MaterialMgr.getModel(MatType.Pet, v.right)

					if petMo then
						local tem = {}

						tem.id = -1
						tem.raceId = petMo.raceId

						table.insert(list, tem)
					end
				end
			end

			local scrollList = self._scrollListMap[cell]

			if scrollList == nil then
				scrollList = ScrollerList.create(tableview, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

				scrollList:setCenterMode(true)

				self._scrollListMap[cell] = scrollList
			end

			scrollList:reloadData(list)
			GameUtil.addClickHandler(btn, GameUtil.handler(self._onVCellClick, self, data))
		end
	end
end

function VrspacenorView:_clearVCell(cell)
	local scrollList = self._scrollListMap[cell]

	if scrollList then
		scrollList:dispose()
	end
end

function VrspacenorView:_updateRCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "infoGo/txtDesc")
	local pass = goutil.findChild(cell, "infoGo/pass")
	local btn = goutil.findChild(cell, "btn")
	local txtName = goutil.findChildTextComponent(cell, "infoGo/txtName")
	local img_1 = goutil.findChild(cell, "infoGo/img_1")
	local img_2 = goutil.findChild(cell, "infoGo/img_2")

	GameUtil.SetActive(img_1, self._mode == 0)
	GameUtil.SetActive(img_2, self._mode ~= 0)

	txtName.text = langPara("第<size=36>%s</size>关", data.stageId)
	txtDesc.text = langPara("虚影精灵要求：<color=#D74CFF>%s</color>", data.virtualPassNum)

	if not self._modeInfoMap[self._mode] then
		local modeInfo = {}

		GameUtil.SetActive(pass, data.stageId <= checknumber(modeInfo.passedRealityStageId))
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onRcellClick, self, data))
	end
end

function VrspacenorView:_clearRCell(cell)
	return
end

function VrspacenorView:_updatePetCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local dead = goutil.findChild(cell, "dead")

	MaterialMgr.setCell(MatType.Pet, data.raceId, con)
	GameUtil.SetActive(dead, self._deadPetIdMap[data.id] ~= nil)
end

function VrspacenorView:_clearPetCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function VrspacenorView:_onVCellClick(data)
	local stageId = data.stageId
	local info = self._stageInfoMap[stageId]
	local lastInfo = self._stageInfoMap[stageId - 1]

	if info then
		TipsFacade.instance:openPopupWindow(lang("tip"), "重复挑战产生新的虚影精灵情况下，将会重置现实关卡精灵哦", function()
			VRSpaceController.instance:openVFmtView(self._activityId, self._mode, stageId)
		end)
	elseif data.stageId == 1 then
		VRSpaceController.instance:openVFmtView(self._activityId, self._mode, stageId)
	elseif lastInfo then
		VRSpaceController.instance:openVFmtView(self._activityId, self._mode, stageId)
	else
		TipsFacade.instance:openCommonTips("请先通关上一关卡战斗")
	end
end

function VrspacenorView:_onRcellClick(data)
	if not self._isCanFightR then
		TipsFacade.instance:openCommonTips("请先通关虚空间所有挑战")

		return
	end

	local stageId = data.stageId

	if not self._modeInfoMap[self._mode] then
		if stageId <= checknumber(self._modeInfoMap[self._mode].passedRealityStageId) then
			TipsFacade.instance:openCommonTips("已通关")
		elseif stageId == checknumber(self._modeInfoMap[self._mode].passedRealityStageId) + 1 then
			if data.virtualPassNum > self._curLeftPet then
				TipsFacade.instance:openCommonTips(langPara("虚影精灵需要：%s只", data.virtualPassNum))
			else
				VRSpaceController.instance:openRFmtView(self._activityId, self._mode, stageId)
			end
		else
			TipsFacade.instance:openCommonTips("请先通关上一关卡战斗")
		end
	end
end

function VrspacenorView:_onClickReset()
	if not self._modeInfoMap[self._mode] then
		if checknumber(self._modeInfoMap[self._mode].passedRealityStageId) > 0 then
			TipsFacade.instance:openPopupWindow(lang("tip"), "重置后将清空所有现实关卡通关状态，虚影空间中所有精灵将复活，是否立即重置？", function()
				VRSpaceController.instance:sendResetInfo(self._activityId, self._mode)
			end)
		else
			TipsFacade.instance:openCommonTips("不需要重置~")
		end
	end
end

function VrspacenorView:_onClickHelp()
	CommonTipsMgr.instance:showTextTips("通关虚拟关卡后，在虚拟关卡中死亡的精灵将进入虚影空间，虚影空间中的精灵可在现实关卡中上阵", self._btnHelp)
end

function VrspacenorView:_onClickJump()
	UIStateManager.instance:push(ViewName.VrspaceprizeView, self._activityId)
end

return VrspacenorView
