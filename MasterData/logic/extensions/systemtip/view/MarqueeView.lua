-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemtip/view/MarqueeView.lua

module("logic.extensions.systemtip.view.MarqueeView", package.seeall)

local M = class("MarqueeView", ViewComponent)
local fromPosX = 700
local endPosX = -650
local speed = 120
local kBlackColor = Astral.ColorUtil.ParseColor("#00000000")

function M:buildUI()
	self._imgBg = self:getImage("marquee_view_1391418612")
	self._txtContent = self:getText("marquee_view_-182743639")

	self:_resetView()
end

function M:destroyUI()
	self._imgBg = nil
	self._txtContent = nil
end

function M:_resetView()
	self._txtContent.text = ""

	Astral.ColorUtil.SetImageColor(self._imgBg, "#00000000")
	Astral.TransformUtil.SetLocalPos(self._txtContent.transform, fromPosX, 0, 0)
end

function M:onEnter()
	MarqueeFacade.instance:registered(self)

	self._isPlaying = false
end

function M:showMarquee(data)
	self._isPlaying = true

	self._imgBg:DOFade(1, 0.5)

	self._txtContent.text = data

	local txtWidth = self._txtContent.preferredWidth

	goutil.setWidth(self._txtContent.transform, txtWidth)

	local distance = endPosX - txtWidth
	local duration = math.abs(distance) / speed

	DG.Tweening.DOTween.Kill(self._txtContent.transform)
	self._txtContent.transform:DOLocalMoveX(distance, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
		self._isPlaying = false

		Astral.TransformUtil.SetLocalPos(self._txtContent.transform, fromPosX, 0, 0)
		GlobalDispatcher:dispatchEvent(EventType.SHOW_MARQUEE_EVENT)
	end)
end

function M:getPlayState()
	return self._isPlaying
end

function M:hideMarquee()
	self._isPlaying = false

	self._imgBg:DOFade(0, 0.3)
	DG.Tweening.DOTween.Kill(self._txtContent.transform)
	Astral.TransformUtil.SetLocalPos(self._txtContent.transform, fromPosX, 0, 0)
end

function M:onExit()
	MarqueeFacade.instance:unregistered()
end

return M
