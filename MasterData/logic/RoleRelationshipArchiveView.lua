-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/view/RoleRelationshipArchiveView.lua

module("logic.extensions.rolerelationship.view.RoleRelationshipArchiveView", package.seeall)

local RoleRelationshipArchiveView = class("RoleRelationshipArchiveView", ViewComponent)

function RoleRelationshipArchiveView:ctor()
	RoleRelationshipArchiveView.super.ctor(self)
end

function RoleRelationshipArchiveView:buildUI()
	RoleRelationshipArchiveView.super.buildUI(self)

	self._txtContent = MaterialMgr.findGraphicText(self.mainGO, "contentView/Viewport/Content/txtContent")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._prizeCol = goutil.findChild(self.mainGO, "prizeCol")
	self._prizeItem = goutil.findChild(self.mainGO, "prizeCol/prizeItem")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "prizeCol/prizeItem/txtCount")
	self._prizeGet = goutil.findChild(self.mainGO, "prizeCol/prizeGet")
	self._received = goutil.findChild(self.mainGO, "prizeCol/received")
	self._prizeCol_effParent = goutil.findChild(self.mainGO, "prizeCol/effParent")
	self._posterCon = goutil.findChild(self.mainGO, "posterCol/posterCon")
	self._txtPosterName = goutil.findChildTextComponent(self.mainGO, "posterName/txt")
	self._prizeEff = nil
	self._btnArc = goutil.findChild(self.mainGO, "btnArc")
	self._btnArcSelect = goutil.findChild(self.mainGO, "btnArc/select")
	self._txtBtnArcName = goutil.findChildTextComponent(self.mainGO, "btnArc/txtName")
	self._scrollerview = goutil.findChild(self.mainGO, "impCol/impScrollerview")
	self._scrollercell = goutil.findChild(self.mainGO, "impCol/impScrollercell")

	local updateCellCallBack = GameUtil.handler(self._updateImpCell, self)
	local clearCellCallBack = GameUtil.handler(self._clearImpCell, self)

	self._taskScrollList = ScrollerList.create(self._scrollerview, self._scrollercell, updateCellCallBack, clearCellCallBack)
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
end

function RoleRelationshipArchiveView:bindEvents()
	RoleRelationshipArchiveView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnArc, self._onClickBtnArc, self)
end

function RoleRelationshipArchiveView:unbindEvents()
	RoleRelationshipArchiveView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnArc)
end

function RoleRelationshipArchiveView:destroyUI()
	RoleRelationshipArchiveView.super.destroyUI(self)
end

function RoleRelationshipArchiveView:onEnter()
	RoleRelationshipArchiveView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil then
		printError("缺少传入参数")
		self:_onClickBtnClose()

		return
	end

	self._roleId = checknumber(params[1])
	self._arcPlanId = checknumber(params[2])
	self._arcId = checknumber(params[3])

	if self._roleId == 0 then
		printError("角色ID错误")
	end

	if self._arcPlanId == 0 then
		printError("档案方案ID错误")
	end

	if self._arcId == 0 then
		printError("档案ID错误")
	end

	self._arcData = RoleRelationshipConfig.instance:getRsRoleArcData(self._arcPlanId, self._arcId)
	self._rsRoleArcImpCfg = RoleRelationshipConfig.instance:getRsRoleArcImpCfg(self._arcData.impPlanId)
	self._selectImpId = 0
	self._activityId = RoleRelationshipModel.instance:getCurActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.RoleShip, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:_onClickBtnClose()

		return
	end

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.RoleShipUpdateMapInfo, self._onUpdate, self)
	self:_onUpdate()
end

function RoleRelationshipArchiveView:onExit()
	RoleRelationshipArchiveView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RoleShipUpdateMapInfo, self._onUpdate, self)
	uGuiUtil.clearImage(self._posterCon)
	self:_onClearArchiveUI()

	if self._prizeEff then
		UIEffectManager.instance:stopEffect(self._prizeEff)
	end
end

function RoleRelationshipArchiveView:_onSetUI()
	if self._posterCon then
		local isNeedSetPoster = not string.nilorempty(self._arcData.posterPath)

		if self._posterCon then
			local spriteType = uGuiUtil.SpriteType.BigBg
			local spriteName = string.format("ui/bigbg/pet/%s.png", self._arcData.posterPath)

			local function handler()
				return
			end

			uGuiUtil.setSpriteToImage(self._posterCon, spriteType, spriteName, handler)
		end

		if not string.nilorempty(self._arcData.txtPosterName) and self._txtPosterName then
			self._txtPosterName.text = self._arcData.txtPosterName
		end

		if self._txtBtnArcName then
			local isNeedSetBtnArcName = not string.nilorempty(self._arcData.txtBtnName)

			if isNeedSetBtnArcName then
				self._txtBtnArcName.text = self._arcData.txtBtnName
			end
		end
	end
end

function RoleRelationshipArchiveView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function RoleRelationshipArchiveView:_onUpdateData()
	self:_onUpdateImpDataMo()
end

function RoleRelationshipArchiveView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateArchiveUI()
	self:_onUpdateImpScrollerList()
end

function RoleRelationshipArchiveView:_onUpdatePlaneUI()
	GameUtil.SetActive(self._btnArcSelect, false)
end

