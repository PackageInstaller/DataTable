-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/impressionstickers/view/Impressionstickers2025changeView.lua

module("logic.extensions.impressionstickers.view.Impressionstickers2025changeView", package.seeall)

local Impressionstickers2025changeView = class("Impressionstickers2025changeView", ViewComponent)

function Impressionstickers2025changeView:ctor()
	Impressionstickers2025changeView.super.ctor(self)
end

function Impressionstickers2025changeView:unbindEvents()
	Impressionstickers2025changeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnUseLast)
	GameUtil.rmClickHandler(self._btnUseNext)
end

function Impressionstickers2025changeView:bindEvents()
	Impressionstickers2025changeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnUseLast, self._onClickUseLast, self)
	GameUtil.addClickHandler(self._btnUseNext, self._onClickUseNext, self)
end

function Impressionstickers2025changeView:buildUI()
	Impressionstickers2025changeView.super.buildUI(self)

	self._txtCur = self:getTxt("txtCur")
	self._txtNext = self:getTxt("txtNext")
	self._btnUseLast = self:getGo("btnUseLast")
	self._txtBtnLast = self:getTxt("btnUseLast/txt")
	self._btnUseNext = self:getGo("btnUseNext")
	self._txtBtnNext = self:getTxt("btnUseNext/txt")
	self._bg = self:getGo("bg")
	self._time = self:getGo("time")
	self._txtTime = self:getTxt("time/txtTime")
end

function Impressionstickers2025changeView:onExit()
	Impressionstickers2025changeView.super.onExit(self)
	uGuiUtil.clearImage(self._bg.gameObject)
end

function Impressionstickers2025changeView:onEnter()
	Impressionstickers2025changeView.super.onEnter(self)

	local pb = self:getFirstParam() or {}
	local cur = checknumber(pb.impressStickCurRank)
	local gain = checknumber(pb.spaceGainRank)

	self._pb = pb
	self._txtCur.text = cur
	self._txtNext.text = gain
	self._txtBtnLast.text = langPara("排名：%s", cur)
	self._txtBtnNext.text = langPara("排名：%s", gain)
	self._stickerId = pb.stickerId

	local cfg = ImpressionStickersConfig.instance:getStickerRankCfg(self._stickerId) or {}

	uGuiUtil.setSpriteToImage(self._bg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/impressionstickers", cfg.bgUrl))
	GameUtil.SetActive(self._time, false)

	if cfg.startTime and cfg.endTime then
		GameUtil.SetActive(self._time, true)

		local startDate = GameUtil.string2date(cfg.startTime)
		local endDate = GameUtil.string2date(cfg.endTime)

		self._txtTime.text = string.format("时间：%02d.%02d %d:%02d - %02d.%02d %d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	self.addGEvent(self, GlobalNotify.IMPRESSIONSTICKERS_2025_COVER_OK, self._onCoverOK, self)
end

function Impressionstickers2025changeView:_onClickUseNext()
	local content = langPara("确认保存\n修复后排名： <size=32><color=#20b376>%s</color></size> 吗?\n\n<color=#eb4642>仅限选择1次，选择后不可更改！</color>", checknumber(self._pb.spaceGainRank))

	TipsFacade.instance:openPopupWindow("注意", content, function()
		ImpressionStickersController.instance:sendPM_Annuity2025ChangeRankReq(self._stickerId, true)
	end, nil, "确认", "返回上一步", UnityEngine.TextAnchor.MiddleCenter)
end

function Impressionstickers2025changeView:_onClickUseLast()
	local content = langPara("确认保存\n修复前排名： <size=32><color=#20b376>%s</color></size> 吗?\n\n<color=#eb4642>仅限选择1次，选择后不可更改！</color>", checknumber(self._pb.impressStickCurRank))

	TipsFacade.instance:openPopupWindow("注意", content, function()
		ImpressionStickersController.instance:sendPM_Annuity2025ChangeRankReq(self._stickerId, false)
	end, nil, "确认", "返回上一步", UnityEngine.TextAnchor.MiddleCenter)
end

function Impressionstickers2025changeView:_onCoverOK()
	TipsFacade.instance:openCommonTips("排名变动处理成功")
	self:close()
	ImpressionStickersController.instance:tryShowNextChangeView()
end

return Impressionstickers2025changeView
