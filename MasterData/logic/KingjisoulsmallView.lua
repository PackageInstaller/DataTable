-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjisoulsmallView.lua

module("logic.extensions.kingjichallenge.view.KingjisoulsmallView", package.seeall)

local KingjisoulsmallView = class("KingjisoulsmallView", ViewComponent)

function KingjisoulsmallView:ctor()
	KingjisoulsmallView.super.ctor(self)
end

function KingjisoulsmallView:buildUI()
	KingjisoulsmallView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._txtNum = self:getTxt("img/txtNum")
	self._txtDesc = self:getTxt("txtDesc")
	self._cellGo = self:getGo("cell")
	self.scrollerGo = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self.scrollerGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function KingjisoulsmallView:bindEvents()
	KingjisoulsmallView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function KingjisoulsmallView:unbindEvents()
	KingjisoulsmallView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function KingjisoulsmallView:onEnter()
	KingjisoulsmallView.super.onEnter(self)

	local param = self:getOpenParam()

	self._activityId = KingjichallengeModel.instance:getActivityId()
	self._stageId = param[1]
	self._passMaxSmallStageId = self:_getPassMaxSmallStageId()
	self._isCanFinishMove = true

	self:_updateTxtNum()
	self:_initTableview()
	self:_setDesc()
end

function KingjisoulsmallView:onExit()
	KingjisoulsmallView.super.onExit(self)
	self.scrollList:dispose()
end

function KingjisoulsmallView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, self._viewPresentor.viewName .. "_rule")
end

function KingjisoulsmallView:_updateTxtNum()
	local info = KingjichallengeModel.instance:getInfo()

	if not info then
		return
	end

	for i, v in ipairs(info.soulInfo.stageList) do
		if v.stageId == self._stageId then
			local cfgs = KingjichallengeConfig.instance:getSoulStagePlanCfgs(self._activityId, self._stageId)
			local maxNum = #cfgs

			self._txtNum.text = string.format("已通关：<color=#F1D545FF>%d</color>/%d", v.passMaxSmallStageId, maxNum)

			break
		end
	end
end

function KingjisoulsmallView:_updateCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local passGo = goutil.findChild(cell, "pass")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local btnPass = Framework.ButtonAdapter.GetFrom(cell.gameObject, "pass")

	txtName.text = string.format("第%s关", cell.data)
	txtDesc.text = data.desc

	local isPass = KingjichallengeController.instance:isSoulSmallPass(self._stageId, data.stageId)
	local isOpen = data.stageId <= self._passMaxSmallStageId + 1

	goutil.setActive(passGo, isPass and isOpen)
	goutil.setActive(btn.gameObject, not isPass and isOpen)
	GameUtil.SetGray(cell.gameObject, not isOpen)

	local modelCo = CharacterConfig.instance:getModelCo(data.raceId)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	btn:AddClickListener(function()
		KingjichallengeController.instance:enterMission(GameEnum.KingjiChallengeType.Hun, self._stageId, data.creepsMasterId, data.stageId)
	end)
	btnPass:AddClickListener(function()
		FloatWordMgr.instance:show("已通关")
	end)
end

function KingjisoulsmallView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function KingjisoulsmallView:_initTableview()
	local list = KingjichallengeConfig.instance:getSoulStagePlanCfgs(self._activityId, self._stageId)

	self.scrollList:regReloadFinish(function()
		if self._isCanFinishMove then
			self.scrollList:MoveCellToCenter(Mathf.Clamp(self._passMaxSmallStageId + 1, 1, #list))

			self._isCanFinishMove = false
		end
	end)
	self.scrollList:reloadData(list)
end

function KingjisoulsmallView:_getPassMaxSmallStageId()
	local info = KingjichallengeModel.instance:getInfo()

	if not info then
		return 0
	end

	for i, v in ipairs(info.soulInfo.stageList) do
		if v.stageId == self._stageId then
			return v.passMaxSmallStageId
		end
	end

	return 0
end

function KingjisoulsmallView:_setDesc()
	local cfg = KingjichallengeConfig.instance:getSoulStageCfg(self._activityId, self._stageId)

	self._txtDesc.text = cfg.stageDesc
end

return KingjisoulsmallView
