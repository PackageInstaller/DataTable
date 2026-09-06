-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillresultView.lua

module("logic.extensions.scriptkill.view.ScriptkillresultView", package.seeall)

local ScriptkillresultView = class("ScriptkillresultView", ViewComponent)

function ScriptkillresultView:unbindEvents()
	ScriptkillresultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ScriptkillresultView:bindEvents()
	ScriptkillresultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ScriptkillresultView:buildUI()
	ScriptkillresultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._topTapContainer = self:getGo("topTapContainer")
	self._btnTopTab = self:getGo("btnTopTab")

	GameUtil.SetActive(self._btnTopTab, false)

	self._contentView = self:getGo("scrollview"):GetComponent("ScrollRect")
	self._viewportSize = self._contentView.viewport.rect.height
	self._content = self._contentView.content
	self._txtRules = self:getTxt("scrollview/Viewport/Content/txtRules")
end

function ScriptkillresultView:onExit()
	ScriptkillresultView.super.onExit(self)
end

function ScriptkillresultView:onEnter()
	ScriptkillresultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._selectIdx = checknumber(params[2])

	if self._selectIdx == 0 then
		self._selectIdx = 1
	end

	self._selectClueIds = {}

	self:_initView()
end

function ScriptkillresultView:_refreshUI()
	if not self._viewConfigList[self._selectIdx] then
		self._txtRules.text = self._viewConfigList[self._selectIdx].reveal
		self._txtRules.fontSize = 24

		local x, y = Framework.TransformUtil.GetAnchoredPos(self._txtRules.transform, nil, nil)
		local preHeight = self._txtRules.preferredHeight
		local sizeDelta = self._content.sizeDelta

		sizeDelta.y = math.abs(y) * 2 + preHeight
		self._content.sizeDelta = sizeDelta
		self._contentView.enabled = sizeDelta.y > self._viewportSize

		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	end
end

function ScriptkillresultView:_initView()
	self._viewConfigList = {}

	local list = ScriptKillConfig.instance:getChapterListById(self._activityId) or {}

	goutil.clearChildren(self._topTapContainer)

	self._topTapList = {}

	for i, v in ipairs(list) do
		if not string.nilorempty(v.title) then
			local go = goutil.clone(self._btnTopTab, "item_" .. i)

			GameUtil.SetActive(go, true)
			goutil.addChildToParent(go, self._topTapContainer)
			table.insert(self._topTapList, go)

			local txtName = goutil.findChildTextComponent(go, "txtName")

			txtName.text = v.title

			local lock = goutil.findChild(go, "lock")

			GameUtil.SetActive(lock, false)
			GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTopTap, self, i))
			table.insert(self._viewConfigList, v)
		end
	end

	self:_onClickTopTap(self._selectIdx)
end

function ScriptkillresultView:_onClickTopTap(index)
	self._selectIdx = index

	for i, v in ipairs(self._topTapList) do
		GameUtil.setUIGroupIdx(v, self._selectIdx == i and 1 or 0)
	end

	self:_refreshUI()
end

return ScriptkillresultView
