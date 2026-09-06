-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitejigsaw/view/InfiniteJigsawComicsView.lua

module("logic.extensions.infinitejigsaw.view.InfiniteJigsawComicsView", package.seeall)

local InfiniteJigsawComicsView = class("InfiniteJigsawComicsView", ViewComponent)

function InfiniteJigsawComicsView:ctor()
	InfiniteJigsawComicsView.super.ctor(self)
end

function InfiniteJigsawComicsView:buildUI()
	InfiniteJigsawComicsView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._icons = {}

	for i = 1, 4 do
		self._icons[i] = self:getGo(string.format("main/comics_%d/icon", i))
	end
end

function InfiniteJigsawComicsView:bindEvents()
	InfiniteJigsawComicsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function InfiniteJigsawComicsView:unbindEvents()
	InfiniteJigsawComicsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function InfiniteJigsawComicsView:onEnter()
	InfiniteJigsawComicsView.super.onEnter(self)
	self:_initIcons()
end

function InfiniteJigsawComicsView:onExit()
	InfiniteJigsawComicsView.super.onExit(self)
	self:_clearIcons()
end

function InfiniteJigsawComicsView:_onClickClose()
	self:close()
end

function InfiniteJigsawComicsView:_initIcons()
	local activityId = InfiniteJigsawModel.instance:getActivityId()
	local cfgActivity = InfiniteJigsawConfig.instance:getActivityCfg(activityId)

	if cfgActivity then
		local cfgPictures = InfiniteJigsawConfig.instance:getPictureList(cfgActivity.picturePlanId)

		for i, v in ipairs(cfgPictures) do
			if self._icons[i] then
				uGuiUtil.setSpriteToImage(self._icons[i], uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("picturepuzzle", v.iconPath))
			end
		end
	end
end

function InfiniteJigsawComicsView:_clearIcons()
	for i, v in ipairs(self._icons) do
		MaterialMgr.clearIcon(v)
	end
end

return InfiniteJigsawComicsView
