-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryActivityView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryActivityView", package.seeall)

local RoleStoryActivityView = class("RoleStoryActivityView", BaseView)

function RoleStoryActivityView:onInitView()
	self._actViewGO = gohelper.findChild(self.viewGO, "actview")
	self.btnMonster = gohelper.findChildButtonWithAudio(self._actViewGO, "BG/#simage_frame")
	self.simageMonster = gohelper.findChildSingleImage(self._actViewGO, "BG/#simage_frame/#simage_photo")
	self.itemPos = gohelper.findChild(self._actViewGO, "BG/itemPos")
	self.timeTxt = gohelper.findChildTextMesh(self._actViewGO, "timebg/#txt_time")
	self.btnEnter = gohelper.findChildButtonWithAudio(self._actViewGO, "#btn_enter")
	self.goEnterRed = gohelper.findChild(self._actViewGO, "#btn_enter/#go_reddot")
	self.txtTitle = gohelper.findChildTextMesh(self._actViewGO, "BG/title/ani/#txt_title")
	self.txtTitleEn = gohelper.findChildTextMesh(self._actViewGO, "BG/title/ani/#txt_en")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryActivityView:addEvents()
	self.btnEnter:AddClickListener(self._btnenterOnClick, self)
	self.btnMonster:AddClickListener(self._btnenterOnClick, self)
end

function RoleStoryActivityView:removeEvents()
	self.btnEnter:RemoveClickListener()
	self.btnMonster:RemoveClickListener()
end

function RoleStoryActivityView:_editableInitView()
	RedDotController.instance:addRedDot(self.goEnterRed, RedDotEnum.DotNode.RoleStoryChallenge)
end

function RoleStoryActivityView:_btnscoreOnClick()
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function RoleStoryActivityView:_btnenterOnClick()
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeMainViewShow, false)
end

function RoleStoryActivityView:onUpdateParam()
	return
end

function RoleStoryActivityView:onOpen()
	return
end

function RoleStoryActivityView:onClose()
	return
end

function RoleStoryActivityView:refreshView()
	self.storyId = RoleStoryModel.instance:getCurActStoryId()
	self.storyMo = RoleStoryModel.instance:getById(self.storyId)

	if not self.storyMo then
		return
	end

	self:refreshMonsterItem()
	self:refreshRoleItem()
	self:refreshLeftTime()
	self:refreshTitle()
	TaskDispatcher.cancelTask(self.refreshLeftTime, self)
	TaskDispatcher.runRepeat(self.refreshLeftTime, self, 1)
end

function RoleStoryActivityView:refreshTitle()
	if not self.storyMo then
		return
	end

	local name = self.storyMo.cfg.name
	local strLen = GameUtil.utf8len(name)
	local first = GameUtil.utf8sub(name, 1, 1)
	local second = ""

	if strLen > 1 then
		second = GameUtil.utf8sub(name, 2, 2)
	end

	self.txtTitle.text = string.format("<size=99>%s</size><size=70>%s</size>%s", first, second, (strLen > 3 or nil) and GameUtil.utf8sub(name, 4, strLen - 3))
	self.txtTitleEn.text = self.storyMo.cfg.nameEn
end

function RoleStoryActivityView:refreshMonsterItem()
	if not self.storyMo then
		return
	end

	local monsterPic = self.storyMo.cfg.monster_pic
	local path = string.format("singlebg/dungeon/rolestory_photo_singlebg/%s_2.png", monsterPic)

	self.simageMonster:LoadImage(path)
end

function RoleStoryActivityView:refreshRoleItem()
	if not self.roleItem then
		local go = self:getResInst(self.viewContainer:getSetting().otherRes.itemRes, self.itemPos)

		self.roleItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoleStoryActivityItem)

		self.roleItem:initInternal(go, self)
	end

	self.roleItem:onUpdateMO(self.storyMo)
end

function RoleStoryActivityView:refreshLeftTime()
	local mo = self.storyMo

	if not mo then
		return
	end

	local startTime, endTime = mo:getActTime()
	local leftTime = endTime - ServerTime.now()

	if leftTime > 0 then
		local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(leftTime)
		local timeFormat

		self.timeTxt.text = string.format("%s%s", luaLang("activity_remain"), day > 0 and string.format("<color=#f09a5a>%s</color>%s<color=#f09a5a>%s</color>%s", day, luaLang("time_day"), hour, luaLang("time_hour2")) or hour > 0 and string.format("<color=#f09a5a>%s</color>%s<color=#f09a5a>%s</color>%s", hour, luaLang("time_hour2"), min, luaLang("time_minute2")) or string.format("<color=#f09a5a>%s</color>%s<color=#f09a5a>%s</color>%s", min, luaLang("time_minute2"), sec, luaLang("time_second")))
	else
		TaskDispatcher.cancelTask(self.refreshLeftTime, self)
	end
end

function RoleStoryActivityView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshLeftTime, self)
end

return RoleStoryActivityView
