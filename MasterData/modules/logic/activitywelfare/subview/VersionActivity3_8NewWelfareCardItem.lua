-- chunkname: @modules/logic/activitywelfare/subview/VersionActivity3_8NewWelfareCardItem.lua

module("modules.logic.activitywelfare.subview.VersionActivity3_8NewWelfareCardItem", package.seeall)

local VersionActivity3_8NewWelfareCardItem = class("VersionActivity3_8NewWelfareCardItem", LuaCompBase)

function VersionActivity3_8NewWelfareCardItem:init(go, index)
	self._go = go
	self._index = index
	self._txttitle = gohelper.findChildText(go, "txt_title")
	self._gocomplete = gohelper.findChild(go, "go_complete")
	self._txtcompletenum1 = gohelper.findChildText(go, "go_complete/txt_completenum1")
	self._txtcompletenum2 = gohelper.findChildText(go, "go_complete/txt_completenum2")
	self._gonormal = gohelper.findChild(go, "go_normal")
	self._txtnormalnum1 = gohelper.findChildText(go, "go_normal/go_icon1/txt_iconnum1")
	self._txtnormalnum2 = gohelper.findChildText(go, "go_normal/go_icon2/txt_iconnum2")
	self._btnclaim = gohelper.findChildButton(go, "go_normal/btn_claim")
	self._btnjump = gohelper.findChildButton(go, "go_normal/btn_jump")

	self:_initItem()
	self:_addEvents()
end

function VersionActivity3_8NewWelfareCardItem:_initItem()
	self._actId = ActivityEnum.Activity.NewWelfare
end

function VersionActivity3_8NewWelfareCardItem:_addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
end

function VersionActivity3_8NewWelfareCardItem:_removeEvents()
	self._btnjump:RemoveClickListener()
	self._btnclaim:RemoveClickListener()
end

function VersionActivity3_8NewWelfareCardItem:_btnjumpOnClick()
	local episodeId = self._co.episodeId

	if episodeId ~= 0 then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		local jumpParam = {}
		local chapterId = episodeConfig.chapterId
		local chapterConfig = lua_chapter.configDict[chapterId]

		jumpParam.chapterType = chapterConfig.type
		jumpParam.chapterId = chapterId
		jumpParam.episodeId = episodeConfig.id

		ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
		DungeonController.instance:jumpDungeon(jumpParam)
	end
end

function VersionActivity3_8NewWelfareCardItem:_btnclaimOnClick(id)
	Activity160Rpc.instance:sendGetAct160FinishMissionRequest(self._actId, self._co.id)
end

function VersionActivity3_8NewWelfareCardItem:refresh(co)
	self._co = co

	self:_refreshItem()
end

function VersionActivity3_8NewWelfareCardItem:_refreshItem()
	self._txttitle.text = self._co.desc

	local isFinish = Activity160Model.instance:isMissionFinish(self._actId, self._co.id)
	local canGet = Activity160Model.instance:isMissionCanGet(self._actId, self._co.id)

	gohelper.setActive(self._gocomplete, isFinish)
	gohelper.setActive(self._gonormal, not isFinish)
	gohelper.setActive(self._btnclaim.gameObject, canGet)
	gohelper.setActive(self._btnjump.gameObject, not canGet)

	local rewards = GameUtil.splitString2(self._co.bonus, true)

	if isFinish then
		if self._txtcompletenum1 and rewards[1] then
			self._txtcompletenum1.text = luaLang("multiple") .. rewards[1][3]
		end

		if self._txtcompletenum2 and rewards[2] then
			self._txtcompletenum2.text = luaLang("multiple") .. rewards[2][3]
		end
	else
		if self._txtnormalnum1 and rewards[1] then
			self._txtnormalnum1.text = luaLang("multiple") .. rewards[1][3]
		end

		if self._txtnormalnum2 and rewards[2] then
			self._txtnormalnum2.text = luaLang("multiple") .. rewards[2][3]
		end
	end
end

function VersionActivity3_8NewWelfareCardItem:destroy()
	self:_removeEvents()
end

return VersionActivity3_8NewWelfareCardItem
