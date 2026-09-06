-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/HuimiexinshengView.lua

module("logic.extensions.caiqingdraw.view.HuimiexinshengView", package.seeall)

local HuimiexinshengView = class("HuimiexinshengView", CaiqingdrawView)

function HuimiexinshengView:ctor()
	HuimiexinshengView.super.ctor(self)
end

function HuimiexinshengView:unbindEvents()
	HuimiexinshengView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTaskLeft)
	GameUtil.rmClickHandler(self._btnTaskRight)
end

function HuimiexinshengView:bindEvents()
	HuimiexinshengView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTaskLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnTaskRight, self._onClickRight, self)
end

function HuimiexinshengView:buildUI()
	HuimiexinshengView.super.buildUI(self)

	self._btnTaskLeft = self:getGo("btnTaskLeft")
	self._btnTaskRight = self:getGo("btnTaskRight")
	self._redLeft = self:getGo("btnTaskLeft/redpoint")
	self._redRight = self:getGo("btnTaskRight/redpoint")
	self._txtNumLeft = self:getTxt("btnTaskLeft/txtNum")
	self._txtNumRight = self:getTxt("btnTaskRight/txtNum")
	self._bloodImgLeft = self:getGo("btnTaskLeft/bloodImg"):GetComponent(goutil.Type_UIImage)
	self._bloodImgRight = self:getGo("btnTaskRight/bloodImg"):GetComponent(goutil.Type_UIImage)
	self._txt = MaterialMgr.findGraphicText(self.mainGO, "txtCost")
	self._effectRootGo = self:getGo("effectRoot")
end

function HuimiexinshengView:onExit()
	HuimiexinshengView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redLeft)
	RedPointController.instance:unregRedPoint(self._redRight)
end

function HuimiexinshengView:onEnter()
	HuimiexinshengView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._updateItem, self)
	self.addGEvent(self, GlobalNotify.UpdataTiliCount, self._updateItem, self)
	self.addGEvent(self, GlobalNotify.UpdataEnergyCount, self._updateItem, self)
	self:_updateItem()
	RedPointController.instance:regRedPoint(self._redLeft, 445)
	RedPointController.instance:regRedPoint(self._redRight, 445)
end

function HuimiexinshengView:_initSpine()
	return
end

function HuimiexinshengView:_updateItem()
	self._txtNumLeft = self:getTxt("btnTaskLeft/txtNum")
	self._txtNumRight = self:getTxt("btnTaskRight/txtNum")

	local costStr = self._activityCfg.cost
	local arr = string.split(costStr, "#")
	local t1, id1, num1 = MaterialMgr.getMatParams(arr[1])
	local t2, id2, num2 = MaterialMgr.getMatParams(arr[2])
	local count1 = MaterialModel.instance:getMaterialsNumber(t1, id1)
	local count2 = MaterialModel.instance:getMaterialsNumber(t2, id2)

	self._txtNumLeft.text = langPara("<color=#4DEE77>%d</color>/%d", count1, num1)
	self._txtNumRight.text = langPara("<color=#4DEE77>%d</color>/%d", count2, num2)
	self._bloodImgLeft.fillAmount = math.min(1, count1 / num1)
	self._bloodImgRight.fillAmount = math.min(1, count2 / num2)
end

function HuimiexinshengView:_onClickLeft()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId, 1)
end

function HuimiexinshengView:_onClickRight()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId, 2)
end

function HuimiexinshengView:_initAnimPre()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Caiqingdraw)
	end

	self._activityCfg = CaiQingDrawConfig.instance:getActivityCfgById(self._activityId)
	self._animationPreKey = self.__cname
end

function HuimiexinshengView:_lotteryCost()
	local costStr = self._activityCfg.cost
	local content = "消耗："
	local arr = string.split(costStr, "#")

	for i, cfgStr in ipairs(arr) do
		local matType, matId, num = MaterialMgr.getMatParams(cfgStr)

		content = content .. MaterialMgr.getContentMatStr(cfgStr, 26, -5, MaterialMgr.ICON_TYPE_ICON) .. "x" .. num

		if i ~= #arr then
			content = content .. "、"
		end
	end

	self._txt.text = content
end

function HuimiexinshengView:_getDrawAnimPath()
	return "20241220/longyanchoujiang/fx_ui_longyanchoujiang.prefab"
end

function HuimiexinshengView:_onClickLottery()
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")
	local isCanLottery, curState = self:_canLottery(isTen)

	if not isCanLottery then
		if curState == 1 then
			local limit = self._activityCfg.weekLimit

			FloatWordMgr.instance:show(string.format("目前已达到每周抽奖次数上限%s次，等周五5点刷新后再来抽吧~", limit))

			return
		elseif curState == 2 then
			FloatWordMgr.instance:show("请去获得足够的抽奖道具后再来抽吧~")

			return
		end
	end

	local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")

	if not isPass then
		local animPath = self:_getDrawAnimPath()

		local function onAnimPlashFinish()
			ViewBlockMgr.instance:blockClick(false, self._animationPreKey)
			self:_CaiQingDrawPrizeReq()
		end

		local function onAnimPlashStart()
			ViewBlockMgr.instance:blockClick(true, self._animationPreKey)
		end

		local animEffect = UIEffectManager.instance:playEffect(self, animPath, nil, 0, 0, false, nil, onAnimPlashFinish, onAnimPlashStart, self)

		animEffect:setParent(self._effectRootGo.transform)
		animEffect:setScale(1, 1, 1)
		animEffect:setLocalPos(0, 0, 0)
	else
		self:_CaiQingDrawPrizeReq()
	end
end

return HuimiexinshengView
