-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/PagetourlinkageView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.PagetourlinkageView", package.seeall)

local PagetourlinkageView = class("PagetourlinkageView", ViewComponent)

function PagetourlinkageView:ctor()
	PagetourlinkageView.super.ctor(self)
end

function PagetourlinkageView:unbindEvents()
	PagetourlinkageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnLink)
	GameUtil.rmClickHandler(self.btnLinkLimit)
end

function PagetourlinkageView:bindEvents()
	PagetourlinkageView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnLink, self.onClickLink, self)
	GameUtil.addClickHandler(self.btnLinkLimit, self.onClickLink, self)
end

function PagetourlinkageView:buildUI()
	PagetourlinkageView.super.buildUI(self)

	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.btnLink = self:getGo("btnLink")
	self.btnLinkLimit = self:getGo("btnLinkLimit")
	self.con = self:getGo("con")
	self.txtTime = self:getTxt("time/txtTime")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function PagetourlinkageView:onExit()
	PagetourlinkageView.super.onExit(self)
	self.scrollList:dispose()

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function PagetourlinkageView:onEnter()
	PagetourlinkageView.super.onEnter(self)

	local str = XiaonuoBirthConfig.instance:getCommonValue("H5_CELL_LIST")
	local list = string.split(str, "#")

	self.scrollList:reloadData(list)

	local platformTypeLimit = XiaonuoBirthConfig.instance:getCommonValue("H5_PLATFORM_LIMIT")
	local matchPlat = ActivityPopupModel.instance:checkIsMatchPlatform(platformTypeLimit)

	GameUtil.SetActive(self.btnLink, matchPlat)
	GameUtil.SetActive(self.btnLinkLimit, not matchPlat)

	local skinId = XiaonuoBirthConfig.instance:getCommonValue("H5_SKINID")

	skinId = checknumber(skinId)

	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self.con, scale, nil, true, modelCfg[1], y)
			end
		end
	end
end

function PagetourlinkageView:_updateCell(view, cell, data, tag)
	local pre = XiaonuoBirthConfig.instance:getCommonValue("H5_ICON_PRE")

	uGuiUtil.setSpriteToImage(cell.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("bonus", pre .. data))
end

function PagetourlinkageView:clearCell(cell)
	uGuiUtil.clearImage(cell.gameObject)
end

function PagetourlinkageView:onClickLink()
	local url = XiaonuoBirthConfig.instance:getCommonValue("H5_URL")

	UnityEngine.Application.OpenURL(url)
end

return PagetourlinkageView
