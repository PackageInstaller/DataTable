-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginageshowView.lua

module("logic.extensions.orimatgame.view.OriginageshowView", package.seeall)

local OriginageshowView = class("OriginageshowView", ViewComponent)

function OriginageshowView:buildUI()
	OriginageshowView.super.buildUI(self)

	self._imgSolo = self:getGo("imgSolo")

	local showScrView = self:getGo("showScrView")
	local showCells = self:getGo("showCells")

	self._scrCells = {}
	self._sizeList = {}

	for tag = 1, showCells.transform.childCount do
		local go = goutil.findChild(showCells, "scrCell" .. tag)

		table.insert(self._scrCells, go)

		self._sizeList[tag] = {
			GameUtil.getWidth(go),
			GameUtil.getHeight(go)
		}
	end

	self._scrollerList = ScrollerList.create(showScrView, self._scrCells, GameUtil.handler(self._updateShowCell, self), GameUtil.handler(self._clearShowCell, self))

	self._scrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._scrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
end

function OriginageshowView:bindEvents()
	OriginageshowView.super.bindEvents(self)
end

function OriginageshowView:unbindEvents()
	OriginageshowView.super.unbindEvents(self)
end

function OriginageshowView:onEnter()
	OriginageshowView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._showPlanId = checknumber(params[1])
	self._showCfg = OriginAgeConfig.instance:getShowCfg(self._showPlanId) or {}

	GameUtil.setUIImageSpriteIdx(self._imgSolo, self._showPlanId - 1)
	self:_onUpdateShowColUI()
end

function OriginageshowView:onExit()
	OriginageshowView.super.onExit(self)
	self:_onClearShowColUI()
end

function OriginageshowView:_onUpdateShowColUI()
	self._scrollerList:reloadData(self._showCfg)
end

function OriginageshowView:_onClearShowColUI()
	self._scrollerList:dispose()
end

function OriginageshowView:_updateShowCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	if not string.nilorempty(data.conUrl) then
		local spriteName = GameUrl.getBigbgPngUrl(data.conUrl)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, spriteName, function()
			con:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end)
	else
		uGuiUtil.clearImage(con)
	end

	txtDesc.text = data.desc
end

function OriginageshowView:_clearShowCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")

	uGuiUtil.clearImage(con)
end

function OriginageshowView:_getTagByIdx(data, idx)
	return data.tag
end

function OriginageshowView:_getCellSize(view, idx)
	local data = self._showCfg[idx + 1]
	local tag = self:_getTagByIdx(data, idx)

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

return OriginageshowView
