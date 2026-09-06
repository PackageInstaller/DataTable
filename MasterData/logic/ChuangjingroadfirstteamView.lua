-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadfirstteamView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadfirstteamView", package.seeall)

local ChuangjingroadfirstteamView = class("ChuangjingroadfirstteamView", ViewComponent)

function ChuangjingroadfirstteamView:ctor()
	ChuangjingroadfirstteamView.super.ctor(self)
end

function ChuangjingroadfirstteamView:unbindEvents()
	ChuangjingroadfirstteamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ChuangjingroadfirstteamView:bindEvents()
	ChuangjingroadfirstteamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ChuangjingroadfirstteamView:buildUI()
	ChuangjingroadfirstteamView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ChuangjingroadfirstteamView:onExit()
	ChuangjingroadfirstteamView.super.onExit(self)
	self._scrollList:dispose()
end

function ChuangjingroadfirstteamView:onEnter()
	ChuangjingroadfirstteamView.super.onEnter(self)

	self._activityId = 396001
	self._zoneId = 1

	local params = self:getOpenParam() or {}
	local actId = checknumber(params[1])
	local zoneId = checknumber(params[2])

	if actId > 0 then
		self._activityId = actId
	end

	if zoneId > 0 then
		self._zoneId = zoneId
	end

	self.addGEvent(self, GlobalNotify.CHUANG_JING_ROAD_FIRST_TEAM_INFO_UPDATE, self._onRefershUI, self)
	ChuangJingRoadController.instance:sendGetFirstTeamInfo(self._activityId, self._zoneId)
	self:_onRefershUI()
end

function ChuangjingroadfirstteamView:_onRefershUI()
	local info = ChuangJingRoadModel.instance:getFirstPassInfo(self._activityId, self._zoneId) or {}

	if not info.passTeam then
		local passTeam = {}

		self._scrollList:reloadData(passTeam)
	end
end

function ChuangjingroadfirstteamView:_updateCell(view, cell, data, tag)
	local nameText = goutil.findChildTextComponent(cell, "nameText")

	nameText.text = langPara("第 <size=60>%s</size> 关", cell.data)

	if not data.raceIds then
		local raceIds = {}

		for i = 1, 6 do
			local con = goutil.findChild(cell, "itemCon/con_" .. i)

			MaterialMgr.resetAll(con)

			if raceIds[i] then
				local proxy = MaterialMgr.setCell(MatType.Pet, raceIds[i], con)

				if proxy then
					proxy.binder:setClickCallBack(nil)
				end
			end
		end
	end
end

function ChuangjingroadfirstteamView:_clearCell(cell)
	for i = 1, 6 do
		local con = goutil.findChild(cell, "itemCon/con_" .. i)

		MaterialMgr.resetAll(con)
	end
end

return ChuangjingroadfirstteamView
