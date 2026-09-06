-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/view/XinxiyaTeamView.lua

module("logic.extensions.xinxiyamirror.view.XinxiyaTeamView", package.seeall)

local XinxiyaTeamView = class("XinxiyaTeamView", ViewComponent)

function XinxiyaTeamView:ctor()
	XinxiyaTeamView.super.ctor(self)

	self._headGoList = nil
	self._awardItemList = nil
	self._params = nil
	self._stageInfo = nil
end

function XinxiyaTeamView:bindEvents()
	XinxiyaTeamView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._sureBtn:AddClickListener(self._onClickSureBtn, self)
	self._resetBtn:AddClickListener(self._onClickResetBtn, self)
end

function XinxiyaTeamView:unbindEvents()
	XinxiyaTeamView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
	self._resetBtn:RemoveClickListener()
end

function XinxiyaTeamView:onExit()
	XinxiyaTeamView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ResetMirrorStage, self._resetXinxiyaTeamShow, self)

	self._params = nil
	self._stageInfo = nil
end

function XinxiyaTeamView:destroyUI()
	XinxiyaTeamView.super.destroyUI(self)

	self._headGoList = nil
	self._awardItemList = nil
end

function XinxiyaTeamView:buildUI()
	XinxiyaTeamView.super.buildUI(self)

	local viewBgGo = self:getGo("viewBgGo")

	self._closeBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "closeBtn")

	local leftInfoGo = goutil.findChild(viewBgGo, "leftInfoGo")

	self._headGoList = {
		goutil.findChild(leftInfoGo, "headGo_1"),
		goutil.findChild(leftInfoGo, "headGo_2"),
		goutil.findChild(leftInfoGo, "headGo_3"),
		goutil.findChild(leftInfoGo, "headGo_4"),
		goutil.findChild(leftInfoGo, "headGo_5"),
		goutil.findChild(leftInfoGo, "headGo_6"),
		goutil.findChild(leftInfoGo, "headGo_7"),
		goutil.findChild(leftInfoGo, "headGo_8"),
		goutil.findChild(leftInfoGo, "headGo_9")
	}

	local rightInfoGo = goutil.findChild(viewBgGo, "rightInfoGo")

	self._powerTxt = goutil.findChildComponent(rightInfoGo, "powerTxt", "UIImgNumeralText")
	self._awardItemList = {
		goutil.findChild(rightInfoGo, "awardGo_1"),
		goutil.findChild(rightInfoGo, "awardGo_2"),
		goutil.findChild(rightInfoGo, "awardGo_3"),
		goutil.findChild(rightInfoGo, "awardGo_4"),
		goutil.findChild(rightInfoGo, "awardGo_5"),
		goutil.findChild(rightInfoGo, "awardGo_6"),
		goutil.findChild(rightInfoGo, "awardGo_7"),
		goutil.findChild(rightInfoGo, "awardGo_8")
	}
	self._sureBtn = Framework.ButtonAdapter.GetFrom(rightInfoGo, "sureBtn")
	self._resetBtn = Framework.ButtonAdapter.GetFrom(rightInfoGo, "resetBtn")
end

function XinxiyaTeamView:onEnter()
	XinxiyaTeamView.super.onEnter(self)

	SunranBattleModel.instance.cacheStageId = nil
	self._params = self:getFirstParam()

	if self._params == nil or checknumber(self._params.stageId) <= 0 then
		printError("sr---挑战 XinxiyaTeamView:onEnter()   传入参数为空！")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.ResetMirrorStage, self._resetXinxiyaTeamShow, self)

	self._stageInfo = nil

	self:_resetXinxiyaTeamShow()
end

function XinxiyaTeamView:_resetXinxiyaTeamShow()
	self._stageInfo = XinxiyaMirrorModel.instance:getSingleMirrorItem(self._params.planId, self._params.stageId)

	if self._stageInfo == nil or checknumber(self._stageInfo.stageId) ~= self._params.stageId then
		printError("sr---镜像   XinxiyaTeamView:_resetXinxiyaTeamShow()   重置镜像出错！")
	end

	local headList, isSystem = XinxiyaMirrorModel.instance:getMirrorHeadList(self._stageInfo.stageId, self._stageInfo.masterId)

	for i = 1, #self._headGoList do
		MaterialMgr.resetAll(self._headGoList[i])

		if headList[i] and headList[i].num == i then
			local luaCls = MaterialMgr.setCell(MatType.Pet, headList[i].raceId, self._headGoList[i])

			luaCls.binder:setLvl(headList[i].curLv)
			Framework.TransformUtil.SetLocalScale(luaCls.view.transform, 0.8, 0.8, 0.8)
			Framework.TransformUtil.SetLocalPos(luaCls.view.transform, 0, -1.5, 0)
		end
	end

	self._powerTxt:SetNum((self._stageInfo.isSys or nil) and (self._stageInfo.mirPower or self._stageInfo.sysPower))

	if self._stageInfo.isSys then
		if not self._stageInfo.mirPrize then
			local goodsList = self._stageInfo.sysPrize

			for i = 1, #self._awardItemList do
				MaterialMgr.resetAll(self._awardItemList[i])

				if goodsList[i] then
					MaterialMgr.setCellByCfg(goodsList[i], self._awardItemList[i])
				end
			end

			GameUtil.SetActive(self._resetBtn, self._stageInfo.isSys)
		end
	end
end

function XinxiyaTeamView:_onClickSureBtn()
	if self._stageInfo.isSys then
		local baseInfo = XinxiyaMirrorModel.instance:getMirrorBaseInfo()
		local mirrorCfg = XinxiyaMirrorConfig.instance:getOpenTimeCfg(self._params.actyId)

		if mirrorCfg == nil or checknumber(mirrorCfg.dailyTimesLimit) <= checknumber(baseInfo.dailyTimes) then
			FloatWordMgr.instance:show("今日镜像挑战次数已用完！")

			return
		end
	end

	local params = {
		stageId = self._stageInfo.stageId,
		masterId = self._stageInfo.masterId,
		isMirror = self._stageInfo.isSys
	}

	self:close()
	UIStateManager.instance:push(ViewName.XXYMission, params)
end

function XinxiyaTeamView:_onClickResetBtn()
	GameUtil.SetActive(self._resetBtn, false)

	if not self._stageInfo.isSys then
		return
	end

	XinxiyaMirrorController.instance:csResetMirrorStageReq()
end

return XinxiyaTeamView
