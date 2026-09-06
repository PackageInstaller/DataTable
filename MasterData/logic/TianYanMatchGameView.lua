-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchGameView.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchGameView", package.seeall)

local TianYanMatchGameView = class("TianYanMatchGameView", ClearStarGameView)

function TianYanMatchGameView:ctor()
	TianYanMatchGameView.super.ctor(self)
end

function TianYanMatchGameView:unbindEvents()
	TianYanMatchGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function TianYanMatchGameView:bindEvents()
	TianYanMatchGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function TianYanMatchGameView:buildUI()
	TianYanMatchGameView.super.buildUI(self)

	self._btnOneKey = self:getGo("btnOneKey")
end

function TianYanMatchGameView:onExit()
	TianYanMatchGameView.super.onExit(self)
end

function TianYanMatchGameView:onEnter()
	TianYanMatchGameView.super.onEnter(self)
end

function TianYanMatchGameView:_onClickOneKey()
	local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(self._activityId)

	if not isCanSweep then
		FloatWordMgr.instance:show(lang("扫荡不可用"))

		return
	end

	local clearStarInfo = ClearStarGameModel.instance:getInfo(self._activityId)

	if not clearStarInfo.scores or #clearStarInfo.scores <= 0 then
		FloatWordMgr.instance:show(lang("未首通，扫荡不可用"))

		return
	end

	local totalMatMap = {}

	for i, v in ipairs(clearStarInfo.scores) do
		local convertCfg = ClearStarGameConfig.instance:getConvertCfgByType(self._activityId, v.scoreType)
		local matNum = Mathf.Min(Mathf.Ceil(v.num / convertCfg.ratio), convertCfg.limit)

		totalMatMap[convertCfg.itemId] = totalMatMap[convertCfg.itemId] or 0
		totalMatMap[convertCfg.itemId] = totalMatMap[convertCfg.itemId] + matNum
	end

	local isInitInfo = YearCardModel.instance:isInitInfo()

	if not isInitInfo then
		FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

		return
	end

	local matStr = ""

	for itemId, itemNum in pairs(totalMatMap) do
		matStr = not string.nilorempty(matStr) and string.format("%s、%s*%d", matStr, MaterialMgr.getMaterialsName(MatType.ACTIVITY_ITEM, itemId), itemNum) or string.format("%s*%d", MaterialMgr.getMaterialsName(MatType.ACTIVITY_ITEM, itemId), itemNum)
	end

	local descTxt = langPara("您已首通完毕，是否扫荡直接通关？\n当前可获得奖励数量：%s", matStr)

	local function sureCallBack(view)
		ClearStarGameAgent.instance:sendPM_ClearStarSweepReq(self._activityId, view:getCurTimes())
	end

	local function cancelCallBack(view)
		return
	end

	local otherCallBack

	local function updateCoinTxtCallBack(view)
		view:getTxtCoin().text = ""
	end

	local function updateDescTxtCallBack(view)
		local combineStr = ""

		for itemId, itemNum in pairs(totalMatMap) do
			local numResult = itemNum * view:getCurTimes()

			combineStr = not string.nilorempty(combineStr) and string.format("%s、%s*%d", combineStr, MaterialMgr.getMaterialsName(MatType.ACTIVITY_ITEM, itemId), numResult) or string.format("%s*%d", MaterialMgr.getMaterialsName(MatType.ACTIVITY_ITEM, itemId), numResult)
		end

		view:getTxtDesc().text = langPara("您已首通完毕，是否扫荡直接通关？\n当前可获得奖励数量：%s", combineStr)
	end

	local left = self:_getLeftTimes()

	if left == 0 then
		FloatWordMgr.instance:show("已无通关次数")

		return
	end

	TipsFacade.instance:openPopupCommonCostPopView(left, 1, "年费扫荡", "扫荡", "取消", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
end

function TianYanMatchGameView:_getLeftTimes()
	local actCfg = ClearStarGameConfig.instance:getActivityCfgById(self._activityId)
	local info = ClearStarGameModel.instance:getInfo(self._activityId)

	if info == nil then
		return 0
	end

	return actCfg.dailyTime - checknumber(info.todayTimes)
end

return TianYanMatchGameView
