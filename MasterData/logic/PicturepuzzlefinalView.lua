-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/picturepuzzle/view/PicturepuzzlefinalView.lua

module("logic.extensions.picturepuzzle.view.PicturepuzzlefinalView", package.seeall)

local PicturepuzzlefinalView = class("PicturepuzzlefinalView", ViewComponent)

function PicturepuzzlefinalView:ctor()
	PicturepuzzlefinalView.super.ctor(self)
end

function PicturepuzzlefinalView:buildUI()
	PicturepuzzlefinalView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._gainBtn = self:getBtn("gainBtn")
	self._gainBtnTxt = self:getTxt("gainBtn/Text")
	self._bubbleTxt = self:getTxt("role/bubble/Text")
	self._view = ScrollerList.create(self:getGo("view"), self:getGo("cell"), GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PicturepuzzlefinalView:bindEvents()
	PicturepuzzlefinalView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._gainBtn:AddClickListener(self._onClickGain, self)
end

function PicturepuzzlefinalView:unbindEvents()
	PicturepuzzlefinalView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._gainBtn:RemoveClickListener()
end

function PicturepuzzlefinalView:destroyUI()
	PicturepuzzlefinalView.super.destroyUI(self)
end

function PicturepuzzlefinalView:onEnter()
	PicturepuzzlefinalView.super.onEnter(self)
	GlobalDispatcher:addListener(PicturepuzzleController.PM_PuzzleJigsawGainFinalPrizeRes, self.close, self)

	local openParam = self:getOpenParam()

	self._actId = openParam[1].id
	self._complete = openParam[2] and ServerTime.now() >= openParam[1].startTime + 86400 * (openParam[1].gainDay - 1)

	local prizeStr = string.split(openParam[1].finalPrize, "#")

	self._view:reloadData(prizeStr)

	local startT = os.date("*t", openParam[1].startTime + 86400 * (openParam[1].gainDay - 1))

	self._bubbleTxt.text = string.format("成功拼完%d张拼图，即可在%d月%d日 %d:%02d 后领取大奖！", #openParam[1], startT.month, startT.day, startT.hour, startT.min)

	if openParam[1].isGainFinalPrize then
		self._gainBtnTxt.text = "已领取"

		self._gainBtn:RemoveClickListener()
		uGuiUtil.setGoGrayState(self._gainBtn.gameObject, true)
	else
		uGuiUtil.setGoGrayState(self._gainBtn.gameObject, not self._complete)

		self._gainBtnTxt.text = "领取"
	end
end

function PicturepuzzlefinalView:onEnterFinished()
	PicturepuzzlefinalView.super.onEnterFinished(self)
end

function PicturepuzzlefinalView:onExit()
	PicturepuzzlefinalView.super.onExit(self)
	GlobalDispatcher:removeListener(PicturepuzzleController.PM_PuzzleJigsawGainFinalPrizeRes, self.close, self)
end

function PicturepuzzlefinalView:onExitFinished()
	PicturepuzzlefinalView.super.onExitFinished(self)
end

function PicturepuzzlefinalView:_onClickGain()
	if self._complete then
		PuzzleJigsawAgent.instance:sendPM_PuzzleJigsawGainFinalPrizeReq(self._actId)
	else
		FloatWordMgr.instance:show("尚不满足领取条件")
	end
end

function PicturepuzzlefinalView:_updateCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, goutil.findChild(cell.gameObject, "item"))
end

function PicturepuzzlefinalView:_clearCell(cell)
	MaterialMgr.resetAll(goutil.findChild(cell.gameObject, "item"))
end

return PicturepuzzlefinalView
