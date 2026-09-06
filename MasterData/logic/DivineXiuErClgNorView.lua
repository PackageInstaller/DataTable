-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgNorView.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgNorView", package.seeall)

local DivineXiuErClgNorView = class("DivineXiuErClgNorView", ViewComponent)

function DivineXiuErClgNorView:buildUI()
	DivineXiuErClgNorView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._partCol = goutil.findChild(self.mainGO, "partCol")
	self._partView = goutil.findChild(self.mainGO, "partCol/partView")
	self._partCell = goutil.findChild(self.mainGO, "partCol/partCell")
	self._partCol_left = goutil.findChild(self.mainGO, "partCol/left")
	self._partCol_left_txtTitle = goutil.findChildTextComponent(self.mainGO, "partCol/left/txtTitle")
	self._partCol_left_txtTips = goutil.findChildTextComponent(self.mainGO, "partCol/left/txtTips")
	self._partCol_right = goutil.findChild(self.mainGO, "partCol/right")
	self._partCol_right_txtTitle = goutil.findChildTextComponent(self.mainGO, "partCol/right/txtTitle")
	self._partCol_right_txtTips = goutil.findChildTextComponent(self.mainGO, "partCol/right/txtTips")
	self._progressCol_left = goutil.findChild(self.mainGO, "progressCol/left")
	self._progressCol_left_slider = goutil.findChild(self.mainGO, "progressCol/left/slider")
	self._progressCol_left_sliderComp = self._progressCol_left_slider:GetComponent(ComponentType.Slider)
	self._progressCol_left_txtName = goutil.findChildTextComponent(self.mainGO, "progressCol/left/txtName")
	self._progressCol_left_txtProgress = goutil.findChildTextComponent(self.mainGO, "progressCol/left/txtProgress")
	self._progressCol_right = goutil.findChild(self.mainGO, "progressCol/right")
	self._progressCol_right_slider = goutil.findChild(self.mainGO, "progressCol/right/slider")
	self._progressCol_right_sliderComp = self._progressCol_right_slider:GetComponent(ComponentType.Slider)
	self._progressCol_right_txtName = goutil.findChildTextComponent(self.mainGO, "progressCol/right/txtName")
	self._progressCol_right_txtProgress = goutil.findChildTextComponent(self.mainGO, "progressCol/right/txtProgress")

	GameUtil.SetActive(self._partCell, false)
end

function DivineXiuErClgNorView:bindEvents()
	DivineXiuErClgNorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function DivineXiuErClgNorView:unbindEvents()
	DivineXiuErClgNorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineXiuErClgNorView:onEnter()
	DivineXiuErClgNorView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = DivineXiuErClgController.instance:getActivityType()

	local isInTime = DivineXiuErClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = DivineXiuErClgConfig.instance:getDxecActData(self._activityId)
	self._norClgData = DivineXiuErClgConfig.instance:getDxecNorClgData(self._activityId)

	self.addGEvent(self, GlobalNotify.handlePM_DivineXiuErClgGetInfoRes, self._onUpdate, self)
	self:_onSetUI()
	DivineXiuErClgController.instance:sendPM_DivineXiuErClgGetInfoReq(self._activityId)
end

function DivineXiuErClgNorView:onExit()
	DivineXiuErClgNorView.super.onExit(self)
	self:_onClear()
end

function DivineXiuErClgNorView:_onSetUI()
	return
end

