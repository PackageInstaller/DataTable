-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapter1View.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapter1View", package.seeall)

local DreamTeamChapter1View = class("DreamTeamChapter1View", ScriptkillchapteriewView)

function DreamTeamChapter1View:buildUI()
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTask = self:getTxt("txtTask")
	self._txtTarget = self:getTxt("txtTarget")
	self._txtProgress = self:getTxt("txtProgress")
	self._btnEnter = self:getGo("btnEnter")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtName = self:getTxt("middle/txtName")
	self._items = self:getGo("items")
	self._npcs = self:getGo("npcs")
	self._item = self:getGo("item")

	GameUtil.SetActive(self._item, false)

	self._head = self:getGo("head")

	GameUtil.SetActive(self._head, false)
	GameUtil.SetActive(self._Nego_Icon, false)
end

function DreamTeamChapter1View:onEnter()
	self.addGEvent(self, GlobalNotify.ScriptKillInfoUpdate, self._refreshUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._chapterId = checknumber(params[2])
	self._dreamTeamActId = checknumber(params[3])

	GameUtil.doCallbackWhenFirst("ScriptkillchapteriewView" .. self._activityId, function()
		self:_onClickTip()
	end)
	ScriptKillController.instance:sendGetInfo(self._activityId)
end

function DreamTeamChapter1View:_onClickEnter()
	local chapterCfg = DreamTeamChapterConfig.instance:getChapterCfg(self._dreamTeamActId, self._chapterId)
	local openTime = chapterCfg and chapterCfg.openTime

	if openTime then
		local openTimeStamp = GameUtil.string2time(openTime)

		if openTimeStamp > ServerTime.now() then
			local timeStr = GameUtil.formatTimeStamp("%Y-%m-%d %H: %M:%S", openTimeStamp)

			FloatWordMgr.instance:show(lang("%s后可挑战"), timeStr)

			return
		end
	end

	UIStateManager.instance:push(ViewName.DreamTeamChapterScriptKillSeachView, self._activityId, self._chapterId, self._dreamTeamActId)
end

function DreamTeamChapter1View:_refreshUI()
	local cfg = ScriptKillConfig.instance:getChapterCfgById(self._activityId, self._chapterId) or {}

	self._txtTask.text = cfg.task
	self._txtTarget.text = cfg.target
	self._txtName.text = cfg.name
	self._txtDesc.text = string.format(lang("收集<color=#ffffff>%s</color>个线索\n且解出关键线索后可通关\n奖励在[收集进度]\n任务中产出"), cfg.passNeedNum)

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

return DreamTeamChapter1View
