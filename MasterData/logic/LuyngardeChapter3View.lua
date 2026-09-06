-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeChapter3View.lua

module("logic.extensions.luyngarde.view.LuyngardeChapter3View", package.seeall)

local LuyngardeChapter3View = class("LuyngardeChapter3View", ViewComponent)

function LuyngardeChapter3View:ctor()
	LuyngardeChapter3View.super.ctor(self)
end

function LuyngardeChapter3View:unbindEvents()
	LuyngardeChapter3View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnDecrypt)
	GameUtil.rmClickHandler(self._btnTip)
end

function LuyngardeChapter3View:bindEvents()
	LuyngardeChapter3View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnDecrypt, self._onClickBtnDecrypt, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickbtnTip, self)
end

function LuyngardeChapter3View:buildUI()
	LuyngardeChapter3View.super.buildUI(self)

	self._btnDecrypt = self:getGo("btnDecrypt")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRank = self:getGo("btnRank")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._roleCon = self:getGo("roleCon")
	self._empty = self:getGo("info/firstPlayer/empty")
	self._txtName = self:getTxt("info/firstPlayer/txtName")
	self._headIcon = self:getGo("info/firstPlayer/headIcon")
end

function LuyngardeChapter3View:onExit()
	LuyngardeChapter3View.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	HeadItemController.instance:resetHeadCell(self._headIcon)
end

function LuyngardeChapter3View:onEnter()
	LuyngardeChapter3View.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.LuyngardeUpdateRankInfoList, self._handleGetRankInfo, self)
	LuyngardeController.instance:getChapter3Info(self._activityId)
	LuyngardeController.instance:getChapter3ExploreRankInfo(self._activityId)

	self._actCfg = LuyngardeConfig.instance:getActCfg(self._activityId)

	local c3ShowSkinId = checknumber(self._actCfg.c3ShowSkinId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, c3ShowSkinId, self._roleCon, nil, nil, true, nil, nil)
end

function LuyngardeChapter3View:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.LuyngardeRankMainView, self._activityId, 2, 1)
end

function LuyngardeChapter3View:_onClickBtnDecrypt()
	UIStateManager.instance:push(ViewName.LuyngardeDecryptView, self._activityId)
end

function LuyngardeChapter3View:_onClickbtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function LuyngardeChapter3View:_handleGetRankInfo()
	local info = LuyngardeModel.instance:getChapter3RankInfo(self._activityId)

	if not info.rankInfos then
		local rankInfos = {}

		if #rankInfos > 0 then
			local headInfo = rankInfos[1].headInfo

			HeadItemController.instance:setHeadCellByInfo(self._headIcon, headInfo, true)

			self._txtName.text = headInfo.userName

			goutil.setActive(self._empty, false)
			goutil.setActive(self._headIcon, true)
			goutil.setActive(self._txtName.gameObject, true)
		else
			goutil.setActive(self._empty, true)
			goutil.setActive(self._headIcon, false)
			goutil.setActive(self._txtName.gameObject, false)
		end
	end
end

return LuyngardeChapter3View
