-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/NoahSignInPopupView.lua

module("logic.extensions.operationsignin.view.NoahSignInPopupView", package.seeall)

local NoahSignInPopupView = class("NoahSignInPopupView", ViewComponent)

function NoahSignInPopupView:ctor()
	NoahSignInPopupView.super.ctor(self)
end

function NoahSignInPopupView:buildUI()
	NoahSignInPopupView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._con = self:getGo("poster/con")
	self._bgEff = nil
	self._txtTitle = self:getGo("txtTitle"):GetComponent(goutil.Type_UIText)
	self._txtDesc = self:getGo("txtDesc"):GetComponent(goutil.Type_UIText)
	cell = {}
	cell._mainGo = self:getGo("signCell")
	cell._btnSignin = self:getBtn("signCell")
	cell._item = goutil.findChild(cell._mainGo, "item")
	cell._recieve = goutil.findChild(cell._mainGo, "recieve")
	cell._txtNum = goutil.findChild(cell._mainGo, "txtNum"):GetComponent(goutil.Type_UIText)
	cell._effGo = goutil.findChild(cell._mainGo, "effect")
	cell._eff = nil

	goutil.setActive(cell._bg, true)
	goutil.setActive(cell._item, true)
	goutil.setActive(cell._recieve, false)
	goutil.setActive(cell._effGo, false)
end

function NoahSignInPopupView:bindEvents()
	NoahSignInPopupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(cell._btnSignin, self._onClickBtnSignInReward, self)
end

function NoahSignInPopupView:unbindEvents()
	NoahSignInPopupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(cell._btnSignin)
end

function NoahSignInPopupView:destroyUI()
	NoahSignInPopupView.super.destroyUI(self)
end

function NoahSignInPopupView:onEnter()
	NoahSignInPopupView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil then
		printError("缺少传入数据，无法继续运行")

		return
	end

	self.data = params[1]

	local cfgAllStr = string.split(self.data.reward, "#")

	if #cfgAllStr ~= 1 then
		printError(string.format("该物品配置个数不正确，一次只能配一个物品， activityId = %d, day = %d", self.data.activityId, self.data.day))
	end

	local cfgStr = string.split(cfgAllStr[1], ":")

	self.matStr = {}
	self.matStr.matType = checknumber(cfgStr[1])
	self.matStr.matId = checknumber(cfgStr[2])
	self.matStr.matNum = checknumber(cfgStr[#cfgStr])

	if matType == MatType.Pet then
		self.matStr.matNum = checknumber(cfgStr[3])
	end

	self:_setPlaneUI()
	GlobalDispatcher:addListener(GlobalNotify.OperationSignIn, self._updateSignCell, self)
	self:_updateSignCell()
end

function NoahSignInPopupView:onExit()
	NoahSignInPopupView.super.onExit(self)
	uGuiUtil.clearImage(self._con)
	MaterialMgr.resetAll(cell._item)
	UIEffectManager.instance:stopEffect(cell._eff)
	GlobalDispatcher:removeListener(GlobalNotify.OperationSignIn, self._updateSignCell, self)
end

function NoahSignInPopupView:_setPlaneUI()
	if not string.nilorempty(self.data.posterName) then
		local bgUrl = string.format("ui/bigbg/operationsignin/%s.png", self.data.posterName)

		uGuiUtil.setSpriteToImage(self._con, uGuiUtil.SpriteType.BigBg, bgUrl)
	else
		printError("缺失背景图片配置")
	end

	self._txtTitle.text = self.data.posterTitle or "未配置"
	self._txtDesc.text = self.data.posterText or "未配置"

	MaterialMgr.setIcon(cell._item, self.matStr.matType, self.matStr.matId)
	GameUtil.setLocalScale(cell._item, 1, 1, 1)

	cell._txtNum.text = self.matStr.matNum
end

function NoahSignInPopupView:_updateSignCell()
	local onlineDay = OperationSignInModel.instance:getOnlineDay() or -1
	local daysList = OperationSignInModel.instance:getDaysList()
	local isCanGain = not daysList[self.data.day] and onlineDay >= self.data.day
	local isHasGain = daysList[self.data.day]

	goutil.setActive(cell._recieve, isHasGain)
	UIEffectManager.instance:stopEffect(cell._eff)
	goutil.setActive(cell._effGo, isCanGain)

	if isCanGain then
		local path = "fx_ui_fuli/fx_ui_fuli_lingqu" .. ".prefab"

		local function func(_, eff)
			eff:setParent(cell._effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScaleXYZ(0.8, 0.8, 1)
			eff:setClipping(cell._effGo:GetComponent(goutil.Type_RectTransform))
		end

		cell._eff = UIEffectManager.instance:playEffect(self, path, cell._effGo, 0, 0, true, false, nil, func)
	end
end

function NoahSignInPopupView:_onClickBtnSignInReward()
	local onlineDay = OperationSignInModel.instance:getOnlineDay() or -1
	local daysList = OperationSignInModel.instance:getDaysList()
	local isCanGain = not daysList[self.data.day] and onlineDay >= self.data.day

	local function func(msg)
		MaterialFacade.instance:popAndShowChangeSetItems(msg.changeSetId)
	end

	if isCanGain == true then
		OperationSignInController.instance:gainPrize(self.data.day, func)
		OperationSignInController.instance:getInfo()
	else
		local cfg = self.matStr

		CommonTipsMgr.instance:openMaterialTips(cell._item, cfg.matType, cfg.matId, cfg.matNum)
	end
end

function NoahSignInPopupView:_onClickBtnClose()
	self:close()
end

return NoahSignInPopupView
