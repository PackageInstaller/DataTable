-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillchapteriewView.lua

module("logic.extensions.scriptkill.view.ScriptkillchapteriewView", package.seeall)

local ScriptkillchapteriewView = class("ScriptkillchapteriewView", ViewComponent)

function ScriptkillchapteriewView:unbindEvents()
	ScriptkillchapteriewView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function ScriptkillchapteriewView:bindEvents()
	ScriptkillchapteriewView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
end

function ScriptkillchapteriewView:buildUI()
	ScriptkillchapteriewView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTask = self:getTxt("txtTask")
	self._txtTarget = self:getTxt("txtTarget")
	self._txtProgress = self:getTxt("txtProgress")
	self._btnEnter = self:getGo("btnEnter")
	self._txtDesc = self:getTxt("txtDesc")
	self._img = self:getGo("middle/con/img")
	self._txtName = self:getTxt("middle/txtName")
	self._items = self:getGo("items")
	self._npcs = self:getGo("npcs")
	self._item = self:getGo("item")

	GameUtil.SetActive(self._item, false)

	self._head = self:getGo("head")

	GameUtil.SetActive(self._head, false)
	GameUtil.SetActive(self._Nego_Icon, false)
end

function ScriptkillchapteriewView:onExit()
	ScriptkillchapteriewView.super.onExit(self)
end

function ScriptkillchapteriewView:onEnter()
	ScriptkillchapteriewView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._chapterId = checknumber(params[2])

	GameUtil.doCallbackWhenFirst("ScriptkillchapteriewView" .. self._activityId, function()
		self:_onClickTip()
	end)
	self:_refreshUI()
end

function ScriptkillchapteriewView:_refreshUI()
	local cfg = ScriptKillConfig.instance:getChapterCfgById(self._activityId, self._chapterId) or {}

	self._txtTask.text = cfg.task
	self._txtTarget.text = cfg.target
	self._txtName.text = cfg.name

	uGuiUtil.setSpriteToImage(self._img.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/scriptkill", cfg.img))

	self._txtDesc.text = langPara("收集<color=#ffffff>%s</color>个线索\n且解出关键线索后可推测真凶", cfg.passNeedNum)

	local childCount = self._items.transform.childCount

	for i = 1, childCount do
		local trans = self._items.transform:GetChild(i - 1)
		local go = trans.gameObject

		MaterialMgr.resetAll(go)
	end

	goutil.clearChildren(self._items)

	local arr = string.split(cfg.prize or "", "#")

	for i, v in ipairs(arr) do
		local go = goutil.clone(self._item, "item_" .. i)

		GameUtil.SetActive(go, true)
		goutil.addChildToParent(go, self._items)
		MaterialMgr.setCellByCfg(v, go)
	end

	local childCount = self._npcs.transform.childCount

	for i = 1, childCount do
		local trans = self._npcs.transform:GetChild(i - 1)
		local go = trans.gameObject
		local headIcon = goutil.findChild(go, "Nego_Icon/ImgC_Icon")

		uGuiUtil.clearImage(headIcon)
	end

	goutil.clearChildren(self._npcs)

	for i, v in ipairs(cfg.npcs) do
		local go = goutil.clone(self._head, "npc_" .. v)

		GameUtil.SetActive(go, true)
		goutil.addChildToParent(go, self._npcs)

		local headIcon = goutil.findChild(go, "Nego_Icon/ImgC_Icon")
		local npcCfg = ScriptKillConfig.instance:getNpcCfgById(self._activityId, v) or {}

		uGuiUtil.setSpriteToImage(headIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(npcCfg.icon))
	end
end

function ScriptkillchapteriewView:_onClickEnter()
	UIStateManager.instance:push(ViewName.ScriptkillseachView, self._activityId, self._chapterId)
end

function ScriptkillchapteriewView:_onClickTip()
	local list = ScriptKillConfig.instance:getTipsList()

	TipsFacade.instance:openImageRuleView(list, "规则说明")
end

return ScriptkillchapteriewView
