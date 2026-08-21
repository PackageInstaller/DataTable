-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/CharacterInfoFlyPagerTransformer.lua

module("logic.extensions.characterinformation.view.CharacterInfoFlyPagerTransformer", package.seeall)

local M = class("CharacterInfoFlyPagerTransformer", PagerTransformer)

function M:onCreate()
	local transform = self._viewPager.mainGO.transform

	self._width = RectTransformUtils.GetWidth(transform)
end

function M:transfromIn(view)
	local transform = view.mainGO.transform

	transform:DOKill(false)
	Astral.TransformUtil.SetLocalPosX(transform, self._width)
	transform:DOLocalMoveX(-0.5 * self._width * 0, 0.5, false):OnComplete(self.notifyTransformInFinish, self)
end

function M:transfromOut(view)
	if view.beforeExit then
		view:beforeExit()
	end

	local transform = view.mainGO.transform

	transform:DOKill(false)
	Astral.TransformUtil.SetLocalPosX(transform, 0)
	transform:DOLocalMoveX(self._width, 0.5, false):OnComplete(self.notifyTransformOutFinish, self)
end

return M