function DivineXiuErClgNorView:_onUpdate()
	local result, tips = DivineXiuErClgController.instance:getTryEnterNorClgResultAndTips(self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		if result == GameEnum.ResultCode.IsPass then
			local info = {}

			info.desc1 = "恭喜通关"
			info.desc2 = self._norClgData.clgTips

			function info.closeCallBack()
				self:close()
			end

			UIStateManager.instance:push(ViewName.DivineXiuErClgExtTruefalseSuccessView, info)
		else
			self:close()
		end

		return
	end

	self._groupId = DivineXiuErClgController.instance:getTodayGroupIdOfNor(self._activityId)

	self:_onUpdatePartColUI()
	self:_onUpdateProgressColUI()
end

function DivineXiuErClgNorView:_onClear()
	self:_onClearPartCol()
end

function DivineXiuErClgNorView:_onUpdatePartColUI()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)
	local childGo = self._partCell
	local cfg = DivineXiuErClgConfig.instance:getDxecNorStageGroupCfg(self._activityId, self._groupId)

	if cfg then
		if not #cfg then
			local length = 0

			if cfg then
				for idx, data in ipairs(cfg) do
					local mainGo = children[idx]

					if mainGo == nil then
						mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))

						local pos = data.pos
						local x, y = checknumber(pos[1]), checknumber(pos[2])

						GameUtil.setLocalPos(mainGo, x, y, 0)
					end

					self:_updatePartCell(mainGo, data)
				end
			end

			for idx = 1, parentTran.childCount do
				local mainGo = parentTran:GetChild(idx - 1)

				if idx <= length then
					GameUtil.SetActive(mainGo, true)
				else
					self:_clearPartCell(mainGo)
					GameUtil.SetActive(mainGo, false)
				end
			end

			local leftStageTypeData = DivineXiuErClgConfig.instance:getDxecNorStageTypeData(self._activityId, DxecEnum.ExtStageType_True)

			if leftStageTypeData then
				self._partCol_left_txtTips.text = leftStageTypeData.tipsDesc
				self._partCol_left_txtTitle.text = leftStageTypeData.title
			end

			local rightStageTypeData = DivineXiuErClgConfig.instance:getDxecNorStageTypeData(self._activityId, DxecEnum.NorStageType_False)

			if rightStageTypeData then
				self._partCol_right_txtTips.text = rightStageTypeData.tipsDesc
				self._partCol_right_txtTitle.text = rightStageTypeData.title
			end
		end
	end
end

function DivineXiuErClgNorView:_onClearPartCol()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		self:_clearPartCell(mainGo)
	end
end

function DivineXiuErClgNorView:_updatePartCell(mainGo, data)
	local groupId = data.groupId
	local dataBitId = data.dataBitId
	local isPass = DivineXiuErClgController.instance:isPassOfStageOfNor(self._activityId, dataBitId)
	local score = DivineXiuErClgController.instance:getStageScoreOfNor(self._activityId, dataBitId)
	local head = goutil.findChild(mainGo, "head")
	local icon = goutil.findChild(mainGo, "head/icon")
	local imgPass = goutil.findChild(mainGo, "head/imgPass")
	local desc = goutil.findChild(mainGo, "desc")
	local desc_txt = goutil.findChildTextComponent(mainGo, "desc/txt")

	desc_txt.text = string.format(data.desc, score)

	self:_loadBigBg(icon, data.iconPath)
	GameUtil.SetActive(imgPass, false)
	GameUtil.addClickHandler(head, GameUtil.handler(self._onClickPartCell, self, groupId, dataBitId))
end

function DivineXiuErClgNorView:_clearPartCell(mainGo)
	local head = goutil.findChild(mainGo, "head")
	local icon = goutil.findChild(mainGo, "head/icon")

	GameUtil.rmClickHandler(head)
	self:_unLoadBigBg(icon)
end

function DivineXiuErClgNorView:_onClickPartCell(groupId, dataBitId)
	local result, tips = DivineXiuErClgController.instance:getTryFightNorClgResultAndTips(self._activityId, groupId, dataBitId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.DivineXiuErClgMainView, nil)
	UIJumper.instance:pushOneStack(ViewName.DivineXiuErClgNorView, nil, self._activityId)
	DivineXiuErClgController.instance:enterBattleOfNorClg(self._activityId, groupId, dataBitId)
end

function DivineXiuErClgNorView:_onUpdateProgressColUI()
	local trueProgress = DivineXiuErClgController.instance:getProgressByTypeOfNor(self._activityId, DxecEnum.ExtStageType_True)
	local falseProgress = DivineXiuErClgController.instance:getProgressByTypeOfNor(self._activityId, DxecEnum.NorStageType_False)
	local maxProgress = DivineXiuErClgController.instance:getMaxProgressLimitOfNor(self._activityId)

	self._progressCol_left_sliderComp.value = trueProgress / maxProgress
	self._progressCol_right_sliderComp.value = falseProgress / maxProgress
	self._progressCol_left_txtProgress.text = string.format("%s/%s", Mathf.Min(trueProgress, maxProgress), maxProgress)
	self._progressCol_right_txtProgress.text = string.format("%s/%s", Mathf.Min(falseProgress, maxProgress), maxProgress)
end

function DivineXiuErClgNorView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function DivineXiuErClgNorView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function DivineXiuErClgNorView:_onClickBtnTip()
	local key = DivineXiuErClgConfig.instance:getDxecCommonValue(self._activityId, "ruleKeyNor")

	TipsFacade.instance:openRulesView(key)
end

return DivineXiuErClgNorView