function RoleRelationshipArchiveView:_onUpdateArchiveUI()
	local mo = self._impDataMo[self._selectImpId]

	if mo == nil then
		self:_onClickBtnArc()

		return
	end

	local data = mo.data
	local state = mo.impState
	local isCanGetPrize = state == 2
	local isHasGain = state == 3

	if self._txtTitle then
		local isNeedTxtTitle = not string.nilorempty(data.txtTitle)

		if isNeedTxtTitle then
			self._txtTitle.text = data.txtTitle
		end

		if self._txtContent then
			local isNeedTxtContent = not string.nilorempty(data.txtContent)

			if isNeedTxtContent then
				self._txtContent.text = data.txtContent
			end

			GameUtil.SetActive(self._prizeCol, true)

			if not string.nilorempty(data.prize) then
				local matStrArr = string.split(data.prize, ":")
				local matType = checknumber(matStrArr[1])
				local matId = checknumber(matStrArr[2])
				local matNum = checknumber(matStrArr[#matStrArr])

				MaterialMgr.setIcon(self._prizeItem, matType, matId)

				if self._txtCount then
					self._txtCount.text = matNum
				end

				local handler

				GameUtil.addClickHandler(self._prizeCol, isCanGetPrize and function()
					local activityId = self._activityId
					local roleId = self._roleId
					local archiveId = self._arcId
					local impressId = self._selectImpId

					RoleRelationshipController.instance:onSendRRMGainImpressPrizeReq(activityId, roleId, archiveId, impressId)
				end or function()
					CommonTipsMgr.instance:openMaterialTips(self._prizeCol, matType, matId, matNum)
				end)
			end

			GameUtil.SetActive(self._received, isHasGain)

			if self._prizeEff ~= nil then
				UIEffectManager.instance:stopEffect(self._prizeEff)

				self._prizeEff = nil
			end

			local effPath = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"
			local itemGo = self._prizeCol_effParent

			if isCanGetPrize and itemGo then
				local function func(_, eff)
					eff:setClipping(itemGo:GetComponent(goutil.Type_RectTransform))
					eff:setParent(itemGo.transform)
					eff:setLocalPos(0, 0, 0)
					eff:setScale(1, 1, 1)
				end

				self._prizeEff = UIEffectManager.instance:playEffect(self, effPath, itemGo, 0, 0, true, false, nil, func, nil)
			end
		end
	end
end

function RoleRelationshipArchiveView:_onClearArchiveUI()
	if self._prizeItem then
		MaterialMgr.resetAll(self._prizeItem)
	end
end

function RoleRelationshipArchiveView:_onClickBtnArc()
	local data = self._arcData

	if self._txtTitle then
		local isNeedTxtTitle = not string.nilorempty(data.txtTitle)

		if self._txtTitle then
			self._txtTitle.text = data.txtTitle
		end

		if self._txtContent then
			local isNeedTxtContent = not string.nilorempty(data.txtContent)

			if isNeedTxtContent then
				self._txtContent.text = data.txtContent
			end

			GameUtil.SetActive(self._prizeCol, false)
			GameUtil.SetActive(self._btnArcSelect, true)

			self._selectImpId = 0

			self:_onUpdateImpScrollerList()
		end
	end
end

function RoleRelationshipArchiveView:_onUpdateImpDataMo()
	self._impDataMo = {}

	for impId, data in ipairs(self._rsRoleArcImpCfg) do
		table.insert(self._impDataMo, {
			impState = RoleRelationshipController.instance:getImpressState(self._roleId, self._arcPlanId, self._arcId, impId),
			data = data
		})
	end
end

function RoleRelationshipArchiveView:getTaskData(impId)
	return self._impDataMo[impId].impState
end

function RoleRelationshipArchiveView:getTaskData(impId)
	return self._impDataMo[impId].data
end

function RoleRelationshipArchiveView:_onUpdateImpScrollerList()
	local list = {}

	for _, mo in ipairs(self._impDataMo) do
		table.insert(list, mo)
	end

	self._taskScrollList:reloadData(list)
end

function RoleRelationshipArchiveView:_updateImpCell(view, cell, mo, tag)
	local data = mo.data
	local state = mo.impState
	local mainGo = cell.gameObject
	local uiChange = mainGo:GetComponent(ComponentType.UIImageSpriteChange)
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local lock = goutil.findChild(mainGo, "lock")
	local txtTab = goutil.findChildTextComponent(mainGo, "txtTab")

	GameUtil.SetActive(mainGo, true)

	local isNeedTxtTab = txtTab and not string.nilorempty(data.txtTab)

	if isNeedTxtTab then
		txtTab.text = data.txtTab
	end

	local isNeedRed = state == 2

	GameUtil.SetActive(redPoint, isNeedRed)

	if data.impId == self._selectImpId then
		uiChange:SetState(0)
	else
		uiChange:SetState(1)
	end

	local isLocked = state == 1

	GameUtil.SetActive(lock, isLocked)
	GameUtil.SetGray(mainGo, isLocked)

	local handler

	GameUtil.addClickHandler(mainGo, isLocked and function()
		FloatWordMgr.instance:show("与这只精灵间的关系线还有未探索的哦，快去探索吧！")
	end or GameUtil.handler(self._onClickChangeTab, self, data))
end

function RoleRelationshipArchiveView:_clearImpCell(cell)
	return
end

function RoleRelationshipArchiveView:_onClickChangeTab(data)
	self._selectImpId = data.impId

	self:_onUpdateUI()
end

function RoleRelationshipArchiveView:_onClickBtnClose()
	self:close()
end

return RoleRelationshipArchiveView
