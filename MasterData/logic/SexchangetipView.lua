-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/SexchangetipView.lua

module("logic.extensions.dress.view.SexchangetipView", package.seeall)

local SexchangetipView = class("SexchangetipView", ViewComponent)

function SexchangetipView:ctor()
	SexchangetipView.super.ctor(self)
end

function SexchangetipView:buildUI()
	SexchangetipView.super.buildUI(self)

	self._btnEnsure = self:getBtn("btnEnsure")
	self._btnCancel = self:getBtn("btnCancel")
	self._txtShow = self:getTxt("txtShow")
	self._tip1 = self:getGo("tip1")
	self._itemCell = self:getGo("itemCell")
	self._txtNum = self:getTxt("itemCell/txtNum")
	self._goldenDiamond = self:getGo("goldenDiamond")
end

function SexchangetipView:bindEvents()
	SexchangetipView.super.bindEvents(self)
	self._btnEnsure:AddClickListener(self._onClickEnsure, self)
	self._btnCancel:AddClickListener(self.close, self)
end

function SexchangetipView:unbindEvents()
	SexchangetipView.super.unbindEvents(self)
	self._btnEnsure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function SexchangetipView:destroyUI()
	SexchangetipView.super.destroyUI(self)
end

function SexchangetipView:onEnter()
	SexchangetipView.super.onEnter(self)

	self._isNotEnough = true

	if not DressModel.instance:getIsInitData() then
		DressController.instance:sendGetNotoutInfoReq()
	end

	self:_refreshUI()
	GlobalDispatcher:addListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self._refreshUI, self)
end

function SexchangetipView:onExit()
	SexchangetipView.super.onExit(self)
	MaterialMgr.resetAll(self._itemCell)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self._refreshUI, self)
end

function SexchangetipView:_refreshUI()
	self.isGoldenDiamondUser = GoldenDiamondCardModel.instance.isUser

	goutil.setActive(self._goldenDiamond, self.isGoldenDiamondUser)

	self.isHasFreeTimes = RoleModel.instance:getLeftTimesOfTransform() > 0 or self.isGoldenDiamondUser

	goutil.setActive(self._tip1, self.isHasFreeTimes)
	goutil.setActive(self._itemCell, not self.isHasFreeTimes)

	local matStr = DressConfig.instance:getChangeSexCostMatStr()

	if not GameUtil.isEmptyString(matStr) then
		MaterialMgr.setCellByCfg(matStr, self._itemCell)

		local matType, id, matNum = MaterialMgr.getMatParams(matStr)
		local curOwnNum = MaterialMgr.getMatCount(matStr)

		self._isNotEnough = curOwnNum < matNum

		local preStr = self._isNotEnough and string.format("<color=red>%s</color>", curOwnNum) or curOwnNum

		self._txtNum.text = string.format("%s/%s", preStr, matNum)
	end

	local a = RoleModel.instance:getGender() == 1 and lang("男") or lang("女")
	local b = a == lang("男") and lang("女") or lang("男")

	self._txtShow.text = langPara("你将从%s性转换成%s性，服装也会对应转换为%s性服装。确认要进行性别转换吗？", a, b, b)
end

function SexchangetipView:_onClickEnsure()
	if self._isNotEnough and not self.isHasFreeTimes then
		FloatWordMgr.instance:show(langPara("性转卡不足，无法性转"))

		return
	end

	self:close()
	PlayerAgent.instance:sendTransformGenderReq(RoleModel.instance:getGender() == 1 and 0 or 1)
end

return SexchangetipView
