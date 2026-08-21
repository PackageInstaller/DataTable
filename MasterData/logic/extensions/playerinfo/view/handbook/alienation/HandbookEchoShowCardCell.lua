-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/alienation/HandbookEchoShowCardCell.lua

module("logic.extensions.playerinfo.view.handbook.alienation.HandbookEchoShowCardCell", package.seeall)

local M = class("HandbookEchoShowCardCell", EchoItemShowCardView)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_buildUI()
	M.super._buildUI(self)
	goutil.setActive(self._btnFind.gameObject, false)
end

function M:onEnter()
	M.super.onEnter(self)
end

function M:onExit()
	M.super.onExit(self)
end

function M:refreshView(echoItemId)
	if not echoItemId then
		return
	end

	M.super.refreshView(self, echoItemId)
end

function M:_destroyUI()
	M.super._destroyUI(self)
end

return M
