-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/detail/CharacterDetailFragmentView_Lookover.lua

module("logic.extensions.charactersystem.view.detail.CharacterDetailFragmentView_Lookover", package.seeall)

local M = class("CharacterDetailFragmentView_Lookover", CharacterDetailFragmentView)

function M:bindEvents()
	self._btnProperty:AddClickListener(self._onClickProperty, self)
	self._clickBtn:AddClickListener(self._clickMask, self)
end

function M:unbindEvents()
	self._btnProperty:RemoveClickListener()
	self._clickBtn:RemoveClickListener()
end

function M:_handleBtnActive()
	goutil.setActive(self._levelExp.gameObject, false)
	goutil.setActive(self._btnCloth.gameObject, false)
	goutil.setActive(self._btnDeta.gameObject, false)
	goutil.setActive(self._btnIncrExp.gameObject, false)
end

function M:_refreshRedDot()
	return
end

function M:_handleOnSystemOpen()
	return
end

return M
